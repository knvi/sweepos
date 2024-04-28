[bits 16]
[cpu 686]

%assign TextBufSeg 0xb800

;   Dimensions
%assign ScreenWidth 40
%assign ScreenHeight 25
%assign ScreenSize (ScreenWidth * ScreenHeight)

;   Get index from coordinates
%define GetIndex(y, x) ((y) * ScreenWidth * 2 + (x) * 2)

%assign Up 0x48
%assign Down 0x50
%assign Left 0x4b
%assign Right 0x4d

%assign Enter 0x1c
%assign Space 0x39

%assign RestartGame "r"

org 0x7c00

MAIN:
    xor ax, ax  ;   Clear ax
    int 0x10    ;   Set video mode

    mov ah, 0x01
    mov ch, 0x3f
    int 0x10    ;   https://wiki.osdev.org/Text_Mode_Cursor#Disabling_the_Cursor

    mov dx, 0x03DA
    in al, dx
    mov dx, 0x03C0
    mov al, 0x30
    out dx, al

    inc dx
    in al, dx
    and al, 0xF7

    dec dx
    out dx, al

RUNGAME:
    mov dx, TextBufSeg
    mov es, dx
    mov ds, dx

GAME_LOOP:
    xor ax, ax
    int 0x16

%assign CodeSize $ - $$
%warning Code is CodeSize bytes

BOOT_END:
    times (512 - 2) - CodeSize db 0
    dw 0xAA55