.data

format: .asciz "%d"
noduri : .space 4
cerinta : .space 4
array : .space 10000000
temp : .space 4
var : .long 0
empty : .asciz "/n"
.text

.global main

main:


lea array, %edi 



pushl $cerinta
pushl $format
call scanf
popl %edx
popl %edx



pushl $noduri
pushl $format
call scanf
popl %edx
popl %edx


xor %edx, %edx
xor %eax, %eax
xor %ecx, %ecx
get_array_sum:   

cmp noduri, %ecx
je continue

pushl %eax
pushl %ecx
pushl $temp  
pushl $format
call scanf
popl %ebx
popl %ebx
popl %ecx
popl %eax

movl temp, %edx

addl %edx, %eax 
movl temp, %ebx 
movl %ebx, (%edi, %ecx, 4)

inc %ecx
jmp get_array_sum


continue:
movl %eax, var
addl noduri, %eax
jmp array_set

array_set: 

cmp %eax, %ecx
je afisare

pushl %eax
pushl %ecx
pushl $temp
pushl $format
call scanf
popl %ebx
popl %ebx
popl %ecx
popl %eax

movl temp, %ebx
movl %ebx, (%edi, %ecx, 4)

inc %ecx
jmp array_set



afisare:
movl var, %eax
dec %eax
xor %ecx, %ecx
xor %ebx, %ebx
xor %edx, %edx



for_1:

xor %ebx, %ebx
cmp noduri, %edx

jg fin

inc %edx


for_2:

cmp noduri, %ebx
jg for_1

subl $1, %edx
cmp %edx, %ebx
je cout_0
inc %edx

cmp %ebx, (%edi, %eax, 4)
je cout_1

jmp cout_0



cout_0:

pusha
pushl $0
pushl $format
call printf
popl %ecx
popl %ecx
popa

pusha
pushl $0
call fflush
popl %ecx
popa
inc %ebx
inc %edx
jmp for_2


cout_1:

pusha
pushl $1
pushl $format
call printf
popl %ecx
popl %ecx
popa

pusha
pushl $0
call fflush
popl %ecx
popa
inc %ebx
jmp for_2


cout_n:

movl $1, %ebx       # set ebx to the file descriptor for standard output
movl $1, %eax       # set eax to the 'write' function number
movl $10, %ecx      # set ecx to the newline character
movl $1, %edx       # set edx to the number of bytes to write
int $0x80           # call the operating system's write function

inc %ebx
jmp for_2




fin:
mov $1, %eax
xor %ebx, %ebx
int $0x80
