#include<iostream>
#include<math.h>
#include<graphics.h>
using namespace std;

class Myline
{
	int x1, y1, x2, y2, length, s1, s2, flag=0;
	float dx, dy, x, y;
	
	public:
	void drawline_DDA(int fl);
	void drawline_Bresenham(int fl);
	Myline(int a, int b, int c, int d)
	{
		x1=a;
		y1=b;
		x2=c;
		y2=d;
	}
};

void Myline::drawline_DDA(int fl)
{	
	int sbit;
	if(x2-x1==0)
		sbit =-1;
	else if(((y2-y1)/(x2-x1))<0)
		sbit = 1;
	else
		sbit = 0;

	if(abs(x2-x1)>abs(y2-y1))
	length = abs(x2-x1);
	else
	length = abs(y2-y1);
	
	dx = (x2-x1)/length;
	dy = (y2-y1)/length;
	
	dx = round(dx);	
	dy = round(dy);
	
	x = x1; y = y1;
	
	for(int i=0; i<length; i++)
	{	
		switch(fl)
		{
			case 1:
				if(i%2==0)
					putpixel(x, y, WHITE);
				break;
					
			case 2:
				if(i%5!=0)
					putpixel(x, y, WHITE);
				break;	
					
			case 3:
				
				if(flag%5!=0 && flag%7!=0)
					putpixel(x, y, WHITE);
					flag++;
				if(flag==7)
					flag=0;
				break;	
					
			case 4:
				if(sbit==-1)
					for(int j=0; j<4; j++)
						putpixel(x+j, y, WHITE);
				else if(sbit==0)
					for(int j=0; j<4; j++)
						putpixel(x+j, y, WHITE);
				else
					for(int j=0; j<4; j++)
						putpixel(x-j, y, WHITE);
				break;
						
		}
		
		x = x + dx;
		y = y + dy;
	} 
}

void Myline::drawline_Bresenham(int fl)
{
	int temp, e, interchange, sbit;
	
	if(x2-x1==0)
		sbit = -1;
	else if(((y2-y1)/(x2-x1))<0)
		sbit = 1;
	else
		sbit = 0;
		
	
	x = x1;
	y = y1;
	dx = abs(x2-x1);
	dy = abs(y2-y1);
	
	if(x1>x2)
	s1 = -1;
	else
	s1 = 1;
	
	if(y1>y2)
	s2 = -1;
	else
	s2 = 1;
	
	if(dy>dx)
	{
		temp = dx;
		dx = dy;
		dy = temp;
		interchange = 1;
	}
	else
	interchange = 0;
	
	e = (2*dy) - dx;
	
	for(int i=1; i<=dx; i++)
	{
		switch(fl)
		{
			case 1:
				if(i%2==0)
					putpixel(x, y, WHITE);
				break;
					
			case 2:
				if(i%5!=0)
					putpixel(x, y, WHITE);
				break;	
					
			case 3:
				
				if(flag%5!=0 && flag%7!=0)
					putpixel(x, y, WHITE);
					flag++;
				if(flag==7)
					flag=0;
				break;	
					
			case 4:
				if(sbit==-1)
					for(int j=0; j<4; j++)
						putpixel(x+j, y, WHITE);
				
				else if(sbit==0)
					for(int j=0; j<4; j++)
						putpixel(x+j, y, WHITE);
				else
					for(int j=0; j<4; j++)
						putpixel(x-j, y, WHITE);
				break;
		}
		while(e>0)
		{
			if(interchange==1)
				x = x + s1;
			else
				y = y + s2;
			e = e - (2*dx);
		}
		
		if(interchange==1)
			y = y + s2;
		else
			x = x + s1;
			
		e = e + (2*dy);
	}
}



int main()
{
	int gdriver = DETECT, gmode,x1,x2,y1,y2, choice, ch;
	
	cout<<"\nEnter the co-ordinates of the end points- x1, y1, x2, y2 :-";
	cin>>x1>>y1>>x2>>y2;
	Myline l(x1, y1, x2, y2);
	
	while(ch!=3)
	{
		cout<<"\n1.DDA\n2.Bresenham\n3.Exit\n\nEnter your choice: ";
		cin>>choice;
		switch(choice)
		{	
			case 1:
				cout<<"\n1.Dotted Line\n2.Dashed Line\n3.Dot n Dash Line\n4.Thick Line\n\nEnter your choice: ";
				cin>>ch;
	
				initgraph(&gdriver, &gmode, NULL);
				l.drawline_DDA(ch);
				getch();
				closegraph();
				break;
			
			case 2:
				cout<<"\n1.Dotted Line\n2.Dashed Line\n3.Dot n Dash Line\n4.Thick Line\n\nEnter your choice: ";
				cin>>ch;
	
				initgraph(&gdriver, &gmode, NULL);
				l.drawline_Bresenham(ch);
				getch();
				closegraph();
				break;
				
			case 3:
				cout<<"\nEND";
				break;
				
			default:
				cout<<"\nInvalid input!";
				break;
		}
	}
	
	return 0;
}
