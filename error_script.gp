reset

set xlabel 'N'
set ylabel 'error'
set style fill solid
set title 'compute pi error'
set term png enhanced font 'Verdana,10'
set output 'error.png'
set datafile separator ','

plot 'compute_error.csv' using 1:2 with lines linewidth 2 title 'baseline', \
'' using 1:3 with lines linewidth 2 title 'Leibniz'
