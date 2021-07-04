TITLE Basic Logic and Arithmetic Program 1

; Author: Lake Peterson
; Last Modified: July 5, 2021
; OSU email address: peterlak@oregonstate.edu
; Course number/section: CS271 Section 001
; Project Number: 1
; Due Date: July 4, 2021
; Description: Calculator used for determining the volume of a prism, pyramid, and sphere based on user input.

INCLUDE Irvine32.inc

.data

	;Strings used for printing out the intro/directions for using the calculator
	Intro			BYTE	"Welcome to the Volume Calculator by Lake Peterson", 0
	DirectionsOne		BYTE	"Please enter two numbers that are greater than zero and", 0
	DirectionsTwo		BYTE	"I will use them to compute the volume of several shapes.", 0
	ClosingMessage		BYTE	"Thanks for using my calculator! Goodbye!", 0

	;Variables used to ask/store the users values
	UserInputOne		BYTE	"First number: ", 0
	UserValueOne		DWORD	?
	UserInputTwo		BYTE	"Second number: ", 0
	UserValueTwo		DWORD	?

	;Variables used to store the product of the shapes volumes
	PrismVolume			DWORD	?
	PyramidVolume		DWORD	?
	SphereVolumeOne		DWORD	?
	SphereVolumeTwo		DWORD	?

	;Strings used for printing out the answer for a prism
	PrismStmntOne		BYTE	"A prism that has an area of ", 0
	PrismStmntTwo		BYTE	" meter(s) and a height", 0
	PrismStmntThree		BYTE	"of ", 0
	PrismStmntFour		BYTE	" meter(s) will have a volume of ", 0
	PrismStmntFive		BYTE	" meter(s) cubed.", 0

	;Strings used for printing out the answer for a pyramid
	PyramidStmntOne		BYTE	"A pyramid that has an area of ", 0
	PyramidStmntTwo		BYTE	" meter(s) and a height", 0
	PyramidStmntThree	BYTE	"of ", 0
	PyramidStmntFour	BYTE	" meter(s) will have a volume of ", 0
	PyramidStmntFive	BYTE	" meter(s) cubed.", 0

	;Strings used for printing out the answer for a sphere
	SphereStmntOne		BYTE	"A sphere with radius ", 0
	SphereStmntTwo		BYTE	" meter(s) has a volume of ", 0
	SphereStmntThree	BYTE	" meter(s) cubed.", 0

.code
main PROC
	;Print intro/name and directions
	mov	edx, OFFSET Intro
	call	WriteString
	call	CrLf

	;Print directions
	mov	edx, OFFSET DirectionsOne
	call	WriteString
	call	CrLf

	;Print directions
	mov	edx, OFFSET DirectionsTwo
	call	WriteString
	call	CrLf

	;Get user input for the first value
	mov	edx, OFFSET UserInputOne
	call	WriteString
	Call	ReadInt
	mov	UserValueOne, eax

	;Get user input for the second value
	mov	edx, OFFSET UserInputTwo
	call	WriteString
	call	ReadInt
	mov	UserValueTwo, eax
	call	CrLf

VolumeCalculations:

	;Volume calculation for a prism
	mov	eax, UserValueOne
	mov	ebx, UserValueTwo
	mul	ebx							;Multiply the two user values to get answer
	mov	PrismVolume, eax

	;Volume calculation for a pyramid
	mov	eax, UserValueOne
	mov	ebx, UserValueTwo
	mul	ebx							;Multiply the two user values
	mov	ebx, 3
	div	ebx							;Divide the multiplied result by 3 to get answer
	mov	PyramidVolume, eax

	;Volume calculation for a sphere and first user input
	mov	eax, 4
	mov	ebx, 3141
	mul	ebx							;Multiply the value 4 and 3141
	mov	ebx, UserValueOne
	mul	ebx							;Multiply the result by the users value
	mov	ebx, UserValueOne
	mul	ebx							;Multiply the result by the users value
	mov	ebx, UserValueOne
	mul	ebx							;Multiply the result by the users value
	mov	ebx, 3000
	div	ebx							;Divide the result by 3000 to get answer
	mov	SphereVolumeOne, eax

	;Volume calculation for a sphere and second user input
	mov	eax, 4
	mov	ebx, 3141
	mul	ebx							;Multiply the value 4 and 3141
	mov	ebx, UserValueTwo
	mul	ebx							;Multiply the result by the users value
	mov	ebx, UserValueTwo
	mul	ebx							;Multiply the result by the users value
	mov	ebx, UserValueTwo
	mul	ebx							;Multiply the result by the users value
	mov	ebx, 3000
	div	ebx							;Divide the result by 3000 to get answer
	mov	SphereVolumeTwo, eax

PrintCalculations:

	;Print statemtent for prism volume calculation
	mov	edx, OFFSET PrismStmntOne
	call	WriteString
	mov	eax, UserValueOne
	call	WriteDec
	mov	edx, OFFSET PrismStmntTwo
	call	WriteString
	call	CrLf
	mov	edx, OFFSET PrismStmntThree
	call	WriteString
	mov	eax, UserValueTwo
	call	WriteDec
	mov	edx, OFFSET PrismStmntFour
	call	WriteString
	mov	eax, PrismVolume
	call	WriteDec
	mov	edx, OFFSET PrismStmntFive
	call	WriteString
	call	CrLf
	call	CrLf

	;Print statemtent for pyramid volume calculation
	mov	edx, OFFSET PyramidStmntOne
	call	WriteString
	mov	eax, UserValueOne
	call	WriteDec
	mov	edx, OFFSET PyramidStmntTwo
	call	WriteString
	call	CrLf
	mov	edx, OFFSET PyramidStmntThree
	call	WriteString
	mov	eax, UserValueTwo
	call	WriteDec
	mov	edx, OFFSET PyramidStmntFour
	call	WriteString
	mov	eax, PyramidVolume
	call	WriteDec
	mov	edx, OFFSET PyramidStmntFive
	call	WriteString
	call	CrLf
	call	CrLf

	;Print statemtent for sphere volume calculation (First User Input)
	mov	edx, OFFSET SphereStmntOne
	call	WriteString
	mov	eax, UserValueOne
	call	WriteDec
	mov	edx, OFFSET SphereStmntTwo
	call	WriteString
	mov	eax, SphereVolumeOne
	call	WriteDec
	mov	edx, OFFSET SphereStmntThree
	call	WriteString
	call	CrLf

	;Print statemtent for sphere volume calculation (Second User Input)
	mov	edx, OFFSET SphereStmntOne
	call	WriteString
	mov	eax, UserValueTwo
	call	WriteDec
	mov	edx, OFFSET SphereStmntTwo
	call	WriteString
	mov	eax, SphereVolumeTwo
	call	WriteDec
	mov	edx, OFFSET SphereStmntThree
	call	WriteString
	call	CrLf
	call	CrLf

EndMessage:

	mov	edx, OFFSET ClosingMessage
	call	WriteString
	call	CrLf

	Invoke	ExitProcess, 0	; exit to operating system

main ENDP

END main
