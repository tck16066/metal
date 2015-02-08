CC=arm-none-eabi-gcc

SRC_DIR:=$(realpath ./src)
INC_DIR:=$(realpath ./include)
BUILD_DIR=build

SRC_FILES=main.c test.c
SRC=$(patsubst %.c, $(SRC_DIR)/%.c, $(SRC_FILES))
OBJ=$(patsubst %.c, $(BUILD_DIR)/%.o, $(SRC_FILES))

CC_FLAGS=	\
	-I $(INC_DIR)

CC_FLAGS+=  -mfpu=vfp -mfloat-abi=hard -march=armv6zk	\
	-mtune=arm1176jzf-s -nostartfiles -T ./armelf.x

LD_FLAGS= -L$(BUILD_DIR)


all: kernel.elf

kernel.elf: $(BUILD_DIR) $(OBJ)
	$(CC) $(CC_FLAGS) $(LD_FLAGS) $(OBJ) -o $(BUILD_DIR)/kernel.elf

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CC_FLAGS) $< -c -o $@

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

clean:
	rm -rf $(BUILD_DIR)
