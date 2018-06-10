/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package test;

import javax.ejb.Stateless;
import javax.ejb.LocalBean;

@Stateless
@LocalBean
public class calcbean {

       public Integer operations(int num1 , int num2 , String opr)
    {
        if(opr.equals("+"))
            return (num1+num2);
        else if(opr.equals("-"))
            return (num1-num2);
        else if(opr.equals("*"))
            return (num1*num2);
        else if(opr.equals("/"))
            return (num1/num2);
        else
            return 0;
    }

}
