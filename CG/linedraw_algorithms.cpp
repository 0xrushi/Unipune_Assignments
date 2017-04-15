#include<graphics.h>
#include<iostream>
#include<math.h>
using namespace std;
class pixel
{
public:
	void getpixel(int x,int y )
	{
		putpixel(x,y,WHITE);
	}
};

class dda:public pixel
{
	int x,y,length;
	float dx,dy;
public:
	void draw(int x1,int y1,int x2,int y2)
	{
		x=abs(x2-x1);
		y=abs(y2-y1);
		if(x>y)
			length=x;
		else
			length=y;
		dx=x/length;
		dy=y/length;
		getpixel(x1,y1);
		x=x1;
		y=y1;
		for(int i=1;i<length;i++)
		{
			getpixel(x,y);
			x=x+dx;
			y=y+dy;
		}
	}

};

class bresenham:public pixel
{
int x,y,length,dx,dy,s1,s2;
int e,ebar;
int interchange;
int sign(int x)
{
return ((x>0) ? 1 : -1);
}

public:
	void draw(int x1,int y1,int x2,int y2)
	{
		x=x1;
		y=y1;
		dx=abs(x2-x1);
		dy=abs(y2-y1);
		s1=sign(x2-x1);
		s2=sign(y2-y1);
		
		if(dy>dx)
		{
			int temp;
			dx=dy;
			dy=temp;
			interchange=1;		
		}
		else
		{
			interchange=0;		
		}
		ebar=2*dy-dx;
		for(int i=1;i<dx;i++)
		{
			getpixel(x,y);
			while(ebar>0)
			{
				if(interchange==1)
				{
					x=x+s1;
				}			
				else
				y=y+s2;
				
				ebar=ebar-2*dx;
			}
			
			if(interchange==1)
			{
				y+=s2;			
			}		
			else
			{	
				x+=s1;
			}
			ebar+=2*dy;
		}
	}
};

int main()
{
	int x1,y1,x2,y2;
	dda d;
	int ch;
	bresenham b;
	cout<<"enter your starting ponts";
			cin>>x1>>y1;
			cout<<"enter your lasr point";
			cin>>x2>>y2;
			cout<<"enter your starting ponts\n1.dda\n2.bresenham line\n";
			cin>>ch;
	       int gdriver=DETECT,gmode;
	      initgraph(&gdriver,&gmode,NULL);
	       
	        if(ch==1)
	        b.draw(x1,y1,x2,y2);

	   	   if(ch==2)
			 d.draw(x1,y1,x2,y2);

	       getch();
	closegraph();
	return 0;
}

