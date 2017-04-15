#include<iostream>
#include<graphics.h>
using namespace std;

class Circle
{
	int x, y, s;
	
public:
	Circle(){
		x =0; y=0; s=0;
	}	
	
	void drawCircle(int r, int cx, int cy);
	
};

void Circle::drawCircle(int r, int cx, int cy)
{
	x = 0; y = r;
	putpixel(0, r, 15);
	s = 3-(2*r);
	
	while(x<=y)
	{
		if(s<=0)
		{
			s = s + (4*x) + 6;
			x = x+1;
		}
		else
		{
			s = s + (4*(x-y)) + 10;
			x = x+1;
			y = y-1;
		}
		putpixel(cx+x, cy+y, 15);
		putpixel(cx+x, cy-y, 15);
		putpixel(cx-x, cy+y, 15);
		putpixel(cx-x, cy-y, 15);
		putpixel(cx+y, cy+x, 15);
		putpixel(cx+y, cy-x, 15);
		putpixel(cx-y, cy+x, 15);
		putpixel(cx-y, cy-x, 15);
		putpixel(cx,cy,15)
	}
	
}


int main(){

	int gdriver = DETECT, gmode;
	int radius, x, y;
	Circle c;

	cout<<"\nEnter radius of circle: ";
	cin>>radius;
	cout<<"\nEnter centre coordinates: ";
	cin>>x>>y;
	
	initgraph(&gdriver, &gmode, NULL);
	c.drawCircle(radius, x, y);
	getch();
	closegraph();
	
	return 0;		
}
