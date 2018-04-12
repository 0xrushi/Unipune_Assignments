import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Scanner;

class Process{
	int pid,at,bt,st,wt,ft,tt,rt;
	public Process(int pid,int at,int bt) {
		this.pid=pid;
		this.at=at;
		this.bt=bt;
		this.rt=this.bt;
	}
	
	public int getAt() {
		return this.at;
	}
	
	public void print() {
		System.out.println(pid+"\t"+at+"\t"+bt+"\t"+st+"\t"+wt+"\t"+ft+"\t"+tt);
	}
}

class PriorityProcess{
	int pid,at,bt,st,wt,ft,tt,rt,pri;
	public PriorityProcess(int pid,int bt,int pri) {
		this.pid=pid;
		this.pri=pri;
		this.bt=bt;
	}
	
	public int getPri() {
		return pri;
	}
	
	public void print() {
		System.out.println(pid+"\t"+bt+"\t"+pri+"\t"+wt+"\t"+ft+"\t"+tt);
	}
}

public class Scheduling {
	
	public static void fcfs() {
		
		ArrayList<Process> s1=new ArrayList<Process>();	
		Scanner sc=new Scanner(System.in);
		
		for(int i=0;i<5;i++) {
			System.out.println("Enter at of P"+(i+1));
			int tat=sc.nextInt();
			System.out.println("Enter bt of P"+(i+1));
			int tbt=sc.nextInt();
			Process p1=new Process(i+1,tat,tbt);
			s1.add(p1);
		}
		
		Collections.sort(s1,Comparator.comparingInt(Process::getAt));
		
		int totalbt=0;
		int cnt=0;
		for(Process i:s1) {
			totalbt=i.bt;
		}
		
		for(int i=0;i<s1.size();i++) {
			s1.get(i).st=cnt;
			s1.get(i).ft=s1.get(i).st+s1.get(i).bt;
			s1.get(i).wt=s1.get(i).st-s1.get(i).at;
			s1.get(i).tt=s1.get(i).ft-s1.get(i).at;
			cnt=s1.get(i).ft;
			}

		System.out.println("PID  AT	BT	ST  WT  FT  TT");
		for(Process p:s1) {
			p.print();
		}
	}
	
	public static void sjf() {
		Process p1[]=new Process[4];
		p1[0]=new Process(1, 0, 8);//pid arrival burst
		p1[1]=new Process(2, 2, 6);
		p1[2]=new Process(3, 4, 5);
		p1[3]=new Process(4, 6, 1);
		int n=4;
		
		int process_done = 0, t = 0;
        int shortest_ind = 0;
        boolean check = false;
        
        while(process_done!=n) {
        	int min = Integer.MAX_VALUE;
        	for(int i=0;i<n;i++) {
        		if((p1[i].at<=t)&&(p1[i].rt<min)&&(p1[i].rt>0)) {
        			min=p1[i].rt;
        			shortest_ind=i;
        			check=true;
        		}
        	}
        	if(check==false) {
        		t++;
        		continue;
        	}
        	p1[shortest_ind].rt--;
        	min=p1[shortest_ind].rt;
        	System.out.println(shortest_ind+1);
        	if(min==0) {
        		min=Integer.MAX_VALUE;
        		process_done++;
        		p1[shortest_ind].ft=t+1;
        		p1[shortest_ind].wt=p1[shortest_ind].ft-p1[shortest_ind].bt-p1[shortest_ind].at;
        	}
        	t++;
        }
        
        
        for (int i = 0; i < n; i++)
            p1[i].tt = p1[i].bt + p1[i].wt;
        
		System.out.println("PID\tA\tBT\tST\tWT\tFT\tTT");
		for(Process p:p1) {
			p.print();
		}
	}
	
	public static void priority() {
		int total=0,t=0;
		PriorityProcess p1[]=new PriorityProcess[4];
		p1[0]=new PriorityProcess(1, 0, 8);//pid arrival burst
		p1[1]=new PriorityProcess(2, 1, 1);
		p1[2]=new PriorityProcess(3, 2, 3);
		p1[3]=new PriorityProcess(4, 3, 2);
		int n=4;
		
		ArrayList<PriorityProcess> pr1=new ArrayList<PriorityProcess>();
		pr1.add(p1[0]);
		pr1.add(p1[1]);
		pr1.add(p1[2]);
		pr1.add(p1[3]);
		
		Collections.sort(pr1, Comparator.comparingInt(PriorityProcess::getPri));
		
		for(PriorityProcess p:pr1)
			p.print();
	}
	
	public static void main(String args[]) {
		sjf();
	}
}
