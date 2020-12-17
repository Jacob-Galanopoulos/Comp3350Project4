;Jake Galanopoulos
;Lmod date: 4/24/2019
;This program implements the Vigenere cipher.

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
.data
	input byte "MEMORY"
	key byte "BAD"
	options byte 1
	output byte ?
.code
main proc
	cmp options, 1
	jne e
	call encrypt
	jmp f
	e:
	call decrypt
	f:
	invoke ExitProcess, 0
main endp

encrypt PROC
	mov eax, 0
	mov esi, 0
	mov edi, 0
	mov ecx, LENGTHOF input
	s: 
		cmp edi, LENGTHOF key ;check to see if edi has gone beyond valid characters
		jne d
		mov edi, 0 ;reset it to the beginning of key
		d:
		movzx eax, key[edi] ;put the ASCII code of the character of Key in eax
		sub eax, 65 ;Get the offset of how many characters to shift the input
		movzx ebx, input[esi] ;Move the current character of input into ebx
		add eax, ebx ;Add eax and ebx to set the offset
		cmp eax, 90
		jle e ;Need to check if the number is greater than 90. If so, it needs to wrap around to 65.
		sub eax, 90
		add eax, 64
		e:
		mov output[esi], al
		inc esi
		inc edi
	loop s
	ret
encrypt ENDP

decrypt PROC
	mov eax, 0
	mov esi, 0
	mov edi, 0
	mov ecx, LENGTHOF input
	s: 
		cmp edi, LENGTHOF key ;check to see if edi has gone beyond valid characters
		jne d
		mov edi, 0 ;reset it to the beginning of key
		d:
		movzx eax, key[edi] ;put the ASCII code of the character of Key in eax
		sub eax, 65 ;Get the offset of how many characters to shift the input
		movzx ebx, input[esi] ;Move the current character of input into ebx
		sub ebx, eax ;Subtract eax and ebx to set the offset
		cmp ebx, 65
		jge e ;Need to check if the number is less than 65. If so, it needs to wrap around to 90.
		add ebx, 26
		e:
		mov output[esi], bl
		inc esi
		inc edi
	loop s
	ret
decrypt ENDP
end main