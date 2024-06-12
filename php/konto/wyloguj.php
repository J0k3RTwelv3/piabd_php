<?php

session_start();

if(isset($_SESSION["zalogowany"])) {
    if($_SESSION["zalogowany"] == true) {
        session_unset();
        session_destroy();
        header("Location: /piabd_php/");
        exit;
    }
}