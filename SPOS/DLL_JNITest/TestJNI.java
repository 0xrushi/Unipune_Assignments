import java.lang.*;
import java.util.*;
import java.io.*;
public class TestJNI
{
	public native float add(int n1,int n2);
	public native float sub(int n1,int n2);
	public native float mul(int n1,int n2);
	public native float div(int n1,int n2);
	public native int fact(int n);
	public native float sin(int n);
	
	static
	{
		System.loadLibrary("cal");
	}
	public static void main(String args[])
	{
		Scanner sc=new Scanner(System.in);
		int n1=0,n2=0,n=0;
		while(true)
		{
			System.out.println("Enter choice:\n1.Add\n2.Sub\n3.Mul\n4.Div\n5.Fact\n6.Sin\n7.Exit\n");
			int choice=sc.nextInt();
			if(choice<5)
			{
				System.out.println("Enter first no: ");
				n1=sc.nextInt();
				System.out.println("Enter second no: ");
				n2=sc.nextInt();
			}
			else if(choice==5 || choice==6)
			{
				System.out.println("Enter no: ");
				n=sc.nextInt();
			}
			switch(choice)
			{
				case 1:
					System.out.println("Addition is: "+new TestJNI().add(n1,n2));
				break;
				case 2:
					System.out.println("Subtraction is: "+new TestJNI().sub(n1,n2));
				break;
				case 3:
					System.out.println("Multiplication is: "+new TestJNI().mul(n1,n2));
				break;
				case 4:
					System.out.println("Division is: "+new TestJNI().div(n1,n2));
				break;
				case 5:
					System.out.println("Factorial is: "+new TestJNI().fact(n));
				break;
				case 6:
					System.out.println("Sine is: "+new TestJNI().sin(n));
				break;
				case 7:
					System.exit(0);
				break;
			}
		}
	}
}
