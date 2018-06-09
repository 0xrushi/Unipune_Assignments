<%@page contentType="html/txt" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>

<%
  try{
      String name= request.getParameter("uname");
      String pass= request.getParameter("upass");
     
      Class.forName("com.mysql.jdbc.Driver").newInstance();
      Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/test","fedora20","fedora20");
      Statement st=conn.createStatement();
      
      Resultset result= st.executeQuery("select *from login where '"username"'=+name+ and '"password"'=+pass+");
      
      int cnt=0;
      
      if(result.next())
      {
         response.Redirect("home.html");
      }
      else
      {
         response.Redirect("inval.html");
      }
  }//try
  
   catch(Exception e){
    System.out.println(e);
    }
%>

