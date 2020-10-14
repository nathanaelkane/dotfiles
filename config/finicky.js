module.exports = {
  defaultBrowser: "Firefox",
  rewrite: [
    {
      // Redirect all urls to use https
      match: ({ url }) => url.protocol === "http",
      url: { protocol: "https" }
    }
  ],
  handlers: [
    {
      // Open Google Meet URLs in Chrome
      match: ["meet.google.com*"],
      browser: "Google Chrome"
    }
  ]
};
