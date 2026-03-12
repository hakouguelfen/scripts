#!/usr/bin/env bash

# Ensure fd is installed
if ! command -v fd >/dev/null 2>&1; then
  echo "Error: fd is not installed." >&2
  exit 1
fi

DOWNLOAD="/home/hakou/Downloads"
TORRENTS="/home/hakou/Downloads/TORRENTS"
DOCS="/home/hakou/Downloads/DOCS"

fd . -e torrent "$DOWNLOAD" -x mv {} "$TORRENTS"
fd . -e pdf "$DOWNLOAD" -x mv {} "$DOCS"
