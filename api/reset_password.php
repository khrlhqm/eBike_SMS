<?php
header("Content-Type: application/json");

// Database configuration
$host = "localhost";
$username = "root";
$password = "";
$dbname = "ebikesms"; // Replace with your database name

// Connect to the database
$conn = new mysqli($host, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die(json_encode(["status" => "error", "message" => "Connection failed: " . $conn->connect_error]));
}

// Handle HTTP POST request
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Get JSON input
    $input = json_decode(file_get_contents("php://input"), true);

    // Validate input
    if (!isset($input["email"]) || !isset($input["new_password"])) {
        echo json_encode(["status" => "error", "message" => "Email and new password are required"]);
        exit;
    }

    $email = $conn->real_escape_string($input["email"]);
    $newPassword = $conn->real_escape_string($input["new_password"]);

    // Hash the new password for security
    $hashedPassword = password_hash($newPassword, PASSWORD_BCRYPT);

    // Update the password in the database
    $sql = "UPDATE user SET password = ? WHERE user_email = ?";
    $stmt = $conn->prepare($sql);

    if ($stmt) {
        $stmt->bind_param("ss", $hashedPassword, $email);

        if ($stmt->execute()) {
            if ($stmt->affected_rows > 0) {
                echo json_encode(["status" => "success", "message" => "Password updated successfully"]);
            } else {
                echo json_encode(["status" => "error", "message" => "No user found with the given email"]);
            }
        } else {
            echo json_encode(["status" => "error", "message" => "Failed to update password"]);
        }

        $stmt->close();
    } else {
        echo json_encode(["status" => "error", "message" => "Failed to prepare SQL statement"]);
    }
} else {
    echo json_encode(["status" => "error", "message" => "Invalid request method"]);
}

// Close the database connection
$conn->close();
?>
