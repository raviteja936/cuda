#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void add(int n, float *x, float *y) {
    for (int i=0; i<n; i++)
        y[i] = y[i] + x[i];
}


int main(void) {
    
    int n = 1000000;
    float *x = (float *) malloc(n * sizeof(float));
    float *y = (float *) malloc(n * sizeof(float));

    // Initialize arrays
    for (int i=0; i<n; i++) {
        x[i] = 1.0f;
        y[i] = 2.0f;
    }
        
    add(n, x, y);
    // Check for errors (all values should be 3.0f)
    int error = 0;
    for (int i=0; i<n; i++) {
        if (y[i]-3.0 != 0)
            error += 1;
    }
        
    printf("Errors: %d\n", error);

    // Free memory
    free(x);
    free(y);
    return 0;
}