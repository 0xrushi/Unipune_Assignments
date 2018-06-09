<?php
    
    $roll=$_POST["id"];
    $name=$_POST["name"];
    $dept=$_POST["dept"];
    $sal=$_POST["sal"];
    $conn=mysqli_connect('localhost','root','','mydb');
	
    $sql="insert into employee values(".$roll.",'".$name."','".$dept."','".$sal."')";
    //$sql="insert into student values(790,'lo','TE!','COm','8-0')";
    mysqli_query($conn,$sql);
    
    echo 'Done';

?>