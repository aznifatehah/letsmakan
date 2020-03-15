<?php
$servername = "localhost";
$username   = "asaboleh_letsmakanadmin";
$password   = "ywNEKeC)]B3L";
$dbname     = "asaboleh_letsmakan";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>