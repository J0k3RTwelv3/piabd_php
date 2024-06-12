<?php

session_start();

$nazwa = $_POST["nazwa"];
$haslo = $_POST["haslo"];

$mysqli = new mysqli("localhost", "piabd_php", "PHP_PIABD", "piabd_php");

$zwroconyId = 0;
$zwroconaNazwa = "";
$zwroconyHash = "";

$kwerenda = $mysqli->prepare("SELECT uzytkownicy.id, uzytkownicy.nazwa, uzytkownicy.pwd_hash FROM uzytkownicy WHERE uzytkownicy.nazwa = ?;");
$kwerenda->bind_param("s", $nazwa);
$kwerenda->bind_result($zwroconeId, $zwroconaNazwa, $zwroconyHash);
$kwerenda->execute();
$kwerenda->store_result();

if($kwerenda->num_rows <= 0) {
    $mysqli->close();
    header("Location: /piabd_php/pages/logowanie.php?sukces=0");
    exit;
}

$kwerenda->fetch();

if(password_verify($haslo, $zwroconyHash)) {
    $_SESSION["zalogowany"] = true;
    $_SESSION["uzytkownik"] = $nazwa;
    $_SESSION["id"] = $zwroconeId;
    $mysqli->close();
    header("Location: /piabd_php/");
    exit;
} else {
    $mysqli->close();
    header("Location: /piabd_php/pages/logowanie.php?sukces=0");
    exit;
}