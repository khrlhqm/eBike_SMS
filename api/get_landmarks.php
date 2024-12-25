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

    // Get the posted JSON data
    $data = json_decode(file_get_contents("php://input"), true);
    
    $query = "SELECT
                landmark_id,
                landmark_name_malay,
                landmark_name_english,
                landmark_type,
                address,
                latitude,
                longitude
            FROM
                landmark";

    // Execute query
    $result = $conn->query($query);

    if ($result === FALSE) {
        echo json_encode(["status" => "error", "message" => "Failed to execute query. Error: " . $conn->error]);
    } 
    // Check if no results were returned
    elseif ($result->num_rows < 1) {
        echo json_encode(["status" => "error", "message" => "It appears there are no landmarks in the system."]);
    } 
    // If query succeeded and results are available
    else {
        $landmarks = [];
        while ($row = $result->fetch_assoc()) {
            $landmarks[] = [
                "landmark_id" => $row['landmark_id'],
                "landmark_name_malay" => $row['landmark_name_malay'],
                "landmark_name_english" => $row['landmark_name_english'],
                "landmark_type" => $row['landmark_type'],
                "address" => $row['address'],
                "latitude" => $row['latitude'],
                "longitude" => $row['longitude'],
            ]; 
        }
        echo json_encode([
            "status" => "success", 
            "message" => "Location information forwarded.", 
            "data" => $landmarks]
        );
    }

    // Close the database connection
    $conn->close();
?>
