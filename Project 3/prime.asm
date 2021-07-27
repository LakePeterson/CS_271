TITLE Nested Loops and Procedures Program 3

; Author: Lake Peterson
; Last Modified: July 25, 2021
; OSU email address: peterlak@oregonstate.edu
; Course number/section: CS271 Section 001
; Project Number: 3
; Due Date: July 25, 2021
; Description: Calculates prime numbers based after a user inputs the amount of prime numbers they want displayed.

INCLUDE Irvine32.inc

;set constants
minimum = 0
maximum = 181

.data
	;Strings used for printing out the intro/directions for using the calculator
	Intro				BYTE	"Prime Numbers Programmed by Lake Peterson", 0
	DirectionsOne		BYTE	"Enter the number of prime numbers you would like to see", 0
	DirectionsTwo		BYTE	"I will accept orders for up to 180 primes.", 0
	ErrorMessage		BYTE	"No primes for you! Number out of range. Try again.", 0
	Space				BYTE	" ", 0
	FarewellMessage		BYTE	"Results certified by Lake Peterson. Goodbye.", 0

	;Variables used to ask/store the values
	UserInput			BYTE	"Enter the number of primes to display [1 ... 180]: ", 0
	UserValue			DWORD	?
	Pick				DWORD	0
	CurrentValue		DWORD	2

.code
main PROC
	call	introduction
	call	readData
	call	showPrimes
	call	farewell

introduction PROC
	;Print intro/name and directions
	mov		edx, OFFSET Intro
	call	WriteString
	call	CrLf
	call	CrLf

	;Print directions
	mov		edx, OFFSET DirectionsOne
	call	WriteString
	call	CrLf
	mov		edx, OFFSET DirectionsTwo
	call	WriteString
	call	CrLf
	call	CrLf

	RET
introduction ENDP

readData PROC
	;Get user input so we know how many prime numbers to display
	mov		edx, OFFSET UserInput
	call	WriteString
	call	ReadInt
	mov		UserValue, eax
	call	validate

	RET
readData ENDP

validate PROC
	;Validate user input to make sure it is within accepted bounds 1 - 180
	mov		eax, maximum
	cmp		eax, UserValue
	jle		printError
	mov		eax, minimum
	cmp		eax, UserValue
	jge		printError

	RET

	;Print the error message if the input is not within the speified bounds
	printError:
		mov		edx, OFFSET ErrorMessage
		call	WriteString
		call	CrLf
		call	readData
	
	RET
validate ENDP

showPrimes PROC
	;Find the prime numbers within the specified range
	call	CrLf
	mov		ecx, UserValue
	mov		ebx, 0

	;Looking for prime numbers
	checkPrime:
		mov		eax, Pick
		cmp		eax, UserValue
		jge		farewell
		call	isPrime
		jmp		checkPrime

	RET
showPrimes ENDP

isPrime	PROC
	;Determines if the number is prime and then print out the prime number
	mov		ecx, CurrentValue
	dec		ecx

	printPrimeNumbers:
		cmp		ecx, 1
		je		primeNum
		mov		eax, CurrentValue
		cdq
		div		ecx
		cmp		edx, 0
		je		nonPrimeNum

	loop printPrimeNumbers
		primeNum:
		cmp		ebx, 9
		jle		newLineCheck
		call	CrLf
		mov		ebx, 0

		newLineCheck:
		mov		eax, CurrentValue
		call	WriteDec
		mov		edx, OFFSET Space
		call	WriteString
		inc		Pick
		inc		ebx
		nonPrimeNum:
		inc		CurrentValue

	RET
isPrime ENDP

farewell PROC
	;Print farewell message
	call	CrLf
	call	CrLf
	mov		edx, OFFSET FarewellMessage
	call	WriteString
	call	CrLf

	; exit to operating system
	Invoke	ExitProcess, 0

farewell ENDP

main ENDP

END main