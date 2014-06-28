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
CC_INC      = -I$(LIBDIR) -I$(ARCHDIR)/lib/fwlib/inc -I$(ARCHDIR)/lib -I$(ARCHDIR) -I.
LD_INC      = -L$(ARCHDIR)/lib -L$(ARCHDIR)/ld -L$(ARCHDIR)/ld/other

LD_SCRIPT = STM32F103_384K_64K_FLASH.ld
STMPROC   = STM32F10X_HD
HSE_VALUE = 8000000

ARCH_CFLAGS= -D$(STMPROC) -DHSE_VALUE=$(HSE_VALUE)    \
	   -Wl,--as-needed                            \
           -mthumb -mcpu=cortex-m3 -Wall              \
           -Wno-main -DUSE_STDPERIPH_DRIVER -pipe     \
           -ffunction-sections -fno-unwind-tables     \
	   -fno-exceptions	\
           -D_SMALL_PRINTF -DNO_FLOATING_POINT        \
	   -Os -Wextra -DVERSION="\"$(VER)\""     \
	   -Wno-missing-field-initializers            \
	   -ggdb -DARCH_CORTEX $(CC_INC) $(CFLAGS) -MMD

ARCH_LDFLAGS=$(ALL_CFLAGS)                            \
            -nostartfiles                             \
            -Wl,--gc-sections,-Map=$@.map,-cref       \
            -Wl,-u,Reset_Handler                      \
            -Wl,-static              			\
	    -fno-exceptions \
	    -fwhole-program -fno-unwind-tables		\
            $(LD_INC) -T $(LD_SCRIPT) -MMD

OBJ       = $(SRC:=.o)
TRASH        += $(TARGET) $(TARGET:.bin=.elf) \
	$(TARGET:.bin=.elf.map) \
	$(OBJ) $(OBJ:.o=.d)

ifeq ($(V),)
	AT=@
endif


clean :
	@echo "CLEAN"
	$(AT)$(RM) $(TRASH)

%.s.o: %.s $(HEADER)
	@echo "AS $@"
	$(AT)$(AS) $(ALL_ASFLAGS) -c -o $@ $<

%.c.o: %.c $(HEADER)
	@echo "CC $@"
	$(AT)$(CC) $(ALL_CFLAGS) -c -o $@ $<

%.elf: $(OBJ)
	@echo "LD $@"
	$(AT)$(LD) $(ALL_LDFLAGS) -o $@ $^

%.hex: %.elf
	@echo "HEX $@"
	$(AT)$(OBJCOPY) -S -O ihex $< $@

%.bin: %.elf
	@echo "BIN $@"
	$(AT)$(OBJCOPY) -S -O binary $< $@

# Create extended listing file from ELF output file.
%.elf.lss: %.elf
	@echo "LSS $@"
	$(AT)$(OBJDUMP) -h -S $< > $@

# Create a symbol table from ELF output file.
%.elf.sym: %.elf
	@echo "SYM $@"
	$(AT)$(NM) -n $< > $@

.PHONY: clean rebuild depend
.SECONDARY: 
