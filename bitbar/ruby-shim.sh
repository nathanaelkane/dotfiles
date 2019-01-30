#!/bin/bash
cd "$(dirname "$0")"
RB_FILE=".$(basename "$0" | cut -d . -f 1).rb"
exec /bin/bash -l -c "ruby $(printf %q "$RB_FILE")"
