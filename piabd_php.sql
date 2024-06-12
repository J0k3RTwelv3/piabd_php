-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Cze 12, 2024 at 10:38 PM
-- Wersja serwera: 10.4.32-MariaDB
-- Wersja PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `piabd_php`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `lekcja`
--

CREATE TABLE `lekcja` (
  `id` int(11) NOT NULL,
  `nazwa` varchar(100) NOT NULL,
  `opis` text NOT NULL,
  `obraz_uri` varchar(255) DEFAULT NULL,
  `ilosc_stron` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Dumping data for table `lekcja`
--

INSERT INTO `lekcja` (`id`, `nazwa`, `opis`, `obraz_uri`, `ilosc_stron`) VALUES
(1, 'Obsługa formularzy HTML i PHP', 'W tej lekcji poznasz jak za pomocą HTML oraz PHP obsłużyć formularze', '/piabd_php/assets/images/1-thumb.png', 2),
(2, 'PHP i MySQLi - Podstawy', 'W tej lekcji poznasz jak za pomocą MySQLi i PHP polączyć się z bazą danych i wykonać kwerendę INSERT.', '/piabd_php/assets/images/2-thumb.png', 3);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `postepy`
--

CREATE TABLE `postepy` (
  `id_uzytkownika` int(11) NOT NULL,
  `id_lekcji` int(11) NOT NULL,
  `ilosc_stron_ukonczonych` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Dumping data for table `postepy`
--

INSERT INTO `postepy` (`id_uzytkownika`, `id_lekcji`, `ilosc_stron_ukonczonych`) VALUES
(15, 1, 2),
(15, 2, 3);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `strona_lekcji`
--

CREATE TABLE `strona_lekcji` (
  `id_lekcji` int(11) NOT NULL,
  `nazwa` varchar(255) NOT NULL,
  `numer_strony` int(11) NOT NULL,
  `ostatnia_strona` tinyint(1) NOT NULL,
  `zawartosc` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Dumping data for table `strona_lekcji`
--

INSERT INTO `strona_lekcji` (`id_lekcji`, `nazwa`, `numer_strony`, `ostatnia_strona`, `zawartosc`) VALUES
(1, 'Formularze w HTML', 1, 0, '<article>\r\n    <p>\r\n        Formularze w HTML 5 są obsługiwane za pomocą znacznika <code>form</code>, a w nim umieszczone są kontrolki <code>input</code>. Znacznik <code>form</code> posiada dwa ważne atrybuty:\r\n        <ul>\r\n            <li><code>action</code> - definiuje lokalizację w formacie URI do której ma być przesłany formularz</li>\r\n            <li><code>method</code> - definiuje metodę przesyłania danych: <code>GET</code> lub <code>POST</code>. Różnice pomiędzy metodami będą omówione na następnej stronie.</li>\r\n        </ul>\r\n    </p>\r\n    <p>\r\n        Kontrolki definiowane za pomocą znacznika <code>input</code> mogą przybierać różne postacie np. pole tekstowe, numeryczne, hasła, email, telefonu, pliku, próbnik kolorów, itd. Pełną listę można znaleźć <a href=\"https://www.w3schools.com/tags/tag_input.asp\" target=\"_blank\">tutaj</a>. \r\n    </p>\r\n    <p>\r\n        Jednakże najważniejszymi elementami każdego formularza HTML są atrybuty <code>name</code> w kontrolkach, oraz przycisk przesyłający formularz (jest to zazwyczaj <code>input</code> lub <code>button</code> z atrybutem <code>type=\"submit\"</code>). Po naciśnięciu przycisku formularza przeglądarka zbiera ze wszystkich kontrolek spod formularza, w którym znajduje się owy przycisk zawierających atrybut <code>name</code> aktualną wartość (z atrybutu <code>value</code>), a następnie zebrane dane są przesyłane do wcześniej zdefiniowanej lokalizacji w atrybucie <code>action</code> w znaczniku <code>form</code>.\r\n    </p>\r\n    <p>\r\n        Poniżej znajduje się przykładowy kod formularza HTML 5:\r\n    </p>\r\n        <pre><code>&lt;form action=&quot;./serwer.php&quot; method=&quot;post&quot;&gt;\r\n    Login: &lt;input type=&quot;text&quot; name=&quot;login&quot;&gt;&lt;br&gt;\r\n    Hasło: &lt;input type=&quot;password&quot; name=&quot;haslo&quot;&gt;&lt;br&gt;\r\n    &lt;input type=&quot;submit&quot; value=&quot;Zaloguj się&quot;&gt;\r\n&lt;/form&gt;</code></pre>\r\n</article>'),
(1, 'Dostęp do danych z przesłanego formularza za pomocą PHP', 2, 1, '<article>\r\n    <p>\r\n        Po naciśnięciu przycisku z typem <code>submit</code> następuje przesłanie danych do serwera pod adresem wskazanym w <code>action</code>. Dane są spreparowane w odpowiedni sposób w zależności od wartości atrybutu <code>method</code> zdefiniowanej w znaczniku <code>form</code>:\r\n        <ul>\r\n            <li><code>GET</code>: dane są przechowywane w postaci <code>klucz=wartosć</code> w adresie URL (mało bezpieczne, ponieważ zawartość jest widoczna, lokalizacja jest zapisywana w historii, a adres można dodać do zakładek)</li>\r\n            <li><code>POST</code>: dane są przechowywane w postaci <code>klucz=wartosć</code> w <i>ciele</i> żądania, tuż po nagłówkach. (bardziej bezpieczne, używane typowo do przesyłania danych logowania)</li>\r\n        </ul>\r\n        <br>\r\n    </p>\r\n    <p>\r\n        Obsługa tych wartości w kodzie PHP jest banalnie prosta. Język PHP definiuje dwie globalne tablice asocjacyjne: <code>$_GET</code> oraz <code>$_POST</code>. Obie tablice przechowują wartości pod indeksem odpowiedniego klucza (lub wartości atrybutu <code>name</code> z pola <code>input</code>, w którym została wpisana). Elementy te można modyfikować i odczytywać tak samo jak w tablicach asocjacyjnych. Należy tylko pamiętać o dwóch rzeczach:\r\n        <ul>\r\n            <li>Należy używać odpowiedniej tablicy w zależności od typu żądania wysłanego,</li>\r\n            <li>Należy sprawdzić za pomocą wbudowanej funkcji <code>isset()</code>, czy oczekiwana wartość pod podanym kluczem została przesłana.</li>\r\n        </ul>\r\n    </p>\r\n</article>'),
(2, 'Pobieranie danych z formularza', 1, 0, '<article>\r\n    <p>\r\n        W tej lekcji utworzymy prosty formularz rejestracyjny za pomocą HTML, PHP i biblioteki MySQLi. Przed rozpoczęciem tej lekcji, zalecane jest ukończenie lekcji <i><b>Obsługa formularzy HTML i PHP</b></i>, który wchodzi bardziej w detale działania formularzy.\r\n    </p>\r\n    <p>\r\n        Na początek należy utworzyć na stronie internetowej formularz HTML. Formularz będzie bardzo prosty, bowiem będzie zawierał tylko pole loginu oraz hasła. W atrybucie <code>action</code> umieść adres URI skryptu PHP, w którym napiszesz skrypt rejestracji.\r\n    </p>\r\n    <pre><code>&lt;form action=&quot;./serwer.php&quot; method=&quot;post&quot;&gt;\r\n    Login: &lt;input type=&quot;text&quot; name=&quot;login&quot;&gt;&lt;br&gt;\r\n    Hasło: &lt;input type=&quot;password&quot; name=&quot;haslo&quot;&gt;&lt;br&gt;\r\n    &lt;input type=&quot;submit&quot; value=&quot;Zaloguj się&quot;&gt;\r\n&lt;/form&gt;</code></pre>\r\n    <p>\r\n        Do formularzy rejestracyjnych lub logowania zalecane jest użycie metody <code>POST</code>, ponieważ przesyłane dane nie są widoczne na pasku URL, a żądań <code>POST</code> nie można zapisać w zakładkach.\r\n    </p>\r\n    <p>\r\n        W skrypcie <code>serwer.php</code> umieszczę kod, który będzie odpowiadał za rejestrację nowego użytkownika. Dane przesłane do serwera są dostępne w globalnej tablicy asocjacyjnej <code>$_POST</code>. Należy również pamiętać o sprawdzeniu, czy dane te zostały rzeczywiście przesłane.\r\n    </p>\r\n    <pre><code>if(!isset($_POST[&quot;login&quot;]) || !isset($_POST[&quot;haslo&quot;])) {\r\n    die(&quot;Brakuje danych potrzebnych do rejestracji!&quot;);\r\n}\r\n\r\n$login = $_POST[&quot;login&quot;];\r\n$haslo = $_POST[&quot;haslo&quot;];</code></pre>\r\n    <p>\r\n        Dane są już gotowe do użycia, a na następnej stronie zostanie omówione połączenie z bazą danych.\r\n    </p>\r\n</article>'),
(2, 'Połączenie z bazą danych', 2, 0, '<article>\r\n    <p>\r\n        Do obsługi połączeń z bazą danych potrzebna jest biblioteka MySQLi. Jest ona jedną z najpopularniejszych i najprostszych bibliotek do obsługi baz danych MySQL w języku PHP.\r\n    </p>\r\n    <p>\r\n        Na początek należy utworzyć nowe połączenie z bazą danych. Dla uproszczenia na potrzeby tej lekcji, baza danych znajduje się pod <code>localhost</code>, nazywa się <b><i>moja_baza</i></b>, a użytkownik <code>root</code> nie ma hasła. Aby połączyć się z bazą danych, należy utworzyć nową instancję klasy <code>mysqli</code>, która będzie repezentowała otwarte połączenie z bazą danych. Konstruktor przyjmuje 4 argumenty: adres URL, pod którym jest hostowana baza danych, nazwa użytkownika, hasło oraz nazwa bazy danych. Należy również sprawdzić, czy udało się połączyć z bazą danych. Do tego służy pole obiektu <code>connect_error</code>, który przechowuje informację o błędzie, jeżeli taki wystąpi.\r\n    </p>\r\n        <pre><code>$polaczenie = new mysqli(&quot;localhost&quot;, &quot;root&quot;, &quot;&quot;, &quot;moja_baza&quot;);\r\nif($polaczenie-&gt;connect_error) {\r\n    die(&quot;Błąd połączenia z bazą danych: &quot;.$polaczenie-&gt;connect_error);\r\n}</code></pre>\r\n    <p>\r\n        Po udanej próbie połączenia, możemy przystąpić do przygotowania i wykonania kwerendy <code>INSERT</code>.\r\n    </p>\r\n</article>'),
(2, 'Przygotowanie i wykonanie kwerendy INSERT', 3, 1, '<article>\r\n    <p>\r\n        Teraz pozostało tylko wysłać odpowiednią kwerendę SQL do bazy danych. Proces ten można podzielić na trzy kroki:\r\n        <ol>\r\n            <li>Przygotowanie kwerendy SQL</li>\r\n            <li>Podstawienie danych do kwerendy</li>\r\n            <li>Wykonanie kwerendy</li>\r\n        </ol>\r\n    </p>\r\n    <article>\r\n        <h2>\r\n            Przygotowanie kwerendy SQL\r\n        </h2>\r\n        <p>\r\n            Przygotowanie kwerendy SQL odbywa się za pomocą metody <code>prepare</code> obiektu <code>mysqli</code>. Metoda przyjmuje tylko jeden argument typu <code>string</code> - kwerendę SQL. Należy jednak pamiętać, aby nie wstawiać danych pochodzących z niezaufanego źródła (tzn. źródła, którego nie jesteśmy w żaden sposób w pełni kontrolować) bezpośrednio do kwerendy. Powodem tego jest narażanie się na atak <a href=\"https://www.w3schools.com/sql/sql_injection.asp\" target=\"_blank\">wstrzykiwania kodu SQL</a>. Aby zapobiec tego typu atakom, biblioteka MySQLi stosuje mechanizm parametryzacji zapytań. Aby skorzystać z tego, wystarczy w miejsca, gdzie mają być umieszczone dane wstawić znak <code>?</code>.\r\n        </p>\r\n        <pre><code>$kwerenda = $polaczenie->prepare(\"INSERT INTO uzytkownicy(uzytkownicy.login, uzytkownicy.haslo) VALUES(?, ?);\");</code></pre>\r\n    </article>\r\n    <article>\r\n        <h2>\r\n            Podstawienie danych do kwerendy\r\n        </h2>\r\n        <p>\r\n            Aby podstawić dane do przygotowanej kwerendy, należy skorzystać z metody <code>bind_param</code> dostępnej w nowo utworzonym obiekcie pod zmienną <code>$kwerenda</code>. Metoda przyjmuje co najmniej dwa argumenty:\r\n            <ul>\r\n                <li>Pierwszy argument jest zawsze ciągiem znaków, który odpowiada typom danych, które będą wstawiane do kwerendy. W związku z tym, że dane są typu <code>string</code>, jako pierwszy argument podstawimy <code>\"ss\"</code></li>\r\n                <li>Kolejne argumenty to zmienne, które przechowują dane</li>\r\n            </ul>\r\n            Ostatecznie kod wywołujący tą metodę przyjmie taką postać:\r\n        </p>\r\n        <pre><code>$haslo = password_hash($haslo, &quot;2y&quot;);\r\n$kwerenda-&gt;bind_param(&quot;ss&quot;, $login, $haslo);</code></pre>\r\n        <p>\r\n            Warto zaznaczyć, że zanim hasło zostało podstawione, zostało ono zahashowane, ponieważ w bazie danych <a href=\"https://stackoverflow.com/questions/1197417/why-are-plain-text-passwords-bad-and-how-do-i-convince-my-boss-that-his-treasur\" target=\"_blank\">nie powinno się przechowywać haseł w postaci zwykłego tekstu</a>.\r\n        </p>\r\n    </article>\r\n    <article>\r\n        <h2>\r\n            Wykonanie kwerendy\r\n        </h2>\r\n        <p>\r\n            Ostatnim krokiem jest wykonanie kwerendy za pomocą metody <code>execute()</code>. Nie przyjmuje żadnych argumentów, oraz zwraca wartość typu <code>bool</code>, która wskazuje, czy kwerenda została poprawnie wykonana lub nie.\r\n        </p>\r\n        <pre><code>if($kwerenda-&gt;execute()) {\r\nprint(&quot;Pomyślnie zarejestrowano nowego użytkownika!&quot;);\r\n} else {\r\nprint(&quot;Nie udało się wykonać poprawnie kwerendy!&quot;);\r\n}</code></pre>\r\n    </article>\r\n    <p>\r\n        Po zakończonej operacji z bazą danych należy pamiętać o zamknięciu połączenia. Można to łatwo wykonać za pomocą metody <code>close()</code>.\r\n    </p>\r\n    <pre><code>$polaczenie->close();</code></pre>\r\n    <p>\r\n        Oto cały kod skryptu, który realizuje rejestrację użytkownika: \r\n    </p>\r\n    <pre><code>&lt;?php\r\n\r\nif(!isset($_POST[&quot;login&quot;]) || !isset($_POST[&quot;haslo&quot;])) {\r\n    die(&quot;Brakuje danych potrzebnych do rejestracji!&quot;);\r\n}\r\n\r\n$login = $_POST[&quot;login&quot;];\r\n$haslo = $_POST[&quot;haslo&quot;];\r\n\r\n$polaczenie = new mysqli(&quot;localhost&quot;, &quot;root&quot;, &quot;&quot;, &quot;moja_baza&quot;);\r\nif($polaczenie-&gt;connect_error) {\r\n    die(&quot;Błąd połączenia z bazą danych: &quot;.$polaczenie-&gt;connect_error);\r\n}\r\n\r\n$kwerenda = $polaczenie-&gt;prepare(&quot;INSERT INTO uzytkownicy(uzytkownicy.login, uzytkownicy.haslo) VALUES(?, ?);&quot;);\r\n\r\n$haslo = password_hash($haslo, &quot;2y&quot;);\r\n$kwerenda-&gt;bind_param(&quot;ss&quot;, $login, $haslo);\r\n\r\nif($kwerenda-&gt;execute()) {\r\n    print(&quot;Pomyślnie zarejestrowano nowego użytkownika!&quot;);\r\n} else {\r\n    print(&quot;Nie udało się wykonać poprawnie kwerendy!&quot;);\r\n}\r\n\r\n$polaczenie-&gt;close();\r\n\r\n?&gt;</code></pre>\r\n</article>');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `uzytkownicy`
--

CREATE TABLE `uzytkownicy` (
  `id` int(11) NOT NULL,
  `nazwa` varchar(50) NOT NULL,
  `pwd_hash` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Dumping data for table `uzytkownicy`
--

INSERT INTO `uzytkownicy` (`id`, `nazwa`, `pwd_hash`) VALUES
(15, 'test', '$2y$10$gbRKOBc1qd.Un2kGHZsMGun2On/o8H7sby0H1yMp9rZlZoiL7DpdO'),
(17, 'super', '$2y$10$HWOmCWf5/L26eAQV7frXX.clL9fghi4I4qSoLv2CAYQ1TE7IHwwrK');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `lekcja`
--
ALTER TABLE `lekcja`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indeksy dla tabeli `postepy`
--
ALTER TABLE `postepy`
  ADD PRIMARY KEY (`id_uzytkownika`,`id_lekcji`),
  ADD KEY `postepy_fk1` (`id_lekcji`);

--
-- Indeksy dla tabeli `strona_lekcji`
--
ALTER TABLE `strona_lekcji`
  ADD PRIMARY KEY (`id_lekcji`,`numer_strony`);

--
-- Indeksy dla tabeli `uzytkownicy`
--
ALTER TABLE `uzytkownicy`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD UNIQUE KEY `nazwa` (`nazwa`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `lekcja`
--
ALTER TABLE `lekcja`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `uzytkownicy`
--
ALTER TABLE `uzytkownicy`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `postepy`
--
ALTER TABLE `postepy`
  ADD CONSTRAINT `postepy_fk0` FOREIGN KEY (`id_uzytkownika`) REFERENCES `uzytkownicy` (`id`),
  ADD CONSTRAINT `postepy_fk1` FOREIGN KEY (`id_lekcji`) REFERENCES `lekcja` (`id`);

--
-- Constraints for table `strona_lekcji`
--
ALTER TABLE `strona_lekcji`
  ADD CONSTRAINT `strona_lekcji_fk0` FOREIGN KEY (`id_lekcji`) REFERENCES `lekcja` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
