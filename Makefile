CC = gcc
CFLAGS = -Wall -Wextra -Werror -g -Iinclude
BIN_DIR = bin
SRC_DIR = src

all: $(BIN_DIR)/api_bridge_lab

check: all
	bash ./scripts/check.sh

grade: all
	bash ./scripts/grade.sh

$(BIN_DIR)/legacy_api.o: $(SRC_DIR)/legacy_api.c include/api_bridge_lab.h
	$(CC) $(CFLAGS) -c $< -o $@

$(BIN_DIR)/liblegacy_api.a: $(BIN_DIR)/legacy_api.o
	ar rcs $@ $<

$(BIN_DIR)/libmodern_api.so: $(SRC_DIR)/modern_api.c include/api_bridge_lab.h
	$(CC) $(CFLAGS) -fPIC -shared $< -o $@

$(BIN_DIR)/api_bridge_lab: $(SRC_DIR)/api_bridge_lab.c $(BIN_DIR)/liblegacy_api.a $(BIN_DIR)/libmodern_api.so include/api_bridge_lab.h
	$(CC) $(CFLAGS) $< $(BIN_DIR)/liblegacy_api.a -L$(BIN_DIR) -lmodern_api -Wl,-rpath,'$$ORIGIN' -o $@

clean:
	rm -f $(BIN_DIR)/legacy_api.o \
		$(BIN_DIR)/liblegacy_api.a \
		$(BIN_DIR)/libmodern_api.so \
		$(BIN_DIR)/api_bridge_lab

.PHONY: all check grade clean
