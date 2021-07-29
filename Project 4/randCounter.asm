TITLE Arrays, Addressing, and Stack-Passed Parameters Program 4

; Author: Lake Peterson
; Last Modified: July 30, 2021
; OSU email address: peterlak@oregonstate.edu
; Course number/section: CS271 Section 001
; Project Number: 4
; Due Date: August 3, 2021
; Description: Determines a filled array with 200 numbers and then counts each instance of the random numnbers

INCLUDE Irvine32.inc

;set constants
HI = 29
LO = 10
ARRAYSIZE = 200

.data
	;Strings used for printing out the intro/directions for using the calculator
	Intro				BYTE	"Generating and Counting Random integers! Programmed by Lake Peterson.", 0
	DirectionsOne		BYTE	"This program generates 200 random numbers in the range [10 ... 29], displays the", 0
	DirectionsTwo		BYTE	"array of generated numbers, counts how many times each number appears,", 0
	DirectionsThree		BYTE	"and then displays the number of instances of each value,", 0
	DirectionsFour		BYTE	"starting with the number of 10s.", 0
	unsortedTitle		BYTE	"Your random numbers:", 0
    Spaces              BYTE    " ", 0
	DisplayResultsOne	BYTE	"I counted all of the values and computed the following results. The top line", 0
	DisplayResultsTwo	BYTE	"shows the value and the lower line shows the corresponding count.", 0
	NumberList			BYTE	"010 011 012 013 014 015 016 017 018 019 020 021 022 023 024 025 026 027 028 029", 0
	GoodbyeMessage		BYTE	"Goodbye, and thanks for using this program!", 0

	;Variables used to ask/store the values
	randomNumberArray	DWORD	ARRAYSIZE DUP(?)
    numbersInLine   DWORD   0

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
	call	introduction

	;Procedure call to fill the dedicated array with random value
	push	OFFSET ARRAYSIZE
    push	OFFSET randomNumberArray
    push	OFFSET HI
    push	OFFSET LO
    call	fillArray

	;Procedure call to display the entries of someArray to the user
    ;Display unsorted array to the console
    push            OFFSET numbersInLine
    push            OFFSET unsortedTitle
    push            OFFSET ARRAYSIZE
    push            OFFSET randomNumberArray
    call            displayList

	;Procedure call to print a zero-padded header of values
	;call	displayHeader

	;Procedure call to inspect each element of someArray1 and keeps track of how many instances were found
	;call	countList

	;Procedure call for the goodbye message of the program
	push	OFFSET GoodbyeMessage
	call	goodbye

; ---------------------------------------------------------------------------------
; Name: introduction
; Descritpion: Displays an intro message and the directions for the program.
; Receives:
;	[ebp+24] = reference to message
;	[ebp+20] = reference to message
;	[ebp+16] = reference to message
;	[ebp+12] = reference to message
;	[ebp+8]  = reference to message
; ---------------------------------------------------------------------------------
introduction PROC
	;Initialize Stack
	push	ebp
    mov		ebp, esp

	;Print intro/name and directions
	mov		edx, [ebp+24]
    call	WriteString
    call    CrLf
	
	;Print directions
	mov		edx, [ebp+20]
    call	WriteString
    call    CrLf
	mov		edx, [ebp+16]
    call	WriteString
    call    CrLf
	mov		edx, [ebp+12]
    call	WriteString
    call    CrLf
	mov		edx, [ebp+8]
    call	WriteString
    call    CrLf
	call    CrLf

	;Clean Stack
	pop		ebp
    ret		16

introduction ENDP

; ---------------------------------------------------------------------------------
; Name: fillArray
; Description: Inserts random integers (10 - 29) into an array
; Preconditions: The array must only contain positive values between 10 and 29 
; Postconditions: Array must be filled with values and be size of ARRAYSIZE 
; Receives:
;   [ebp+20] = ARRAYSIZE -> Length of the array
;	[ebp+16] = randNumberArray -> The array
;	[ebp+12] = HI -> Constant value and upper bound for accepted values (29)
;	[ebp+8] = LO -> Constant value and lower bound for accepted values (10)
; returns: An array that is filled with positive integers
; ---------------------------------------------------------------------------------
fillArray PROC
    ;Initialize Stack
	push	ebp
    mov		ebp, esp

    ;Move parameters into registers
    mov     ecx, [ebp+20]
    mov     esi, [ebp+16]
    ;mov     ecx, [ebp+12]

    ;Determine a value 10 - 29 and insert into the array
    insertRandVal:
        mov     eax, [ebp+12]
        sub     eax, [ebp+8]
        add     eax, 1
        call    RandomRange
        add     eax, [ebp+8]
        mov     [esi], eax
        add     esi, 4
        loop    insertRandVal

    ;Clean Stack
	pop     ebp
    ret		12

fillArray ENDP

displayList PROC

    ;Set stack frame
    push            ebp
    mov             ebp, esp

    ; Display section title
    mov             edx, [ebp + 16] ;Title
    call            WriteString
    call            CRLF

    mov             ecx, [ebp + 12] ;ArraySize
    mov             esi, [ebp + 8] ;List
    mov             edx, [ebp + 20] ;numbersInLine

    mov             edx, 0

    beginLoop:

        ;Display the number and account for spaces
        mov             eax, [esi]
        call            WriteDec
        mov             edx, OFFSET Spaces
        call            WriteString
        inc             edx

        ;Check if new line is needed. If 10 number in the line already
        mov             edx, 0
        mov             eax, edx
        mov             ebx, 10
        div             ebx
        cmp             ebx, 0
        jne             endLoop
        call            CRLF

    endLoop:
        add             esi, 4
        loop            beginLoop

    call            CRLF
    call            CRLF

    pop             ebp
    ret             16
displayList ENDP

; ---------------------------------------------------------------------------------
; Name: goodbye
; Descritpion: Displays an goodbye message and the directions for the program.
; Receives:
;	[ebp+8]  = reference to message
; ---------------------------------------------------------------------------------
goodbye PROC
	;Initialze Stack
	push	ebp
    mov		ebp, esp

	;Print goodbye message
	mov		edx, [ebp + 8]
    call	WriteString
    call    CrLf
    exit

goodbye ENDP

main ENDP
END main
