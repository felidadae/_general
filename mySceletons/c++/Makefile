CC = g++
CC_FLAGS = -Wall -pedantic -std=c++14
INCL = -I`` 
LIBS = -L``

sources = $(shell find . \
	-name *.cpp \
	-print \
)
objects = $(sources:.cpp=.o)


echoConfig:
	@echo "CC <- $(CC)"; echo "INCL <- $(INCL)"; echo "LIBS <- $(LIBS)";

echoSources:
	@echo $(sources)

echoObjects:
	@echo $(objects)

echoFilenames:
	@echo $(filenamesonly)



all: $(objects)
	$(CC) $(CC_FLAGS) $(INCL) -o $@ $+ $(LIBS)

%.o: %.cpp
	$(CC) $(CC_FLAGS) $(INCL) -o $@ -c $<

clear:
	find . -name *.o -delete; rm all;
