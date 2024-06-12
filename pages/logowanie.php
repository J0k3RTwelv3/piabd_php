<!DOCTYPE html>
<html lang="pl-PL">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PHP</title>
    <link rel="stylesheet/less" href="../styles/style.less">
    <?php include("../less/importy.html") ?>
</head>
<body>
    <?php include("../components/naglowek.php"); ?>
    <main class="srodek">
        <section class="ui card">
            <div class="content">
                <h1 class="ui icon header small">
                    <i class="user lock icon"></i>
                    <div class="content">
                        Zaloguj się
                    </div>
                    <div class="ui divider"></div>
                </h1>
                <?php if(isset($_GET["sukces"])) {
                    if($_GET["sukces"] == 1) { ?>
                    <p class="ui text tsrodek" style="color: green">
                        Udało się pomyślnie utworzyć konto!
                    </p>
                <?php } elseif($_GET["sukces"] == 0) { ?>
                    <p class="ui text tsrodek" style="color: red">
                        Niepoprawny login lub hasło
                    </p>
                <?php }} ?>
                <div class="description">
                    <form action="../php/konto/zaloguj.php" method="post">
                        <div class="ui padded input icon fluid">    
                            <i class="user icon"></i>
                            <input type="text" placeholder="Nazwa użytkownika" name="nazwa" required>
                        </div>
                        <div class="ui input icon fluid">    
                            <i class="key icon"></i>
                            <input type="password" minlength="5" placeholder="Hasło" name="haslo" required>
                        </div>
                        <button type="submit" class="fluid ui purple primary button">
                            Zaloguj się
                        </button>
                    </form>
                    <div class="ui divider"></div>
                    <p class="ui tsrodek">
                        Nie masz konta?
                        <a href="./rejestracja.php" class="ui">Zarejestruj się!</a>
                    </p>
                </div>
            </div>
        </section>
    </main>
</body>
</html>