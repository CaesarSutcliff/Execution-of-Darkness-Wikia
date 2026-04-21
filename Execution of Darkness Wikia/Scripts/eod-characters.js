document.addEventListener("DOMContentLoaded", function () {
    var homeSearch = document.getElementById("wikiSearch");
    var homeSearchBtn = document.getElementById("btnSearchHomeCharacters");

    function goToCharacterSearch() {
        if (!homeSearchBtn) return;
        var term = homeSearch ? encodeURIComponent(homeSearch.value || "") : "";
        window.location.href = "/Pages/Characters/CharacterList.aspx?q=" + term;
    }

    if (homeSearchBtn) {
        homeSearchBtn.addEventListener("click", goToCharacterSearch);
    }

    if (homeSearch) {
        homeSearch.addEventListener("keydown", function (e) {
            if (e.key === "Enter") {
                e.preventDefault();
                goToCharacterSearch();
            }
        });
    }
});
