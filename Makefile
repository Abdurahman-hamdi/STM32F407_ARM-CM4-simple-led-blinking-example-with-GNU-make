PROJ_NAME = Blink
CC      =  arm-atollic-eabi-gcc
OBJCOPY  = arm-atollic-eabi-objcopy
OBJDUMP  = arm-atollic-eabi-objdump



CFLAGS  =  -c -fno-common -O0 -g -mthumb -mcpu=cortex-m4 -std=gnu11
CFLAGS +=  -Wall -ffunction-sections -fdata-sections -fno-builtin -fstack-usage
CFLAGS +=  -mfloat-abi=hard -mfpu=fpv4-sp-d16 -specs=nano.specs
CFLAGS +=  -DSTM32F4XX -DSTM32F40XX -DUSE_STDPERIPH_DRIVER -Isrc -Ilibrary/inc

LDFLAGS = -mthumb -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16 -Tstm32f4_flash.ld -specs=nosys.specs  
LDFLAGS += -static -Wl,-cref,-u,Reset_Handler -Wl,-Map,$(OBJDIR)/$(PROJ_NAME).map -g -Wl,--gc-sections
LDFLAGS +=  -Wl,--defsym=malloc_getpagesize_P=0x80 -Wl,--start-group -lc -lm -Wl,--end-group -specs=nano.specs


SRCDIR         = src
LIBRARY_SRC    = library/src
OBJDIR         =build

SRCS       = $(wildcard  $(SRCDIR)/*.c) \
             $(wildcard  $(LIBRARY_SRC)/*.c)

ASRC       = $(wildcard $(SRCDIR)/*.s)

OBJ_os     = $(SRCS:.c=.o) $(ASRC:.s=.o)

objs       = $(addprefix $(OBJDIR)/,$(OBJ_os)) 

ELF_FILE = $(OBJDIR)/$(PROJ_NAME)

all:  $(ELF_FILE).elf hex bin


$(ELF_FILE).elf: $(objs)
	$(CC) $(LDFLAGS) $^ -o $@ 

$(OBJDIR)/src/%.o:src/%.c
	
	$(CC) $(CFLAGS) $< -o $@

$(OBJDIR)/src/%.o:src/%.s
	
	$(CC) $(CFLAGS) $< -o $@

$(OBJDIR)/library/src/%.o:library/src/%.c
	
	$(CC) $(CFLAGS) $< -o $@


hex: $(ELF_FILE).elf
	$(OBJCOPY) -O ihex $(ELF_FILE).elf $(PROJ_NAME).hex

bin: $(ELF_FILE).elf
	$(OBJCOPY) -O binary $(ELF_FILE).elf $(PROJ_NAME).bin

clean :
	rm  *.hex *.bin $(OBJDIR)/*.elf $(OBJDIR)/*.map  $(OBJDIR)/library/src/*.o  $(OBJDIR)/src/*.o 











