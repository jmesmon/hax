/* Memory Spaces Definitions */
MEMORY
{
	RAM (xrw) : ORIGIN = 0x20000000, LENGTH = 64K
	FLASH (rx) : ORIGIN = 0x8000000, LENGTH = 384K
	FLASHB1 (rx) : ORIGIN = 0x00000000, LENGTH = 0
	EXTMEMB0 (rx) : ORIGIN = 0x00000000, LENGTH = 0
	EXTMEMB1 (rx) : ORIGIN = 0x00000000, LENGTH = 0
	EXTMEMB2 (rx) : ORIGIN = 0x00000000, LENGTH = 0
	EXTMEMB3 (rx) : ORIGIN = 0x00000000, LENGTH = 0
}
/* higher address of the user mode stack */
_estack = ORIGIN(RAM) + LENGTH(RAM);

