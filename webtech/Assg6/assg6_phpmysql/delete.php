<?php
$id = ''; 
if( isset( $_GET['id'])) {
    $id = $_GET['id']; 
} 
    
    $conn=mysqli_connect('localhost','root','','mydb');
	
    $sql="delete from employee where id='".$id."'";
    //$sql="insert into student values(790,'lo','TE!','COm','8-0')";
    mysqli_query($conn,$sql);
    
    echo 'Done';
?>