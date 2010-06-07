RM          = rm -rf

srcdir      = .
VPATH       = $(srcdir)

ALL_CFLAGS  = $(ARCH_CFLAGS)  $(CFLAGS)
ALL_LDFLAGS = $(ARCH_LDFLAGS) $(LDFLAGS)
ALL_ASFLAGS = $(ARCH_ASFLAGS) $(ASFLAGS)
ALL_MDFLAGS = $(ARCH_MDFLAGS) $(MDFLAGS)

HAX_SRC     = hax_main.c
HAX_INC     = hax.h

.PHONY: all help arch_pic arch_cortex clean build rebuild
all: build
rebuild : | clean build

include $(PROG)/Makefile
include $(ARCH)/build.mk
TARGET  = $(PROG)-$(ARCH).$(ARCH_EXT)

build: $(TARGET)

help:
	@echo "Valid targets:"
	@echo "  arch_pic"
	@echo "  arch_cortex"

arch_pic:
	@$(MAKE) ARCH="arch_pic" $(MAKEFLAGS) all

arch_cortex:
	@$(MAKE) ARCH="arch_cortex" $(MAKEFLAGS) all

