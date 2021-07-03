TITLE Basic Logic and Arithmetic Program 1

; Author: Lake Peterson
; Last Modified: July 5, 2021
; OSU email address: peterlak@oregonstate.edu
; Course number/section: CS271 Section 001
; Project Number: 1
; Due Date: July 4, 2021
; Description: The purpose of this assignment is to acquaint you with elementary MASM programming and integer arithmetic operations (CLO 3, 4).

INCLUDE Irvine32.inc

; (insert macro definitions here)

; (insert constant definitions here)

.data

	Intro BYTE	"Welcome to the Volume Calculator by Student Name", 0
	DirectionsOne BYTE	"Please enter two numbers that are greater than zero and", 0
	DirectionsTwo BYTE	"I will use them to compute the volume of several shapes.", 0

	UserInputOne BYTE "First number: ", 0
	UserValueOne DWORD ?
	UserInputTwo BYTE "Second number: ", 0
	UserValueTwo DWORD ?

	PrismVolume DWORD ?

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

	mov eax, UserValueOne
	mov ebx, UserValueTwo
	mul ebx
	mov PrismVolume, eax

	mov eax, PrismVolume
	call WriteDec

; (insert executable instructions here)

	Invoke ExitProcess,0	; exit to operating system

main ENDP

; (insert additional procedures here)

END main
