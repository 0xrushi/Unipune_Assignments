<?php
    $conn=mysqli_connect('localhost','root','','mydb');
    if(!$conn)
    {
            die("Unsuccessful connection");
    }	
    $id=$_REQUEST["id"];
    $name=$_REQUEST["name"];
    $dept=$_REQUEST["dept"];
    $sal=$_REQUEST["sal"];	
    $sql="insert into employee values(".$id.",'".$name."','".$dept."','".$sal."')";
    //$sql="insert into student values(790,'lo','TE!','COm','8-0')";
    mysqli_query($conn,$sql);
    
    echo "1 Query added";


?>