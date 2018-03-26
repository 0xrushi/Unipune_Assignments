package Package2;

import java.util.Scanner;

import Package1.GenericCalculator;

public class CalculatorApplication {

	public static void main(String[] args) {
            GenericCalculator<Object>  gc = new GenericCalculator<Object>();
            String number1="",number2="";
            int choice=0;
            Scanner sc = new Scanner(System.in);
            
            do{
            	System.out.println();System.out.println();
            	System.out.println("Menu:");
            	System.out.println("1.Enter Data");
            	System.out.println("2.Addition");
            	System.out.println("3.Subtraction");
            	System.out.println("4.Multiplication");
            	System.out.println("5.Division");
            	System.out.println("6.Exit");
            	System.out.println("Enter your choice");
            	choice = Integer.parseInt(sc.next());
            	
            	switch(choice){
            	case 1:
            		   System.out.println("Enter Number 1: ");
            		   number1 = sc.next();
            		   System.out.println("Enter Number 2: ");
            		   number2 = sc.next();
            		break;
            		
            	case 2:gc.addition(number1, number2);
            		break;
            		
            	case 3:gc.subtraction(number1, number2);
            		break;
            		
            	case 4:gc.multiplication(number1, number2);
            		break;
            		
            	case 5:gc.division(number1, number2);
            		break;
            		
            	case 6:
            		System.out.println("End of program");
            		break;
            		
            	default:
            	     System.out.println("Invalid Choice");		
            	}
            	
            }while(choice!=6);
        }
}
