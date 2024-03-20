; traffic_lights.asm

section .data
    ; off
    car_traffic_off db "Car Traffic Light", 10, " |  -----  |", 10, " |    ⚫   |", 10, " |  ------ |", 10, " |    ⚫   |", 10, " |  ------ |", 10, " |    ⚫   |", 10, " |  ------ |", 10, 0
    car_traffic_off_len equ $ - car_traffic_off
    pedestrian_traffic_off db "Pedestrian Traffic Light", 10, " |  -----  |", 10, " |    ⬛   |", 10, " |  ------ |", 10, " |    ⬛   |", 10, " |  ------ |", 10, 0
    pedestrian_traffic_off_len equ $ - pedestrian_traffic_off

    ; stop cars, people walk
    car_traffic_cstop db "Car Traffic Light", 10, " |  -----  |", 10, " |    🔴   |", 10, " |  ------ |", 10, " |    ⚫   |", 10, " |  ------ |", 10, " |    ⚫   |", 10, " |  ------ |", 10, 0
    car_traffic_cstop_len equ $ - car_traffic_cstop
    pedestrian_traffic_cstop db "Pedestrian Traffic Light", 10, " |  -----  |", 10, " |    ⬛   |", 10, " |  ------ |", 10, " |    🟩   |", 10, " |  ------ |", 10, 0
    pedestrian_traffic_cstop_len equ $ - pedestrian_traffic_cstop

    ; flash on
    car_traffic_flashon db "Car Traffic Light", 10, " |  -----  |", 10, " |    ⚫   |", 10, " |  ------ |", 10, " |    🟡   |", 10, " |  ------ |", 10, " |    🟢   |", 10, " |  ------ |", 10, 0
    car_traffic_flashon_len equ $ - car_traffic_flashon
    pedestrian_traffic_flashon db "Pedestrian Traffic Light", 10, " |  -----  |", 10, " |    ⬛   |", 10, " |  ------ |", 10, " |   🟩   |", 10, " |  ------ |", 10, 0
    pedestrian_traffic_flashon_len equ $ - pedestrian_traffic_flashon

    ; flash off
    car_traffic_flashoff db "Car Traffic Light", 10, " |  -----  |", 10, " |    ⚫   |", 10, " |  ------ |", 10, " |    ⚫   |", 10, " |  ------ |", 10, " |    ⚫   |", 10, " |  ------ |", 10, 0
    car_traffic_flashoff_len equ $ - car_traffic_flashoff
    pedestrian_traffic_flashoff db "Pedestrian Traffic Light", 10, " |  -----  |", 10, " |    ⬛   |", 10, " |  ------ |", 10, " |    🟩   |", 10, " |  ------ |", 10, 0
    pedestrian_traffic_flashoff_len equ $ - pedestrian_traffic_flashoff

    ; cars move, people stop
    car_traffic_cgo db "Car Traffic Light", 10, " |  -----  |", 10, " |    ⚫   |", 10, " |  ------ |", 10, " |    ⚫   |", 10, " |  ------ |", 10, " |    🟢   |", 10, " |  ------ |", 10, 0
    car_traffic_cgo_len equ $ - car_traffic_cgo
    pedestrian_traffic_cgo db "Pedestrian Traffic Light", 10, " |  -----  |", 10, " |    🟥   |", 10, " |  ------ |", 10, " |    ⬛   |", 10, " |  ------ |", 10, 0
    pedestrian_traffic_cgo_len equ $ - pedestrian_traffic_cgo

section .text
    global show_traffic_sequence


traffic_lights_off:

    mov eax, 4                          ; Specify sys_write call
    mov ebx, 1                          ; Specify File Descriptor 1: Stdout
    mov ecx, ClearTerm                  ; Pass offset of terminal control string
    mov edx, CLEARLEN                   ; Pass the length of terminal control string
    int 80h

    ; Output Car Traffic Light
    mov eax, 4
    mov ebx, 1
    mov ecx, car_traffic_off
    mov edx, car_traffic_off_len
    int 0x80

    ; Output Pedestrian Traffic Light
    mov eax, 4
    mov ebx, 1
    mov ecx, pedestrian_traffic_off
    mov edx, pedestrian_traffic_off_len
    int 0x80


