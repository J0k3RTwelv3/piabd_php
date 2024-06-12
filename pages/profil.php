<!DOCTYPE html>
<html lang="pl-PL">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PHP</title>
    <link rel="stylesheet/less" href="/piabd_php/styles/style.less">
    <?php include("../less/importy.html") ?>
</head>
<body>
    <?php 

    include("../components/naglowek.php"); 

    if(!$zalogowany) {
        header("Location: /piabd_php/pages/logowanie.php");
        exit;
    }

    ?>
    <main class="srodek">
        <div class="ui raised card">
            <div class="content">
                <h1 class="ui icon header small">
                    <i class="user icon"></i>
                    <div class="content">
                        <?php echo $_SESSION["uzytkownik"]; ?>
                    </div>
                    <div class="ui divider"></div>
                </h1>
                <div class="description">
                    <a href="/piabd_php/pages/lekcje.php" class="ui basic purple fluid button">
                        <i class="book reader icon"></i>Lekcje
                    </a>
                    <a href="/piabd_php/php/konto/wyloguj.php" class="ui basic fluid red button martop">
                        <i class="sign out icon"></i>Wyloguj się
                    </a>
                </div>
            </div>
        </div>
    </main>
</body>
</html>