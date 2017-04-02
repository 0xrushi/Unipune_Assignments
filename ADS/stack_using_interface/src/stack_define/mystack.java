package stack_define;

import interface_display_module.display_module;
//import interface_module.Operations;

public class mystack implements display_module{

	int ar[]=new int[20];
	int c=0;
	@Override
	public void push(int x) {
		ar[c++]=x;
	}

	@Override
	public int pop() {
		return ar[--c];
	}

	@Override
	public int top() {
		return ar[c];
	}

	@Override
	public void display() {
		for(int i=0;i<c;i++){
		System.out.println(ar[i]);
		}
	}

}
