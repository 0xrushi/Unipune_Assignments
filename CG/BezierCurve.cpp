#include<iostream>
#include<graphics.h>
#include<math.h>
using namespace std;
class bezier
{
	private:
		float xi,yi;
		int flag;
	public:
		bezier()
		{
			xi = yi = flag = 0;
		}
	
		void bezCurve(int x[4],int y[4]);
		void sine(int x[4],int y[4]);
};


void bezier::bezCurve(int x[4],int y[4])
{
	for(float i=0.0; i<1; i=i+0.0004)
	{
		xi=x[0]*pow(1-i,3)+3*x[1]*i*pow(1-i,2)+3*x[2]*pow(i,2)*(1-i)+x[3]*pow(i,3);
		yi=y[0]*pow(1-i,3)+3*y[1]*i*pow(1-i,2)+3*y[2]*pow(i,2)*(1-i)+y[3]*pow(i,3);
		putpixel(xi,yi,WHITE);
		delay(2);
	}
}


void bezier::sine(int x[4],int y[4])
{

	line(x[0], y[0], x[0]+400, y[0]);
	line(x[0], y[0]-100, x[0], y[0]+100);

	bezCurve(x, y);
	int count;
	count = 3;
	
	while(count!=0)
	{
		if(flag==0)
		{
			int temp;
			temp = x[1];
		
			x[0] = x[3];
			x[1] = x[2];
			x[2] = x[2] + (x[2] - temp);
			x[3] = x[2];
			
			y[1] += 2*(y[0] - y[1]);
			y[2] = y[1];
		
			bezCurve(x,y);
			flag = 1;
		}
		else if(flag==1)
		{
			int temp;
			temp = x[1];
			
			x[0] = x[3];
			x[1] = x[2];
			x[2] = x[2] + (x[2] - temp);
			x[3] = x[2];
			
			y[1] -= 2*(y[1] - y[0]);
			y[2] = y[1];
			
			bezCurve(x,y);
			flag = 0;
		}
		count--;
	}
}


int main()
{
	bezier b;
	int gdriver = DETECT, gmode, x[4], y[4];
	
	cout<<"\nEnter single Control Point for sine curve:- ";
	
	cout<<"\nX:-";
	cin>>x[0];
	cout<<"\nY:- ";
	cin>>y[0];

	x[1] = x[0];
	x[2] = x[0] + 70;
	x[3] = x[2];
	
	y[1] = y[0] - 80;
	y[2] = y[1];
	y[3] = y[0];
	
	initgraph(&gdriver,&gmode,NULL);
	b.sine(x,y);
	getch();
	closegraph();
}
