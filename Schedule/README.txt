《Schedule Manager_raw》
This is a local webpage for making Schedules. Frontend(UI): javascript + CSS	Backend(database): python + SQL

Paste the contact_list.xlsx and database.xlsx in the asset folder

=============================  
MAC Users  
=============================  

FIRST TIME SETUP (do this once):  
1. Unzip the Schedule Manager folder  
2. Open Terminal (Press Cmd + Space, type "Terminal", press Enter)  
3. Paste this command and press Enter:  

  xattr -cr ~/Downloads/Schedule\ Manager_raw && chmod +x ~/Downloads/Schedule\ Manager_raw/run.command  

  (If your folder is not in the Download folder,   
  Option 1: Place the folder into the Download folder.  
  Option 2: type pwd in the Terminal, it will show your current path, replace ~/Downloads with your current path)  
  
4. Double-click run.command to launch the app at https://localhost:5000  

Every time after that, just double click run.command  

=============================  
WINDOWS USERS  
=============================  

FIRST TIME SETUP(do this once):  
1. Unzip the Schedule Manager folder  
2. Double-click run.bat  
3. A black window (Terminal) will open and install the required libraries automatically  
4. The app will launch in your default browser at https://localhost:5000  

Every time after that, just double-click run.bat  

=============================  
USING THE APP  
=============================  

-Press save manually at the top of the webpage to save the schedule. Note that you cannot press Crtl+S, it conflicts with saving the html webpage

=============================  
LIMITATIONS
=============================  

-It is not linked to Tracker

--------------------------------------------------------------------------------------------------------------

《Schedule_Tracker》
This is an excel linked to word using Mailing to make schedule and tracker

=============================  
USING THE EXCEL  
=============================  

Copy and paste the database into the database tab in the excel

Input the meeting details in the Schedule tab, then press Paste Value and Save. Open the Word doc, press yes, select the Result tab. At the tool bar, go to Mailing, press edit individual Documents. The day of the week (星期X) is automatically detected.

Press 加到Tracker to add to tracker, PLEASE ONLY REMAIN THE TIME OF THE MEETINGS NEEDED IN COLUMN A, OTHERWISE THE Tracker TAB WILL BE BUGGED.

=============================
LIMITATIONS
=============================

1. It is limited to maximum 6 meetings per day.
2. Cannot handle group meetings.
3. Requires you to delete extra rows in the word doc manually.
4. Manual input for management team and CMS team


