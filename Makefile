DESTDIR ?= /
PREFIX  ?= /usr/local
OPENSSL_LDFLAGS := $(shell pkg-config --libs libcrypto)
OPENSSL_CFLAGS  := $(shell pkg-config --cflags libcrypto)
PLIST_LDFLAGS   := $(shell pkg-config --libs libplist)
PLIST_CFLAGS    := $(shell pkg-config --cflags libplist)
CFLAGS          := $(OPENSSL_CFLAGS) $(PLIST_CFLAGS) -O2
LDFLAGS         := $(OPENSSL_LDFLAGS) $(PLIST_LDFLAGS)
LDID_VERSION	:= $(shell git describe --tags --match="v*" | sed -e 's@-\([^-]*\)-\([^-]*\)$$@+\1.\2@;s@^v@@;s@%@~@g')

ifeq (LDID_VERSION,)
	error("No LDID_VERSION")
endif

CFLAGS          += -DLDID_VERSION=\"$(LDID_VERSION)\"

.PHONY: all clean
LDID_OBJS = ldid.cpp.o lookup2.c.o

all: ldid

%.c.o: %.c
	$(CC) $(CFLAGS) -o $@ -c $^ -I.

%.cpp.o: %.cpp
	$(CXX) $(CFLAGS) $(CXXFLAGS) -std=c++11 -o $@ -c $^ -I.

ldid: $(LDID_OBJS)
	$(CXX) $(CFLAGS) $(CXXFLAGS) $(LDFLAGS) -o $@ $^

clean:
	rm -f $(LDID_OBJS)

install: all
	mkdir -p $(DESTDIR)/$(PREFIX)/bin
	cp ldid $(DESTDIR)/$(PREFIX)/bin
