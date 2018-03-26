#include <iostream>
#include<string.h>
using namespace std;

class node
{
public:
	char word[20];
	char meaning[20];
	node* left,*right;
	int ht;

	node(char *wor,char* mean)
	{
		strcpy(word,wor);
		strcpy(meaning,mean);
		left=NULL;
		right=NULL;
		ht=0;
	}
};
class ATree
{
public:
	node* root;
	ATree()
	{
		root=NULL;
	}
	node* Right_Rotate(node* root)
	{
		node* temp;
		temp=root->left;
		root->left=temp->right;
		temp->right=root;
		root->ht=height(root);
		temp->ht=height(temp);
		return temp;
	}
	node* Left_Rotate(node* root)
	{
		node* temp;
		temp=root->right;
		root->right=temp->left;
		temp->left=root;
		root->ht=height(root);
		temp->ht=height(temp);
		return temp;
	}
	node* LL(node* root)
	{
		root=Right_Rotate(root);
		return root;
	}
	node* RR(node* root)
	{
		root=Left_Rotate(root);
		return root;
	}
	node* LR(node* root)
	{
		root->left=Left_Rotate(root->left);
		root=Right_Rotate(root);
		return root;
	}
	node* RL(node* root)
	{
		root->right=Right_Rotate(root->right);
		root=Left_Rotate(root);
		return root;
	}
	int height(node* root)
	{
		int lh,rh;
		if(root->left==NULL)
			lh=0;
		else
			lh=1+root->left->ht;
		if(root->right==NULL)
			rh=0;
		else
			rh=1+root->right->ht;

		if(lh>rh)
			return lh;
		else
			return rh;
	}
	int balance_factor(node* root)
	{
		int lh,rh;
			if(root->left==NULL)
				lh=0;
			else
				lh=1+root->left->ht;
			if(root->right==NULL)
				rh=0;
			else
				rh=1+root->right->ht;
			return (lh-rh);
	}
	node* delete_Node(node* root,char* wor)
	{
		if(root==NULL)
			return NULL;
		else if(strcmp(wor,root->word)>0)
		{
			root->right=delete_Node(root->right,wor);
			if(balance_factor(root)==2)
				if(balance_factor(root->left)>=0)
					root=LL(root);
				else
					root=LR(root);
		}
		else if(strcmp(wor,root->word)<0)
		{
			root->left=delete_Node(root->left,wor);
			if(balance_factor(root)==-2)
				if(balance_factor(root->right)<=0)
					root=RR(root);
				else
					root=RL(root);
		}
		else
		{
			if(root->right!=NULL)
			{
				node* temp;
				temp=root->right;
				while(temp->left!=NULL)
					temp=temp->left;
				strcpy(root->word,temp->word);
				strcpy(root->meaning,temp->meaning);
				root->right=delete_Node(root->right,temp->word);
				if(balance_factor(root)==-2)
					if(balance_factor(root->right)<=0)
						root=RR(root);
					else
						root=LR(root);
			}
			else
				return(root->left);

		}
		root->ht=height(root);
		return root;
	}
	node* insert_Node(node* root,char* wor,char* mea)
	{
		if(root==NULL)
			root=new node(wor,mea);
		else if(strcmp(wor,root->word)>0)
		{
			root->right=insert_Node(root->right,wor,mea);
			if(balance_factor(root)==-2)
			{
				if(strcmp(wor,root->right->word)>0)
					root=RR(root);
				else
					root=RL(root);
			}

		}
		else if(strcmp(wor,root->word)<0)
		{
			root->left=insert_Node(root->left,wor,mea);
			if(balance_factor(root)==2)
			{
				if(strcmp(wor,root->left->word)<0)
					root=LL(root);
				else
					root=LR(root);
			}
		}
		root->ht=height(root);
		return root;
	}

	void inorder_Display(node* root)
	{
		node* temp=root;
		if(temp!=NULL)
		{
			inorder_Display(temp->left);
			cout<<temp->word<<"\t"<<temp->meaning<<"\n";
			inorder_Display(temp->right);
		}
	}
	void Search_data(node* root,char *word)
	{
		node* temp;
		temp=root;
		int found=0;
		while(temp!=NULL)
		{
			if(strcmp(temp->word,word)>0)
				temp=temp->left;
			else if(strcmp(temp->word,word)<0)
				temp=temp->right;
			else if(strcmp(temp->word,word)==0)
			{
				found=1;
				break;
			}
		}
		if(found==1)
			cout<<"Element found \n";
		else if(found==0)
			cout<<"Element Not Found \n";

	}
};
int main()
{
	ATree tree;
	char wor[20],mea[20];
	cout<<"Enter data for 7 nodes \n";
	for(int i=0;i<7;i++)
	{
		cout<<"Enter the word \t";
		cin>>wor;
		cout<<"Enter the meaning \t";
		cin>>mea;
		tree.root=tree.insert_Node(tree.root,wor,mea);
	}
	tree.inorder_Display(tree.root);
	cout<<"Enter the word you want to delete \t";
	cin>>wor;
	tree.root=tree.delete_Node(tree.root,wor);
	tree.inorder_Display(tree.root);

	cout<<"Enter data you want to search \t";
	cin>>wor;
	tree.Search_data(tree.root,wor);

	cout<<"Enter the data you want to modify \t";
	cin>>wor;
	tree.root=tree.delete_Node(tree.root,wor);
	cout<<"Enter new data \n";
	cout<<"Enter new word \t";
	cin>>wor;
	cout<<"\n";
	cout<<"Enter its meaning \t";
	cin>>mea;
	tree.root=tree.insert_Node(tree.root,wor,mea);
	tree.inorder_Display(tree.root);



	return 0;
}
/*Enter data for 7 nodes 
Enter the word 	qwer
Enter the meaning 	q
Enter the word 	as
Enter the meaning 	a
Enter the word 	zx
Enter the meaning 	z
Enter the word 	ff
Enter the meaning 	f
Enter the word 	gh
Enter the meaning 	g
Enter the word 	jk
Enter the meaning 	j
Enter the word 	nm
Enter the meaning 	n
as	a
ff	f
gh	g
jk	j
nm	n
qwer	q
zx	z
Enter the word you want to delete 	as
ff	f
gh	g
jk	j
nm	n
qwer	q
zx	z
Enter data you want to search 	nm
Element found 
Enter the data you want to modify 	qwer
Enter new data 
Enter new word 	lkjio

Enter its meaning 	l
ff	f
gh	g
jk	j
lkjio	l
nm	n
zx	z
*/
