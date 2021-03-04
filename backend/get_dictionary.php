<?php

include 'koneksi.php';

$queryResult = $connect->query("SELECT * FROM tb_dictionary");
$result = array();

while ($fetch_data = $queryResult->fetch_assoc()) {
    $result[] = $fetch_data;
}
$res = json_encode($result);
echo($res);

