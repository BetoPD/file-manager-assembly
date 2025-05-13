format PE console 
entry start

include 'win32a.inc'

MAX_INPUT_SIZE = 20h

section '.data' data readable writeable 
    menu_welcome db 'Welcome to the file manager!', 0
    menu_option1 db '1. Create a file', 0
    menu_option2 db '2. Read a file', 0
    menu_option3 db '3. Write to a file', 0
    menu_option4 db '4. Delete a file', 0
    menu_option5 db '5. Exit', 0
    filename db ? 