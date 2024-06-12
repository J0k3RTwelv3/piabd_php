{
    function weryfikujHaslo() {
        /**@type {string} */
        const poczatkoweHaslo = document.getElementById("haslo").value;

        /**@type {HTMLInputElement} */
        const polePowtorzHaslo = document.getElementById("haslo2");

        /**@type {HTMLButtonElement} */
        const przyciskPrzeslij = document.getElementById("przyciskPrzeslij");

        if(polePowtorzHaslo.value.length === 0) {
            polePowtorzHaslo.classList.remove("nieprawidlowe");
            polePowtorzHaslo.classList.remove("prawidlowe");
            przyciskPrzeslij.disabled = true;
        } else if(polePowtorzHaslo.value === poczatkoweHaslo) {
            polePowtorzHaslo.classList.remove("nieprawidlowe");
            polePowtorzHaslo.classList.add("prawidlowe");
            przyciskPrzeslij.disabled = false;
        } else {
            polePowtorzHaslo.classList.remove("prawidlowe");
            polePowtorzHaslo.classList.add("nieprawidlowe");
            przyciskPrzeslij.disabled = true;
        }
    }
}