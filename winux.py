demon = 0
skiprun = 0
import sys
from os import system as run
import os
import argparse
import questionary
from colorama import *
parser = argparse.ArgumentParser(description='Winux, the Linux(R) environment for Windows(R)', prog="linux", epilog="To enable a switch, pass 'yes' to it. Running 'sudomode' activates Winux's Sudo Mode. This adds a warning before the prompt. Many Windows apps can be used in Winux.\nRun 'man bash' to learn more about the Winux shell or 'help' for a list of commands. Winux is built on WSL.")
parser.add_argument('--sudo', help='switch: enable Sudo Mode', default="no")
parser.add_argument('--version', help='switch: print Winux and BASH versions', default="no")
parser.add_argument('--update', help='switch: update Winux components', default="no")
args = parser.parse_args()
sudomode = 0
dir = os.getcwd()
run("bash -c clear")
questionary.print("Winux 1.0 - Linux for Windows", style="bold")
if os.name != "nt":
  print("Winux is only for Windows. Running on Linux or macOS will not work. Are you running Winux\nin Winux?")
  exit()
if args.update == "yes" and args.version == "no":
        questionary.print("    WARNING: only works if WSL distro is Debian GNU/Linux, Ubuntu, or Kali Linux.", style="italic")
        run("bash -c 'sudo apt full-upgrade'")
        sys.exit()
if args.version == "yes":
   print("Licensed under the 3-clause BSD license (http://opensource.org/licenses/BSD-3-Clause)")
   print("-------------------------------------")
   run("bash --version")
   sys.exit()
if args.sudo == "yes":
         os.system(f"bash -c 'sudo echo Sudo Mode enabled. You are now running as root.'")
         sudomode = 1
while True:
  if sudomode:
    cmd = input(f"{Back.RED} SUDO MODE {Style.RESET_ALL} {Fore.LIGHTGREEN_EX}{os.getcwd()}{Style.RESET_ALL} {Fore.MAGENTA}Winux{Style.RESET_ALL} {Fore.CYAN}#{Style.RESET_ALL} ")
  else:
    cmd = input(f"{Fore.LIGHTGREEN_EX}{dir}{Style.RESET_ALL} {Fore.MAGENTA}Winux{Style.RESET_ALL} {Fore.CYAN}${Style.RESET_ALL} ")
  if cmd == "exit":
     sys.exit()
  elif cmd == "sudomode":
     if sudomode == 1:
       print("Sudo Mode is already enabled.")
       skiprun = 1
     else:
       os.system(f"bash -c 'sudo echo Sudo Mode enabled. You are now running as root.'")
       sudomode = 1
       skiprun = 1
     if cmd.startswith("cd "):
       raise NotImplementedError("cd command is not implemented")
  if not skiprun:
     if sudomode:
        runasroot = questionary.select(
            "Run this command in Sudo Mode (superuser)?",
            choices=[
              "No (run as non-admin Linux user)",
              "Yes (run as root user / superuser)",
              "Disable Sudo Mode (stop running Winux as root)"
        ]).ask()
        if runasroot == "Yes (run as root user / superuser)":
          run(f"bash -c 'sudo {cmd}' -d '{dir}'")
        else:
          if runasroot == "Disable Sudo Mode (stop running Winux as root)":
             sudomode = 0
          run(f"bash -c '{cmd}' -d '{dir}'")
     else:
      run(f"bash -c '{cmd}' -d '{os.getcwd()}'")
  skiprun = 0