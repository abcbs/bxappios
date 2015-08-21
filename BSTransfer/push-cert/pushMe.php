<?php

// Put your device token here (without spaces):
$deviceToken =
        "b617a5ff9796e7bef6fe426fb9b9e141453f8db8b7a770f60ab20aa84a6627e3";

// Put your private key's passphrase here:密语
$passphrase = "admin";

    
// Put your alert message here:
$messages =“来自苹果的通知问候”;

////////////////////////////////////////////////////////////////////////////////

$ctx = stream_context_create();
stream_context_set_option($ctx,"ssl","local_cert","ck.pem");
stream_context_set_option($ctx, "ssl", "passphrase", $passphrase);

// Open a connection to the APNS server
$fp = stream_socket_client(
	"ssl://gateway.sandbox.push.apple.com:2195", $err,
	$errstr, 60, STREAM_CLIENT_CONNECT|STREAM_CLIENT_PERSISTENT, $ctx);

if (!$fp)
	exit("Failed to connect: $err $errstr" . PHP_EOL);

echo "Connected to APNS" . PHP_EOL;

// Create the payload body
$body["aps"] = array(
	"alert"=> $messages,
	"sound" => "default"
	);

// Encode the payload as JSON
$payload = json_encode($body);

// Build the binary notification
$msg = chr(0) . pack("n", 32) . pack("H*", $deviceToken) . pack("n", strlen($payload)) . $payload;

// Send it to the server
$result = fwrite($fp, $msg, strlen($msg));

if (!$result)
	echo "Message not delivered" . PHP_EOL;
else
	echo "Message successfully delivered". PHP_EOL;

// Close the connection to the server
fclose($fp);
    
?>
