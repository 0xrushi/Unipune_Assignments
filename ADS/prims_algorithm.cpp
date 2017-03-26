
#include <iostream>

using namespace std;

#define I 9999
#define V 5
int row,col;


 void display (int a[20],int n)
{
for (int i = 0; i < n; i++)
    {
		cout<<a[i]<<" , ";
	}	
	cout<<endl;
}

int isnotfull(int vis[20])
{
	for(int i=0;i<V;i++)
	{
		if(vis[i]==0)
		{
			return 1;
		}
	}
	
	return 0;
} 


void prims(int graph[V][V])

{
	int path[20][3];
    int dist[20];
	int cnt=0;
    int visited[V];


    for (int i = 0; i < V; i++)
        visited[i] = 0;

    visited[0]=1;

    //for(int i=0;i<V;i++)
    while(isnotfull(visited))
    {
	int min=99999;
    for (int j = 0; j< V; j++)
    {
		if(visited[j]==1)
		{
		for(int k=0;k<V;k++){
			if(min>graph[j][k]&&visited[k]==0&&graph[j][k]!=0)
			{
			min =graph[j][k];
			row=j;
			col=k;
			}
		}
		}
    }
    
    visited[row]=visited[col]=1;
    dist[cnt]=min;
    path[cnt][0]=row;
    path[cnt][1]=col;
    path[cnt][2]=min;
    cnt++;
    
    //display(visited,cnt);
	}	
	
    display(dist,cnt);
}


int main()

{

    int graph[V][V] = { { 0, 2, 0, 1, 0 }, { 2, 0, 3, 8, 5 },

            { 0, 3, 0, 0, 7 }, { 1, 8, 0, 0, 9 }, { 0, 5, 7, 9, 0 }, };

    prims(graph);

 

    return 0;
    
 }
