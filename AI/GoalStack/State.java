package goastackshrayank;

import java.util.Arrays;

public class State {
	int ontable[];
	int on[][];
	int clear[];
	int hold[];
	int arm;
	
	State(int n,String s){
		ontable = new int[n];
		on = new int[n][n];
		clear = new int[n];
		hold = new int[n];
		arm = -1;
		setState(s);
	}
	void setState(String s){
		String subG[] = s.split("['^']+");
		for(int i=0;i<subG.length;i++){
			String ele[] = subG[i].split("[() ]+");
			if(ele[1].equals("ontable"))
				ontable[ele[2].charAt(0)%97]=1;
			
			if(ele[1].equals("on"))
				on[ele[2].charAt(0)%97][ele[3].charAt(0)%97]=1;
			
			if(ele[1].equals("AE"))
				arm = 1;//arm=1 if arm is empty+
			
		}
	}
	
	int check(String s){
		int flag = 1;
		String subG[] = s.split("['^']+");
		for(int i=0;i<subG.length;i++){
			String ele[] = subG[i].split("[() ]+");
			if(ele[1].equals("on") && on[(int)ele[2].charAt(0)%97][(int)ele[3].charAt(0)%97] == 1)
				return 1;
			else if(ele[1].equals("hold") && hold[ele[2].charAt(0)%97] ==1)
				return 1;
			else if(ele[1].equals("ontable") && ontable[ele[2].charAt(0)%97] ==1)
				return 1;
			else if(ele[1].equals("clear") && clear[ele[2].charAt(0)%97] ==1)
				return 1;
			else if(ele[1].equals("AE") && arm==1)
				return 1;
			else 
				return 0;
		}
		return 1;
	}
	int checktop(char c){
		int i=0;
		for(i=0;i<4;i++){
			if(on[i][c%97]==1)
				return i; 
		}
		return -1;
	}
	void performAction(String s){
		String ele[] = s.split("[() ]+");
		//System.out.println(s);
		if(s.contains("unstack")){
			hold[ele[2].charAt(0)%97]=1;
			clear[ele[2].charAt(0)%97]=0;
			clear[ele[3].charAt(0)%97]=1;
			on[ele[2].charAt(0)%97][ele[3].charAt(0)%97]=0;
			arm=0;
			return;
			//System.out.println(Arrays.toString(hold));
			
		}
		
		if(s.contains("release")){
			ontable[ele[2].charAt(0)%97]=1;
			clear[ele[2].charAt(0)%97]=1;
			hold[ele[2].charAt(0)%97]=0;
			arm=1;
			return;
		}
		
		 if(s.contains("stack"))
		{
			 //System.out.println("stack"+Arrays.toString(hold));
			hold[ele[2].charAt(0)%97]=0;
			clear[ele[2].charAt(0)%97]=1;
			clear[ele[3].charAt(0)%97]=0;
			on[ele[2].charAt(0)%97][ele[3].charAt(0)%97]=1;
			arm=1;
			return;
		}
		
	}
}
