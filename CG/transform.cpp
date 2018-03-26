#include<graphics.h>
#include<iostream>
#include <X11/Xlib.h>
#include<math.h>
using namespace std;


class bresenham
{
int xar[20],yar[20];
int x,y,length,dx,dy,s1,s2;
int e,ebar;
int interchange;
int sign(int x)
{
return ((x>0) ? 1 : -1);
}

public:
	int n;

	void draw(float x1,float y1,float x2,float y2)
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
	
	void translate(int x1,int y1)
	{
	for(int a=0;a<n;a++)
	{
    xar[a]=xar[a]+x1;
    yar[a]=yar[a]+y1;

	}
	}
	
	void rotate(float theta)
	{
		theta*=3.1416/180;
		int a,b,i,c,d;
		a=xar[0];
		b=yar[0];
		translate(-a,-b);
		
		for(i=0;i<n;i++)
		{
			c=xar[i]*cos(theta)-yar[i]*sin(theta);
			d=xar[i]*sin(theta)+yar[i]*cos(theta);
			xar[i]=c;
			yar[i]=d;
		}
		translate(a,b);
	}
	
	void scale(int x1,int y1)
	{
	int a,b;
	a=xar[0];
	b=yar[0];
	int i;
	for(i=0;i<n;i++)
	{
    xar[i]=xar[i]*x1;
    yar[i]=yar[i]*y1;
	}
	}

	
	void draw_poly(	)
	{

	for(int i=0;i<n-1;i++)
	{
		draw(xar[i],yar[i],xar[i+1],yar[i+1]);
	}
		draw(xar[0],yar[0],xar[n-1],yar[n-1]);		
	}

	void sheary(int y)
	{
		for(int a=0;a<n;a++){
		yar[a]=xar[a]*y+yar[a];
		}
	}
	void shearx(int x)
	{
	for(int a=0;a<n;a++)
	xar[a]=xar[a]+yar[a]*x;
	}

	friend istream &operator>>(istream& ist,bresenham &b){
		for(int i=0;i<b.n;i++)
			{
				cout<<"\n"<<i+1<<"::";
				ist>>b.xar[i]>>b.yar[i];
			}
			return ist;
	}
       
};

int main()
{
	int ch;
	
	int sx,sy,tx,ty;
	float theta;
	bresenham b;
	
	      int gdriver=DETECT,gmode;
	       
			cout<<"\nEnter no. of Sides:: ";
			cin>>b.n;
			cout<<"\nEnter the Co-ordinate of Vertices::";
			cin>>b;
				
   initgraph(&gdriver, &gmode, NULL);		
   //XInitThreads();		
   b.draw_poly();
   getch();	
   cleardevice();

  do
   {
    cout<<"\n1)Translate\n2)Rotate\n3)Scale\n4)Shear\n5)Exit.";
    cout<<"\nEnter Ur Choice::";
    cin>>ch;
    switch(ch)
    {
        case 1:
            cout<<"\ntx";
            cin>>tx;
            cout<<"\nty";
            cin>>ty;
            b.translate(tx,ty);
            //XInitThreads();	
            b.draw_poly();
	       getch();
	       cleardevice();
            break;

        case 2:
            cout<<"\nEnter theta :";
            cin>>theta;
            b.rotate(theta);
            b.draw_poly();
            getch();
            break;

        case 3:
            cout<<"\nsx:";
            cin>>sx;
            cout<<"\nsy:";
            cin>>sy;
            b.scale(sx,sy);
            b.draw_poly();
            getch();
            break;
        case 4:
        	int ch2;
        	cout<<"Enter \n1.Shearx\n2.sheary:\n";
        	cin>>ch2;
        	if(ch2==1){
        	cout<<"\nsx:";
            cin>>sx;
            b.shearx(sx);
        	}
        	else if(ch2==2){
            cout<<"\nsy:";
            cin>>sy;
            b.sheary(sy);
        	}
            else{
            	cout<<"Invalid choice \n";
            }
            b.draw_poly();
            getch();
            break;
    }
    } while(ch!=5);
	
	closegraph();
	return 0;
}
