<?php
    // Database connection
    $host = "localhost";
    $db_user = "root"; // Database username
    $db_password = ""; // Database password
    $db_name = "ebikesms"; // Database name

    $conn = new mysqli($host, $db_user, $db_password, $db_name);

    // Check connection
    if ($conn->connect_error) { die("Connection failed: {$conn->connect_error}"); }


    // Set content header (must follow what's defined in Flutter too)
    header("Content-Type: application/json");

    // Get the posted JSON data
    $data = json_decode(file_get_contents("php://input"), true);

    // Validation
    $hasAllData = (isset($data["transaction_date"]) && isset($data["transaction_total"]) &&isset($data["obtained_ride_time"]) && isset($data["user_id"]));
    if($hasAllData) {
        $query = "INSERT INTO transaction (transaction_date, transaction_total, obtained_ride_time, user_id) 
        VALUES (
            '{$data["transaction_date"]}', 
            '{$data["transaction_total"]}', 
            '{$data["obtained_ride_time"]}',
            '{$data["user_id"]}'
        )";

        if ($conn->query($query) === TRUE) {
            echo json_encode(["status" => "success", "message" => "Transaction added"]);
        } else {
            echo json_encode(["status" => "error", "message" => "Failed to add transaction"]);
        }
    }
    else {
        echo json_encode(["status" => "error", "message" => "Invalid data"]);
    }


    $conn->close();
?>