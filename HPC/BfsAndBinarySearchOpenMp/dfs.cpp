#include<iostream>
#include<stdlib.h>
#include<queue>
#include<stack>
#include<omp.h>
using namespace std;


class node
{
   public:
	
	node *left, *right;
	int data;
	int visited;

};	 

class Breadthfs
{
 
 public:
 
 node *insert(node *, int);
 void bfs(node *);
 
};


node *insert(node *root, int data)
{

	if(!root)
	{
		
		root=new node;
		root->left=NULL;
		root->right=NULL;
		root->data=data;
		root->visited=0;
		return root;
	}

	queue<node *> q;
	q.push(root);
	
	while(!q.empty())
	{

		node *temp=q.front();
		q.pop();
	
		if(temp->left==NULL)
		{
			
			temp->left=new node;
			temp->left->left=NULL;
			temp->left->right=NULL;
			temp->left->data=data;
			temp->left->visited =0;	
			return root;
		}
		else
		{

		q.push(temp->left);

		}

		if(temp->right==NULL)
		{
			
			temp->right=new node;
			temp->right->left=NULL;
			temp->right->right=NULL;
			temp->right->data=data;
			temp->right->visited =0;		
			return root;
		}
		else
		{

		q.push(temp->right);

		}

	}
	
}


void bfs(node *head,int key)
{
	stack<node*> s;
	s.push(head);
	head->visited = 1;
	while(!s.empty()){
		node *temp = s.top();
		s.pop();
		cout<<temp->data;
		#pragma omp parallel
		{
		#pragma omp critical
		{
		if(temp->left!=NULL && temp->left->visited==0){
			s.push(temp->left);
			temp->left->visited = 1;
		}
		}
		#pragma omp critical
		{
		if(temp->right!=NULL && temp->right->visited==0){
			s.push(temp->right);
			temp->right->visited = 1;
		}
		}
		}
		
	}

}

int main(){

	node *root=NULL;
	int data;
	int key;
	char ans;
	
	do
	{
		cout<<"\n enter data=>";
		cin>>data;
		
		root=insert(root,data);
	
		cout<<"do you want insert one more node?";
		cin>>ans;
	
	}while(ans=='y'||ans=='Y');
	
	cout<<"Enter key to be searched";
	cin>>key;
	bfs(root,key);
	
	return 0;
}

