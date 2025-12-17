#!/bin/sh
# Move to the folder where this script lives
cd "$(dirname "$0")"
# Launch LOVE forcing X11 (like your alias)
SDL_VIDEODRIVER=x11 love .

