; eax - Acumulator (32-bit register)
; ebx - Base index
; ecx - Counter
; edx - Data register

; e stands for extended

format PE console ; queremos crear un ejecutable de tipo consola (portable executable)
entry start ; 

include 'win32a.inc'

MAX_INPUT_SIZE = 20h

section '.data' data readable writeable ; sección de datos 
    
    filename db 'myfile.txt', 0

section '.bss' readable writeable ; sección de bss (bloque de almacenamiento sin inicializar)
    input_handle dd ?
    file_handle dd ?
    bytes_read dd ?
    bytes_written dd ?
    input_str db MAX_INPUT_SIZE dup (?)

section '.text' code readable ; seccion de text es para el codigo

start:
    push STD_INPUT_HANDLE
    call [GetStdHandle]
    mov dword [input_handle], eax

    push 0
    push bytes_read
    push MAX_INPUT_SIZE
    push input_str
    push dword [input_handle]
    call [ReadFile]

    push 0
    push FILE_ATTRIBUTE_NORMAL  
    push CREATE_ALWAYS
    push 0
    push 0
    push GENERIC_WRITE
    push filename
    call [CreateFileA]
    mov dword [file_handle], eax

    push 0
    push bytes_written
    push dword [bytes_read]
    push input_str
    push dword [file_handle]
    call [WriteFile]

    push [file_handle]
    call [CloseHandle]

    push 0
    call [ExitProcess]

section '.idata' import data readable ; no se ejecuta esta seccion, solo se importa
    library kernel32, 'kernel32.dll'
    import kernel32, \
        GetStdHandle, 'GetStdHandle', \
        ReadFile, 'ReadFile', \
        CreateFileA, 'CreateFileA', \
        WriteFile, 'WriteFile', \
        CloseHandle, 'CloseHandle', \
        ExitProcess, 'ExitProcess' 