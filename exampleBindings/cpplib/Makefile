TARGET = ../dist/lib/libMyLib.so
SOURCES = src/A.cpp src/B.cpp
CPPFLAGS = -Iinclude
CXXFLAGS = -fPIC
LDFLAGS = -shared -Wl,-soname,libMyLib.so

objects = $(patsubst %.cpp,%.o,$(SOURCES))
$(TARGET): $(objects)
	mkdir -p ../dist/lib
	mkdir -p ../dist/include
	cp -a ./include/* ../dist/include/
	g++ -std=c++14 $(LDFLAGS) $(CPPFLAGS) $(objects) -o $@
