<?php

$mysqli = new mysqli("localhost", "piabd_php", "PHP_PIABD", "piabd_php");
if($mysqli->connect_error) {
    print("Nie udalo sie polaczyc z baza danych: ".$mysqli->connect_error);
}

$query = $mysqli->prepare("SELECT uzytkownicy.nazwa FROM uzytkownicy WHERE uzytkownicy.nazwa = ?;");
$query->bind_param("s", $_POST["nazwa"]);
$query->execute();
$query->store_result();
if($query->num_rows > 0) {
    die("Uzytkownik juz istnieje");
}

$haslo = password_hash($_POST["haslo"], "2y");
$nazwa = $_POST["nazwa"];

$query = $mysqli->prepare("INSERT INTO uzytkownicy VALUES(NULL, ?, ?);");

$query->bind_param("ss", $nazwa, $haslo);
if($query->execute()) {
    $mysqli->close();
    header("Location: /piabd_php/pages/logowanie.php?sukces=1");
}

$mysqli->close();