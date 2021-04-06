from tkinter import *
import tkinter.font as  tkFont
win = Tk()

myFont = tkFont.Font(family = 'Helvetica', size = 36, weight = 'bold')

win.title("First GUI")
win.geometry('800x480')

def ledON():
	pass

def exitProgram():
	win.quit()

exitButton  = Button(win, text = "Exit", font = myFont, command = exitProgram, height =2 , width = 6) 
exitButton.pack(side = BOTTOM)

ledButton = Button(win, text = "Start", font = myFont, command = ledON, height = 2, width =8 )
ledButton.pack()

mainloop()
