%include "traffic_lights.asm"

section .data
    ClearTerm: db   27,"[H",27,"[2J"    ; <ESC> [H <ESC> [2J
    CLEARLEN   equ  $-ClearTerm         ; Length of term clear string

    user_prompt db "Enter s to stop cars only", 10
                 db "Enter d to stop pedestrians", 10
                 db "Enter b to start sequence", 10
                 db "Enter q to quit program", 10
    user_input resb 100  ; Assume a maximum input of 100 characters
    wrong_input db "Wrong input. Please enter a valid option.", 10

section .text
    global input_loop

input_loop:
    ; Prompt user for input
    mov eax, 4
    mov ebx, 1
    mov ecx, user_prompt
    mov edx, 149 ; Length of the prompt, including the null terminator
    int 0x80

    ; Read user input
    mov eax, 3
    mov ebx, 0  ; Standard input
    mov ecx, user_input
    mov edx, 100 ; Maximum length
    int 0x80


    ; Check if input is 'q' to quit
    cmp byte [user_input], 'q'   ; Compare it with 'q'
    je exit_program               ; Jump to exit_program if equal

    ; Check user input for validity
    cmp byte [user_input], 's' ; Compare with "1ts" (case-sensitive)
    je show_stop_cars
    cmp byte [user_input], 'd' ; Compare with "2ts" (case-sensitive)
    je show_stop_people
    cmp byte [user_input], 'o' ; Compare with "3ts" (case-sensitive)
    je traffic_lights_off
    cmp byte [user_input], 'b' ; Compare with "start" (case-sensitive)
    je show_traffic_sequence
    ; If none of the valid options matched, display error message

    call clear_terminal
    mov eax, 4
    mov ebx, 1
    mov ecx, wrong_input
    mov edx, 42 ; Length of the error message
    int 0x80
    ; Jump back to the input loop
    jmp input_loop

;end loop
show_traffic_sequence:
    call stop_cars
    call flash_lights
    call stop_people
    call traffic_lights_off
    jmp input_loop
ret
;end

show_stop_people:
    call stop_people
    call traffic_lights_off
    je input_loop
ret

show_stop_cars:
    call stop_cars
    call traffic_lights_off
    je input_loop
ret


stop_cars:
    call clear_terminal
    ; stop cars and let people pass
    mov eax, 4
    mov ebx, 1
    mov ecx, car_traffic_cstop
    mov edx, car_traffic_cstop_len
    int 0x80
    mov eax, 4
    mov ebx, 1
    mov ecx, pedestrian_traffic_cstop
    mov edx, pedestrian_traffic_cstop_len
    int 0x80

    ; Call the delay function
    mov eax, 5000
    call delay_loop
ret

flash_lights:
;flash on
 call clear_terminal

    mov eax, 4
    mov ebx, 1
    mov ecx, car_traffic_flashon
    mov edx, car_traffic_flashon_len
    int 0x80
    mov eax, 4
    mov ebx, 1
    mov ecx, pedestrian_traffic_flashoff
    mov edx, pedestrian_traffic_flashoff_len
    int 0x80

    ; Call the delay function
    mov eax, 1000
    call delay_loop
 call clear_terminal

; Flash off
    mov eax, 4
    mov ebx, 1
    mov ecx, car_traffic_flashoff
    mov edx, car_traffic_flashoff_len
    int 0x80
    mov eax, 4
    mov ebx, 1
    mov ecx, pedestrian_traffic_flashoff
    mov edx, pedestrian_traffic_flashoff_len
    int 0x80

    ; Call the delay function
    mov eax, 1000
    call delay_loop

  call clear_terminal

;flash on
    mov eax, 4
    mov ebx, 1
    mov ecx, car_traffic_flashon
    mov edx, car_traffic_flashon_len
    int 0x80
    mov eax, 4
    mov ebx, 1
    mov ecx, pedestrian_traffic_flashoff
    mov edx, pedestrian_traffic_flashoff_len
    int 0x80

    ; Call the delay function
    mov eax, 1000
    call delay_loop
 
ret

stop_people:
    call clear_terminal
    ; stop people and let cars pass
    mov eax, 4
    mov ebx, 1
    mov ecx, car_traffic_cgo
    mov edx, car_traffic_cgo_len
    int 0x80
    mov eax, 4
    mov ebx, 1
    mov ecx, pedestrian_traffic_cgo
    mov edx, pedestrian_traffic_cgo_len
    int 0x80

    ; Call the delay function
    mov eax, 3000
    call delay_loop
ret

delay_loop:
    loop_start:
        pause
        loop loop_start
ret

clear_terminal:
    mov eax, 4                          ; Specify sys_write call
    mov ebx, 1                          ; Specify File Descriptor 1: Stdout
    mov ecx, ClearTerm                  ; Pass offset of terminal control string
    mov edx, CLEARLEN                   ; Pass the length of terminal control string
    int 80h
ret

exit_program:
    ; Exit the program
    mov eax, 1
    xor ebx, ebx
    int 0x80
