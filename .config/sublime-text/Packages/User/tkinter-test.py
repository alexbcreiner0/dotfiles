import tkinter as tk
from tkinter import ttk

window = tk.Tk()
window.title("Example")

label1 = tk.Label(window, text="Hello world!")
label2 = tk.Label(window, text="Packed widgets appear underneath each other in the order they were packed.")

label1.pack(pady= 10)
label2.pack(padx= 10, pady= 10)

window.mainloop()