CC = gcc
OBJDIR	= obj
BUILDDIR = build
TARGET  = $(BUILDDIR)/clib.dll
DEFFILES = $(OBJDIR)/clib.def
AFILES = $(OBJDIR)/clib.a
SOURCES = $(shell echo src/*.c)
HEADERS = $(shell echo inc/*.h)
OBJECTS = obj/map.o obj/llist.o

all: $(OBJDIR) $(BUILDDIR) $(TARGET)

$(OBJDIR) :
	mkdir $(OBJDIR)
$(BUILDDIR) :
	mkdir $(BUILDDIR)

$(TARGET) : $(OBJECTS)
#	dlltool --output-def $(DEFFILES) --kill-at --dllname $(TARGET) $^
#	dlltool --output-lib $(AFILES) --input-def $(DEFFILES) --kill-at --dllname $(TARGET) $^
	gcc $^ -o $(TARGET) -mwindows -Wall -L. -shared
        
obj/map.o : src/map.c
	gcc -c $^ -Iinc -o $@

obj/llist.o : src/llist.c
	gcc -c $^ -Iinc -o $@
    
clean:
	del $(OBJDIR)\* /Q
	del $(BUILDDIR)\* /Q