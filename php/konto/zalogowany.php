<?php

session_start();

$zalogowany = false;

if(isset($_SESSION["zalogowany"])) {
    if($_SESSION["zalogowany"] = true) {
        $zalogowany = true;
    }
}