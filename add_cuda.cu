#include <stdio.h>
#include <stdlib.h>
#include <math.h>

__global__
void add(int n, float *x, float *y) {
    int index = blockIdx.x * blockDim.x + threadIdx.x;
    int stride = blockDim.x * gridDim.x;

    for (int i=index; i<n; i += stride)
        y[i] = y[i] + x[i];
}


int main(void) {
    
    int n = 1000000;
    float *x, *y;
    cudaMallocManaged(&x, n * sizeof(float));
    cudaMallocManaged(&y, n * sizeof(float));

    // Initialize arrays
    for (int i=0; i<n; i++) {
        x[i] = 1.0f;
        y[i] = 2.0f;
    }
    
    int blockSize = 256;
    int numBlocks = (n + blockSize - 1) / blockSize;
    add<<<numBlocks, blockSize>>>(n, x, y);
    
    
    cudaDeviceSynchronize();
    
    // Check for errors (all values should be 3.0f)
    int error = 0;
    for (int i=0; i<n; i++) {
        if (y[i]-3.0 != 0)
            error += 1;
    }
    
    printf("Errors: %d\n", error);

    // Free memory
    cudaFree(x);
    cudaFree(y);
    return 0;
}