<?php
header('Content-Type: application/json');

// Your existing PHP code...

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

include("connect.php");
$con = dbconnnection();

$response = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST["fname"]) && isset($_POST["lname"]) && isset($_POST["email"]) && isset($_POST["pwd"]) && isset($_POST["admin_id"])) {
        $fname = $_POST["fname"];
        $lname = $_POST["lname"];
        $email = $_POST["email"];
        $pwd = $_POST["pwd"];
        $admin_id = $_POST["admin_id"]; // Cast to integer
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
        // Check if the email already exists in the student table
        $checkQuery = "SELECT id FROM student WHERE mail = '$email'";
        $checkResult = mysqli_query($con, $checkQuery);

        if (mysqli_num_rows($checkResult) > 0) {
            // Email already exists
            $response["error"] = "Email already exists";
        } else {
            // Insert the new record
            $query = "INSERT INTO student (fname, lname, mail, pwd, admin_id, `image_path`) VALUES ('$fname', '$lname', '$email', '$pwd', $admin_id,'$imagePath')";
            $exe = mysqli_query($con, $query);

            if ($exe) {
                $response["success"] = true;
            } else {
                $response["error"] = "Error inserting record";
            }
        }
    } else {
        $response["error"] = "Please provide all required fields";
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Handle GET request: Fetch admin ID based on email
    if (isset($_GET['email'])) {
        $email = $_GET['email'];
        $query = "SELECT id FROM admin WHERE mail = '$email'";
        $exe = mysqli_query($con, $query);

        if ($row = mysqli_fetch_assoc($exe)) {
            $response["admin_id"] = $row["id"];
        } else {
            $response["error"] = "Admin not found";
        }
    } else {
        $response["error"] = "Email not provided";
    }
    if (isset($_GET['email']) && isset($_GET['pwd'])) {  // Check if the email is passed as a query parameter
        $email = $_GET['email'];
        $pwd = $_GET["pwd"];
        $query = "SELECT * FROM `student` WHERE `mail` = '$email' AND `pwd` = '$pwd'";
        $exe = mysqli_query($con, $query);

        if (mysqli_num_rows($exe) > 0) {
            $response["exists"] = true;
        } else {
            $response["exists"] = false;
        }
    }
}

echo json_encode($response);
?>
