PROJ_NAME = Blink
output    =build
CC      =  arm-atollic-eabi-gcc
OBJCOPY  = arm-atollic-eabi-objcopy




CFLAGS  =  -c -fno-common -O0 -g -mthumb -mcpu=cortex-m4 -std=gnu11
CFLAGS +=  -Wall -ffunction-sections -fdata-sections -fno-builtin -fstack-usage
CFLAGS +=  -mfloat-abi=hard -mfpu=fpv4-sp-d16 -specs=nano.specs
CFLAGS +=  -DSTM32F4XX -DSTM32F40XX -DUSE_STDPERIPH_DRIVER -Isrc -Ilibrary/inc

LDFLAGS = -mthumb -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16 -Tstm32f4_flash.ld -specs=nosys.specs  
LDFLAGS += -static -Wl,-cref,-u,Reset_Handler -Wl,-Map,$(output)/$(PROJ_NAME).map -g -Wl,--gc-sections
LDFLAGS +=  -Wl,--defsym=malloc_getpagesize_P=0x80 -Wl,--start-group -lc -lm -Wl,--end-group -specs=nano.specs


SRCDIR         = src
LIBRARY_SRC    = library/src

src_obj        = $(output)/src
library_objs    = $(output)/library/src


SRCS       = $(wildcard  $(SRCDIR)/*.c) \
             $(wildcard  $(LIBRARY_SRC)/*.c)

ASRC       = $(wildcard $(SRCDIR)/*.s)

OBJ_c_asm     = $(SRCS:.c=.o) $(ASRC:.s=.o)

objs       = $(addprefix $(output)/,$(OBJ_c_asm)) 

ELF_FILE = $(output)/$(PROJ_NAME)

all:  $(ELF_FILE).elf hex bin


$(ELF_FILE).elf: $(objs)
	$(CC) $(LDFLAGS) $^ -o $@ 

$(src_obj)/%.o:$(SRCDIR)/%.c
	
	$(CC) $(CFLAGS) $< -o $@

$(src_obj)/%.o:$(SRCDIR)/%.s
	
	$(CC) $(CFLAGS) $< -o $@

$(library_objs)/%.o:$(LIBRARY_SRC)/%.c
	
	$(CC) $(CFLAGS) $< -o $@


hex: $(ELF_FILE).elf
	$(OBJCOPY) -O ihex $(ELF_FILE).elf $(PROJ_NAME).hex

bin: $(ELF_FILE).elf
	$(OBJCOPY) -O binary $(ELF_FILE).elf $(PROJ_NAME).bin

clean :
	rm  *.hex *.bin $(output)/*.elf $(output)/*.map  $(library_objs)/*.o  $(src_obj)/*.o 











