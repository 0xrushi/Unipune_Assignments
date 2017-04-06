#include<math.h>
#include<iostream>
#include<graphics.h>

void display(double i)
{
	int x1=300,y1=180,x,y;
	circle(300,130,50);
	line(210,60,210,320);
	line(210,60,390,60);
	line(390,60,390,320);
	line(210,320,390,320);
	outtextxy(295,88,"12");
	outtextxy(260,130,"9");
	outtextxy(340,130,"3");
	outtextxy(295,168,"6");
	line(300,130,300,98);
	line(300,98,297,101);
	line(300,98,303,101);
	line(337,130,300,130);
	line(337,130,334,127);
	line(337,130,334,133);
	x=(int)((double)x1+100*cos(i));
	y=(int)((double)y1+100*sin(i));
	line(x1,y1,x,y);
	circle(x,y,10);
	delay(30);
	cleardevice();
}

int main()
{
	int gd=DETECT,gm;
	double i;
	initgraph(&gd,&gm,0);
	while(1)
	{
		for(i=2;i>1;i=i-0.01)
			display(i);
		for(i=1;i<2;i=i+0.01)
			display(i);
	}
	getch();
	return 0;
}