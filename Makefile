.POSIX:

QEMU = qemu-system-i386
BOCHS = bochs
NASM = nasm

.PHONY: all clean qemu bochs

all: sweepos

sweepos: game.asm
	$(NASM) $< -o $@

clean:
	rm -f sweepos

qemu: sweepos
	$(QEMU) $<