debug:
	openocd -f interface/stlink.cfg -f target/stm32f4x.cfg

all:
	arm-none-eabi-gcc -x assembler-with-cpp -c -O0 -mcpu=cortex-m0 -mthumb -Wall core.S -o core.o
	arm-none-eabi-gcc core.o -mcpu=cortex-m4 -mthumb -Wall -nostdlib -lgcc -T./linker.ld -o main.elf
	arm-none-eabi-objcopy -O binary main.elf main.bin
