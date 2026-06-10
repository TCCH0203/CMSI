====================================
SCHEDULE MANAGER — SETUP GUIDE
====================================

REQUIREMENTS
------------
You need Python installed on your computer.
Download it for free at: https://www.python.org/downloads/

Windows users: During installation, CHECK the box that says "Add Python to PATH".


====================================
MAC USERS
====================================

FIRST TIME SETUP (do this once):
---------------------------------
1. Unzip the Schedule Manager folder
2. Open Terminal
   (Press Cmd + Space, type "Terminal", press Enter)
3. Paste this command and press Enter:

   xattr -cr ~/Downloads/Schedule\ Manager && chmod +x ~/Downloads/Schedule\ Manager/run.command

   (If your folder is not in Downloads, drag the Schedule Manager folder
   into the Terminal window instead of typing the path)

4. Double-click run.command to launch the app

EVERY TIME AFTER THAT:
-----------------------
Just double-click run.command


====================================
WINDOWS USERS
====================================

FIRST TIME SETUP (do this once):
---------------------------------
1. Unzip the Schedule Manager folder
2. Double-click run.bat
3. A black window will open and install the required libraries automatically
4. The app will launch in your browser at http://localhost:5000

EVERY TIME AFTER THAT:
-----------------------
Just double-click run.bat


====================================
USING THE APP
====================================

- The app runs in your web browser
- After launching, open your browser and go to: http://localhost:5000
- To close the app, close the Terminal / black window


====================================
TROUBLESHOOTING
====================================

"Python not found" error:
  → Download and install Python from https://www.python.org/downloads/
  → Windows: make sure to check "Add Python to PATH" during install

"pip not found" error (Mac):
  → Open Terminal and run: python3 -m ensurepip --upgrade

App doesn't open in browser:
  → Manually open your browser and go to http://localhost:5000

Any other issues:
  → Contact the person who sent you this file


====================================
