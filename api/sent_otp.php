<?php
require 'vendor/autoload.php';
use SendGrid\Mail\Mail;
use Dotenv\Dotenv;

// Load .env file
$dotenv = Dotenv::createImmutable(__DIR__);
$dotenv->load();

// Get the SendGrid API key from the .env file
$sendGridApiKey = $_ENV['SENDGRID_API_KEY'];

// Check if email and OTP are set in the request body
if (isset($_POST['email']) && isset($_POST['otp'])) {
    $email = $_POST['email'];
    $otp = $_POST['otp'];

    // Send email using SendGrid
    $sendGridEmail = new Mail();
    $sendGridEmail->setFrom("amirhmzh02@gmail.com", "Example");
    $sendGridEmail->setSubject("Your Verification Code");
    $sendGridEmail->addTo($email); // Use the email from the request
    $sendGridEmail->addContent("text/plain", "Your verification code is: $otp");

    $sendGrid = new \SendGrid($sendGridApiKey);
    $response = $sendGrid->send($sendGridEmail);

    // Check if the email was sent successfully
    if ($response->statusCode() == 202) {
        echo "Email sent successfully";
    } else {
        echo "Failed to send email: " . $response->statusCode();
    }
} else {
    echo "Email or OTP not provided";
}
?>
