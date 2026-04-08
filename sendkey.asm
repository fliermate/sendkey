format PE GUI
include 'win32a.inc'

INPUT_MOUSE    = 0
INPUT_KEYBOARD = 1
INPUT_HARDWARE = 2

struct INPUT
  .type         dd       ?
  .wVk          dw       ?
                dw       ?
  .wScan        dw       ?
                dw       ?
  .dwFlags      dd       ?
  .time         dd       ?
  .dwExtraInfo  dq       ?
ends

section '.code' code readable executable

entry $

  invoke    FindWindow,0,_title
  or        eax, eax
  jz        .quit
  invoke    SetForegroundWindow, eax
  invoke    Sleep, 500
  invoke    SendInput, 2, _input, sizeof.INPUT
  or        eax,eax
  jz        .quit
  ;invoke    MessageBox, 0, _message, _title, MB_OK

.quit:
  invoke    ExitProcess,0

section '.data' data readable writeable

  _title      db 'Calculator',0
  _message    db 'Key "3" pressed',0
  _input      INPUT INPUT_KEYBOARD,'3',0,0,0,0
              INPUT INPUT_KEYBOARD,'3',0,KEYEVENTF_KEYUP,0,0

section '.idata' import data readable writable

  library kernel32,'KERNEL32.DLL',\
          user32,'USER32.DLL'

  import kernel32,\
         Sleep,'Sleep',\
         ExitProcess,'ExitProcess'

  import user32,\
         MessageBox, 'MessageBoxA',\
         FindWindow, 'FindWindowA',\
         SendInput,'SendInput',\
         SetForegroundWindow,'SetForegroundWindow'    
