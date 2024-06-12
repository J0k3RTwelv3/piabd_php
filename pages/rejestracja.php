<!DOCTYPE html>
<html lang="pl-PL">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PHP</title>
    <link rel="stylesheet/less" href="../styles/style.less">
    <script src="../scripts/rejestracja/walidacjaHasla.js" defer></script>
    <?php include("../less/importy.html") ?>
</head>
<body>
    <?php include("../components/naglowek.php"); ?>
    <main class="srodek">
        <section class="ui card">
            <div class="content">
                <h1 class="ui icon header small">
                    <i class="user add icon"></i>
                    <div class="content">
                        Zarejestruj się
                    </div>
                    <div class="ui divider"></div>
                </h1>
                <div class="description">
                    <form action="../php/konto/zarejestruj.php" method="post" onsubmit="return sprawdz()">
                        <div class="ui padded input icon fluid">    
                            <i class="user icon"></i>
                            <input type="text" placeholder="Nazwa użytkownika" name="nazwa" required>
                        </div>
                        <div class="ui input icon fluid">    
                            <i class="key icon"></i>
                            <input type="password" minlength="5" oninput="weryfikujHaslo()" placeholder="Hasło" name="haslo" id="haslo" required>
                        </div>
                        <div class="ui input icon fluid">    
                            <i class="repeat icon" id="haslo2-ikona"></i>
                            <input type="password" oninput="weryfikujHaslo()" minlength="5" placeholder="Powtórz hasło" name="haslo2" id="haslo2" required>
                        </div>
                        <button type="submit" class="fluid ui purple primary button" id="przyciskPrzeslij" disabled>
                            Zarejestruj się
                        </button>
                    </form>
                    <div class="ui divider"></div>
                    <p class="ui tsrodek">
                        Masz już konto?
                        <a href="./logowanie.php" class="ui">Zaloguj się!</a>
                    </p>
                </div>
            </div>
        </section>
    </main>
</body>
</html>