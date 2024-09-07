<?php

include ("connect.php");
$con = dbconnnection();

$response = [];

// Create (Insert) operation
/*if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if(isset($_POST["fname"]) && isset($_POST["lname"]) && isset($_POST["email"]) && isset($_POST["pwd"])) {
        $fname = $_POST["fname"];
        $lname = $_POST["lname"];
        $email = $_POST["email"];
        $pwd = $_POST["pwd"];

        $query = "INSERT INTO `admin`(`mail`, `pwd`, `fname`, `lname`) VALUES ('$email','$pwd','$fname','$lname')";
        $exe = mysqli_query($con, $query);

        if($exe){
            $response["success"] = true;
        } else {
            $response["error"] = false;
        }
    } else {
        $response["error"] = "Please provide all the required fields.";
    }
}*/

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST["fname"]) && isset($_POST["lname"]) && isset($_POST["email"]) && isset($_POST["pwd"])) {
        $fname = $_POST["fname"];
        $lname = $_POST["lname"];
        $email = $_POST["email"];
        $pwd = $_POST["pwd"];

        $imagePath = "images/user.png"; // Default image

        // Check if image file is uploaded
        if (isset($_FILES['image']['name'])) {
            $imageName = $_FILES['image']['name'];
            $imageTmpName = $_FILES['image']['tmp_name'];
            $imagePath = "images/" . uniqid() . "-" . basename($imageName); // Unique name to avoid conflicts

            // Move uploaded file to the server
            if (move_uploaded_file($imageTmpName, $imagePath)) {
                $response["image_upload"] = "Image uploaded successfully";
            } else {
                $response["image_upload"] = "Failed to upload image";
            }
        }

        // Insert into the database, including the image path
        $query = "INSERT INTO `admin`(`mail`, `pwd`, `fname`, `lname`, `image_path`) VALUES ('$email','$pwd','$fname','$lname','$imagePath')";
        $exe = mysqli_query($con, $query);

        if ($exe) {
            $response["success"] = true;
        } else {
            $response["error"] = "Failed to insert data.";
        }
    } else {
        $response["error"] = "Please provide all the required fields.";
    }
}


// Read (Select) operation
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if (isset($_GET['email']) && isset($_GET['pwd']) ) {  // Check if the email is passed as a query parameter
        $email = $_GET['email'];
        $pwd = $_GET['pwd'];
        $query = "SELECT * FROM `admin` WHERE `mail` = '$email' AND `pwd` = '$pwd'";
        $exe = mysqli_query($con, $query);

        if (mysqli_num_rows($exe) > 0) {
            $response["exists"] = true;
        } else {
            $response["exists"] = false;
        }
    }
}


// Update operation
if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
    parse_str(file_get_contents("php://input"), $_PUT);
    if(isset($_PUT["id"]) && isset($_PUT["fname"]) && isset($_PUT["lname"]) && isset($_PUT["email"]) && isset($_PUT["pwd"])) {
        $id = $_PUT["id"];
        $fname = $_PUT["fname"];
        $lname = $_PUT["lname"];
        $email = $_PUT["email"];
        $pwd = $_PUT["pwd"];

        $query = "UPDATE `admin` SET `fname`='$fname', `lname`='$lname', `mail`='$email', `pwd`='$pwd' WHERE `id`=$id";
        $exe = mysqli_query($con, $query);

        if($exe){
            $response["success"] = true;
        } else {
            $response["error"] = "Failed to update record.";
        }
    } else {
        $response["error"] = "Please provide all the required fields.";
    }
}

// Delete operation
if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
    parse_str(file_get_contents("php://input"), $_DELETE);
    if(isset($_DELETE["id"])) {
        $id = $_DELETE["id"];

        $query = "DELETE FROM `admin` WHERE `id`=$id";
        $exe = mysqli_query($con, $query);

        if($exe){
            $response["success"] = true;
        } else {
            $response["error"] = "Failed to delete record.";
        }
    } else {
        $response["error"] = "Please provide the id of the record to be deleted.";
    }
}

echo json_encode($response);
?>
