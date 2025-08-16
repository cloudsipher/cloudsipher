<?php

// echo "<pre>";
// print_r($_REQUEST);
// echo "Hello";
// exit;



if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $name    = htmlspecialchars(trim($_POST['name'] ?? ''));
    $email   = htmlspecialchars(trim($_POST['email'] ?? ''));
    $phone   = htmlspecialchars(trim($_POST['phone'] ?? ''));
    $subject = htmlspecialchars(trim($_POST['subject'] ?? 'Product Enquiry'));
    $message = htmlspecialchars(trim($_POST['message'] ?? ''));

    // Validate required fields
    if (!empty($name) && !empty($email) && !empty($phone) && !empty($message)) {
        $to      = "contact@swarnasol.com"; // Replace with your email
        $headers = "From: $name <$email>\r\n";
        $headers .= "Reply-To: $email\r\n";
        $headers .= "Content-Type: text/plain; charset=UTF-8\r\n";

        $body = "You received a product enquiry from Swarnasol website:\n\n";
        $body .= "Name: $name\n";
        $body .= "Email: $email\n";
        $body .= "Phone: $phone\n";
        $body .= "Subject: $subject\n";
        $body .= "Message: $message\n";

        if (mail($to, $subject, $body, $headers)) {
            echo json_encode(["status" => "success", "message" => "Your enquiry has been sent successfully."]);
        } else {
            echo json_encode(["status" => "error", "message" => "Failed to send email."]);
        }
    } else {
        echo json_encode(["status" => "error", "message" => "All fields are required."]);
    }
} else {
    echo json_encode(["status" => "error", "message" => "Invalid request."]);
}
?>
