#include<iostream>
#include<graphics.h>
#include<cstdio>
#include<math.h>
using namespace std;
int count;
int Integer(float a)
{
	int temp;
	temp=a;
	return temp;
}
void breshsimple(int x1,int y1,int x2,int y2)
{
	float dx,dy;
	float x,y;
	float length;
	if(abs(x2-x1)>=abs(y2-y1))
		length=abs(x2-x1);
	else
		length=abs(y2-y1);
	dx=abs(x2-x1)/length;
	dy=abs(y2-y1)/length;
	x=x1;
	y=y1;
	for(int i=0;i<=length;i++)
	{
		
		
			putpixel(Integer(x),Integer(y),WHITE);
			
		x=x+dx;
		y=y+dy;
		
	}

}
void breshdashed(int x1,int y1,int x2,int y2)
{
	count=0;
	float dx,dy;
	float x,y;
	float length;
	if(abs(x2-x1)>=abs(y2-y1))
		length=abs(x2-x1);
	else
		length=abs(y2-y1);
	dx=abs(x2-x1)/length;
	dy=abs(y2-y1)/length;
	x=x1;
	y=y1;
	for(int i=0;i<=length;i++)
	{
		if(count<=5)
		{
			putpixel(Integer(x),Integer(y),WHITE);
		}	
		x=x+dx;
		y=y+dy;
		
		if(count==10)
		{
			count=0;
		}
		count++;
	}

}
void breshdotted(int x1,int y1,int x2,int y2)
{
	count=1;
	float dx,dy;
	float x,y;
	float length;
	if(abs(x2-x1)>=abs(y2-y1))
		length=abs(x2-x1);
	else
		length=abs(y2-y1);
	dx=abs(x2-x1)/length;
	dy=abs(y2-y1)/length;
	x=x1;
	y=y1;
	for(int i=0;i<=length;i++)
	{
		if(count<=1)
		{
			putpixel(Integer(x),Integer(y),WHITE);
		}	
		x=x+dx;
		y=y+dy;
		
		if(count==2)
		{
			count=0;
		}
		count++;
	}

}

int main()
{
	int gd=DETECT,gm;
	int x1,y1,x2,y2;
	int choice;
	
	
		cout<<"Enter the starting co-ordinate \n";
		cin>>x1>>y1;
		cout<<"Enter the end point co-ordinate \n";
		cin>>x2>>y2;
		cout<<"1) Straight Line   2) Dash Line   3) Dotted Line  4)Fat Line \n";
		cin>>choice;
		switch(choice)
		{
			case 2:
					initgraph(&gd,&gm,0);
					breshdashed(x1,y1,x2,y2);
					getch();
					closegraph();

					break;
			case 3:
					initgraph(&gd,&gm,0);
					breshdotted(x1,y1,x2,y2);
					getch();
					closegraph();
					break;
			case 1:
					initgraph(&gd,&gm,0);
					breshsimple(x1,y1,x2,y2);
					getch();
					closegraph();
					break;
			case 4:
					initgraph(&gd,&gm,0);
					breshsimple(x1,y1,x2,y2);
					breshsimple(x1-1,y1,x2-1,y2);
					getch();
					closegraph();
					break;
		}

	
	
	
		
}