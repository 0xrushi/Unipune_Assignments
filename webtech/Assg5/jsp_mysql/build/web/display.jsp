
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = null; 
            con=DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","");
            Statement stmt=con.createStatement();
            
            ResultSet rs=stmt.executeQuery("select * from employee");
            
            while(rs.next()){
                out.println(rs.getInt(1)+"  "+rs.getString(2)+"  "+rs.getString(3)+" "+rs.getString(4)+"<br>");  
                out.println();
            }
            con.close();
            %>
        <h1>Hello World!</h1>
    </body>
</html>
