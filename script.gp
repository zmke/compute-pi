reset

set xlabel 'N'
set ylabel 'time(sec)'
set style fill solid
set title 'perfomance comparison'
set term png enhanced font 'Verdana,10'
set output 'runtime.png'
set datafile separator ','
set key left

plot 'result_clock_gettime.csv' using 1:2 with lines linewidth 2 title 'baseline', \
'' using 1:3 with lines linewidth 2 title 'omp_2', \
'' using 1:4 with lines linewidth 2 title 'omp_4', \
'' using 1:5 with lines linewidth 2 title 'avx', \
'' using 1:6 with lines linewidth 2 title 'avx\_unroll', \
'' using 1:7 with lines linewidth 2 title 'leibniz', \
'' using 1:8 with lines linewidth 2 title 'leibniz\_omp_4', \
'' using 1:9 with lines linewidth 2 title 'leibniz\_avx'
