<?php
require 'connect.php';
header("Content-Type: application/json");
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    // Handle OPTIONS request
    header("Access-Control-Allow-Origin: *");
    header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
    header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
    exit;
}

// Add your existing CORS headers
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
$method = $_SERVER['REQUEST_METHOD'];

switch ($method) {
    case 'GET':

        if (isset($_GET["id"]) && $_GET["id"] != null)
            getaccount(intval($_GET["id"]));
        else
            getallaccounts();

        break;
    case 'POST':
        $input = json_decode(file_get_contents("php://input"), true);
        postaccount($input);
        break;
    case 'PUT':
        $input = json_decode(file_get_contents("php://input"), true);

        if (
            $input['action'] === 'calc'
        ) {
            $id_account = $input['id'];
            $nbtotales = calcnbfromjournee($id_account);

            $query = "UPDATE account SET nbheures = :nbtotales WHERE id = :id";
            $stmt = $connexion->prepare($query);
            $stmt->bindParam(':nbtotales', $nbtotales);
            $stmt->bindParam(':id', $id_account);
            $stmt->execute();
            $response = array('status' => 'success', 'message' => 'Calc updated');
            echo json_encode($response);
        } else if ($input['action'] === 'pay') {

            $id_account = $input['id'];
            $pay = $input['pay'];
            $query = "UPDATE account SET pay = :pay WHERE id = :id";
            $stmt = $connexion->prepare($query);
            $stmt->bindParam(':pay', $pay);
            $stmt->bindParam(':id', $id_account);
            $stmt->execute();
            $response = array('status' => 'success', 'message' => 'Pay updated');
            echo json_encode($response);
        } elseif (isset($_GET["id"]) && $_GET["id"] != null && !isset($input["action"])) {

            $id = intval($_GET["id"]);
            putaccount($input, $id);
        } else {
            http_response_code(400);
            echo json_encode(["error" => "Missing account ID"]);
        }
        break;

    case 'DELETE':
        // Extract ID from URL parameter
        $id = intval($_GET["id"]);
        deleteaccount($id);
        break;
}

function postaccount($input)
{
    // Extract data from the input
    $username = $input["username"];
    $pwd = $input["pwd"];
    $role = $input["role"];
    global $connexion;
    $query = "INSERT INTO account (username, pwd, role) VALUES (:username,:pwd, :role)";
    $stmt = $connexion->prepare($query);
    $stmt->bindParam(":username", $username);
    $stmt->bindParam(":pwd", $pwd);
    $stmt->bindParam(":role", $role);
    $result = $stmt->execute();

    if ($result) {
        echo json_encode(["message" => "Account added successfully"]);
    } else {
        http_response_code(500); // Internal Server Error
        echo json_encode(["error" => "Failed to add account"]);
    }
}