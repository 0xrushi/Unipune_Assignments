package goastackshrayank;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Scanner;
import java.util.Stack;

public class Planner {
	State init,goal;
	String goal_s;
	Stack stk;
	ArrayList<String> steps;
	
	Planner(String i,String g){
		init = new State(4,i);
		goal = new State(4,g);
		goal_s = g;
		stk = new Stack();
		steps = new ArrayList<String>();
	}
	
	void stackPlan(){
		String temp;
		stk.push(goal_s);
		String subG[] = goal_s.split("['^']+");
		for(int i=subG.length-1;i>=0;i--)
			stk.push(subG[i]);
		
		while(!stk.isEmpty()){
			
			temp = (String)stk.pop();
			//System.out.println(temp+" "+Arrays.toString(init.hold));
			
			if(temp.contains("ontable") && init.check(temp)==0){
				
			}
			if(temp.contains("on") && init.check(temp)==0){
				String ele[] = temp.split("[() ]+");
				stk.push("(stack " + ele[2].charAt(0) + " " + ele[3].charAt(0)  +")");
				stk.push("(clear "+ ele[2].charAt(0) +")^(clear "+ ele[3].charAt(0) +")^"+"(AE)");
				stk.push("(AE)");
				stk.push("(clear "+ ele[3].charAt(0) +")");
				stk.push("(clear "+ ele[2].charAt(0) +")");
			}
			
			if(temp.contains("clear") && init.check(temp)==0){
				String ele[] = temp.split("[() ]+");
				if(init.hold[ele[2].charAt(0)%97]==1){
					stk.push("(release " + ele[2].charAt(0)  +")");
					
				    stk.push("(hold " + ele[2].charAt(0) +")");
				}
				else{
					int t =init.checktop(ele[2].charAt(0));
					//System.out.println(t);
					//System.out.println(g);
					if(t!=-1)
					{
						stk.push("(unstack "+ Character.toString((char)(t+97))+" " + ele[2].charAt(0)  +")");
					 
						stk.push("(on "+ Character.toString((char)(t+97))+" " + ele[2].charAt(0) +")^"+"(clear "+ Character.toString((char)(t+97)) +")^"+"(AE)");
						stk.push("(AE)");
					    stk.push("(clear "+ Character.toString((char)(t+97)) +")");
					    stk.push("(on "+ Character.toString((char)(t+97))+" " + ele[2].charAt(0) +")");
					}    
				}
			}
			if(temp.contains("hold") && init.check(temp)==0){

			}
			if(temp.contains("AE") && init.check(temp)==0){
				//System.out.println("hello"+Arrays.toString(init.hold));
				for(int i=0;i<4;i++){
					if(init.hold[i]==1){
						stk.push("(release " + Character.toString((char)(i+97))  +")");
						stk.push("(hold " + Character.toString((char)(i+97)) +")");
					}
				}
			}
			if(temp.contains("unstack") || temp.contains("release") || temp.contains("stack")){
				init.performAction(temp);
				steps.add(temp);
				//System.out.println("hello"+Arrays.toString(init.hold));
				//init.hold[1] = 6;
			}
		}
		printSteps();
		
	}
	 public void printSteps(){
	    	int i;
	    	//for(i=0;i<steps.size();i++)
	    		System.out.println(""+steps);
	    }
	public static void main(String args[]){
		String i,g;
		i = "(on b a) ^ (ontable c) ^ (ontable a) ^ (ontable d)^ AE";
		g = "(on c a) ^ (on b d) ^ (ontable a) ^ (ontable d) ^ AE";
		
		Planner p = new Planner(i,g);
		p.stackPlan();
	}
}
