RM          = rm -rf

srcdir      = .
VPATH       = $(srcdir)

ALL_CFLAGS  = $(ARCH_CFLAGS)  $(CFLAGS)
ALL_LDFLAGS = $(ARCH_LDFLAGS) $(LDFLAGS)
ALL_ASFLAGS = $(ARCH_ASFLAGS) $(ASFLAGS)
ALL_MDFLAGS = $(ARCH_MDFLAGS) $(MDFLAGS)

HAX_SRC     = hax_main.c
HAX_INC     = hax.h

ifeq ($(ARCH),vex_pic)
	TARGET  = $(PROG)-$(ARCH).hex
endif

ifeq ($(ARCH),vex_cortex)
	TARGET  = $(PROG)-$(ARCH).bin
endif

.PHONY: all help vex_pic vex_cortex easyc_cortex clean


all: $(TARGET)

help:
	@echo "Valid targets:"
	@echo "  vex_pic"
	@echo "  vex_cortex"
	@echo "  easyc_cortex"

vex_pic:
	@$(MAKE) ARCH="vex_pic" $(MAKEFLAGS) all

vex_cortex:
	@$(MAKE) ARCH="vex_cortex" $(MAKEFLAGS) all

easyc_cortex:
	@$(MAKE) ARCH="easyc_cortex" $(MAKEFLAGS) all


include $(PROG)/Makefile
include $(ARCH)/build.mk
