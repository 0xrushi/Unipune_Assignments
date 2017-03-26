#include<iostream>
#include<graphics.h>
using namespace std;

class Circle
{
	public:
	void display(int x1,int y1,int x,int y)
	{
		putpixel(x+x1,y+y1,WHITE);
		delay(15);
		putpixel(x+x1,y-y1,WHITE);
		delay(15);
		putpixel(x-x1,y+y1,WHITE);
		delay(15);
		putpixel(x-x1,y-y1,WHITE);
		delay(15);
		putpixel(x+y1,y+x1,WHITE);
		delay(15);
		putpixel(x+y1,y-x1,WHITE);
		delay(15);
		putpixel(x-y1,y+x1,WHITE);
		delay(15);
		putpixel(x-y1,y-x1,WHITE);
		delay(15);
	}
	void circle_bresenham(int x,int y,int rad )
	{
		float dis_par;
		int x1,y1;
		x1=0;
		y1=rad;
		dis_par=3-2*rad;
		while(x1<=y1)
		{
			if(dis_par<=0)
				dis_par+=(4*x1)+6;
			else
			{
				dis_par+=4*(x1-y1)+10;
				y1--;
			}
			x1++;
			display(x1,y1,x,y);
		}
	}

	int sign(int num)
	{
		if(num>0)
			return 1;
		else if(num<0)
			return -1;	
	}

	void drawline(float x1,float y1,float x2,float y2)
	{
		int x=x1;
		int y=y1;
		int e_bar;
		int dx=abs(x2-x1);
		int dy=abs(y2-y1);
		
		int s1=sign(x2-x1);
		int s2=sign(y2-y1);
		int interchange;
		if(dy>dx)
		{
			int temp;
			temp=dx;
			dx=dy;
			dy=temp;
			interchange=1;
		}
		else
		{
			interchange=0;
		}
		e_bar=(2*dy)-dx;
		for(int i=1;i<dx;i++)
		{
			putpixel(x,y,12);
			while(e_bar>0)
			{
				if(interchange==1)
				{
					x+=s1;
				}
				else
				{
					y+=s2;
				}
				e_bar-=(2*dx);
			}
			if(interchange==1)
			{
				y+=s2;
			}
			else
			{
				x+=s1;
			}
			e_bar+=(2*dy);
		}
	}
};
int main()
{
	Circle c;
	int gd=DETECT,gm;
	int x,y,rad;
	cout<<"\nEnter the centre co-ordinates of circle :";
	cin>>x>>y;
	cout<<"\nEnter the radius of circle :";
	cin>>rad;
	initgraph(&gd,&gm,NULL);
	c.circle_bresenham(x,y,rad);
	c.drawline((x-0.866*rad),(y+0.5*rad),x,y-rad);
	c.drawline((x+0.866*rad),(y+0.5*rad),x,y-rad);
	c.drawline((x-0.866*rad),(y+0.5*rad),(x+0.866*rad),(y+0.5*rad));
	c.circle_bresenham(x,y,rad*0.5);
	getch();
	closegraph();
}
