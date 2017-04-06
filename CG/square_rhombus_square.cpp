#include<iostream>
#include<graphics.h>
#include<math.h>
using namespace std;
class pixel
{
        public:
                void plot(int x , int y ,int colour)
                {
                        putpixel(x,y,colour);
                }
};

class shape : public pixel
{
        float length,dx,dy,x,y;
        public:
	void draw(int x1,int y1,int x2,int y2);
        void draw(int x1,int y1,int x2,int y2,int colour);
        
};


void shape::draw(int x1,int y1,int x2,int y2)
{
	if((abs(x2-x1))>=(abs(y2-y1)))
		length=abs(x2-x1);
        else
                length=abs(y2-y1);
                dx=(x2-x1)/length;
                dy=(y2-y1)/length;
                dx=round(dx);
                dy=round(dy);
                x=x1+dx;
                y=y1+dy;
                
		for(int i=1;i<length;i++)
                {
                        plot(x,y,10);
                        x=x+dx;
                        y=y+dy;
                        delay(5);
                }
}



void shape::draw(int x1,int y1,int x2,int y2,int colour)
{
	int s1=-1,s2=-1,interchange,err;
        float temp;
        x=x1;
        y=y1;
        dx=abs(x2-x1);
        dy=abs(y2-y1);
        if((x2-x1)>=0)
        	s1=1;
        if((y2-y1)>=0)
        	s2=1;
        if(dy>dx)
        {
        	temp=dx;
                dx=dy;
                dy=temp;
                interchange=1;
        }
        else
                interchange=0;
                err=2*dy-dx;
                for(int i=1;i<dx;i++)
                {
                        plot(x,y,colour);
                        while(err>0)
                        {
                                if(interchange==1)
                                        x=x+s1;
                                else
                                        y=y+s2;
                                err=err-2*dx;
                        }
                        if(interchange==1)
                                y=y+s2;
                        else
                                x=x+s1;
                        err=err+2*dy;
                        delay(5);
                }
}



int main()
{
        int x1,y1,x2,y2,p1,p2,q1,q2,q3,q4,colour,flag=0, choice;
        int gd = DETECT, gm;
        shape sh;

        cout<<"\nEnter (X1,Y1): ";
        cin>>x1>>y1;
        cout<<"\nEnter (X2,Y2): ";
        cin>>x2>>y2;
	jump: if(flag==1)
    {
            cout<<"\nEnter colour Value For Bresenham: \n";
            cin>>colour;
    }    
    p1=(y1+y2)/2;
    p2=(x1+x2)/2;
    q1=(x1+p2)/2;
    q2=(y1+p1)/2;
    q3=(x2+p2)/2;
    q4=(p1+y2)/2;
    do
    {
     	cout<<"\n1.DDA\n2.Bresenham\n3.Exit";
        cout<<"\nEnter your choice...";
        cin>>choice;
        initgraph(&gd,&gm,NULL);
        switch(choice)
        {
         	case 1:
                sh.draw(x1,y1,x2,y1);
                sh.draw(x2,y1,x2,y2);
                sh.draw(x2,y2,x1,y2);
                sh.draw(x1,y2,x1,y1);    
                sh.draw(x1,p1,p2,y1);
                sh.draw(p2,y1,x2,p1);
                sh.draw(x2,p1,p2,y2);
                sh.draw(p2,y2,x1,p1);    
                sh.draw(q1,q2,q3,q2);
                sh.draw(q3,q2,q3,q4);
                sh.draw(q3,q4,q1,q4);
                sh.draw(q1,q4,q1,q2);
                break;
                
		case 2:
                sh.draw(x1,y1,x2,y1,colour);
                sh.draw(x2,y1,x2,y2,colour);
                sh.draw(x2,y2,x1,y2,colour);
                sh.draw(x1,y2,x1,y1,colour);
                sh.draw(x1,p1,p2,y1,colour);
                sh.draw(p2,y1,x2,p1,colour);
                sh.draw(x2,p1,p2,y2,colour);
                sh.draw(p2,y2,x1,p1,colour);
                sh.draw(q1,q2,q3,q2,colour);
                sh.draw(q3,q2,q3,q4,colour);
                sh.draw(q3,q4,q1,q4,colour);
                sh.draw(q1,q4,q1,q2,colour);
                break;
            }
    }while(choice!=3);
        getch();
        closegraph();
        

	return 0;
}
