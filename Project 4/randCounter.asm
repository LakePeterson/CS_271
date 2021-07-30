TITLE Arrays, Addressing, and Stack-Passed Parameters Program 4

; Author: Lake Peterson
; Last Modified: July 30, 2021
; OSU email address: peterlak@oregonstate.edu
; Course number/section: CS271 Section 001
; Project Number: 4
; Due Date: August 3, 2021
; Description: Determines a filled array with 200 numbers and then counts each instance of the random numnbers

INCLUDE Irvine32.inc

;CONSTANT VALUES
HI = 29
LO = 10
ARRAYSIZE = 200

.data
	;Strings used for printing out the intro/directions for using the calculator
	Intro				BYTE	"Generating and Counting Random integers! Programmed by Lake Peterson.", 0
	DirectionsOne		BYTE	"This program generates ", 0
    DirectionsTwo       BYTE    " random numbers in the range [", 0
    DirectionsThree     BYTE    " ... ", 0
    DirectionsFour      BYTE    "], displays the", 0
	DirectionsFive		BYTE	"array of generated numbers, counts how many times each number appears,", 0
	DirectionsSix		BYTE	"and then displays the number of instances of each value,", 0
	DirectionsSeven		BYTE	"starting with the number of ", 0
    DirectionsEight     BYTE    "s.", 0
	DisplayNumbers		BYTE	"Your random numbers:", 0
    Spaces              BYTE    " ", 0
	DisplayResultsOne	BYTE	"I counted all of the values and computed the following results. The top line", 0
	DisplayResultsTwo	BYTE	"shows the value and the lower line shows the corresponding count.", 0
	NumberList			BYTE	"010 011 012 013 014 015 016 017 018 019 020 021 022 023 024 025 026 027 028 029", 0
	GoodbyeMessage		BYTE	"Goodbye, and thanks for using this program!", 0

	;Variables used to ask/store the values
	randomNumberArray	DWORD	ARRAYSIZE DUP(?)
    zeroPad             DWORD   0

.code
main PROC
	;Get the random number generator started
	call randomize

	;Procedure call for the introduction of the program
	push	OFFSET Intro
	push	OFFSET DirectionsOne
	push	OFFSET DirectionsTwo
	push	OFFSET DirectionsThree
	push	OFFSET DirectionsFour
    push	OFFSET DirectionsFive
	push	OFFSET DirectionsSix
	push	OFFSET DirectionsSeven
	push	OFFSET DirectionsEight
    push	OFFSET ARRAYSIZE
    push	OFFSET HI
    push	OFFSET LO
	call	introduction

	;Procedure call to fill the dedicated array with random value
	push	OFFSET ARRAYSIZE
    push	OFFSET randomNumberArray
    push	OFFSET HI
    push	OFFSET LO
    call	fillArray

	;Procedure call to display the entries of someArray to the user
    ;Display unsorted array to the console
    push    OFFSET ARRAYSIZE
    push    OFFSET randomNumberArray
    push    OFFSET zeroPad
    call    displayList

	;Procedure call to print a zero-padded header of values
	;call	displayHeader

	;Procedure call to inspect each element of someArray1 and keeps track of how many instances were found
	;call	countList

	;Procedure call for the goodbye message of the program
	call	goodbye

; ---------------------------------------------------------------------------------
; Name: introduction
; Descritpion: Displays an intro message and the directions for the program.
; Receives:
;   [ebp+16] = ARRAYSIZE -> Length of the array
;	[ebp+12] = HI -> Constant value and upper bound for accepted values
;	[ebp+8]  = LO -> Constant value and lower bound for accepted values
; ---------------------------------------------------------------------------------
introduction PROC
	;Initialize Stack
	push	ebp
    mov		ebp, esp

	;Print intro/name and directions
	mov		edx, OFFSET Intro
    call	WriteString
    call    CrLf
    call    CrLf
	
	;Print directions
	mov		edx, OFFSET DirectionsOne
    call	WriteString
    mov	    eax, [ebp+16]
	call	WriteDec
    mov		edx, OFFSET DirectionsTwo
    call	WriteString
    mov	    eax, [ebp+8]
	call	WriteDec
    mov		edx, OFFSET DirectionsThree
    call	WriteString
    mov	    eax, [ebp+12]
	call	WriteDec
    mov		edx, OFFSET DirectionsFour
    call	WriteString
    call    CrLf
    mov		edx, OFFSET DirectionsFive
    call	WriteString
    call    CrLf
    mov		edx, OFFSET DirectionsSix
    call	WriteString
    call    CrLf
    mov		edx, OFFSET DirectionsSeven
    call	WriteString
    mov	    eax, [ebp+8]
	call	WriteDec
    mov		edx, OFFSET DirectionsEight
    call	WriteString
    call    CrLf
    call    CrLf

	;Clean Stack
	pop		ebp
    ret		12

introduction ENDP

; ---------------------------------------------------------------------------------
; Name: fillArray
; Description: Inserts random integers (LO <-> HI) into an array
; Preconditions: The array must only contain positive values between 10 and 29 
; Postconditions: Array must be filled with values and be size of ARRAYSIZE 
; Receives:
;   [ebp+20] = ARRAYSIZE -> Length of the array
;	[ebp+16] = randNumberArray -> The array
;	[ebp+12] = HI -> Constant value and upper bound for accepted values
;	[ebp+8] = LO -> Constant value and lower bound for accepted values
; returns: Nothing
; ---------------------------------------------------------------------------------
fillArray PROC
    ;Initialize Stack
	push	ebp
    mov		ebp, esp

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
    ret		16

fillArray ENDP

; ---------------------------------------------------------------------------------
; Name: displayList
; Description: Displays the contents of the array
; Preconditions: The array must be filled.
; Postconditions: None
; Receives:
;	[ebp+16] = ARRAYSIZE -> Length of the array
;	[ebp+12] = randNumberArray -> The array
;	[ebp+8]  = zeroPad -> Indicates if the numbers are padded with leading zeros
; returns: Prints the contents of the array to the screen.
; ---------------------------------------------------------------------------------
displayList PROC
    ;Initialize Stack
	push	ebp
    mov		ebp, esp

    ; Display section title
    mov             edx, OFFSET DisplayNumbers
    call            WriteString
    call            CrLf

    ;Move parameters and values into registers to setup printing the array
    mov             ebx, 1
    mov             ecx, [ebp + 16]
    mov             esi, [ebp + 12]

    printArray:
        ;Display the number and account for spaces
        mov     eax, [esi]
        call    WriteDec
        mov     edx, OFFSET Spaces
        call    WriteString
        cmp	    ebx, 20
		jge	    newLine
        inc     ebx
        add     esi, 4
        loop    printArray

    newLine:
        call    CrLf
        mov     ebx, 1
        loop    printArray

    call    CrLf

    ;Clean Stack
	pop     ebp
    ret		16

displayList ENDP

; ---------------------------------------------------------------------------------
; Name: goodbye
; Descritpion: Displays an goodbye message and the directions for the program.
; Receives:
;	[ebp+8]  = reference to message
; ---------------------------------------------------------------------------------
goodbye PROC
	;Print goodbye message
    mov     edx, OFFSET GoodbyeMessage
    call	WriteString
    call    CrLf
    exit

goodbye ENDP

main ENDP
END main
