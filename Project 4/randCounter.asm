TITLE Arrays, Addressing, and Stack-Passed Parameters Program 4

; Author: Lake Peterson
; Last Modified: August 3, 2021
; OSU email address: peterlak@oregonstate.edu
; Course number/section: CS271 Section 001
; Project Number: 4
; Due Date: August 3, 2021
; Description: Determines a filled array with 180, 200, or 220 numbers and then counts each instance of the random numbers

INCLUDE Irvine32.inc

;CONSTANT VALUES
.const
HI = 32
LO = 13
ARRAYSIZE = 200
COUNTSIZE = 20
ZEROPAD = 1

.data
    ;Strings used for printing out the intro/directions for using the calculator
    Intro		BYTE	"Generating and Counting Random integers! Programmed by Lake Peterson.", 0
    DirectionsOne	BYTE	"This program generates ", 0
    DirectionsTwo       BYTE    " random numbers in the range [", 0
    DirectionsThree     BYTE    " ... ", 0
    DirectionsFour      BYTE    "], displays the", 0
    DirectionsFive	BYTE	"array of generated numbers, counts how many times each number appears,", 0
    DirectionsSix	BYTE	"and then displays the number of instances of each value,", 0
    DirectionsSeven	BYTE	"starting with the number of ", 0
    DirectionsEight     BYTE    "s.", 0
    DisplayNumbers	BYTE	"Your random numbers:", 0
    SinglePadding       BYTE    "0", 0
    DoublePadding       BYTE    "00", 0
    Spaces              BYTE    " ", 0
    DisplayResultsOne	BYTE	"I counted all of the values and computed the following results. The top line", 0
    DisplayResultsTwo	BYTE	"shows the value and the lower line shows the corresponding count.", 0
    NumberList		BYTE	"010 011 012 013 014 015 016 017 018 019 020 021 022 023 024 025 026 027 028 029", 0
    GoodbyeMessage	BYTE	"Goodbye, and thanks for using this program!", 0

    ;Arrays used to store the values
    randomNumberArray	DWORD	ARRAYSIZE   DUP(?)
    counterArray        DWORD   COUNTSIZE   DUP(?)

; ---------------------------------------------------------------------------------
; Name: main
; Descritpion: Controls the operation of the program.
; ---------------------------------------------------------------------------------
.code
main PROC
    ;Get the random number generator started
    call    randomize

    ;Procedure call for the introduction of the program
    push    OFFSET ARRAYSIZE
    push    OFFSET HI
    push    OFFSET LO
    call    introduction

    ;Procedure call to fill the dedicated array with random value
    push    OFFSET ARRAYSIZE
    push    OFFSET randomNumberArray
    push    OFFSET HI
    push    OFFSET LO
    call    fillArray

    ;Procedure call to display the numbers generated numbers to the user
    push    OFFSET ZEROPAD
    push    OFFSET ARRAYSIZE
    push    OFFSET randomNumberArray
    call    displayList

    ;Procedure call to rearrange the array so it is easier to count
    push    OFFSET ARRAYSIZE
    push    OFFSET randomNumberArray
    call    rearrangeList

    ;Procedure call to print a zero-padded header of values
    push    OFFSET HI
    push    OFFSET LO
    call    displayHeader
    
    ;Procedure call to print a count the instances of each number
    push    OFFSET HI
    push    OFFSET counterArray
    push    OFFSET LO
    push    OFFSET randomNumberArray
    push    OFFSET ARRAYSIZE
    call    countList

    ;Procedure call to display the counted instances to the user
    push    OFFSET ZEROPAD
    push    OFFSET COUNTSIZE
    push    OFFSET counterArray
    call    displayList

    ;Procedure call for the goodbye message of the program
    call    goodbye

    exit

; ---------------------------------------------------------------------------------
; Name: introduction
; Descritpion: Displays an intro message and the directions for the program.
; Receives:
;   [ebp+16] = ARRAYSIZE -> Length of the array
;   [ebp+12] = HI -> Constant value and upper bound for accepted values
;   [ebp+8]  = LO -> Constant value and lower bound for accepted values
; ---------------------------------------------------------------------------------
introduction PROC
    ;Initialize Stack
    push    ebp
    mov     ebp, esp

    ;Print intro/name and directions
    mov	    edx, OFFSET Intro
    call    WriteString
    call    CrLf
    call    CrLf
	
    ;Print directions
    mov	    edx, OFFSET DirectionsOne
    call    WriteString
    mov	    eax, [ebp+16]
    call    WriteDec
    mov	    edx, OFFSET DirectionsTwo
    call    WriteString
    mov	    eax, [ebp+8]
    call    WriteDec
    mov	    edx, OFFSET DirectionsThree
    call    WriteString
    mov	    eax, [ebp+12]
    call    WriteDec
    mov     edx, OFFSET DirectionsFour
    call    WriteString
    call    CrLf
    mov	    edx, OFFSET DirectionsFive
    call    WriteString
    call    CrLf
    mov	    edx, OFFSET DirectionsSix
    call    WriteString
    call    CrLf
    mov	    edx, OFFSET DirectionsSeven
    call    WriteString
    mov	    eax, [ebp+8]
    call    WriteDec
    mov	    edx, OFFSET DirectionsEight
    call    WriteString
    call    CrLf
    call    CrLf
    mov     edx, OFFSET DisplayNumbers
    call    WriteString
    call    CrLf

    ;Clean Stack
    pop	    ebp
    ret	    12

introduction ENDP

; ---------------------------------------------------------------------------------
; Name: fillArray
; Description: Inserts random integers (LO <-> HI) into an array
; Preconditions: The array must only contain positive values between 10 and 29 
; Postconditions: Array must be filled with values and be size of ARRAYSIZE 
; Receives:
;   [ebp+20] = ARRAYSIZE -> Length of the array
;   [ebp+16] = randNumberArray -> The array
;   [ebp+12] = HI -> Constant value and upper bound for accepted values
;   [ebp+8] = LO -> Constant value and lower bound for accepted values
; Returns: Nothing
; ---------------------------------------------------------------------------------
fillArray PROC
    ;Initialize Stack
    push    ebp
    mov	    ebp, esp

    ;Move parameters and values into registers to setup array insertions
    mov     ecx, [ebp+20]
    mov     esi, [ebp+16]
    mov     ebx, [ebp+12]
    sub     ebx, [ebp+8]
    add     ebx, 1
    mov     edx, 4

    ;Determine a value 10 - 29 and insert into the array
    insertRandVal:
        mov     eax, ebx
        call    RandomRange
        add     eax, [ebp+8]
        mov     [esi], eax
        add     esi, edx
        loop    insertRandVal

    ;Clean Stack
    pop     ebp
    ret	    16

fillArray ENDP

; ---------------------------------------------------------------------------------
; Name: displayList
; Description: Displays the contents of the array
; Preconditions: The array must be filled.
; Postconditions: None
; Receives:
;   [ebp+16] = ZEROPAD -> Indicates if the numbers are padded with leading zeros
;   [ebp+12] = ARRAYSIZE -> Length of the array
;   [ebp+8]  = randNumberArray -> The array
; Returns: Prints the contents of the array to the screen.
; ---------------------------------------------------------------------------------
displayList PROC
    ;Initialize Stack
    push    ebp
    mov	    ebp, esp

    ;Move parameters and values into registers to setup printing the array
    mov     ebx, 1
    mov     ecx, [ebp + 12]
    mov     esi, [ebp + 8]

    ;Displays the contents ccontained within array
    printArray:
        ;Display the number and account for spaces
        mov     eax, [esi]
        call    WriteDec
        mov     edx, OFFSET Spaces
        call    WriteString
        cmp	ebx, 20
	jge	newLine
        inc     ebx
        add     esi, 4
        loop    printArray

    ;Prints a new line
    newLine:
        call    CrLf
        mov     ebx, 1
        add     esi, 4
        loop    printArray

    call    CrLf

    ;Clean Stack
    pop     ebp
    ret	    12

displayList ENDP

; ---------------------------------------------------------------------------------
; Name: displayHeader
; Description: Prints a zero padded header for the counted values
; Preconditions: HI and LO bounds needed to create
; Postconditions: None
; Receives:
;   [ebp+12] = HI -> Constant value and upper bound for accepted values
;   [ebp+8]  = LO -> Constant value and lower bound for accepted values
; Returns: Header is displayed
; ---------------------------------------------------------------------------------
displayHeader PROC
    ;Initialize Stack
    push    ebp
    mov	    ebp, esp

    ;Display the count header
    mov     edx, OFFSET DisplayResultsOne
    call    WriteString
    call    CrLf
    mov     edx, OFFSET DisplayResultsTwo
    call    WriteString
    call    CrLf

    ;Move parameters and values into registers to setup printing the array
    mov     eax, [ebp+8]
    mov     ecx, 20

    ;Print the values in the display header with single padding
    printSingleHeader:
        cmp     eax, 9
        jle     printDoubleHeader
        mov     edx, OFFSET SinglePadding
        call    WriteString
        call    WriteDec
        mov     edx, OFFSET Spaces
        call    WriteString
        add     eax, 1
        loop    printSingleHeader

    ;Appends a double zero padding
    printDoubleHeader:
        cmp     ecx, 0
        je      exitLoop
        mov     edx, OFFSET DoublePadding
        call    WriteString
        call    WriteDec
        mov     edx, OFFSET Spaces
        call    WriteString
        add     eax, 1
        loop    printSingleHeader

    ;Leave loop once upper bound is hit
    exitLoop:
        call    CrLf

    ;Clean Stack
    pop     ebp
    ret	    8

displayHeader ENDP

; ---------------------------------------------------------------------------------
; Name: rearrangeList
; Description: List is orginaized from hi to lo order so that I can count it easier
; Preconditions: Array and array size is needed
; Postconditions: Array must give the exact same amount of values once organized
; Receives:
;   [ebp+12] = ARRAYSIZE -> Length of the array
;   [ebp+8]  = randNumberArray -> The array
; Returns: Array arranged lo to hi
; ---------------------------------------------------------------------------------
rearrangeList PROC
    ;Initialize Stack
    push    ebp
    mov	    ebp, esp

    ;Move parameters and values into registers to setup switching the numbers
    mov     ebx, 0
    mov     edi, [ebp + 8]
    mov     ecx, [ebp + 12]
    sub     ecx, 1

    ;Loop to put the numbers in the array in order
    switch:
        mov     esi, edi
        push    esi
	mov	ebx, ecx
        push    ecx
	call    switchNumbers
	mov	ecx, ebx
	loop    switch

    ;Clean Stack
    pop     ebp
    ret	    8

rearrangeList ENDP

; ---------------------------------------------------------------------------------
; Name: switchNumbers
; Description: Helper function to rearrangeList
; Preconditions: Swaps the numbers
; Postconditions: Smaller number is swapped
; Returns: None
; ---------------------------------------------------------------------------------
switchNumbers PROC
    ;Initialize Stack
    push    ebp
    mov	    ebp, esp

    ;Switch position of the numbers if needed
    switchNum:
        mov     eax, [esi]
        add     esi, 4
	mov	edx, [esi]
        sub     esi, 4
	cmp	eax, edx
	jl	continue
        cmp	eax, edx
	je	continue
	mov	[esi], edx
        add     esi, 4
	mov	[esi], eax
        sub     esi, 4
	
    ;Go to next number
    continue:
	add	esi, 4
	loop	switchNum

    ;Clean Stack
    cleanStack:
	pop     ebp
        ret	8

switchNumbers ENDP

; ---------------------------------------------------------------------------------
; Name: countList
; Description: Counts each instance in the original array and stored in secondary array
; Preconditions: Original array must be sorted lo to high
; Postconditions: Count stored in secondary array
; Receives:
;   [ebp+12] = ARRAYSIZE -> Length of the array
;   [ebp+8]  = randNumberArray -> The array
; Returns: None
; ---------------------------------------------------------------------------------
countList PROC
    ;Initialize Stack
    push    ebp
    mov	    ebp, esp

    ;Move parameters and values into registers to setup switching the numbers
    mov     ecx, [ebp+8]
    mov     esi, [ebp+12]
    mov     edx, [ebp+16]
    mov     edi, [ebp+20]
    mov     ebx, 0

    ;Count the values in the original array
    countNumbers:
        mov     eax, [esi]
        cmp     edx, eax
        je      findNext
        cmp     edx, [ebp+16]
        jg      foundSame
        jmp     insertCount

    ;Counter needs increased because the number is the same
    foundSame:
        add     ebx, 1

    ;Stores the counted value into the count array
    insertCount:
        mov     edx, eax
        add     esi, 4
        push    ecx
        mov     ecx, eax
        mov     eax, ebx
        mov     [edi], eax
        add     edi, 4
        mov     eax, ecx
        pop     ecx
        mov     ebx, 0

    ;Number count increased and move to next index in the array
    findNext:
        mov     edx, eax
        add     esi, 4
        add     ebx, 1
        loop    countNumbers

    ;Clean Stack
    pop     ebp
    ret	    16

countList ENDP

; ---------------------------------------------------------------------------------
; Name: goodbye
; Descritpion: Displays an goodbye message and the directions for the program.
; ---------------------------------------------------------------------------------
goodbye PROC
    ;Print goodbye message
    mov     edx, OFFSET GoodbyeMessage
    call    WriteString
    call    CrLf
    exit

goodbye ENDP

main ENDP
END main
