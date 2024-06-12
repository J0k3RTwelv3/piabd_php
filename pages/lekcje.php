<?php

$mysqli = new mysqli("localhost", "piabd_php", "PHP_PIABD", "piabd_php");
$mysqli->set_charset("utf8");
$kwerenda = $mysqli->prepare("SELECT * FROM lekcja");

$lekcjaId = 0;
$nazwa = "";
$opis = "";
$obrazUri = "";
$iloscStron = 0;

$kwerenda->bind_result($lekcjaId, $nazwa, $opis, $obrazUri, $iloscStron);
$kwerenda->execute();
$kwerenda->store_result();

?>

<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="utf-8">
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
    <main>
        <div class="ui grid" id="widokLekcji">
            <?php while($kwerenda->fetch()) { 

                $subKwerenda = $mysqli->prepare("SELECT postepy.ilosc_stron_ukonczonych FROM postepy WHERE postepy.id_uzytkownika = ? AND postepy.id_lekcji = ?;");
                $subKwerenda->bind_param("ii", $_SESSION["id"], $lekcjaId);

                $iloscStronUkonczonych = 0;
                $subKwerenda->bind_result($iloscStronUkonczonych);

                $subKwerenda->execute();
                $subKwerenda->store_result();
                $subKwerenda->fetch();

                ?>
                <div class="ui card">
                    <div class="image">
                        <img src="<?php echo $obrazUri ?>">
                    </div>
                    <div class="content">
                        <a class="header" href="<?php echo "/piabd_php/pages/stronaLekcji.php?lekcja=$lekcjaId&strona=1"; ?>">
                            <?php echo $nazwa; ?>
                        </a>
                        <div class="description">
                            <p class="ui text">
                                <?php print($opis); ?>
                            </p>
                        </div>
                    </div>
                    <div class="extra content">
                        <p>
                            <?php if($iloscStronUkonczonych == $iloscStron) { ?>
                                <i class="check circle icon green"></i>
                            <?php } else { ?>
                                <i class="check icon"></i>
                            <?php } ?>
                            Ukończono <?php echo $iloscStronUkonczonych; ?> z <?php echo $iloscStron; ?> 
                        </p>
                    </div>
                </div>
            <?php } ?>
        </div>
    </main>
</body>
</html>
<?php $mysqli->close(); ?>