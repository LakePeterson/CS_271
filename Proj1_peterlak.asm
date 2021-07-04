TITLE Basic Logic and Arithmetic Program 1

; Author: Lake Peterson
; Last Modified: July 5, 2021
; OSU email address: peterlak@oregonstate.edu
; Course number/section: CS271 Section 001
; Project Number: 1
; Due Date: July 4, 2021
; Description: The purpose of this assignment is to acquaint you with elementary MASM programming and integer arithmetic operations (CLO 3, 4).

INCLUDE Irvine32.inc

.data

	Intro BYTE	"Welcome to the Volume Calculator by Lake Peterson", 0
	DirectionsOne BYTE	"Please enter two numbers that are greater than zero and", 0
	DirectionsTwo BYTE	"I will use them to compute the volume of several shapes.", 0
	ClosingMessage BYTE	"Thanks for using my calculator! Goodbye!", 0

	UserInputOne BYTE "First number: ", 0
	UserValueOne DWORD ?
	UserInputTwo BYTE "Second number: ", 0
	UserValueTwo DWORD ?

	PrismVolume DWORD ?
	PyramidVolume DWORD ?
	SphereVolumeOne DWORD ?
	SphereVolumeTwo DWORD ?

	PrismStatementOne BYTE "A prism that has an area of ", 0
	PrismStatementTwo BYTE " meter(s) and a height", 0
	PrismStatementThree BYTE "of ", 0
	PrismStatementFour BYTE " meter(s) will have a volume of ", 0
	PrismStatementFive BYTE " meter(s) cubed.", 0

	PyramidStatementOne BYTE "A pyramid that has an area of ", 0
	PyramidStatementTwo BYTE " meter(s) and a height", 0
	PyramidStatementThree BYTE "of ", 0
	PyramidStatementFour BYTE " meter(s) will have a volume of ", 0
	PyramidStatementFive BYTE " meter(s) cubed.", 0

	SphereStatementOne BYTE "A sphere with radius ", 0
	SphereStatementTwo BYTE " meter(s) has a volume of ", 0
	SphereStatementThree BYTE " meter(s) cubed.", 0

.code
main PROC

	mov edx, OFFSET Intro
	call WriteString
	call CrLf

	mov edx, OFFSET DirectionsOne
	call WriteString
	call CrLf

	mov edx, OFFSET DirectionsTwo
	call WriteString
	call CrLf

	mov edx, OFFSET UserInputOne
	call WriteString
	Call ReadInt
	mov UserValueOne, eax

	mov edx, OFFSET UserInputTwo
	call WriteString
	call ReadInt
	mov UserValueTwo, eax
	call CrLf

VolumeCalculations:

	;Volume calculation for a prism
	mov eax, UserValueOne
	mov ebx, UserValueTwo
	mul ebx
	mov PrismVolume, eax

	;Volume calculation for a pyramid
	mov eax, UserValueOne
	mov ebx, UserValueTwo
	mul ebx
	mov ebx, 3
	div ebx
	mov PyramidVolume, eax

	;Volume calculation for a sphere and first user input
	mov eax, 4
	mov ebx, 3141
	mul ebx
	mov ebx, UserValueOne
	mul ebx
	mov ebx, UserValueOne
	mul ebx
	mov ebx, UserValueOne
	mul ebx
	mov ebx, 3000
	div ebx
	mov SphereVolumeOne, eax

	;Volume calculation for a sphere and second user input
	mov eax, 4
	mov ebx, 3141
	mul ebx
	mov ebx, UserValueTwo
	mul ebx
	mov ebx, UserValueTwo
	mul ebx
	mov ebx, UserValueTwo
	mul ebx
	mov ebx, 3000
	div ebx
	mov SphereVolumeTwo, eax

PrintCalculations:

	;Print statemtent for prism volume calculation
	mov edx, OFFSET PrismStatementOne
	call WriteString
	mov eax, UserValueOne
	call WriteDec
	mov edx, OFFSET PrismStatementTwo
	call WriteString
	call CrLf
	mov edx, OFFSET PrismStatementThree
	call WriteString
	mov eax, UserValueTwo
	call WriteDec
	mov edx, OFFSET PrismStatementFour
	call WriteString
	mov eax, PrismVolume
	call WriteDec
	mov edx, OFFSET PrismStatementFive
	call WriteString
	call CrLf
	call CrLf

	;Print statemtent for pyramid volume calculation
	mov edx, OFFSET PyramidStatementOne
	call WriteString
	mov eax, UserValueOne
	call WriteDec
	mov edx, OFFSET PyramidStatementTwo
	call WriteString
	call CrLf
	mov edx, OFFSET PyramidStatementThree
	call WriteString
	mov eax, UserValueTwo
	call WriteDec
	mov edx, OFFSET PyramidStatementFour
	call WriteString
	mov eax, PyramidVolume
	call WriteDec
	mov edx, OFFSET PyramidStatementFive
	call WriteString
	call CrLf
	call CrLf

	;Print statemtent for Sphere volume calculation (First User Input)
	mov edx, OFFSET SphereStatementOne
	call WriteString
	mov eax, UserValueOne
	call WriteDec
	mov edx, OFFSET SphereStatementTwo
	call WriteString
	mov eax, SphereVolumeOne
	call WriteDec
	mov edx, OFFSET SphereStatementThree
	call WriteString
	call CrLf

	;Print statemtent for Sphere volume calculation (Second User Input)
	mov edx, OFFSET SphereStatementOne
	call WriteString
	mov eax, UserValueTwo
	call WriteDec
	mov edx, OFFSET SphereStatementTwo
	call WriteString
	mov eax, SphereVolumeTwo
	call WriteDec
	mov edx, OFFSET SphereStatementThree
	call WriteString
	call CrLf
	call CrLf

EndMessage:

	mov edx, OFFSET ClosingMessage
	call WriteString
	call CrLf

	Invoke ExitProcess, 0	; exit to operating system

main ENDP

END main
