ARCH_PREFIX   = arm-none-eabi-
CC            = $(ARCH_PREFIX)gcc
LD            = $(ARCH_PREFIX)gcc
AS            = $(ARCH_PREFIX)gcc
MD            = $(ARCH_PREFIX)gcc
OBJCOPY       = $(ARCH_PREFIX)objcopy
OBJDUMP       = $(ARCH_PREFIX)objdump
STRIP         = $(ARCH_PREFIX)strip
FIND          = find
XARGS         = xargs
RM            = rm -f
GREP          = grep

# External libraries.
CC_INC      = -I$(srcdir) -I$(ARCH)/lib/fwlib/inc -I$(ARCH)/lib
LD_INC      = -L$(ARCH)/lib -L$(ARCH)/ld -L$(ARCH)/ld/other

LD_SCRIPT = STM32F103_384K_64K_FLASH.ld
STMPROC   = STM32F10X_HD
HSE_VALUE = 8000000

ARCH_CFLAGS=-MD -D$(STMPROC) -DHSE_VALUE=$(HSE_VALUE) \
           -mthumb -mcpu=cortex-m3 -Wall              \
           -Wno-main -DUSE_STDPERIPH_DRIVER -pipe     \
           -ffunction-sections -fno-unwind-tables     \
           -D_SMALL_PRINTF -DNO_FLOATING_POINT        \
           -DARCH_CORTEX $(CC_INC) $(CFLAGS)

ARCH_LDFLAGS=$(ALL_CFLAGS)                            \
            -nostartfiles                             \
            -Wl,--gc-sections,-Map=$@.map,-cref       \
            -Wl,-u,Reset_Handler                      \
            -fwhole-program -Wl,-static               \
            $(LD_INC) -T $(LD_SCRIPT)

OBJECTS  = $(ALL_SRC:=.o)
TRASH   += $(TARGET) $(OBJECTS) $(OBJECTS:.o.=.d)


clean :
	@$(RM) $(TRASH)
	@$(FIND) . -print \
		| $(GREP) '.*\.\([od]\|elf\|hex\|bin\|map\|lss\|sym\|strip\)$$' \
		| $(XARGS) -- $(RM)
	@echo "CLEAN"


.SECONDARY : 

%.s.o: %.s $(ALL_INC)
	@echo "AS $<"
	@$(AS) $(ALL_ASFLAGS) -c -o $@ $<

%.c.o: %.c $(ALL_INC)
	@echo "CC $<"
	@$(CC) $(ALL_CFLAGS) -c -o $@ $<

%.elf: $(OBJECTS)
	@echo "LD $^"
	@$(LD) $(ALL_LDFLAGS) -o $@ $^

%.hex: %.elf
	@echo "HEX $<"
	@$(OBJCOPY) -S -O ihex $< $@

%.bin: %.elf
	@echo "BIN $<"
	@$(OBJCOPY) -S -O binary $< $@

# Create extended listing file from ELF output file.
%.elf.lss: %.elf
	@echo "LSS $<"
	@$(OBJDUMP) -h -S $< > $@

# Create a symbol table from ELF output file.
%.elf.sym: %.elf
	@echo "SYM $<"
	@$(NM) -n $< > $@

.PHONY : clean rebuild
