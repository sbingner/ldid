DESTDIR ?= /usr/local

.PHONY: all clean
LDID_OBJS = ldid.cpp.o sha224-256.c.o sha1.c.o lookup2.c.o

all: ldid ldid2 ldid3

%.c.o: %.c
	$(CC) $(CFLAGS) -o $@ -c $^ -I.

%.cpp.o: %.cpp
	$(CXX) $(CFLAGS) $(CXXFLAGS) -std=c++11 -o $@ -c $^ -I.

ldid: $(LDID_OBJS)
	$(CXX) $(CFLAGS) $(CXXFLAGS) $(LDFLAGS) -o $@ $^

ldid2: ldid
	ln -s ldid ldid2

ldid3: ldid
	ln -s ldid ldid3

clean:
	rm -f $(LDID_OBJS) ldid ldid2 ldid3

install: all
	mkdir -p $(DESTDIR)/bin
	cp ldid ldid2 ldid3 $(DESTDIR)/bin
