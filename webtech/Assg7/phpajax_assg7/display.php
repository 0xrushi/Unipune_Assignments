<?php
        $out="";
        $conn=mysqli_connect('localhost','root','','mydb');
        if(!$conn)
        {
                die("Unsuccessful connection");
                echo mysqli_error();
        }	

        $sql="select * from employee order by sal";
        $result=mysqli_query($conn,$sql);
        $out="<tr><th>Emp. ID.</th><th>Name</th><th>Department</th><th>Salary</th></tr>";

        for($i=0;$i < mysqli_num_rows($result);$i++)
        {
                $row= mysqli_fetch_assoc($result);
                $out.="<tr><td>".$row["id"]."</td><td>".$row["name"]."</td><td>".$row["dept"]."</td><td>".$row["sal"]."</td></tr>";
                $out = $out."<br>";
                echo 'sdsd';
        }

        echo $out;  
?>