<?php require_once(dirname(__FILE__)."/../php/konto/zalogowany.php"); ?>

<header id="naglowek">
    <div>
        <a href="/piabd_php/index.php">
            <h1>PHP</h1>
        </a>
        <?php if($zalogowany) { ?>
            <p class="ui">
                Zalogowany jako: <?php echo $_SESSION["uzytkownik"]; ?>
            </p>
        <?php } ?>
    </div>
    <nav>
        <?php if($zalogowany) { ?>
            <a href="/piabd_php/pages/profil.php" class="ui basic purple button">
                <i class="user icon"></i>Profil
            </a>
            <a href="/piabd_php/pages/lekcje.php" class="ui basic purple button">
                <i class="book reader icon"></i>Lekcje
            </a>
            <a href="/piabd_php/php/konto/wyloguj.php" class="ui basic red button">
                <i class="sign out icon"></i>Wyloguj się
            </a>
        <?php } else { ?>
            <a href="/piabd_php/pages/logowanie.php" class="ui basic purple button">
                <i class="sign in icon"></i>Zaloguj się
            </a>
            <a href="/piabd_php/pages/rejestracja.php" class="ui purple button">
                <i class="check square icon"></i>Zarejestruj się
            </a>
        <?php } ?>
    </nav>
</header>