# Android Bloatware Uninstaller

Bloatware Uninstaller Script is a simple Powershell script that helps you uninstall system apps. It is easy to use as well as customise.

 - You can create your personalized list of packages to uninstall!
 - Compatible with Windows.

## Before starting

- You need to download [SDK Platform Tools ](https://developer.android.com/studio/releases/platform-tools#downloads)
  - Extract the archive and copy the folder **"platform-tools"** in the script folder

- Set up your phone
  - Connect the phone to the computer via USB
  - Enable the USB Debug mode in the options for developers on the phone

- After creating the list of packages you are ready to launch the script

## Lists
You can create your personalized list of packages.

- It is very simple, in the lists folder you have to create a TXT file with inside the packages  to uninstall, one under the other like this:

```
# Comment
com.google.android.apps.docs #Comment
/#Comment#/com.google.android.apps.fitness
com.google.android.youtube
```
You can use **"#"** in front of a row or after the name of a package to comment ro **"/# #/"** to isolate a comment.

>In the lists folder there is an example file for Realme phones, i created it from a [post](https://www.reddit.com/r/Realme/comments/w12bbk/realme_rui_20_rui_30_debloat_list/found) on reddit 
## Running the script
It is very easy to use.

When the script starts, a menu is displayed, choose an option, enter the list and you're done, the packages automatically uninstall.

### Options
0. Exit from the script
1. Manually enter the name of the list with or without extension
2. Graphically insert the list via a file explorer window

## Screenshots
![Screenshot1](https://i.imgur.com/axPIwbOl.png "Screenshot1")

## License
This scipt is open source

### **:warning:Disclaimer:** The Developer is **NOT RESPONSIBLE** for any damage or misbehaviour on your device.
