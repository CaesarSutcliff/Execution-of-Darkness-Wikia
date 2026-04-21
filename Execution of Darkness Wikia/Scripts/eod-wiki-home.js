document.addEventListener("DOMContentLoaded", function () {
    var searchInput = document.getElementById("wikiSearch");
    if (!searchInput) return;

    var cards = Array.prototype.slice.call(document.querySelectorAll("[data-searchable='true']"));

    function normalize(text) {
        return (text || "").toLowerCase().normalize("NFD").replace(/[\u0300-\u036f]/g, "");
    }

    function filterCards() {
        var term = normalize(searchInput.value);

        cards.forEach(function (card) {
            var haystack = normalize(card.getAttribute("data-keywords") + " " + card.innerText);
            var match = term.length === 0 || haystack.indexOf(term) >= 0;

            card.style.display = match ? "" : "none";
            card.classList.toggle("search-hit", term.length > 1 && match);
        });
    }

    searchInput.addEventListener("input", filterCards);

    // Botão de buscar personagens redireciona para a lista com o termo
    var btnSearchChars = document.getElementById("btnSearchHomeCharacters");
    if (btnSearchChars) {
        btnSearchChars.addEventListener("click", function () {
            var term = searchInput.value.trim();
            window.location.href = "/Pages/Characters/CharacterList.aspx?q=" + encodeURIComponent(term);
        });
    }

    // Enter no campo de busca também redireciona
    searchInput.addEventListener("keydown", function (e) {
        if (e.key === "Enter") {
            e.preventDefault();
            var term = searchInput.value.trim();
            if (term.length > 0) {
                window.location.href = "/Pages/Characters/CharacterList.aspx?q=" + encodeURIComponent(term);
            }
        }
    });
});
