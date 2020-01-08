#build a Makefile for hellownux.c

hellonux: hellonux.o sysver.o
	$(CC) $(LDFLAGS) $^ -o hellonux

%.o: %.cpp
	$(CXX) $(CXXFLAGS) $(EXTRA_CXXFLAGS) -c -o $@ $<

clean:
	rm *.o hellownux

