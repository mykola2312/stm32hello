_estack = 0x20001000;

MEMORY
{
    FLASH ( rx )      : ORIGIN = 0x08000000, LENGTH = 1024K
    RAM ( rxw )       : ORIGIN = 0x20000000, LENGTH = 256K
}