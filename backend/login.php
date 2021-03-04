<?php

require "koneksi.php";

if ($_SERVER["REQUEST_METHOD"] == "POST") {

    $response = array();
    $emailOrUsername = $_POST["email_or_username"];
    $password = hash('sha256', $_POST["password"]);
    $cek = "SELECT * FROM tb_user WHERE username='$emailOrUsername' AND password='$password' OR email='$emailOrUsername' AND password='$password'";
    $result = mysqli_fetch_array(mysqli_query($connect, $cek));
    if (isset($result)) {
        $response["value"] = 1;
        $response["message"] = "Login berhasil";
        $response["email"] = $result["email"];
        $response["username"] = $result["username"];
        echo json_encode($response);
    } else {
        $response["value"] = 2;
        $response["message"] = "Login gagal";
        echo json_encode($response);
    }
}
