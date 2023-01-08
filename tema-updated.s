.data

format: .asciz "%d "
noduri : .space 4
cerinta : .space 4
array : .space 10000000
temp : .space 4
var : .long 0
empty : .asciz "\n"
i : .long 0
j : .long 0
k : .long 0
temp_ : .long 0
suma : .long 0
temp2 : .long 0

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

pushl %edi
pushl %eax
pushl %ecx
pushl $temp  
pushl $format
call scanf
popl %ebx
popl %ebx
popl %ecx
popl %eax 
popl %edi

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
je exit_array_set

pushl %edi
pushl %eax
pushl %ecx
pushl $temp
pushl $format
call scanf
popl %ebx
popl %ebx
popl %ecx
popl %eax
popl %edi

movl temp, %ebx
movl %ebx, (%edi, %ecx, 4)

inc %ecx
jmp array_set



exit_array_set:
subl noduri, %eax
jmp afisare





afisare:

xor %ecx, %ecx
xor %ebx, %ebx
xor %edx, %edx

movl noduri, %edx
dec %edx
movl %edx, noduri



for_main:

mov suma, %eax
mov noduri, %ebx
addl %eax, k
addl %ebx, k


mov i, %eax
cmp %eax, noduri
je for_main

movl i, %eax

cmp $0, %eax
jne cout_n


movl i, %ecx
mov (%edi, %ecx, 4), %ebx
addl %ebx, suma
cmp $0, %ebx
je cout_0_loop
jne for_second



cout_0_loop:
mov j, %eax
cmp %eax, noduri
je fin

pusha
pushl $0
pushl $format
call printf
popl %ebx
popl %ebx
popa

pusha
pushl $0
call fflush
popl %ebx
popa

movl j, %eax
inc %eax
movl %eax, j

jmp for_main



for_second:

mov j, %eax
cmp %eax, noduri
jle print_0_2

mov noduri, %eax
addl %eax, temp_
mov suma, %eax
addl %eax, temp_
movl k, %eax
movl %eax, temp2
movl temp_, %eax
subl %eax, temp2

movl j, %ecx
mov temp2, %eax
cmp %eax, (%edi,%ecx, 4)
je print_1
jne print_0

jmp for_main



print_1:

pusha
pushl $1
pushl $format
call printf
popl %ebx
popl %ebx
popa

pusha
pushl $0
call fflush
popl %ebx
popa

movl j, %eax
movl k, %ebx
inc %ebx
inc %eax
movl %eax, j
movl %ebx, k

jmp for_second


print_0:

pusha
pushl $0
pushl $format
call printf
popl %ebx
popl %ebx
popa

pusha
pushl $0
call fflush
popl %ebx
popa

movl j, %eax
inc %eax
movl %eax, j

jmp for_second



print_0_2:

mov j, %eax
cmp %eax, k
je for_second

pusha
pushl $0
pushl $format
call printf
popl %ebx
popl %ebx
popa

pusha
pushl $0
call fflush
popl %ebx
popa

movl j, %eax
inc %eax
movl %eax, j

jmp print_0_2


cout_n:

mov $4, %eax
mov $1, %ebx
mov $empty, %ecx
mov $2, %edx
int $0x80

jmp


fin:
mov $1, %eax
xor %ebx, %ebx
int $0x80
