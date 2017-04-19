//============================================================================
// Name        : heap.cpp
// Author      : 
// Version     :
// Copyright   : Your copyright notice
// Description : Hello World in C++, Ansi-style
//============================================================================

#include <iostream>
#define MAX 20

using namespace std;

class heap{
public:
	int ar[MAX],n,value,x;
public:
	heap(){
		for(int i=0;i<MAX;i++){
			ar[i]=0;
		}
		n=0;
	}

	void create();
	void reheapup(int);
	void reheapdown(int,int);
	void display();
	void del();
	void sort();

};

int main() {
	heap h;
	cout << "!!----!!" << endl; // prints !!!Hello World!!!
	h.create();
	h.del();
	h.display();

	cout<<"n is "<<h.n<<endl;
	h.del();
	h.display();

	cout<<"n is "<<h.n<<endl;
	h.del();
	h.display();

	cout<<"n is "<<h.n<<endl;

	h.display();
	return 0;
}

void heap::create() {
	cout<<"Enter total elements \n";
	cin>>n;
	x=n;
	for(int i=0;i<n;i++){
		cout<<"Enter value \n";
		cin>>value;
		ar[i]=value;
		reheapup(i);
	}
	for(int i=0;i<n;i++){
		cout<<"  "<<ar[i];
	}
	cout<<endl;
}

void heap::reheapup(int i) {
	while(ar[i]>ar[(i-1)/2]&&i>0){
		int temp=ar[i];
		ar[i]=ar[(i-1)/2];
		ar[(i-1)/2]=temp;
		i=(i-1)/2;
	}
}

void heap::reheapdown(int i,int q) {
	int j,flag=1;
	while((2*i+1)<q&&flag==1){
		j=2*i+1;
		if(j+1<q&&ar[j]<ar[j+1]){
			j++;
		}
		if(ar[i]>ar[j]){
			flag=0;
		}
		else
		{
			int temp=ar[i];
			ar[i]=ar[j];
			ar[j]=temp;
			i=j;
		}
	}

}

void heap::display() {
	for(int i=0;i<n;i++){
		cout<<"  "<<ar[i];
	}
	cout<<endl;
}

void heap::del() {
	int temp=ar[0];
	ar[0]=ar[n-1];
	ar[n-1]=temp;
	n--;
	reheapdown(0,n);
}

void heap::sort() {
	x=n;
	for(int i=0;i<7;i=i+1)
	{
		int temp=ar[0];
		ar[0]=ar[n-1];
		ar[n-1]=temp;
		n--;
		reheapdown(0,n);
	}
}
