CC = gcc
OBJDIR	= obj
BUILDDIR = build
TARGET  = $(BUILDDIR)/clib.dll
DEFFILES = $(OBJDIR)/clib.def
AFILES = $(OBJDIR)/clib.a
SOURCES = $(shell echo src/*.c)
HEADERS = $(shell echo inc/*.h)
OBJECTS = obj/map.o obj/llist.o


all: $(TARGET)

$(TARGET) : $(OBJECTS)
	dlltool --output-def $(DEFFILES) --kill-at --dllname $(TARGET) $^
	dlltool --output-lib $(AFILES) --input-def $(DEFFILES) --kill-at --dllname $(TARGET) $^
	gcc $^ -o $(TARGET) -mwindows -Wall -L. -shared
        
obj/map.o : src/map.c
	gcc $^ -Iinc -shared -fPIC -fprofile-arcs -ftest-coverage -O0 -g -Wall -o $@

obj/llist.o : src/llist.c
	gcc $^ -Iinc -shared -fPIC -fprofile-arcs -ftest-coverage -O0 -g -Wall -o $@
    
clean:
	del $(OBJDIR)\* /Q
	del $(BUILDDIR)\* /Q