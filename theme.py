import yaml
import subprocess

setting = "/home/hakouguelfen/.config/theme/setting.yaml"
alacritty = "/home/hakouguelfen/.config/alacritty/alacritty.yml"
options = ['light theme', 'dark theme']

command = ['dmenu', '-i', '-p', 'Choose a theme for your system:']


def updateSetting(option):
    with open(setting) as setting_file:
        data = yaml.safe_load(setting_file)

    if (option == "light theme"):
        data["setting"]["qtile"] = "LIGHT"
        data["setting"]["alacritty"] = "light"
        data["setting"]["emacs"] = "doom-one-light"
    if (option == "dark theme"):
        data["setting"]["qtile"] = "DARK"
        data["setting"]["alacritty"] = "doom-one"
        data["setting"]["emacs"] = "doom-vibrant"

    with open(setting, "w") as setting_file:
        yaml.dump(data, setting_file)

def updateAlacritty(option):
    with open(alacritty) as alacritty_file:
        alacrittyData = yaml.load(alacritty_file, Loader=yaml.FullLoader)

    if (option == "light theme"):
        alacrittyData["colors"] = alacrittyData["schemes"]["light"]

    if (option == "dark theme"):
        alacrittyData["colors"] = alacrittyData["schemes"]["doom-one"]

    with open(alacritty, "w") as alacritty_file:
        yaml.dump(alacrittyData, alacritty_file, sort_keys=False, default_flow_style=False)


def main():
    option = subprocess.run(command,
                                    input='\n'.join(options),
                                    stdout=subprocess.PIPE,
                                    universal_newlines=True
                                    ).stdout.strip()
    try:
        updateSetting(option)
        updateAlacritty(option)
    except:
        print("err")
    finally:
        subprocess.run(["qtile", "cmd-obj", "-o", "cmd", "-f", "reload_config"])


main()
