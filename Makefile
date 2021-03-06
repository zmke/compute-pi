CC = gcc
CFLAGS = -O0 -std=gnu99 -Wall -fopenmp -mavx
EXECUTABLE = \
	time_test_baseline time_test_openmp_2 time_test_openmp_4 \
	time_test_avx time_test_avxunroll time_test_leibniz \
	time_test_leibniz_avx time_test_leibniz_openmp \
	compute_error benchmark_clock_gettime

GIT_HOOKS := .git/hooks/pre-commit

$(GIT_HOOKS):
	@scripts/install-git-hooks
	@echo

default: $(GIT_HOOKS) computepi.o
	$(CC) $(CFLAGS) computepi.o time_test.c -DBASELINE -o time_test_baseline
	$(CC) $(CFLAGS) computepi.o time_test.c -DOPENMP_2 -o time_test_openmp_2
	$(CC) $(CFLAGS) computepi.o time_test.c -DOPENMP_4 -o time_test_openmp_4
	$(CC) $(CFLAGS) computepi.o time_test.c -DAVX -o time_test_avx
	$(CC) $(CFLAGS) computepi.o time_test.c -DAVXUNROLL -o time_test_avxunroll
	$(CC) $(CFLAGS) computepi.o time_test.c -DLEIBNIZ -o time_test_leibniz
	$(CC) $(CFLAGS) computepi.o time_test.c -DLEIBNIZ_OPENMP -o time_test_leibniz_openmp
	$(CC) $(CFLAGS) computepi.o time_test.c -DLEIBNIZ_AVX -o time_test_leibniz_avx
	$(CC) $(CFLAGS) computepi.o benchmark_clock_gettime.c -o benchmark_clock_gettime
	$(CC) $(CFLAGS) computepi.o compute_error.c -o compute_error 

.PHONY: clean default

%.o: %.c
	$(CC) -c $(CFLAGS) $< -o $@ 

check: default
	time ./time_test_baseline
	time ./time_test_openmp_2
	time ./time_test_openmp_4
	time ./time_test_avx
	time ./time_test_avxunroll
	time ./time_test_leibniz
	time ./time_test_leibniz_openmp
	time ./time_test_leibniz_avx

gencsv: default
	for i in `seq 500 500 250000`; do \
		printf "%d," $$i;\
		./benchmark_clock_gettime $$i; \
	done > result_clock_gettime.csv

plot: gencsv
	gnuplot script.gp

plot_error: default
	for i in `seq 500 500 250000`; do \
		printf "%d," $$i;\
		./compute_error $$i; \
	done > compute_error.csv
	gnuplot error_script.gp

clean:
	rm -f $(EXECUTABLE) *.o *.s *.csv *.png
