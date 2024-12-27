<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json; charset=UTF-8");

$servername = "localhost";
$dbUsername = "root";
$dbPassword = "";
$dbname = "ebikesms";

// Create connection
$conn = new mysqli($servername, $dbUsername, $dbPassword, $dbname);

// Check connection
if ($conn->connect_error) {
    die(json_encode(array("status" => "error", "message" => "Connection failed: " . $conn->connect_error)));
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Get the JSON input
    $input = json_decode(file_get_contents('php://input'), true);
    error_log(print_r($input, true)); // Log the incoming data for debugging

    // Extract username and password from JSON
    $username = $input['matric_number'] ?? '';
    $password = $input['password'] ?? '';

    if (empty($username) || empty($password)) {
        echo json_encode(array("status" => "error", "message" => "Username or password cannot be empty"));
        exit;
    }

    // Prepare and execute SQL to prevent SQL injection
    $stmt = $conn->prepare("SELECT user_id,user_type, password FROM user WHERE matric_number = ?");
    if ($stmt === false) {
        die(json_encode(array("status" => "error", "message" => "SQL prepare failed: " . $conn->error)));
    }
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        // Fetch the user data and password from the database
        $row = $result->fetch_assoc();
        $user_id = $row['user_id'];  // Fetch user_id
        $user_type = $row['user_type'];  // Fetch user_type
        $hashedPassword = $row['password'];

        // Verify the entered password against the hashed password
        if (password_verify($password, $hashedPassword)) {
            // Return success with user_id
            echo json_encode(array(
                "status" => "success",
                "message" => "Login successful",
                "user_id" => $user_id,
                "user_type" => $user_type  // Include user_id in the response
            ));
        } else {
            // Password mismatch
            echo json_encode(array("status" => "error", "message" => "Invalid username or password"));
        }
    } else {
        // No matching username
        echo json_encode(array("status" => "error", "message" => "Invalid username or password"));
    }

    $stmt->close();
} else {
    // Invalid request method
    echo json_encode(array("status" => "error", "message" => "Invalid request method"));
}

$conn->close();
?>
