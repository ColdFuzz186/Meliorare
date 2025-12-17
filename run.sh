#!/bin/sh
# Move to the folder where this script lives
cd "$(dirname "$0")"
# Launch Love2D 
SDL_VIDEODRIVER=x11 love .    #If you are using the flatpak version of Love2D, this needs changed so it will launch.

