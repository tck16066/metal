CC=arm-none-eabi-gcc
OBJCPY=arm-none-eabi-objcopy
AS=arm-none-eabi-as

SRC_DIR:=$(realpath ./src)
INC_DIR:=$(realpath ./include)
BUILD_DIR=build

SRC_FILES=main.c test.c
SRC=$(patsubst %.c, $(SRC_DIR)/%.c, $(SRC_FILES))
OBJ=$(patsubst %.c, $(BUILD_DIR)/%.o, $(SRC_FILES))

CC_FLAGS=	\
	-I $(INC_DIR) -Wall -Werror -O2

CC_FLAGS+= -mfpu=vfp -mfloat-abi=hard -march=armv6zk	\
	-mtune=arm1176jzf-s -nostartfiles -nostdlib	\
	-ffreestanding -T ./armelf.x

LD_FLAGS= -L$(BUILD_DIR)


all: $(BUILD_DIR)/kernel.img

$(BUILD_DIR)/kernel.img: $(BUILD_DIR) $(BUILD_DIR)/kernel.elf
	$(OBJCPY) $(BUILD_DIR)/kernel.elf -O binary $(BUILD_DIR)/kernel.img

$(BUILD_DIR)/kernel.elf: $(BUILD_DIR) $(OBJ) $(BUILD_DIR)/init.o
	$(CC) $(CC_FLAGS) $(LD_FLAGS) $(BUILD_DIR)/init.o  $(OBJ) -o $(BUILD_DIR)/kernel.elf

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CC_FLAGS) $< -c -o $@

$(BUILD_DIR)/init.o: $(SRC_DIR)/init.s
	$(AS) $(SRC_DIR)/init.s -o $(BUILD_DIR)/init.o

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

clean:
	rm -rf $(BUILD_DIR)
