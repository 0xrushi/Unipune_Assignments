//============================================================================
// Author      : Rushi Chaudhari
// Roll		   : 205207
// Div         : SE3 A
//============================================================================

#include <iostream>
#include<string.h>
#include<fstream>
using namespace std;


class record
{
	char name[20], address[40];
	int rollno;

public:
	record()
{
		strcpy(name, " ");
		strcpy(address, " ");
		rollno = 0;
}
	void setdata()
	{
		cout<<"\nEnter name of student: ";
		cin>>name;
		cout<<"\nEnter student's address: ";
		cin>>address;
		cout<<"\nEnter roll no. : ";
		cin>>rollno;
	}

	char* getname()
	{
		return name;
	}

	char* getaddress()
	{
		return address;
	}
	int getroll()
	{
		return rollno;
	}

};



class file
{
	fstream fs;

public:
	void insert();
	void display();
	void search(int);
	void dlt(int);
	void edit(int);

};


void file::insert()
{
	record r;

	r.setdata();
	fs.open("Student_Details.txt",ios::out | ios::app);
	fs.write((char *)&r,sizeof(r));
	fs.close();
}


void file::display()
{
	record  r;

	fs.open("Student_Details.txt", ios::binary | ios::in);
	fs.seekg(0, ios::beg);
	while(fs.read((char *)&r,sizeof(r)))
	{
		cout<<"\nName:"<<r.getname();
		cout<<"\nRoll number:"<<r.getroll();
	    cout<<"\nAddress:"<<r.getaddress();
	}
	fs.close();
}


void file::search(int key)
{
	record r;
	int flag = 0;

	fs.open("Student_Details.txt");
	fs.seekg(0, ios::beg);

	while(fs.read((char *)&r,sizeof(r)))
	{
		if(r.getroll()==key)
		{
			flag = 1;
			break;
		}
	}
	if(flag==1)
		cout<<"\nStudent found!";
	else
		cout<<"\nSearch unsuccessful";

	fs.close();
}


void file::dlt(int key)
{
	record r;
	int flag = 0;
	ofstream out;

	out.open("myTemp.txt", ios::ate | ios::app);
	fs.open("Student_Details.txt");
	fs.seekg(0, ios::beg);

	while(fs.read((char *)&r,sizeof(r)))
	{
		if(r.getroll()==key)
		{
			flag = 1;
		}
		else
		{
			out.write((char*)&r, sizeof(r));
		}
	}
	fs.close();
	remove("Student_Details.txt");
	rename("myTemp.txt", "Student_Details.txt");
	out.close();
}


void file::edit(int key)
{
	record r;

	fs.open("Student_Details.txt");
	fs.seekg(0,ios::beg);

	while(fs.read((char *)&r,sizeof(r)))
	{
		if(r.getroll() == key)
		{
			cout<<"Enter new data:";
			r.setdata();
			fs.seekp((int)fs.tellg() - sizeof(r),ios::beg);
			fs.write((char *)&r,sizeof(r));
			break;
		}
	}
	fs.close();
}



int main() {

	file f1;

	int choice=0, n, key;

	while(choice!=6)
	{
		cout<<"\n1.Insert record\n2.Display\n3.Search\n4.Delete\n5.Edit\n6.Exit\n\nEnter your choice: ";
		cin>>choice;

		switch(choice)
		{
		case 1:
			cout<<"\nEnter number of students: ";
			cin>>n;
			for(int i=0; i<n; i++)
				f1.insert();
			break;

		case 2:
			f1.display();
			break;

		case 3:
			cout<<"Enter roll number to be searched:";
			cin>>key;
			f1.search(key);
			break;

		case 4:
			cout<<"Enter roll number of student whose data is to be deleted";
			cin>>key;
			f1.dlt(key);
			break;

		case 5:
			cout<<"Enter roll number of student whose data needs to be edited";
			cin>>key;
			f1.edit(key);
			break;
		}
	}
	return 0;
}

