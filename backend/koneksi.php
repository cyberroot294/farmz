<?php

$connect = new mysqli("localhost", "root", "", "week_3");
if ($connect) {
    // print_r("DB CONNECTED");
} else {
    // print_r("DB NOT CONNECTED");
}
