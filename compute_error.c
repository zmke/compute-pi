#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "computepi.h"

#define PI acos(-1.0)

int main(int argc, char const *argv[])
{
    if (argc < 2) return -1;

    int N = atoi(argv[1]);
    double result, error;

    // Baseline
    result = compute_pi_avx(N);
    error = (result - PI > 0) ? result - PI : PI - result;
    printf("%lf,", error);

    // Leibniz
    result = compute_pi_leibniz_avx(N, 4);
    error = (result - PI > 0) ? result - PI : PI - result;
    printf("%lf\n", error);

    return 0;
}
