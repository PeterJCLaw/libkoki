
EXAMPLE_BINS := $(addprefix examples/,marker_info realtime_quads realtime_text)
GL_EXAMPLE_BINS := $(addprefix examples/,realtime_gl)

CLEAN += $(EXAMPLE_BINS) $(GL_EXAMPLE_BINS) examples/*.o

GL_CFLAGS +=  `pkg-config --cflags gl glu`
GL_LDFLAGS += `pkg-config --libs   gl glu` -lglut

include examples/depend

examples/depend: src/*.c
	rm -f examples/depend
	for file in src/*.c; do \
		$(CC) $(CFLAGS) -MM $$file -o - >> $@ ; \
	done ;

examples: $(EXAMPLE_BINS) $(GL_EXAMPLE_BINS)

$(EXAMPLE_BINS): % : %.o lib/libkoki.so
	$(CC) $< -lkoki $(LDFLAGS) -o $@

$(GL_EXAMPLE_BINS): % : %.o lib/libkoki.so
	$(CC) $< -lkoki $(LDFLAGS) $(GL_LDFLAGS) -o $@

examples/realtime_gl.o: examples/realtime_gl.c
	$(CC) $(CFLAGS) $(GL_CFLAGS) -c -o $@ $^

examples/%.o: examples/%.c
