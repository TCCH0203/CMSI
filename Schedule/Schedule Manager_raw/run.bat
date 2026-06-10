@echo off
cd /d "%~dp0"
echo Installing required libraries...
pip install flask docxtpl pandas openpyxl python-docx
echo Starting app...
python app.py
pause
