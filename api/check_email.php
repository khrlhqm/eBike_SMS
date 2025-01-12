<?php
// Database connection
$host = "localhost";
$db_user = "root"; // Database username
$db_password = ""; // Database password
$db_name = "ebikesms"; // Database name

$conn = new mysqli($host, $db_user, $db_password, $db_name);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Get the posted JSON data
$data = json_decode(file_get_contents("php://input"), true);

// Check if user_email is provided
if (isset($data['user_email'])) {
    $user_email = $conn->real_escape_string($data['user_email']); // Escape the email to prevent SQL injection

    // Check if the email already exists in the database
    $checkQuery = "SELECT * FROM user WHERE user_email = '$user_email'";
    $checkResult = $conn->query($checkQuery);

    if ($checkResult->num_rows > 0) {
        // Email exists
        echo json_encode(["status" => "error", "message" => "Email already exists"]);
    } else {
        // Email does not exist
        echo json_encode(["status" => "success", "message" => "Email does not exist"]);
    }
} else {
    echo json_encode(["status" => "error", "message" => "Invalid data"]);
}

$conn->close();
?>
