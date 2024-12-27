<?php
    // Database connection
    $host = "localhost";
    $db_user = "root"; // Database username
    $db_password = ""; // Database password
    $db_name = "ebikesms"; // Database name

    $conn = new mysqli($host, $db_user, $db_password, $db_name);

    // Check connection
    if ($conn->connect_error) {
        die(json_encode(["status" => "error", "message" => "Connection failed: {$conn->connect_error}"]));
    }

    // Set content header (must match with what's defined in Flutter)
    header("Content-Type: application/json");

    // Invalid request method
    if($_SERVER['REQUEST_METHOD'] != 'POST'){
        echo json_encode(array("status" => "error", "message" => "Invalid request method"));    
    }

    // Get the posted JSON data (from the application)
    $input = json_decode(file_get_contents("php://input"), true);
    error_log(print_r($input, true)); // Log the incoming data for debugging
    $bikeId = $input['bike_id'] ?? '';

    // Execute query
    $query = "SELECT bike_id, status, current_latitude, current_longitude FROM bike WHERE bike_id = '$bikeId'";
    $result = $conn->query($query);

    if ($result === FALSE) {
        echo json_encode(["status" => "error", "message" => "Failed to execute query. Error: " . $conn->error]);
    }
    // Check if no results were returned
    elseif ($result->num_rows < 1) {
        echo json_encode(["status" => "error", "message" => "It appears there is no such bike in the database."]);
    }
    // If query succeeded and results are available
    else {
        $bikes = [];
        while ($row = $result->fetch_assoc()) {
            $bikes[] = [
                "bike_id" => $row['bike_id'],
                "status" => $row['status'],
                "current_latitude" => $row['current_latitude'],
                "current_longitude" => $row['current_longitude']
            ];
        }
        echo json_encode([
            "status" => "success",
            "message" => "Bike information forwarded.",
            "data" => $bikes]
        );
    }



    // Close the database connection
    $conn->close();
?>
