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

	UserInputOne BYTE "First number: ", 0
	UserValueOne DWORD ?
	UserInputTwo BYTE "Second number: ", 0
	UserValueTwo DWORD ?

	PrismVolume DWORD ?
	PyramidVolume DWORD ?

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

; (insert variable definitions here)

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



	Invoke ExitProcess,0	; exit to operating system

main ENDP

; (insert additional procedures here)

END main
