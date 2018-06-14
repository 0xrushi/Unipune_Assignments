#include<stdlib.h>
#include<stdio.h>
#include<unistd.h>
int main()
{
	char *ls[]={"ls",NULL};
	char *ps[]={"ps",NULL};
	char *join[]={"join","file1","file2",NULL};
	int choice;
	int pid;
	char comm[50],temp[50];
	while(1)
	{
		printf("Enter choice:\n1.ps\n2.join\n3.fork and wait\n4.exec\n5.Exit\n");
		scanf("%d",&choice);
		switch(choice)
		{
			case 1:
				execvp(ps[0],ps);
			break;
			case 2:
				execvp(join[0],join);
			break;
			case 3:
				pid=fork();
				if(pid==0)
				{
					printf("It is child process\n");
					printf("Child process id : %d\n",getpid());
					execvp(ps[0],ps);
					printf("\n");
				}
				else if(pid>0)
				{
					printf("It is parent process\n");
					printf("Parent process id : %d before wait\n",getpid());
					wait(0);
					printf("Child process completed\n");
					printf("Parent process id : %d after wait\n",getpid());
					strcpy(comm,"kill -9 ");
					printf("Which process you want to kill: ");
					scanf("%s",&temp);
					strcat(comm,temp);
					system(comm);
				}
				else
				{
					printf("Error\n");
				}
			break;
			case 4:
				execvp(ls[0],ls);
			break;
			case 5:
				exit(0);
			break;
		}
	}
}
