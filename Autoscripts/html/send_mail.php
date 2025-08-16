<?php

// Debug: log POST data to file (remove after testing)
file_put_contents('debug_post.txt', print_r($_POST, true));

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $name    = htmlspecialchars(trim($_POST['name'] ?? ''));
    $email   = htmlspecialchars(trim($_POST['email'] ?? ''));
    $phone   = htmlspecialchars(trim($_POST['phone'] ?? ''));
    $subject = htmlspecialchars(trim($_POST['subject'] ?? ''));
    $message = htmlspecialchars(trim($_POST['message'] ?? ''));

    // Fallback subject if empty
    $mail_subject = !empty($subject) ? $subject : 'From Contact form on website';

    // Validate required fields
    if (!empty($name) && !empty($email) && !empty($phone) && !empty($message)) {
        $to      = "info@cloudsipher.com"; // Original recipient
        $headers = "MIME-Version: 1.0\r\n";
        $headers .= "Content-type:text/html;charset=UTF-8\r\n";
        $headers .= "From: $name <$email>\r\n";
        $headers .= "Reply-To: $email\r\n";

        $body = '<h3>You got a mail from website:</h3><br/>';
        $body .= '<b>Name:</b> ' . $name . '<br/>';
        $body .= '<b>Email:</b> ' . $email . '<br/>';
        $body .= '<b>Phone:</b> ' . $phone . '<br/>';
        $body .= '<b>Subject:</b> ' . $mail_subject . '<br/>';
        $body .= '<b>Message:</b> ' . nl2br($message) . '<br/>';

        $main_sent = mail($to, $mail_subject, $body, $headers);

        // Send auto-response to user
        $auto_subject = "Thank you for contacting CloudSipher";
        $auto_headers = "MIME-Version: 1.0\r\n";
        $auto_headers .= "Content-type:text/html;charset=UTF-8\r\n";
        $auto_headers .= "From: CloudSipher <info@cloudsipher.com>\r\n";
        $auto_headers .= "Reply-To: info@cloudsipher.com\r\n";
        $auto_body = file_get_contents(__DIR__ . '/svg-icons/AutoRepsonseEmail.html');
        $auto_sent = mail($email, $auto_subject, $auto_body, $auto_headers);

        if ($main_sent) {
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
