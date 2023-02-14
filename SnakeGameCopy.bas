' clears the screen; Sets the title of the window; sets the screen size; sets the fullscreen value to 0(false)
CLS
_TITLE "SNAKE GAME"

' loads a image
DIM pic1 AS LONG
SCREEN _NEWIMAGE(640, 480, 32)
pic1 = _LOADIMAGE("pic3.png")
_PUTIMAGE (0, -30), pic1

DIM is_fullscreen AS INTEGER

' makes the first index of array start at 1 instead of 0; Sets up the randomize timer
RANDOMIZE TIMER

' setups score and highscore(will be used to compare with score, so it can update high or medium or low)
DIM score, highscore AS INTEGER

' sets the max length of snake as a constant; Snake body as an array
CONST MAX_SNAKE_LENGTH = 500
DIM snakeArray(1 TO MAX_SNAKE_LENGTH, 0 TO 1) AS INTEGER

' The food's x and y position
DIM foodx AS INTEGER
DIM foody AS INTEGER

' startup values
foodx = INT(RND * 70) + 3
foody = INT(RND * 20) + 3

DIM sn AS INTEGER ' for looping in snakeLenght

'snake head x and y
DIM snakeX AS INTEGER
DIM snakeY AS INTEGER
' snake movement direction xd, yd
DIM snakeXd AS INTEGER
DIM snakeYd AS INTEGER

' snake length(hold how long the snake is), anim(current anim for snake head), died(0 for no, -1 for yes)
DIM snakeSnakeLength AS INTEGER
DIM snakeAnim AS INTEGER
DIM snakeDied AS INTEGER

' initial values
snakeX = 15
snakeY = 31
snakeDied = 0
snakeYd = 1
snakeXd = 0
snakeSnakeLength = 1


' Movement holder and snakespeed(used for difficulty and highscore type)
DIM keypress AS STRING
DIM snakeSpeed AS INTEGER

'gives choices for speed; sets up the game screen
snakeSpeed = speed_choices(snakeSpeed)
SCREEN _NEWIMAGE(640, 480, 256)

DO
    'Input movement for snake
    keypress = INKEY$
    keypress = UCASE$(keypress)

    ' handles the if's
    IF keypress = CHR$(0) + CHR$(72) OR keypress = "W" THEN 'up
        IF snakeYd <> 1 THEN
            snakeXd = 0
            snakeYd = -1
        END IF
    ELSEIF keypress = CHR$(0) + CHR$(80) OR keypress = "S" THEN 'down
        IF snakeYd <> -1 THEN
            snakeXd = 0
            snakeYd = 1
        END IF
    ELSEIF keypress = CHR$(0) + CHR$(77) OR keypress = "D" THEN 'right
        IF snakeXd <> -1 THEN
            snakeXd = 1
            snakeYd = 0
        END IF
    ELSEIF keypress = CHR$(0) + CHR$(75) OR keypress = "A" THEN 'left
        IF snakeXd <> 1 THEN
            snakeXd = -1
            snakeYd = 0
        END IF
    ELSEIF keypress = "B" THEN 'go to browser
        BEEP
        SHELL "start https://skyquestweb.wordpress.com/"
    ELSEIF keypress = "F" THEN ' on and off fullscreen
        BEEP
        IF is_fullscreen = 0 THEN
            is_fullscreen = 1
            _FULLSCREEN
        ELSE
            is_fullscreen = 0
            _FULLSCREEN _OFF
        END IF
    END IF


    ' moves snake
    snakeX = snakeX + snakeXd
    snakeY = snakeY + snakeYd

    IF snakeX < 4 THEN ' appear on right
        snakeX = 77
    ELSEIF snakeX > 77 THEN 'appear on left
        snakeX = 4
    ELSEIF snakeY < 2 THEN ' appear on down
        snakeY = 25
    ELSEIF snakeY > 25 THEN ' appear on down
        snakeY = 2
    END IF

    ' did  snake run into itself  ; snake died
    FOR sn = 2 TO snakeSnakeLength
        IF snakeY = snakeArray(sn, 0) AND snakeX = snakeArray(sn, 1) THEN
            snakeDied = -1
            BEEP
        END IF
    NEXT

    'did snake eat frut  ; snake get bigger
    IF snakeX = foodx AND snakeY = foody THEN
        score = score + 1 'increments score by 1
        snakeAnim = 1
        BEEP
        WHILE foodx = snakeX AND foody = snakeY
            foodx = INT(RND * 70) + 3
            foody = INT(RND * 20) + 3
        WEND
        snakeSnakeLength = snakeSnakeLength + 1
    END IF

    ' check if player died; if died then game ends
    IF snakeDied THEN
        keypress = CHR$(27)
    END IF

    'clears screen before drawing garden, snake, texts
    CLS

    'show garden
    LINE (20, 10)-(620, 400), 15, B

    'show fruit
    COLOR 2
    LOCATE foody, foodx: PRINT CHR$(6)
    COLOR 15

    'show snake
    snakeArray(1, 0) = snakeY
    snakeArray(1, 1) = snakeX
    FOR sn = snakeSnakeLength TO 1 STEP -1
        snakeArray(sn + 1, 0) = snakeArray(sn, 0)
        snakeArray(sn + 1, 1) = snakeArray(sn, 1)
        IF sn <> 1 THEN 'tries not to print behind head(to solve graphics problems for qbjs)
            COLOR 4
            LOCATE snakeArray(sn, 0), snakeArray(sn, 1): PRINT "Û"
            COLOR 15
        END IF
    NEXT
    snakeArray(1, 0) = snakeY
    snakeArray(1, 1) = snakeX

    ' snake head
    COLOR 12
    IF snakeAnim = 0 THEN
        LOCATE snakeY, snakeX: PRINT CHR$(2)
    ELSEIF snakeAnim = 1 THEN
        LOCATE snakeY, snakeX: PRINT CHR$(1)
    END IF
    COLOR 15

    'score and web, fullscreen
    LOCATE 27, 3: PRINT "SCORE:"; STR$(score); "   (Press B for website, Press F for fullscreen)"

    ' handles the saving and loading data
    highscore = load_data(snakeSpeed) ' loads

    IF score > highscore THEN ' checks if greater
        CALL save_data(score, snakeSpeed) 'saves
    END IF

    _DISPLAY

    snakeAnim = 0
    IF snakeSpeed = 1 THEN
        _LIMIT 7
    ELSEIF snakeSpeed = 2 THEN
        _LIMIT 14
    ELSEIF snakeSpeed = 3 THEN
        _LIMIT 20
    END IF

LOOP UNTIL keypress = CHR$(27)

END


' Handles the speed choices AKA difficulty
FUNCTION speed_choices (snakeSpeed AS INTEGER)
    'leaves some space for image
    PRINT
    PRINT
    PRINT
    PRINT
    PRINT "1. EASY"
    PRINT "2. MEDIUM"
    PRINT "3. HARD"
    INPUT "ENTER SNAKE SPEED"; snakeSpeed
    BEEP

    WHILE snakeSpeed <> 1 AND snakeSpeed <> 2 AND snakeSpeed <> 3
        PRINT "INVALID, Please enter 1 or 2 or 3"
        INPUT "ENTER SNAKE SPEED"; snakeSpeed
        BEEP
    WEND

    speed_choices = snakeSpeed
END FUNCTION


'loads data
FUNCTION load_data (value1 AS INTEGER)

    DIM text AS STRING
    DIM text1 AS STRING
    DIM text2 AS STRING
    DIM text3 AS STRING

    ' makes new file if data.txt does not exist  and does not rewrite if it exists
    OPEN "data.txt" FOR APPEND AS #1
    CLOSE #1

    ' opens data.txt to save player data
    OPEN "data.txt" FOR INPUT AS #1

    ' writes data
    DO UNTIL EOF(1)
        LINE INPUT #1, text

        ' Gets highscore easy
        text1 = get_highscore_type$(text, ".", ",")
        text2 = get_highscore_type$(text, ",", ";")
        text3 = get_highscore_type$(text, ";", ":")

        LOCATE 28, 3: PRINT "HIGHSCORES = EASY:"; text1; " MEDUIM:"; text2; " HARD:"; text3

        IF value1 = 1 THEN
            load_data = VAL(text1)
        ELSEIF value1 = 2 THEN
            load_data = VAL(text2)
        ELSEIF value1 = 3 THEN
            load_data = VAL(text3)
        END IF
    LOOP

    CLOSE #1

END FUNCTION


'saves data
SUB save_data (value1 AS INTEGER, value2 AS INTEGER) ' value2 is gamemode AKA snakeSpeed, value1 is my score

    DIM values AS STRING
    DIM text AS STRING

    OPEN "data.txt" FOR INPUT AS #1
    DO UNTIL EOF(1)
        LINE INPUT #1, text
    LOOP
    CLOSE #1

    IF value2 = 1 THEN
        values = "." + STR$(value1) + "," + get_highscore_type$(text, ",", ";") + ";" + get_highscore_type$(text, ";", ":") + ":"
    ELSEIF value2 = 2 THEN
        values = "." + get_highscore_type$(text, ".", ",") + "," + STR$(value1) + ";" + get_highscore_type$(text, ";", ":") + ":"
    ELSEIF value2 = 3 THEN
        values = "." + get_highscore_type$(text, ".", ",") + "," + get_highscore_type$(text, ",", ";") + ";" + STR$(value1) + ":"
    END IF

    ' checks if score is greater than highscore; if true then save data
    OPEN "data.txt" FOR OUTPUT AS #1
    PRINT #1, values
    CLOSE #1

END SUB

FUNCTION get_highscore_type$ (value1 AS STRING, ts AS STRING, te AS STRING) ' value1 is the full data from "data.txt", ts is the start, te is the end
    DIM index, bool AS INTEGER
    output_text$ = ""

    FOR index = 0 TO LEN(value1)
        IF MID$(value1, index, 1) = ts OR bool = 1 THEN
            bool = 1
            IF MID$(value1, index, 1) = te THEN
                bool = 0
            END IF
            IF MID$(value1, index, 1) <> ts AND MID$(value1, index, 1) <> te THEN
                output_text$ = output_text$ + MID$(value1, index, 1)
            END IF
        END IF
    NEXT index

    get_highscore_type$ = output_text$
END FUNCTION



