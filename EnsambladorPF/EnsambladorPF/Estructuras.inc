WNDCLASSEX struct
	cbSize dword ?
    style dword ?
    lpfnWndProc dword ?
    cbClsExtra dword ?
    cbWndExtra dword ?
    hInstance dword ?
    hIcon dword ?
    hCursor dword ?
    hbrBackground dword ?
    lpszMenuName dword ?
    lpszClassName dword ?
    hIconSm dword ?
WNDCLASSEX ends

POINT STRUCT
  x  DWORD ?
  y  DWORD ?
POINT ENDS

MSG STRUCT
  hwnd      DWORD      ?
  message   DWORD      ?
  wParam    DWORD      ?
  lParam    DWORD      ?
  time      DWORD      ?
  pt        POINT      <>
MSG ENDS

RECT STRUCT
  left    dd      ?
  top     dd      ?
  right   dd      ?
  bottom  dd      ?
RECT ENDS

PAINTSTRUCT STRUCT
  hdc           DWORD      ?
  fErase        DWORD      ?
  rcPaint       RECT       <>
  fRestore      DWORD      ?
  fIncUpdate    DWORD      ?
  rgbReserved   BYTE 32 dup(?)
PAINTSTRUCT ENDS

XINPUT_GAMEPAD	STRUCT
  wButtons      WORD	?
  bLeftTrigger  BYTE	?
  bRightTrigger	BYTE	?
  sThumbLX		WORD	?
  sThumbLY		WORD	?
  sThumbRX		WORD	?
  sThumbRY		WORD	?
XINPUT_GAMEPAD  ENDS

XINPUT_STATE STRUCT
  dwPacketNumber	DWORD	?
  Gamepad			XINPUT_GAMEPAD <>
XINPUT_STATE	ENDS

