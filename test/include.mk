
TEST_BINS := $(addprefix test/, speed_test debug_img)

CLEAN += $(TEST_BINS) test/*.o

include test/depend

test/depend: src/*.c
	rm -f test/depend
	for file in src/*.c; do \
		$(CC) $(CFLAGS) -MM $$file -o - >> $@ ; \
	done ;

tests: $(TEST_BINS)

$(TEST_BINS): % : %.o lib/libkoki.so
	$(CC) $< -lkoki $(LDFLAGS) -o $@

test/%.o: test/%.c
