#include <stdlib.h>
#include <stdio.h>

void merge(int* arr,int l,int m,int r)
{
    int i,j,k;
    int n1=m-l+1;
    int n2=r-m;
    
    int L[n1],R[n2];
    
    for(i=0;i<n1;i++)
        L[i]=arr[l+i];
    for(i=0;i<n2;i++)
        R[i]=arr[m+1+i];
    
    i=0;
    j=0;
    k=l;
    
    
    while(i<n1 && j<n2)
    {
        if(L[i] <= R[j]){
            arr[k]=L[i];
            i++;
        }
        else{
            arr[k]=R[j];
            j++;
        }
        k++;
    }
    
    while(i<n1){
        arr[k]=L[i];
        i++;
        k++;
    }
    while(j<n2){
        arr[k]=R[j];
        i++;
        j++;
    }
    
}



void mergeSort(int arr[],int l,int r)
{
    if(l<r){
        int m=l+(r-l)/2;
        
    #pragma omp parallel sections
        {
            #pragma omp section
            {
                mergeSort(arr,l,m);
            }
            #pragma omp section
            {
                mergeSort(arr,m+1,r);
            }
            merge(arr,l,m,r);
        }
    }
}

int main(){
    int A[]={12,13,54,4,6,8};
    int ars=6;
    int i;
    for (i=0; i < ars; i++) 
        printf("%d ", A[i]); 
    printf("\n");
    
    mergeSort(A,0,ars-1);
    
    for (i=0; i < ars; i++) 
        printf("%d ", A[i]); 
    printf("\n");
}


