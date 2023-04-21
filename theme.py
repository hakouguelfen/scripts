import yaml
import subprocess
import os


setting = "/home/hakouguelfen/.config/theme/setting.yaml"
alacritty = "/home/hakouguelfen/.config/alacritty/alacritty.yml"
gtk = "/home/hakouguelfen/.config/gtk-3.0/settings.ini"
rofi = "/home/hakouguelfen/.config/rofi/colors.rasi"
conky = "/home/hakouguelfen/.config/conky/conky.conkyrc"
dunst = "/home/hakouguelfen/.config/dunst/dunstrc"
dmenu = "/home/hakouguelfen/.config/dmenu/config.def.h"
options = ["light theme", "dark theme"]

command = ["dmenu", "-i", "-p", "Choose a theme for your system:"]


def updateSetting(option):
    with open(setting) as setting_file:
        data = yaml.safe_load(setting_file)

    if option == "light theme":
        data["setting"]["qtile"] = "LIGHT"
        data["setting"]["alacritty"] = "light"
        data["setting"]["emacs"] = "doom-one-light"
    if option == "dark theme":
        data["setting"]["qtile"] = "DARK"
        data["setting"]["alacritty"] = "doom-one"
        data["setting"]["emacs"] = "doom-vibrant"

    with open(setting, "w") as setting_file:
        yaml.dump(data, setting_file)

def updateAlacritty(option):
    with open(alacritty) as alacritty_file:
        alacrittyData = yaml.load(alacritty_file, Loader=yaml.FullLoader)

    if option == "light theme":
        alacrittyData["colors"] = alacrittyData["schemes"]["light"]

    if option == "dark theme":
        alacrittyData["colors"] = alacrittyData["schemes"]["doom-one"]

    with open(alacritty, "w") as alacritty_file:
        yaml.dump(
            alacrittyData, alacritty_file, sort_keys=False, default_flow_style=False
        )

def updateGtk(option):
    with open(gtk, "r") as gtk_file:
        setting = gtk_file.readlines()

    if option == "light theme":
        setting[1] = "gtk-theme-name=Colloid-Grey-Light\n"

    if option == "dark theme":
        setting[1] = "gtk-theme-name=Colloid-Grey-Dark-Nord\n"

    with open(gtk, "w") as gtk_writer:
        gtk_writer.writelines(setting)

def updateWallpaper(option):
    wallpaper_dir = "/usr/share/wallpaper/"

    if option == "light theme":
        subprocess.run(["nitrogen", "--set-scaled", f"{wallpaper_dir}drawing.jpg"])
    if option == "dark theme":
        subprocess.run(["nitrogen", "--set-scaled", f"{wallpaper_dir}arch-black.png"])

def updateRofi(option):
    bg_bar_dark = "    background-bar: #f2f2f215;\n"
    bg_dark = "    background: #282c3480;\n"
    fg_dark = "    foreground: #f2f2f2b3;\n"

    bg_bar_light = "    background-bar: #34393d15;\n"
    bg_light = "    background: #fafafa80;\n"
    fg_light = "    foreground: #34393db3;\n"

    with open(rofi, "r") as rofi_file:
        colors = rofi_file.readlines()

    if option == "light theme":
        colors[1] = bg_light
        colors[2] = fg_light
        colors[3] = bg_bar_light

    if option == "dark theme":
        colors[1] = bg_dark
        colors[2] = fg_dark
        colors[3] = bg_bar_dark

    with open(rofi, "w") as rofi_writer:
        rofi_writer.writelines(colors)

def updateConky(option):
    with open(conky, "r") as conky_file:
        conky_setting = conky_file.readlines()

    if option == "light theme":
        conky_setting[5] = "background_color = '#fafafa';\n"
        conky_setting[6] = "purple = '#ac3bce';\n"
        conky_setting[7] = "grey = '#8e9aaf';\n"
        conky_setting[8] = "blue = '#5666a5';\n"
        conky_setting[9] = "green = '#6ed97c';\n"

    if option == "dark theme":
        conky_setting[5] = "background_color = '#282c34';\n"
        conky_setting[6] = "purple = '#c678dd';\n"
        conky_setting[7] = "grey = '#bbc2cf';\n"
        conky_setting[8] = "blue = '#51afef';\n"
        conky_setting[9] = "green = '#98be65';\n"

    with open(conky, "w") as conky_writer:
        conky_writer.writelines(conky_setting)

def updateDunst(option):
    with open(dunst, "r") as dunst_file:
        dunst_setting = dunst_file.readlines()

    if option == "light theme":
        dunst_setting[248] = '    background = "#fafafa80"\n'
        dunst_setting[249] = '    foreground = "#34393db3"\n'
        dunst_setting[253] = '    background = "#fafafa80"\n'
        dunst_setting[254] = '    foreground = "#34393db3"\n'

    if option == "dark theme":
        dunst_setting[248] = '    background = "#282a36bb"\n'
        dunst_setting[249] = '    foreground = "#D9E0EE"\n'
        dunst_setting[253] = '    background = "#282a36bb"\n'
        dunst_setting[254] = '    foreground = "#D9E0EE"\n'

    with open(dunst, "w") as dunst_writer:
        dunst_writer.writelines(dunst_setting)

def updateDmenu(option):
    with open(dmenu, "r") as dmenu_file:
        dmenu_setting = dmenu_file.readlines()

    if option == "light theme":
        dmenu_setting[0] = '#include "themes/light.h"\n'

    if option == "dark theme":
        dmenu_setting[0] = '#include "themes/custom.h"\n'

    with open(dmenu, "w") as dmenu_writer:
        dmenu_writer.writelines(dmenu_setting)

def main():
    option = subprocess.run(
        command,
        input="\n".join(options),
        stdout=subprocess.PIPE,
        universal_newlines=True,
    ).stdout.strip()
    try:
        if len(option) == 0:
            return

        updateSetting(option)
        updateAlacritty(option)
        updateGtk(option)
        updateWallpaper(option)
        updateRofi(option)
        updateConky(option)
        updateDunst(option)
        updateDmenu(option)
    except:
        subprocess.run(["notify-send", "theme script", "an error has occured"])
    finally:
        if len(option) == 0:
            return
        # subprocess.run(["emacsclient", "-e", "(restart-emacs)"])
        subprocess.run(["qtile", "cmd-obj", "-o", "cmd", "-f", "reload_config"])
        subprocess.run(["killall", "dunst"])
        subprocess.run(["dunst", "&"])

        os.chdir('.config/dmenu/')
        subprocess.run(["rm", "-rf", "config.h"])
        subprocess.run(["make", "install"])


if __name__ == "__main__":
    main()
