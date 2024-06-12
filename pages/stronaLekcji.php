<?php

require_once("../php/konto/zalogowany.php");

if(!isset($_GET["lekcja"]) || !isset($_GET["strona"]) || !$zalogowany) {
    header("Location: /piabd_php/");
    exit;
}

$mysqli = new mysqli("localhost", "piabd_php", "PHP_PIABD", "piabd_php");
$mysqli->set_charset("utf8");

$kwerenda = $mysqli->prepare("SELECT strona_lekcji.nazwa, strona_lekcji.ostatnia_strona, strona_lekcji.zawartosc, lekcja.nazwa, lekcja.ilosc_stron FROM strona_lekcji INNER JOIN lekcja ON strona_lekcji.id_lekcji = lekcja.id AND strona_lekcji.id_lekcji = ? AND strona_lekcji.numer_strony = ?;");
$kwerenda->bind_param("ii", $_GET["lekcja"], $_GET["strona"]);

$nazwaStrony = "";
$czyOstatniaStrona = false;
$zawartoscLekcji = "";
$nazwaLekcji = "";
$iloscStron = 1; 

$kwerenda->bind_result($nazwaStrony, $czyOstatniaStrona, $zawartoscLekcji, $nazwaLekcji, $iloscStron);
$kwerenda->execute();
$kwerenda->store_result();
$kwerenda->fetch();

?>

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
    <?php include("../components/naglowek.php") ?>

    <?php if($kwerenda->num_rows <= 0) { ?>

        <main class="srodek">
            <div class="ui card">
                <div class="content">
                    <h1 class="tsrodek">404</h1>
                    <div class="description tsrodek">
                        <p>
                            <b>Nie udało się znaleźć takiej lekcji!</b><br><br>
                            Sprawdź poprawność adresu URL lub przejdź do zakładki
                            <a href="./lekcje.php"><b>Lekcje</b></a>.
                        </p>
                    </div>
                </div>
            </div>
        </main>

    <?php } else { ?>

        <main id="widokStronyLekcji">
            <div class="ui fluid card">
                <div class="content">
                    <h1>
                        <?php echo $nazwaLekcji ?>
                    </h1>
                    <h3>
                        <?php echo $nazwaStrony ?>
                    </h3>
                        <i class="book icon"></i>
                        <?php echo "Strona ".$_GET["strona"]." z ".$iloscStron; ?>
                    </h5>
                    <div class="ui divider"></div>
                    <div class="description">
                        <?php
                        
                        require_once(__DIR__."/../php/html_purifier/HTMLPurifier.standalone.php");
                        
                        $konfiguracjaSanitizera = HTMLPurifier_Config::createDefault();
                        $sanitizer = new HTMLPurifier($konfiguracjaSanitizera);
                        $czystyHtml = $sanitizer->purify($zawartoscLekcji);

                        print($czystyHtml);

                        ?>
                    </div>
                    <div class="ui divider"></div>
                    <div id="postep" class="ui green slow progress" percent="90">
                        <div class="bar">
                            <div class="progress"></div>
                        </div>
                    </div>
                    <script>

                        <?php

                        $iloscStronUkonczonych = 0;

                        function utworzPostep(mysqli $mysqli) {
                            $kwerenda = $mysqli->prepare("INSERT INTO postepy VALUES(?, ?, 1);");
                            $kwerenda->bind_param("ii", $_SESSION["id"], $_GET["lekcja"]);
                            $kwerenda->execute();
                        }

                        function zaktualizujPostep(mysqli $mysqli, int $nowyPostep) {
                            $kwerenda = $mysqli->prepare("UPDATE postepy SET postepy.ilosc_stron_ukonczonych = ? WHERE postepy.id_uzytkownika = ? AND postepy.id_lekcji = ?;");
                            $kwerenda->bind_param("iii", $nowyPostep, $_SESSION["id"], $_GET["lekcja"]);
                            $kwerenda->execute();
                        }

                        $kwerenda->prepare("SELECT postepy.ilosc_stron_ukonczonych FROM postepy WHERE postepy.id_uzytkownika = ? AND postepy.id_lekcji = ?;");
                        $kwerenda->bind_param("ii", $_SESSION["id"], $_GET["lekcja"]);

                        $kwerenda->bind_result($iloscStronUkonczonych);
                        $kwerenda->execute();
                        $kwerenda->store_result();

                        if($kwerenda->num_rows == 0) {
                            utworzPostep($mysqli);
                            $iloscStronUkonczonych = 1;
                        } else {
                            $kwerenda->fetch();
                            if($iloscStronUkonczonych < $iloscStron && intval($_GET["strona"]) > $iloscStronUkonczonych) {
                                $iloscStronUkonczonych++;
                                zaktualizujPostep($mysqli, $iloscStronUkonczonych);
                            }
                        }

                        ?>

                        /* interop 100 */
                        const iloscStronUkonczonych = <?php echo $iloscStronUkonczonych; ?>;
                        const iloscStron = <?php echo $iloscStron; ?>

                        $("#postep").progress({
                            label: false,
                            total: iloscStron,
                            value: iloscStronUkonczonych,
                            text: {
                                active: `Ukończono ${iloscStronUkonczonych} z ${iloscStron}! Tak trzymaj!`,
                                success: "Lekcja została ukończona!"
                            }
                        });
                    </script>
                    <h5 id="postepTekst" class="tsrodek">
                        <?php

                        if($iloscStronUkonczonych < $iloscStron) {
                            print("Ukończono $iloscStronUkonczonych z $iloscStron stron! Tak trzymaj!");
                        } else {
                            print('Kurs został ukończony! <i class="happy icon"></i>');
                        }

                        ?>
                    </h5>
                </div>
                <div id="przyciski">
                    <?php if($_GET["strona"] != 1) { ?>
                        <a href="<?php echo "/piabd_php/pages/stronaLekcji.php?lekcja=".$_GET["lekcja"]."&strona=".intval($_GET["strona"]) - 1; ?>" class="ui basic button">
                            <i class="left arrow icon"></i>Poprzednia strona
                        </a>
                    <?php } if(!$czyOstatniaStrona) { ?>
                        <a href="<?php echo "/piabd_php/pages/stronaLekcji.php?lekcja=".$_GET["lekcja"]."&strona=".intval($_GET["strona"]) + 1; ?>" class="ui purple button">
                            Następna strona<i class="right arrow icon"></i>
                        </a>
                    <?php } ?>
                </div>
            </div>
        </main>

    <?php } ?>

</body>
</html>
<?php $mysqli->close(); ?>