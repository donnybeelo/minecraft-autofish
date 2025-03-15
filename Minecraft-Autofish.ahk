MsgBox, Welcome! Press F2 to mark the position of the fishing hook, F3 to start fishing, F4 to stop, and F12 to exit.
x=1110
y=650

F2::
    MouseGetPos, x, y
    ToolTip, x=%x% y=%y%
return

F3::

    stopped=0

    ToolTip, Started! Casting first line..., 1, 1
    Send, {WheelDown}
    Sleep, 100
    Send, {WheelUp}
    Sleep, 100
    Send, {RButton}
    reeled=1
    Sleep, 1000

    loop
    {
        if (stopped)
            break
        PixelGetColor, color, x, y, RGB
        ; ToolTip, %color%, 1, 1
        if (color <= 0x505050 && reeled)
        {
            reeled=0
            ToolTip, Fishing... press F4 to stop, 1, 1
            Sleep, 1000
        }
        else if (color > 0x505050 && !reeled)
        {
            ToolTip, Casting line..., 1, 1
            Sleep, 500
            Send, {RButton}
            reeled=1
            Sleep, 1000
        }
        else if (color > 0x505050 && reeled)
        {
            Sleep, 3000
            PixelGetColor, color, x, y, RGB
            if (color > 0x505050 && !stopped)
            {
                MsgBox, Color comparison failed. Make sure you:`n`n	Selected the hook of the fishing rod by hovering over it with your mouse and pressing F2`n`n	The block behind the hook is dark enough (more specifically less red) (even more specifically the colour code is less than 0x505050), and `n`n	Your ping isn't higher than 3000ms.
                stopped=1
                if (reeled)
                    Send, {RButton}
                ToolTip, Stopped. Press F3 to start or press F12 to quit, 1, 1
            }
        }
    }
return

F4::
    stopped=1
    if (reeled)
        Send, {RButton}
    ToolTip, Stopped. Press F3 to start or press F12 to quit, 1, 1
return

F12::ExitApp
