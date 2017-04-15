#include <iostream>
#define MAX 10
using namespace std;
class Heap					//declare class Heap
{
	public:
	int array[MAX];			//integer array to store contents
	int size_index;

	Heap()					//initialize the heap
	{
		for(int i=0;i<MAX;i++)
			array[i]=0;
		size_index=-1;
	}
	void insert(int value)	//insert data in array 
	{
		size_index++;
		array[size_index]=value;
		reheap_Up(size_index);		//call reheap up to create heap again

	}
	void reheap_Up(int index)		//restore the heap property
	{
		int temp;
		int k=1;
		while(index>0 && array[index]>array[(index-1)/2])
		{

			temp=array[index];
			array[index]=array[(index-1)/2];
			array[(index-1)/2]=temp;
			index=(index-1)/2;
		}

	}
	void reheap_Down(int numn)   //set the array in ascending order
	{

		int start=0;
		int flag=1;
		int l_start;
		int l_index=size_index;
		int temp=size_index;
		int temp_value;

			while(l_index>0)
			{
				start=0;							
				flag=1;
				temp=array[0];						//replace root element with last element
				array[0]=array[l_index];
				array[l_index]=temp;
				l_index--;
				while(2*start+1<=l_index && flag==1)
				{
					l_start=2*start+1;							//sort the array to restore heap property
					if(l_start+1<=l_index && array[l_start+1]>array[l_start])
					{
						l_start=l_start+1;
					}
					if(array[start]>array[l_start])
					{
						flag=0;
					}
					else
					{
						temp_value=array[start];
						array[start]=array[l_start];
						array[l_start]=temp_value;
						start=l_start;
					}
				}

			}


}
	void display(int x)				//display the contents of array
	{
		for(int i=0;i<x;i++)
			cout<<array[i]<<"\t";
	}
};
int main()
{
	Heap object;
	int num;
	int value;
	char string[MAX];
	cout<<"Enter the Subject \n";
	cin>>string;
	cout<<"Enter the number of Students \t";		
	cin>>num;
	for(int i=0;i<num;i++)
	{
		cout<<"Enter their marks \t";
		cin>>value;
		object.insert(value);

	}
	object.display(num);
	cout<<"\n";
	object.reheap_Down(num);
	cout<<"SUbject:## "<<string<<"\n";
	cout<<"The Minimum marks Are \t"<<object.array[0]<<"\n";
	cout<<"The Maximum marks Are \t"<<object.array[num-1]<<"\n";
	object.display(num);



	return 0;
}
/*Enter the Subject 
Maths
Enter the number of Students 	7
Enter their marks 	120
Enter their marks 	56
Enter their marks 	6
Enter their marks 	12
Enter their marks 	130
Enter their marks 	23
Enter their marks 	67
130	120	67	12	56	6	23	
SUbject:## Maths
The Minimum marks Are 	6
The Maximum marks Are 	130
6	12	23	56	67	120	130	*/
