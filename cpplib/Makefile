TARGET = lib/libmysample.so
SOURCES = src/A.cpp src/B.cpp
CPPFLAGS = -Iinclude
CXXFLAGS = -fPIC
LDFLAGS = -shared -Wl,-soname,libmysample.so

objects = $(patsubst %.cpp,%.o,$(SOURCES))
$(TARGET): $(objects)
	mkdir -p lib
	g++ -std=c++14 $(LDFLAGS) $(objects) -o $@
