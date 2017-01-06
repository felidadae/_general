CC = g++
CC_FLAGS = -Wall -pedantic -std=c++14
INCL = `` #-I``
LIBS = `` #-L``

sources = $(shell find . \
	-name *.cpp \
	-print \
)
objects = $(sources:.cpp=.o)


main: $(objects)
	$(CC) $(CC_FLAGS) $(INCL) -o $@ $+ $(LIBS)

echoConfig:
	@echo "CC <- $(CC)"; echo "INCL <- $(INCL)"; echo "LIBS <- $(LIBS)";

echoSources:
	@echo $(sources)

echoObjects:
	@echo $(objects)

%.o: %.cpp
	$(CC) $(CC_FLAGS) $(INCL) -o $@ -c $<

clean:
	find . -name *.o -delete; rm all; rm main;
