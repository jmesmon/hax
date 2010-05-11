RM          = rm -rf

srcdir      = $(HAX_ROOT) .
VPATH       = $(srcdir)

ALL_CFLAGS  = $(ARCH_CFLAGS)  $(CFLAGS)
ALL_LDFLAGS = $(ARCH_LDFLAGS) $(LDFLAGS)
ALL_ASFLAGS = $(ARCH_ASFLAGS) $(ASFLAGS)
ALL_MDFLAGS = $(ARCH_MDFLAGS) $(MDFLAGS)

HAX_SRC = hax_main.c hax_serial.c
HAX_INC = hax.h

ALL_SRC = $(HAX_SRC) $(ARCH_SRC) $(SOURCE)
ALL_INC = $(HAX_INC) $(ARCH_INC) $(HEADERS)

ifeq ($(ARCH),vex_pic)
	TARGET  = $(PROG)-$(ARCH).hex
endif

ifeq ($(ARCH),vex_cortex)
	TARGET  = $(PROG)-$(ARCH).bin
endif

.PHONY: all help vex_pic vex_cortex easyc_cortex clean


all: $(TARGET)

vex_pic:
	@$(MAKE) ARCH="vex_pic" $(MAKEFLAGS) all

vex_cortex:
	@$(MAKE) ARCH="vex_cortex" $(MAKEFLAGS) all

easyc_cortex:
	@$(MAKE) ARCH="easyc_cortex" $(MAKEFLAGS) all

include $(ARCH)/build.mk
