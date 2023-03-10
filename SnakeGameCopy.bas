' clears the screen; Sets the title of the window; sets the screen size; sets the fullscreen value to 0(false)
CLS
$EXEICON:'.\icon.ico'
_TITLE "SNAKE GAME"

' loads a image
DIM pic1&
SCREEN _NEWIMAGE(640, 480, 32)
pic1& = _LOADIMAGE("pic3.png")
_PUTIMAGE (0, -30), pic1&

DIM is_fullscreen%, use_keypad%

' makes the first index of array start at 1 instead of 0; Sets up the randomize timer
RANDOMIZE TIMER

' setups score and highscore(will be used to compare with score, so it can update high or medium or low)
DIM score%, highscore%

' sets the max length of snake as a constant; Snake body as an array
REDIM snakeArray%(1 TO 500, 0 TO 1)

' The food's x and y position
DIM foodx%
DIM foody%

' startup values
foodx% = INT(RND * 48) + 4
foody% = INT(RND * 23) + 2

DIM sn% ' for looping in snakeLenght

'snake head x and y
DIM snakeX%
DIM snakeY%
' snake movement direction xd, yd
DIM snakeXd%
DIM snakeYd%

' snake length(hold how long the snake is), anim(current anim for snake head), died(0 for no, -1 for yes)
DIM snakeLength%
DIM snakeAnim%
DIM snakeDied%

' initial values
snakeX% = 38
snakeY% = 12
snakeDied% = 0
snakeYd% = 0
snakeXd% = 1
snakeLength% = 1
snakeAnim% = 0

' Movement holder and snakespeed(used for difficulty and highscore type)
DIM keypress%, snakeSpeed%

'gives choices for speed; sets up the game screen
snakeSpeed% = speed_choices%(snakeSpeed%)
use_keypad% = keypad%(use_keypad%)
SCREEN _NEWIMAGE(640, 480, 256)
_FREEIMAGE pic1&

DO
    keypress% = _KEYHIT

    DIM mi, mb, mx%, my%

    DO WHILE _MOUSEINPUT
    LOOP

    mi = _MOUSEINPUT
    mb = _MOUSEBUTTON(1)
    mx% = _MOUSEX
    my% = _MOUSEY

    ' handles the if's
    IF _KEYDOWN(87) OR _KEYDOWN(119) OR _KEYDOWN(18432) THEN 'up
        IF snakeYd% <> 1 THEN
            snakeXd% = 0
            snakeYd% = -1
        END IF
    ELSEIF _KEYDOWN(83) OR _KEYDOWN(115) OR _KEYDOWN(20480) THEN 'down
        IF snakeYd% <> -1 THEN
            snakeXd% = 0
            snakeYd% = 1
        END IF
    ELSEIF _KEYDOWN(68) OR _KEYDOWN(100) OR _KEYDOWN(19712) THEN 'right
        IF snakeXd% <> -1 THEN
            snakeXd% = 1
            snakeYd% = 0
        END IF
    ELSEIF _KEYDOWN(65) OR _KEYDOWN(97) OR _KEYDOWN(19200) THEN 'left
        IF snakeXd% <> 1 THEN
            snakeXd% = -1
            snakeYd% = 0
        END IF
    ELSEIF mb AND use_keypad% = 1 THEN ' handles the input for touchscreen
        IF snakeYd% <> 1 AND mx% >= 500 AND mx% <= 530 AND my% >= 264 AND my% <= 320 THEN
            snakeXd% = 0
            snakeYd% = -1
        ELSEIF snakeYd% <> -1 AND mx% >= 500 AND mx% <= 530 AND my% >= 330 AND my% <= 384 THEN
            snakeXd% = 0
            snakeYd% = 1
        ELSEIF snakeXd% <> -1 AND mx% >= 540 AND mx% <= 600 AND my% >= 310 AND my% <= 344 THEN
            snakeXd% = 1
            snakeYd% = 0
        ELSEIF snakeXd% <> 1 AND mx% >= 434 AND mx% <= 490 AND my% >= 310 AND my% <= 344 THEN
            snakeXd% = -1
            snakeYd% = 0
        END IF

    ELSEIF keypress% = 66 OR keypress% = 98 THEN 'go to browser(B)
        BEEP
        SHELL "start https://skyquestweb.wordpress.com/"
    ELSEIF keypress% = 70 OR keypress% = 102 THEN ' on and off fullscreen(F)
        BEEP
        IF is_fullscreen% = 0 THEN
            is_fullscreen% = 1
            _FULLSCREEN
        ELSE
            is_fullscreen% = 0
            _FULLSCREEN _OFF
        END IF
    END IF


    ' moves snake
    snakeX% = snakeX% + snakeXd%
    snakeY% = snakeY% + snakeYd%

    IF snakeX% < 4 THEN ' appear on right
        snakeX% = 77
    ELSEIF snakeX% > 77 THEN 'appear on left
        snakeX% = 4
    ELSEIF snakeY% < 2 THEN ' appear on down
        snakeY% = 25
    ELSEIF snakeY% > 25 THEN ' appear on down
        snakeY% = 2
    END IF

    ' did  snake run into itself  ; snake died
    FOR sn% = 2 TO snakeLength%
        IF snakeY% = snakeArray%(sn%, 0) AND snakeX% = snakeArray%(sn%, 1) THEN
            snakeDied% = -1
            BEEP
        END IF
    NEXT

    'did snake eat frut  ; snake get bigger
    IF snakeX% = foodx% AND snakeY% = foody% THEN
        score% = score% + 1 'increments score by 1
        snakeAnim% = 1
        BEEP
        WHILE foodx% = snakeX% AND foody% = snakeY%
            IF use_keypad% = 0 THEN
                foodx% = INT(RND * 73) + 4
                foody% = INT(RND * 23) + 2

            ELSE
                foodx% = INT(RND * 48) + 4
                foody% = INT(RND * 23) + 2
            END IF
        WEND
        snakeLength% = snakeLength% + 1
    END IF

    ' check if player died; game resets
    IF snakeDied% THEN
        score% = 0
        highscore% = 0

        REDIM snakeArray%(1 TO 500, 0 TO 1)

        IF use_keypad% = 0 THEN
            foodx% = INT(RND * 73) + 4
            foody% = INT(RND * 23) + 2

        ELSE
            foodx% = INT(RND * 48) + 4
            foody% = INT(RND * 23) + 2
        END IF

        snakeX% = 38
        snakeY% = 12
        snakeDied% = 0
        snakeYd% = 0
        snakeXd% = 1
        snakeLength% = 1
        snakeAnim% = -1

        keypress% = 0
    END IF

    'clears screen before drawing garden, snake, texts
    CLS

    'show garden
    LINE (20, 10)-(620, 400), 15, B

    'show fruit
    COLOR 2
    LOCATE foody%, foodx%: PRINT CHR$(6)
    COLOR 15

    'show snake
    snakeArray%(1, 0) = snakeY%
    snakeArray%(1, 1) = snakeX%
    FOR sn% = snakeLength% TO 1 STEP -1
        snakeArray%(sn% + 1, 0) = snakeArray%(sn%, 0)
        snakeArray%(sn% + 1, 1) = snakeArray%(sn%, 1)
        IF sn% <> 1 THEN 'tries not to print behind head(to solve graphics problems for qbjs)
            COLOR 4
            LOCATE snakeArray%(sn%, 0), snakeArray%(sn%, 1): PRINT "??"
            COLOR 15
        END IF
    NEXT
    snakeArray%(1, 0) = snakeY%
    snakeArray%(1, 1) = snakeX%

    ' snake head
    COLOR 12
    IF snakeAnim% = 0 THEN
        LOCATE snakeY%, snakeX%: PRINT CHR$(2)
    ELSEIF snakeAnim% = 1 THEN
        LOCATE snakeY%, snakeX%: PRINT CHR$(1)
    END IF
    COLOR 15

    IF use_keypad% = 1 THEN
        LINE (500, 264)-(530, 320), 15, B: LOCATE 19, 65: PRINT CHR$(24)
        LINE (500, 330)-(530, 384), 15, B: LOCATE 23, 65: PRINT CHR$(25)
        LINE (540, 310)-(600, 344), 15, B: LOCATE 21, 72: PRINT CHR$(26)
        LINE (434, 310)-(490, 344), 15, B: LOCATE 21, 58: PRINT CHR$(27)
    END IF

    'score and web, fullscreen
    LOCATE 27, 3: PRINT STR$(snakeSpeed%) + ". "; "SCORE:"; STR$(score%); "   (Press B for website, Press F for fullscreen or alt+enter)"

    ' handles the saving and loading data
    highscore% = load_data%(snakeSpeed%) ' loads

    IF score% > highscore% THEN ' checks if greater
        CALL save_data(score%, snakeSpeed%) 'saves
    END IF

    _DISPLAY

    ' handles the animation; speed of snake
    snakeAnim% = 0
    IF snakeSpeed% = 1 THEN
        _LIMIT 10
    ELSEIF snakeSpeed% = 2 THEN
        _LIMIT 15
    ELSEIF snakeSpeed% = 3 THEN
        _LIMIT 20
    END IF

LOOP UNTIL _KEYDOWN(114) OR _KEYDOWN(82) 'exits game if ESCAPE pressed

END


' Handles the speed choices AKA difficulty
FUNCTION speed_choices% (snakeSpeed%)
    'leaves some space for image
    PRINT
    PRINT
    PRINT
    PRINT

    PRINT "[1. EASY]"
    PRINT "-----------"
    PRINT "[2. MEDIUM]"
    PRINT "-----------"
    PRINT "[3. HARD]"
    PRINT
    PRINT "Click on your option"

    DIM buttonPressed%, mi, mb, mx%, my%

    WHILE buttonPressed% = 0 ' checks if player has pressed a button
        DO WHILE _MOUSEINPUT ' loop finished when there is a mouseinput
        LOOP

        mi = _MOUSEINPUT ' gets input
        mb = _MOUSEBUTTON(1) 'gets the button
        mx% = _MOUSEX 'gets mouse x
        my% = _MOUSEY ' gets mouse y

        IF mb THEN ' if 1 is pressed it does if's for button
            IF ((mx% / 680) * 80) >= 0 AND ((mx% / 680) * 80) <= 9 AND ((my% / 480) * 30) >= 4 AND ((my% / 480) * 30) <= 5 THEN
                snakeSpeed% = 1
                buttonPressed% = 1
                BEEP
            ELSEIF ((mx% / 680) * 80) >= 0 AND ((mx% / 680) * 80) <= 11 AND ((my% / 480) * 30) >= 6 AND ((my% / 480) * 30) <= 7 THEN
                snakeSpeed% = 2
                buttonPressed% = 1
                BEEP
            ELSEIF ((mx% / 680) * 80) >= 0 AND ((mx% / 680) * 80) <= 9 AND ((my% / 480) * 30) >= 8 AND ((my% / 480) * 30) <= 9 THEN
                snakeSpeed% = 3
                buttonPressed% = 1
                BEEP
            END IF
        END IF
    WEND
    buttonPressed% = 0

    speed_choices% = snakeSpeed%
END FUNCTION

FUNCTION keypad% (use_keypad%)
    CLS
    PRINT
    PRINT

    PRINT "Use keypad"
    PRINT "[YES]"
    PRINT "-----"
    PRINT " [NO]"
    PRINT "Click on your option"

    SLEEP 1
    DIM buttonPressed%, mi, mb, mx%, my%

    WHILE buttonPressed% = 0 ' checks if player has pressed a button
        DO WHILE _MOUSEINPUT ' loop finished when there is a mouseinput
        LOOP

        mi = _MOUSEINPUT ' gets input
        mb = _MOUSEBUTTON(1) 'gets the button
        mx% = _MOUSEX 'gets mouse x
        my% = _MOUSEY ' gets mouse y

        IF mb THEN ' if 1 is pressed it does if's for button
            IF ((mx% / 680) * 80) >= 0 AND ((mx% / 680) * 80) <= 6 AND ((my% / 480) * 30) >= 3 AND ((my% / 480) * 30) <= 4 THEN
                use_keypad% = 1
                buttonPressed% = 1
                BEEP
            ELSEIF ((mx% / 680) * 80) >= 0 AND ((mx% / 680) * 80) <= 6 AND ((my% / 480) * 30) >= 5 AND ((my% / 480) * 30) <= 6 THEN
                use_keypad% = 0
                buttonPressed% = 1
                BEEP
            END IF
        END IF
    WEND

    keypad% = use_keypad%
END FUNCTION

'loads data
FUNCTION load_data% (snakeSpeed%)

    DIM text$
    DIM text1$
    DIM text2$
    DIM text3$

    ' makes new file if data.txt does not exist  and does not rewrite if it exists
    OPEN "data.txt" FOR APPEND AS #1
    CLOSE #1

    ' opens data.txt to save player data
    OPEN "data.txt" FOR INPUT AS #1

    ' writes data
    DO UNTIL EOF(1)
        LINE INPUT #1, text$

        ' Gets highscores
        text1$ = get_highscore_type$(text$, ".", ",")
        text2$ = get_highscore_type$(text$, ",", ";")
        text3$ = get_highscore_type$(text$, ";", ":")

        LOCATE 28, 3: PRINT "HIGHSCORES = EASY:"; text1$; " MEDUIM:"; text2$; " HARD:"; text3$, "Press R to quit"

        IF snakeSpeed% = 1 THEN
            load_data% = VAL(text1$)
        ELSEIF snakeSpeed% = 2 THEN
            load_data% = VAL(text2$)
        ELSEIF snakeSpeed% = 3 THEN
            load_data% = VAL(text3$)
        END IF
    LOOP

    CLOSE #1

END FUNCTION


'saves data
SUB save_data (score%, snakeSpeed%) ' value2 is gamemode AKA snakeSpeed, value1 is my score

    DIM values$
    DIM text$

    'gets the current text stored in data.txt
    OPEN "data.txt" FOR INPUT AS #1
    DO UNTIL EOF(1)
        LINE INPUT #1, text$
    LOOP
    CLOSE #1


    ' saves data according to gamemode
    IF snakeSpeed% = 1 THEN
        values$ = "." + STR$(score%) + "," + get_highscore_type$(text$, ",", ";") + ";" + get_highscore_type$(text$, ";", ":") + ":"
    ELSEIF snakeSpeed% = 2 THEN
        values$ = "." + get_highscore_type$(text$, ".", ",") + "," + STR$(score%) + ";" + get_highscore_type$(text$, ";", ":") + ":"
    ELSEIF snakeSpeed% = 3 THEN
        values$ = "." + get_highscore_type$(text$, ".", ",") + "," + get_highscore_type$(text$, ",", ";") + ";" + STR$(score%) + ":"
    END IF

    ' checks if score is greater than highscore; if true then save data
    OPEN "data.txt" FOR OUTPUT AS #1
    PRINT #1, values$
    CLOSE #1

END SUB

FUNCTION get_highscore_type$ (text$, ts$, te$) ' text$ is the full data from "data.txt", ts is the start, te is the end
    DIM index%, bool%
    DIM output_text$

    FOR index% = 0 TO LEN(text$)
        IF MID$(text$, index%, 1) = ts$ OR bool% = 1 THEN
            bool% = 1
            IF MID$(text$, index%, 1) = te$ THEN
                bool% = 0
            END IF
            IF MID$(text$, index%, 1) <> ts$ AND MID$(text$, index%, 1) <> te$ THEN
                output_text$ = output_text$ + MID$(text$, index%, 1)
            END IF
        END IF
    NEXT index%

    get_highscore_type$ = output_text$
END FUNCTION
