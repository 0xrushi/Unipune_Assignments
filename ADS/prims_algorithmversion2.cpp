#include <iostream>
#define V 5
#define I 9999
#define C for(int i=0;i<V;i++)
using namespace std;


class graph{
	int g[V][V] = {
			{0, 2, 0, 6, 0},
            {2, 0, 3, 8, 5},
            {0, 3, 0, 0, 7},
            {6, 8, 0, 0, 9},
            {0, 5, 7, 9, 0},
           };

	int visited[V],distance[V],from[V];
	int mincost,mindist,minpos,u;
public:

	void display()
	{
		cout<<"Edge   Weight\n";
		for(int i=1;i<V;i++)
		{
			cout<<from[i]<<"-"<<i<<"  "<<g[i][from[i]]<<" \n";
		}
	}

	void get()
	{
		/*cout << "enter adjacency matrix \n";
		for(int i=0;i<V;i++)
		{
			for(int j=0;j<V;j++)
			{
				cout<<" ENter v"<<i<<" "<<j<<endl;
				cin>>g[i][j];
				if(g[i][j]==0)
					g[i][j]=I;
			}
		}*/



	}

	int getMinpos(int a[V])
	{
		int min=I,minpos;
		for(int i=1;i<V;i++){
			if(a[i]<min&&visited[i]==0)
			{
				min=a[i];
				minpos=i;
			}
		}
		return minpos;
	}

	void prim()
	{

		//Init all distance as infinite
		C
		{
			distance[i]=I;
			visited[i]=0;
		}

		distance[0]=0;
		from[0]=-1;

		for(int count=0;count<V-1;count++)
		{
			minpos=getMinpos(distance);

			visited[minpos]=1;

			C
			{
				if(g[minpos][i]!=0&&visited[i]!=1&&g[minpos][i]<distance[i])
				{
					from[i]=minpos;
					distance[i]=g[minpos][i];
				}
			}
		}

		display();

	}
};

int main()
{
	graph s,g1;
	g1.prim();
	cout << "!!!Hello World!!!" << endl; // prints !!!Hello World!!!
	return 0;
}
