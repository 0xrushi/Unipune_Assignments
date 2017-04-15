#include <iostream>
#include<string.h>
#include<fstream>
using namespace std;
class Record 						//declare class Record
{
	int r_No;
	char name[20];
	long prn_No;
public:
	Record()
	{
		r_No=0;
		
		prn_No=0;
	}
	void setdata()					//set data for variables of class record
	{
		cout<<"Enter roll_No \t";
		cin>>r_No;
		cout<<"Enter Name of Student \t";
		cin>>name;
		cout<<"Enter your PRN \t";
		cin>>prn_No;
		cout<<"\n";
	}
	int Roll_no()					//return roll NO of particular student
	{
		return (r_No);
	}
	void getdata()					//display data of any student 
	{
		cout<<"Roll_No \t"<<r_No<<"\n";
		cout<<"Name of Student \t"<<name<<"\n";
		cout<<"Enter your PRN \t"<<prn_No<<"\n";
		cout<<"\n";
	}
};
class File
{
	ifstream fin;				//create file read,write objects
	ofstream fout;
	fstream out_in;
public:
		File()
		{}
		void insert_Record(char* masterFile)			//insert Record in masterFile
		{

			Record temp;
			temp.setdata();
			fout.open(masterFile,ios::ate|ios::app);
			fout.write((char*)&temp,sizeof(temp));
			fout.close();
		}
		void display_Record(char* filename)				//display Record in masterFile
		{
			Record temp;
			fin.open(filename);
			fin.seekg(0,ios::beg);
			
			while(fin.read((char*)&temp,sizeof(temp)))

			{
				
				temp.getdata();
			}
			fin.close();
		}
	

		int data_Search(char* filename,int x)			//search Record in masterFile
		{
			Record temp;
			fin.open(filename);
			fin.seekg(0,ios::beg);
			while(fin.read((char*)&temp,sizeof(temp)))
			{
				
				if(x==temp.Roll_no())
				{
					fin.close();
					return 1;
				}
			}
			fin.close();
			return 0;
		}
		void delete_Data(char* master,char* temp,int value)		//Delete Record in masterFile
		{
			Record temp1;
			fin.open(master);
			fin.seekg(0,ios::beg);
			fout.open(temp);
			while(fin.read((char*)&temp1,sizeof(temp1)))
			{
				if(value!=temp1.Roll_no())
					fout.write((char*)&temp1,sizeof(temp1));
			}
			
			fout.close();
			fin.close();
			rename(temp,master);
			
			
		}
		void edit_Entry(char* filename,int value)			//Edit Record in masterFile
		{
			Record temp;
			Record r;
			out_in.open(filename,ios::in|ios::out);
			out_in.seekg(0,ios::beg);
			while(out_in.read((char*)&temp,sizeof(temp)))
			{
				if(value==temp.Roll_no())
				{
					out_in.seekp((int)out_in.tellg()-sizeof(temp),ios::beg);
					cout<<"Enter the new details \n";
					r.setdata();
					out_in.write((char*)&r,sizeof(r));
					break;
				}
			}
			out_in.close();
		}

};

int main()
{
	char filename1[20];
	char filename2[20];
	File object;
	Record obj;
	int n;
	int r_no;
	int choice;
	int flag=0;
	cout<<"Enter MAster File Name \n";
	cin>>filename1;
	cout<<"Enter temperory File Name \n";
	cin>>filename2;
	do
	{
		cout<<"1)Create Master File \n 2) Insert Entry \n 3)Search \n 4)Display \n 5)Delete \n  6)Edit \n 7)Exit \n";
		cin>>choice;
		switch(choice)
		{
			case 1:
					if(flag==0)
					{
						flag=1;
						cout<<"Enter the number of records \n";
						cin>>n;
						for(int i=0;i<n;i++)
						{

							object.insert_Record(filename1);
						}
					}
					else
						cout<<"Master File is Present Please Select another Option \n";
					break;

			case 2:
					object.insert_Record(filename1);
					break;


			case 3:
					cout<<"Enter the Roll No you want to Search \t";
					cin>>r_no;
					if(object.data_Search(filename1,r_no))
						cout<<"Data Found \n";
					else
						cout<<"Data Not Found \n";
					break;

			case 4:
					object.display_Record(filename1);
					break;


			case 5:
					cout<<"Entert the Roll_NO of Student whose Record you want to delete \t";
					cin>>r_no;
					
						object.delete_Data(filename1,filename2,r_no);
					
						
					break;

			case 6:
					cout<<"Enter the Roll NO of the student whose info you want to change \n";
					cin>>r_no;
					object.edit_Entry(filename1,r_no);
					break;

		}
	}while(choice!=7);

	return 0;
}
/*Enter MAster File Name 
qwer
Enter temperory File Name 
asdf
1)Create Master File 
 2) Insert Entry 
 3)Search 
 4)Display 
 5)Delete 
  6)Edit 
 7)Exit 
1
Enter the number of records 
2
Enter roll_No 	45
Enter Name of Student 	qwerty
Enter your PRN 	1234

Enter roll_No 	56
Enter Name of Student 	asdfgh
Enter your PRN 	67

1)Create Master File 
 2) Insert Entry 
 3)Search 
 4)Display 
 5)Delete 
  6)Edit 
 7)Exit 
4
Roll_No 	45
Name of Student 	qwerty
Enter your PRN 	1234

Roll_No 	56
Name of Student 	asdfgh
Enter your PRN 	67

1)Create Master File 
 2) Insert Entry 
 3)Search 
 4)Display 
 5)Delete 
  6)Edit 
 7)Exit 
3
Enter the Roll No you want to Search 	45
Data Found 
1)Create Master File 
 2) Insert Entry 
 3)Search 
 4)Display 
 5)Delete 
  6)Edit 
 7)Exit 
5
Entert the Roll_NO of Student whose Record you want to delete 	45
1)Create Master File 
 2) Insert Entry 
 3)Search 
 4)Display 
 5)Delete 
  6)Edit 
 7)Exit 
4
Roll_No 	56
Name of Student 	asdfgh
Enter your PRN 	67

1)Create Master File 
 2) Insert Entry 
 3)Search 
 4)Display 
 5)Delete 
  6)Edit 
 7)Exit 
6
Enter the Roll NO of the student whose info you want to change 
56
Enter the new details 
Enter roll_No 	78
Enter Name of Student 	zxcvb
Enter your PRN 	70

1)Create Master File 
 2) Insert Entry 
 3)Search 
 4)Display 
 5)Delete 
  6)Edit 
 7)Exit 
4
Roll_No 	78
Name of Student 	zxcvb
Enter your PRN 	70

1)Create Master File 
 2) Insert Entry 
 3)Search 
 4)Display 
 5)Delete 
  6)Edit 
 7)Exit 
7
*/
