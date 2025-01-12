<?php
header("Content-Type: application/json");

// Database connection details
$host = "localhost";
$db_user = "root";
$db_password = "";
$db_name = "ebikesms";

// Connect to the database
$conn = new mysqli($host, $db_user, $db_password, $db_name);

// Check connection
if ($conn->connect_error) {
    echo json_encode(['success' => false, 'message' => 'Database connection failed.']);
    exit;
}

// Get the input data
$input = json_decode(file_get_contents('php://input'), true);

// Validate input
if (!isset($input['user_id'], $input['report_type'], $input['report_detail'])) {
    echo json_encode(['success' => false, 'message' => 'Invalid input.']);
    exit;
}

$user_id = $conn->real_escape_string($input['user_id']);
$report_type = $conn->real_escape_string($input['report_type']);
$report_detail = $conn->real_escape_string($input['report_detail']);
$report_date = date('Y-m-d H:i:s');

// Insert the report into the database
$sql = "INSERT INTO report (report_date, report_type, report_detail, user_id) VALUES ('$report_date', '$report_type', '$report_detail', '$user_id')";

if ($conn->query($sql) === TRUE) {
    echo json_encode(['success' => true, 'message' => 'Report submitted successfully.']);
} else {
    echo json_encode(['success' => false, 'message' => 'Failed to submit the report.']);
}

// Close the connection
$conn->close();
?>
