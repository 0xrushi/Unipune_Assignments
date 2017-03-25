
#include <iostream>

using namespace std;

class Heap{
	int ar[20];
	public:
	void insert_element(int data);
	void reheapdown(int i);
	void reheapup(int i);
	void sort();
	void display();
	int c;
	Heap()
	{
		c=0;
	}
};

void Heap::reheapup(int i){
	int tmp;
	while(i>0&&ar[i]>ar[(i-1)/2]){
		tmp=ar[i];
		ar[i]=ar[(i-1)/2];
		ar[(i-1)/2]=tmp;
		
		i=(i-1)/2;
	}
}


void Heap::insert_element(int x){
	ar[c]=x;
	reheapup(c);
	c++;
}


void Heap::display(){
for(int i=0;i<c;i++)
cout<<ar[i]<<"  ";
}



int main()

{
Heap h;
int p=3,i;

h.insert_element(8);
h.insert_element(12);
h.insert_element(5);
h.insert_element(10);
h.display();

return 0;
    
}
