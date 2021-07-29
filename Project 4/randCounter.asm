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
HI = 10
LO = 29
ARRAYSIZE = 180

.data
	;Strings used for printing out the intro/directions for using the calculator
	Intro				BYTE	"Generating and Counting Random integers! Programmed by Lake Peterson.", 0
	DirectionsOne		BYTE	"This program generates 200 random numbers in the range [10 ... 29], displays the", 0
	DirectionsTwo		BYTE	"array of generated numbers, counts how many times each number appears,", 0
	DirectionsThree		BYTE	"and then displays the number of instances of each value,", 0
	DirectionsFour		BYTE	"starting with the number of 10s.", 0
	DisplayNumbers		BYTE	"Your random numbers:", 0
	DisplayResultsOne	BYTE	"I counted all of the values and computed the following results. The top line", 0
	DisplayResultsTwo	BYTE	"shows the value and the lower line shows the corresponding count.", 0
	NumberList			BYTE	"010 011 012 013 014 015 016 017 018 019 020 021 022 023 024 025 026 027 028 029", 0
	GoodbyeMessage		BYTE	"Goodbye, and thanks for using this program!", 0

	;Variables used to ask/store the values
	numberArray			DWORD	ARRAYSIZE DUP(?)

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
	;call	fillArray

	;Procedure call to display the entries of someArray to the user
	;call	displayList

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
	;Initialze Stack
	push	ebp
    mov		ebp, esp

	;Print intro/name and directions
	mov		edx, [ebp + 24]
    call	WriteString
    call    CrLf
	
	;Print directions
	mov		edx, [ebp + 20]
    call	WriteString
    call    CrLf
	mov		edx, [ebp + 16]
    call	WriteString
    call    CrLf
	mov		edx, [ebp + 12]
    call	WriteString
    call    CrLf
	mov		edx, [ebp + 8]
    call	WriteString
    call    CrLf
	call    CrLf

	;Clean Stack
	pop		ebp
    ret		16

introduction ENDP

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

	;Clean Stack
	pop		ebp
    ret		12
	exit

goodbye ENDP

main ENDP
END main