#include <cuda.h>
#include <stdio.h>
#include <time.h>

#define SIZE 10

__global__ void max(int *a , int *c)	// kernel function definition
{
	int i = threadIdx.x;	// initialize i to thread ID

	*c = a[0];
	//printf("a[i] is %d \n",a[i]);
	atomicMin(c,a[i]);
	//printf("max is %d \n",*c);
}

int main()
{
	int i;
	srand(time(NULL));  //makes use of the computer's internal clock to control the choice of the seed

	int a[10]={2,41,21,74,86,45,92,35,49,50};
	int c;

	int *dev_a, *dev_c;   //GPU / device parameters

	cudaMalloc((void **) &dev_a, SIZE*sizeof(int));      //assign memory to parameters on GPU
	cudaMalloc((void **) &dev_c, SIZE*sizeof(int));

	for( i = 0 ; i < SIZE ; i++)
	{
		a[i] = i; // rand()% 1000 + 1;      // input the numbers
		//printf("%d ",a[i]);
	}

	cudaMemcpy(dev_c, &c, sizeof(int),cudaMemcpyHostToDevice);
	cudaMemcpy(dev_a, a, SIZE*sizeof(int),cudaMemcpyHostToDevice);  //copy the array from CPU to GPU
	max<<<1,SIZE>>>(dev_a,dev_c);									// call kernel function <<<number of blocks, number of threads
	cudaMemcpy(&c, dev_c, sizeof(int),cudaMemcpyDeviceToHost);		// copy the result back from GPU to CPU

	printf("\nmax =  %d ",c);

	cudaFree(dev_a);		// Free the allocated memory
	cudaFree(dev_c);
	printf("");

	return 0;
}
