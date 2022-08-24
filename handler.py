################################################################################
#                                                                              #
#  Functional as of 8/21/22 | Requires Windows and Powershell                  #
#                                                                              #
################################################################################
from pathlib import Path
import shutil
import os
import pyautogui
import os
import pywinauto
from pywinauto.application import Application
import keyboard
import time
import re
from pywinauto import mouse
import config
from config import password

path = r'\Samsung Notes - Shortcut.lnk'
source = r'C:\Users\chris\Desktop\samsungnotes'
target = r'C:\Users\chris\Desktop\oldsamsungnotes'



def connect():
    app = Application(backend="uia").connect(title='Samsung Notes')
    return app


def selection(app):
    three_dots = app.SamsungNotes.child_window(title="More options", auto_id="MoreButton", control_type="Button").wrapper_object()
    three_dots.click_input()
    edit = app.SamsungNotes.child_window(title="Edit", auto_id="SelectButton", control_type="MenuItem").wrapper_object()
    edit.click_input()
    edit.click_input()


def remove(target):
    for filename in os.listdir(target):
        os.remove(os.path.join(target, filename))


def copy(source, target):
    files = os.listdir(source)
    for filename in files:
        shutil.copy2(os.path.join(source, filename), target)


def reset(source, target):
    remove(source)
    remove(target)

#def main():
#    reset(source, target)

def main():
    # empty the backup
    try:
        remove(target)
    except Exception as e:
        print(e)

    # fill backup with most recent samsungnotes archive
    try:
        copy(source, target)
    except Exception as e:
        print(e)
    
    # empty out directory to store latest files
    try:
        remove(source)
    except Exception as e:
        print(e)

    # open samsung notes
    os.startfile(r"C:\Users\chris\Desktop"+path)
    time.sleep(2)

    # connect to samsung notes and download notes
    app = connect()
    selection(app)
    check = app.SamsungNotes.child_window(title="All", auto_id="NotesListSelectAllCheckBox", control_type="CheckBox")
    check.click_input()
    save_as = app.SamsungNotes.child_window(title="Save as file", auto_id="SaveAsButton", control_type="Button").wrapper_object()
    save_as.click_input()
    Text_file = app.SamsunNotes.child_window(title="Text file", auto_id="TextRadioButton", control_type="RadioButton").wrapper_object()
    Text_file.click_input()
    Done = app.SamsungNotes.child_window(title="Done", auto_id="OkButton", control_type="Button").wrapper_object()
    Done.click_input()
    keyboard.press_and_release("enter")
    text_editor = app.SamsungNotes.child_window(title="Password", control_type="Text")
    text_editor.type_keys(password)
    keyboard.press_and_release("enter")
    time.sleep(2)
    mouse.click(coords=(330, 50))
    keyboard.press_and_release("enter")
    time.sleep(15)
    app.SamsungNotes.close()


if __name__ == '__main__':
    main()


