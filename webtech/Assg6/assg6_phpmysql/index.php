<?php
$conn= mysqli_connect('localhost', 'root', '','mydb');
$sql="select * from employee order by sal";
$result= mysqli_query($conn, $sql);
?>

<html>
    <head>
        <title>HomePage</title>
    </head>
    
    <body>
        <a href="add.html" >Add New Data</a>
        <a href="delete.html">Delete Data</a>
    
        <select>
            <option >ABD000</option>
            <option>Acx</option>
        </select>
        <table>
            <tr>
                <td>ID</td>
                <td>Name</td>
                <td>Dept</td>
                <td>Sal</td>
            </tr>
        
        <?php
            $out='';
            $n= mysqli_num_rows($result);
            for($i=0;$i<$n;$i++){
                $row= mysqli_fetch_assoc($result);
                $out.="<tr><td>".$row["id"]."</td><td>".$row["name"]."</td><td>".$row["dept"]."</td><td>".$row["sal"]."</td></tr>";
            }
            echo $out;
        ?>
            
        </table>
    </body>
    
</html>