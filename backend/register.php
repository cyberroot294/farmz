<?php

require 'koneksi.php';

try {
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $response = array();

        $email = $_POST["email"];
        $username = $_POST["username"];
        $password = hash('sha256', $_POST["password"]);

        $cekEmail = "SELECT * FROM tb_user WHERE email='$email'";
        $cekUsername = "SELECT * FROM tb_user WHERE username='$username'";
        $resultEmail = mysqli_fetch_array(mysqli_query($connect, $cekEmail));
        $resultUsername = mysqli_fetch_array(mysqli_query($connect, $cekUsername));

        function validateEmail($email)
        {
            return filter_var($email, FILTER_VALIDATE_EMAIL);
        }

        if (empty($email) || empty($username) || empty($password)) {
            $response["value"] = 2;
            $response["message"] = "Field kosong";
            echo json_encode($response);
            return;
        }

        if (!validateEmail($email)) {
            $response["value"] = 2;
            $response["message"] = "Email invalid";
            echo json_encode($response);
            return;
        }

        if (strlen($password) < 6) {
            $response["value"] = 2;
            $response["message"] = "Password terlalu pendek";
            echo json_encode($response);
            return;
        }

        if (isset($resultEmail)) {
            $response["value"] = 2;
            $response["message"] = "Email telah digunakan";
            echo json_encode($response);
            return;
        }

        if (isset($resultUsername)) {
            $response["value"] = 2;
            $response["message"] = "Username telah digunakan";
            echo json_encode($response);
            return;
        }

        $insert = "INSERT INTO tb_user VALUE (NULL, '$username', '$email', '$password')";
        if (mysqli_query($connect, $insert)) {
            $response["value"] = 1;
            $response["message"] = "Berhasil Didaftarkan";
            echo json_encode($response);
        }
    }
} catch (\Throwable $th) {
    echo "woi";
}
