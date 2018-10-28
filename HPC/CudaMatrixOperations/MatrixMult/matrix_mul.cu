/**
 * Copyright 1993-2012 NVIDIA Corporation.  All rights reserved.
 *
 * Please refer to the NVIDIA end user license agreement (EULA) associated
 * with this source code for terms and conditions that govern your use of
 * this software. Any use, reproduction, disclosure, or distribution of
 * this software and related documentation outside the terms of the EULA
 * is strictly prohibited.
 */
 #include <stdio.h>
 #include<cuda.h>
 #include <stdlib.h>
 #include<time.h>
 
 #define SIZE 3
 
 __global__ void matrixmult(int *mat1, int *mat2, int *res)
 {
	 int ROW = blockIdx.y*blockDim.y + threadIdx.y;
	 int COL = blockIdx.x*blockDim.x + threadIdx.x;
	 int mult = 0;
	 for (int i = 0; i < SIZE; i++) {
		 mult += mat1[ROW * SIZE + i] * mat2[i * SIZE + COL];
	 }
	 res[ROW * SIZE + COL] = mult;
 }
 
 int main(void)
 {
	 int i, j;
	 srand(time(NULL));
 //	int a[SIZE][SIZE], b[SIZE][SIZE], c[SIZE][SIZE];
	 int c[SIZE][SIZE];
	 int a[][SIZE]={{1,2,3},{4,5,6},{7,8,9}};
	 int b[][SIZE]={{1,2,3},{4,5,6},{7,8,9}};
 
	 int *dev_a, *dev_b, *dev_c;
 
	 cudaMalloc((void **)&dev_a, SIZE*SIZE * sizeof(int));
	 cudaMalloc((void **)&dev_b, SIZE*SIZE * sizeof(int));
	 cudaMalloc((void **)&dev_c, SIZE*SIZE * sizeof(int));
 
	 printf("\nThe 1st matrix is:\n");
	 for (i = 0; i < SIZE; i++){
		 for (j = 0; j < SIZE; j++){
			 printf("%d\t", a[i][j]);
		 }
		 printf("\n");
	 }
 
	 printf("\nThe 2nd matrix is:\n");
	 for (i = 0; i < SIZE; i++){
		 for (j = 0; j < SIZE; j++){
			 printf("%d\t", b[i][j]);
		 }
		 printf("\n");
	 }
 
	 cudaMemcpy(dev_a, a, sizeof(a), cudaMemcpyHostToDevice);
	 cudaMemcpy(dev_b, b, sizeof(b), cudaMemcpyHostToDevice);
	 matrixmult << <SIZE, SIZE >> > (dev_a, dev_b, dev_c);
	 cudaMemcpy(&c, dev_c, sizeof(c), cudaMemcpyDeviceToHost);
 
	 printf("\nResult matrix is:\n");
	 for (i = 0; i < SIZE; i++){
		 for (j = 0; j < SIZE; j++){
			 printf("%d\t", c[i][j]);
		 }
		 printf("\n");
	 }
 
	 return 0;
 }
 