package Package1;
class NullStringException extends Exception
{
	void print()
	{
		System.out.println("One of the string enetered is null");
	}
}
public class GenericCalculator<T>
{
        private String s1,s2;
        private double number1,number2;
        public void addition(T x,T y){
        	try
        	{
        		s1 = x.toString();
        		if(s1==null)
        		{
        			throw new NullStringException();
        		}
        	        s2 = x.toString();
        	        if(s2==null)
        	        {
        	    		throw new NullStringException();
        	        }
        	   }
        	   catch(NullStringException se)
        	   {
                         se.printStackTrace();
                         se.print();
		   }
        	try
        	{
        		number1 = Double.parseDouble(s1);
        		number2 = Double.parseDouble(s2);
        	}
        	catch(NumberFormatException nfe)
        	{
        		nfe.printStackTrace();
        		System.out.println("Please Enter Number in proper format");
        	}
        	System.out.println("Addition of numbers is: " + (number1+number2));
        }
        public void subtraction(T x,T y)
        {
        	try
        	{
        		s1 = x.toString();
        		if(s1==null)
        		{
        			throw new NullStringException();
        		}
        	        s2 = x.toString();
        	    	if(s2==null){
        	    	throw new NullStringException();}
        	}
        	catch (NullStringException se)
        	{
                    se.printStackTrace();
                    se.print();
		}
        	try
        	{
        		number1 = Double.parseDouble(s1);
        		number2 = Double.parseDouble(s2);
        	}
        	catch(NumberFormatException nfe)
        	{
        		nfe.printStackTrace();
        		System.out.println("Please Enter Number in proper format");
        	}
        	System.out.println("Subtraction of numbers is: " + (number1-number2));
        }
        public void multiplication(T x,T y)
        {
        	try
        	{
        		s1 = x.toString();
        		if(s1==null)
        		{
        			throw new NullStringException();
        		}
        	        s2 = x.toString();
        	    	if(s2==null)
        	    	{
        	    		throw new NullStringException();
        	    	}
        	}
        	catch (NullStringException se)
        	{
                    se.printStackTrace();
                    se.print();
		}
        	try
        	{
        		number1 = Double.parseDouble(s1);
        		number2 = Double.parseDouble(s2);
        	}
        	catch(NumberFormatException nfe)
        	{
        		nfe.printStackTrace();
        		System.out.println("Please Enter Number in proper format");
        	}
        	System.out.println("Multiplication of numbers is: " + (number1*number2));
        }
        public void division(T x,T y)
        {
        	try
        	{
        		s1 = x.toString();
        		if(s1==null)
        		{
        			throw new NullStringException();
        		}
        	    	s2 = x.toString();
        	    	if(s2==null)
        	    	{
        	    		throw new NullStringException();
        	    	}
        	}
        	catch(NullStringException se)
        	{
                    se.printStackTrace();
                    se.print();
		}
        	try
        	{
        		number1 = Double.parseDouble(s1);
        		try
        		{
        			number2 = Double.parseDouble(s2);
        			if(number2==0)
        			{
        				throw new ArithmeticException();
        			}
        		}
        		catch(ArithmeticException ae)
        		{
        			System.out.println("Enter Non-Zero number");
        		}
                	double result = number1/number2;
                	System.out.println("Division of numbers is: " + result);
        	}
        	catch(NumberFormatException nfe)
        	{
        		nfe.printStackTrace();
        		System.out.println("Please Enter Number in proper format");
        	}
         }
}
