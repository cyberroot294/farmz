<?php

include 'koneksi.php';

$queryResult = $connect->query("SELECT * FROM tb_berita ORDER BY created_at DESC LIMIT 3");
$result = array();

while ($fetch_data = $queryResult->fetch_assoc()) {
    $result[] = $fetch_data;
}

echo json_encode($result);
