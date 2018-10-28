#include<cuda.h>
#include <stdio.h>
#include<numeric>

#define SIZE 16

__global__ void para_max(int *input)
{
    int tid=threadIdx.x;
    int step_size=1;
    int no_of_thread=blockDim.x;
    while(no_of_thread>0)
    {
        if(tid<no_of_thread)
        {
            int fst=tid*step_size*2;
            int snd=fst+step_size;
            if(input[fst]<input[snd])
              input[fst]=input[snd];
        }
            step_size <<=1;
            no_of_thread >>=1;
    }
}

__global__ void para_min(int *input)
{
    int tid=threadIdx.x;
    int step_size=1;
    int no_of_thread=blockDim.x;
    while(no_of_thread>0)
    {
        if(tid<no_of_thread)
        {
            int fst=tid*step_size*2;
            int snd=fst+step_size;
            if(input[fst]>input[snd])
              input[fst]=input[snd];
        }
            step_size <<=1;
            no_of_thread >>=1;
    }
}

__global__ void para_add(int *input)
{
    int tid=threadIdx.x;
    int step_size=1;
    int no_of_thread=blockDim.x;
    while(no_of_thread>0)
    {
        if(tid<no_of_thread)
        {
            int fst=tid*step_size*2;
            int snd=fst+step_size;
            input[fst]+=input[snd];
        }
            step_size <<=1;
            no_of_thread >>=1;
    }
}

__global__ void para_avg(int *input)
{
    int tid=threadIdx.x;
    int step_size=1;
    int no_of_thread=blockDim.x;
    while(no_of_thread>0)
    {
        if(tid<no_of_thread)
        {
            int fst=tid*step_size*2;
            int snd=fst+step_size;
            input[fst]+=input[snd];
        }
            step_size <<=1;
            no_of_thread >>=1;
    }
	input[0]=input[0]/SIZE;
}
  int main(void)
  {
      int i;
      int result;
      int *dev_a;
      cudaMalloc(&dev_a, SIZE*sizeof(int));

      int a[]={1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16};

	  printf("Vector is: ");
      for(int i=0;i<SIZE;i++)
          printf("%d ",a[i]);

      cudaMemcpy(dev_a,a,sizeof(a),cudaMemcpyHostToDevice);
      para_max<<<1, SIZE/2>>>(dev_a);
      cudaMemcpy(&result,dev_a,sizeof(result),cudaMemcpyDeviceToHost);
      printf("\n Max is: ");
      printf("%d\n",result);

      cudaMemcpy(dev_a,a,sizeof(a),cudaMemcpyHostToDevice);
      para_min<<<1, SIZE/2>>>(dev_a);
      cudaMemcpy(&result,dev_a,sizeof(result),cudaMemcpyDeviceToHost);
      printf(" Min is: ");
      printf("%d\n",result);

      cudaMemcpy(dev_a,a,sizeof(a),cudaMemcpyHostToDevice);
      para_add<<<1, SIZE/2>>>(dev_a);
      cudaMemcpy(&result,dev_a,sizeof(result),cudaMemcpyDeviceToHost);
      printf(" Sum is: ");
      printf("%d\n",result);

      cudaMemcpy(dev_a,a,sizeof(a),cudaMemcpyHostToDevice);
      para_avg<<<1, SIZE/2>>>(dev_a);
      cudaMemcpy(&result,dev_a,sizeof(result),cudaMemcpyDeviceToHost);
      printf(" Avg is: ");
      printf("%d\n",result);

      cudaFree(dev_a);

      return 0;

  }
