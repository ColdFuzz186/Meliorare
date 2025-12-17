⚠ THIS IS BUILT FOR LINUX! IT USES BASH FOR A LOT OF FUNCTIONALITY! IT WILL NOT WORK ON WINDOWS!

# Meliorare
A day counter for the Linux desktop built with Love2D
If you installed Love2D using flatpak, you will have to manually change the start date in 'main.lua', you will also have to edit 'run.sh', there is a comment there that gives more detail.

## Files
- 'main.lua'  -Main script.
- 'run.sh'  -Launcher script.
- 'icon.png'  -Application icon.
- 'desktoptemplate'  -Template for creating a desktop entry.

## Installing the desktop icon.
If you want the application to display as an icon:
1) Edit 'desktoptemplate' and change the word "USER" to your username.
2) Move it to your applications folder:

```bash
mv desktoptemplate ~/.local/share/applications/Meliorare.desktop
```

## Setting the start date.
The start date will be empty at first, after clicking the desktop icon, or using run.sh while in the directory, click on the change start date.
The start date is in the format month-day-year (So the 16th of december 2025 would be '2025-12-16')
