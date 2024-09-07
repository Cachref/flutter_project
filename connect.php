<?php
function dbconnnection(){
    $servername = "localhost:3307";  // Server name with port
    $username = "root";              // MySQL username
    $password = "";                  // MySQL password (empty)
    $dbname = "flutterapp1";         // Your database name

    // Create connection
    $con = mysqli_connect($servername, $username, $password, $dbname);

    // Check connection
    if (!$con) {
        die("Connection failed: " . mysqli_connect_error());
    }
    return $con;
}
?>
