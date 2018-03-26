//============================================================================
// Name        : btree1.cpp
// Author      : 
// Version     :
// Copyright   : Your copyright notice
// Description : Hello World in C++, Ansi-style
//============================================================================
#include <iostream>
using namespace std;
class tnode
{
	friend class btree;
	string data;
	tnode *left;
	tnode *right;

	public:
	tnode()
	{
		data="";
		left=NULL;
		right=NULL;
	}
	tnode(string x)
	{
		data=x;
		left=NULL;
		right=NULL;
	}
};
class stack
{
	friend class btree;
	tnode *array[30];
	int top;

	public:
	stack()
	{
		top=-1;
	}
	int empty()
	{
		if(top==-1)
			return 1;
		else
			return 0;
		
	}
	void push(tnode *p)
	{
		array[++top]=p;

	}
	tnode *pop()
	{
		return(array[top--]);
	}
	


};
class btree
{
	tnode *root;

	public:
	btree()
	{
		root=NULL;
	}
	tnode *maketree(string val)
	{
		tnode *node;
		node=new tnode(val);
		return node;
	}
	void create(int n)
	{
		int i=0;string val;
		while(i<n)
		{
			cout<<"\nEnter the data in tree";
			cin>>val;
			insert(val);
			i++;
		}

	}
	void insert(string val)
	{
			tnode *temp;
			char direction;
			int insert=0;
			if(root==NULL)
			{
				root=maketree(val);
			}
			else
			{
				temp=root;
				do
				{
					cout<< "\nwhere to insert left/right of:: "<<temp->data<< ":";
					cin>>direction;
					if(direction=='l')
					{
						if(temp->left!=NULL)
						{
							temp=temp->left;
						}
						else
						{
							temp->left=maketree(val);
							insert=1;
						}

					}
					else if(direction=='r')
					{
						if(temp->right!=NULL)
						{
							temp=temp->right;
						}
						else
						{
							temp->right=maketree(val);
							insert=1;
						}
					}

				}while(insert==0);
			}

	}

	
	/*void preorder(tnode *temp)
	{
	   if(temp!=NULL)
	   {
	      cout<<temp->data;
	      preorder(temp->left);
	      preorder(temp->right);
	   }
	}*/
	void preorder(tnode *root)
	{
		tnode *temp;
		stack s;
		s.push(root);
		while(!s.empty())
		{
			temp=s.pop();
			if(temp!=NULL)
			{
				cout<<temp->data<<",";
				s.push(temp->right);
				s.push(temp->left);
			}
		}
	}	
	
	void display()
	{
	preorder(root);
	}

};




int main()
{


		btree  bt;
		int ch,n,i=0,n1;
		string val;
		char ans;
	 do
	 {
	cout<<"\nenter your choice::\n1:create\n2.insert\n3.display\n";
	cin>>ch;
	switch(ch)
	 {	case 1:
		    cout<< " \nhow many nodes in BT:";
		    cin>>n;
		    bt.create(n);
		    break;
	    case 2:
		    cout<<"\n no. of elements wants to insert::";
		    cin>>n1;
		    while(i<n1)
		    {
			cout<< "\nGive data for element to insert:";
			cin>>val;
			bt.insert(val);
			i++;
	        }
	        i=0;
	        break;

		case 3:
		 bt.display();
	       break;
	 }

	      cout<<"\ndo you want to continue::(y/n)::";
	       cin>>ans;
     }while(ans!='n');

	return 0;
}
