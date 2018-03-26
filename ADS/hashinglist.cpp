
#include <iostream>
#include<string.h>
int TS=59;
using namespace std;

class Node
{
public:
	string word;
	string meaning;
	Node *next;

	Node(){
		word="";
		meaning="";
		next=NULL;
	}
};

class Hash{
	//int TS=59;
	Node *ht[59];
	public:
	int hashfn(string k);
	void insert(int key,string w,string m);
	void display();

	Hash(){
		for(int i=0;i<TS;i++){
			//ht[i]=new Node();
			ht[i]=NULL;
		}
	}

};

int Hash::hashfn(string k){
	int loc=0;
	for(int i=0;i<k.length();i++){
		loc+=k[i];
		cout<<loc<<"--------------";
	}
	loc=loc%TS;
	return loc;
}

void Hash::insert(int key,string w,string m){
	Node *p=new Node();
	p->word=w;
	p->meaning=m;
	p->next=NULL;
cout<<"\nkey="<<key<<".............";
	if(ht[key]==NULL){
	ht[key]=p;
	}
	else
	{
	  Node* temp=ht[key];

	  //int L=strcmp(temp->word.c_str(),p->word.c_str());

	if(temp->word>p->word)
	  {
		cout<<"before swap "<<temp->word<<","<<p->word<<endl;
	  	string ddf;
	  	ddf=temp->word;
	  	temp->word=p->word;
	  	p->word=ddf;
	  	 cout<<"after swap "<<temp->word<<","<<p->word<<endl;
	  }
	
	  while(temp->next!=NULL){
	   if(temp->word>p->word)
	  {
	  	string ddf;
	  	ddf=temp->word;
	  	temp->word=p->word;
	  	p->word=ddf;
	  }
	  temp=temp->next;
	  }//end while
	  
	  if(temp->word>p->word)
	  	  {
	  	string ddf;
	  	ddf=temp->word;
	  	temp->word=p->word;
	  	p->word=ddf;
	  }
	  temp->next=p;
	}
}

void Hash::display(){
cout<<" i "<<"word "<<"meaning"<<endl;

	int i=0;
	while(i<59){
		Node* temp=ht[i];
		if(temp!=NULL){
			while(temp!=NULL){
				cout<<i<<"  "<<temp->word<<"  "<<temp->meaning<<"    ";
				temp=temp->next;
			}
			cout<<endl;
		}
		i++;
	}
}

int main() {
	string word,meaning;
	int n,p=0;
	Hash h;
	cout << "Enter n " << endl;
	cin>>n;
	while(n--){
		cout << "Enter word " << endl;
		cin>>word;
		cout << "Enter Meaning " << endl;
		cin>>meaning;
		int key=h.hashfn(word);
		h.insert(key,word,meaning);
	}
	h.display();

	return 0;
}

