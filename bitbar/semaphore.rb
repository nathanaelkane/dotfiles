#!/usr/bin/env ruby

# <bitbar.title>Semaphore CI</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Nathanael Kane</bitbar.author>
# <bitbar.author.github>nathanaelkane</bitbar.author.github>
# <bitbar.desc>List your projects and their statuses, from semaphoreci.com.</bitbar.desc>
# <bitbar.dependencies>ruby</bitbar.dependencies>

# Example ~/.bitbar.semaphore.json config:
#
#   {
#     "auth_token": "SEMAPHORE-TOKEN",
#     "projects": [
#       {
#         "name": "owner/project-foo",
#         "alias": "FO",
#         "directory": "~/code/project-foo"
#       },
#       {
#         "name": "owner/project-bar",
#         "alias": "BA",
#         "directory": "~/code/project-bar"
#       }
#     ]
#   }

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'activesupport', '~> 5.0', require: false
end

require 'json'
require 'net/http'
require 'uri'
require 'time'
require 'active_support/core_ext/enumerable'
require 'active_support/core_ext/hash/indifferent_access'

CONFIG = JSON.parse(File.read("#{Dir.home}/.bitbar.semaphore.json"))

PROJECTS_CONFIG = CONFIG.fetch('projects').inject({}) do |config, project|
  name = project.fetch('name')
  config.merge(name => project)
end

SEMAPHORE_URL = "https://semaphoreci.com/api/v1/projects?auth_token=#{CONFIG.fetch('auth_token')}"

RESULTS = {
  failed: {icon: '✘', color: 'red'},
  pending: {icon: '❉', color: 'blue'},
  passed: {icon: '✔︎', color: 'green'},
}.with_indifferent_access

def local_branch(directory)
  local_branch = `cd #{directory} && git rev-parse --abbrev-ref HEAD`.strip
  local_branch.empty? ? nil : local_branch
end

def output_branch_info(branch, current: false, color: nil)
  result = RESULTS.fetch(branch.fetch('result'))

  [
    '-',
    branch.fetch('branch_name'),
    current ? '(current)' : nil,
    result.fetch(:icon),
    "| href=#{branch.fetch('build_url')} color=#{color || result.fetch(:color)}",
  ].compact.join(' ')
end

def group_result(group_results)
  result = case
  when group_results.include?('failed')
    'failed'
  when group_results.include?('pending')
    'pending'
  when group_results.include?('passed')
    'passed'
  else
    raise "Invalid group results: #{group_results.inspect}"
  end

  RESULTS.fetch(result)
end

def error(message)
  puts '✘ | color=red'
  puts '---'
  puts "#{message} | color=red"
  exit 1
end

def run
  begin
    projects = JSON.parse(Net::HTTP.get(URI(SEMAPHORE_URL)))
  rescue SocketError => e
    error 'Could not connect.'
  end

  menu_bar_items = []
  menu_bar_results = []

  items = [
    '---',
    '⚙ Semaphoreci | href=https://semaphoreci.com/',
  ]

  projects.map do |project|
    full_name = "#{project.fetch('owner')}/#{project.fetch('name')}"
    next unless project_config = PROJECTS_CONFIG.fetch(full_name, nil)

    # Add project heading.
    items << '---'
    items << "#{full_name} | href=#{project.fetch('html_url')}"

    branches = project.fetch('branches').index_by { |branch| branch.fetch('branch_name') }
    local_branch = local_branch(project_config.fetch('directory'))
    focus_branch_names = ['master', 'develop', local_branch].uniq
    other_branch_names = (branches.keys - focus_branch_names).sort

    # Add focus branches.
    project_results = branches.values_at(*focus_branch_names).map do |branch|
      current = branch.fetch('branch_name') == local_branch
      items << output_branch_info(branch, current: current)
      branch.fetch('result')
    end

    # Add other branches that were built recently.
    branches.values_at(*other_branch_names).each do |branch|
      started_at = branch.fetch('started_at', nil)
      next unless started_at

      hours_since_started = (Time.now - Time.parse(started_at)) / 60 / 60
      next unless hours_since_started < 24

      items << output_branch_info(branch, color: '#999999')
    end

    # Add project to menu bar.
    menu_bar_items << "#{project_config.fetch('alias')} #{group_result(project_results).fetch(:icon)}"
    menu_bar_results += project_results
  end

  puts "#{menu_bar_items.join(' ')} | color=#{group_result(menu_bar_results).fetch(:color)}"
  puts items.join("\n")
end

if $0 == __FILE__
  run
end
