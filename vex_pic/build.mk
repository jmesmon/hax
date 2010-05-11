ARCH_SRC = $(ARCH)/hax.c        \
           $(ARCH)/c018iz.c     \
           $(ARCH)/ifi_lib.c    \
           $(ARCH)/ifi_util.asm
ARCH_INC = $(ARCH)/master.h     \
           $(ARCH)/ifi_lib.h

include $(ARCH)/mcc18.mk
