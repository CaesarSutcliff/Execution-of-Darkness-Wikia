using System;
using System.Collections.Generic;
using Execution_of_Darkness_Wikia.ViewModels;

namespace Execution_of_Darkness_Wikia.Services
{
    public class HomePageService
    {
        public HomePageViewModel Get()
        {
            var vm = new HomePageViewModel
            {
                Title = "Execution of Darkness Wikia",
                Subtitle = "Uma base viva para navegar pela fantasia sombria de Ostium e arredores: personagens, ordens, portões, facções, lugares, artefatos, conspirações e a cronologia da saga."
            };

            vm.Factions.Add(new FeaturedCardViewModel
            {
                Title = "Executores",
                Badge = "Ordem",
                Description = "Clãs familiares como os DeRose e Terine, encarregados da proteção e da execução de ameaças. São necessários, mas vistos como inferiores na hierarquia social.",
                Keywords = "executores derose terine ordem execução final",
                Url = "/Pages/Factions/FactionList.aspx"
            });

            vm.Factions.Add(new FeaturedCardViewModel
            {
                Title = "Paladinos",
                Badge = "Aristocracia",
                Description = "Nobres como Makinden e Wallen, marcados por glória, tradição, prestígio político e obsessão por pureza e aparência.",
                Keywords = "paladinos makinden wallen honra glória",
                Url = "/Pages/Factions/FactionList.aspx"
            });

            vm.Factions.Add(new FeaturedCardViewModel
            {
                Title = "Imperiais",
                Badge = "Estado",
                Description = "Cavaleiros e agentes ligados à Coroa, mais protocolares, militares e leais ao poder institucional do reino.",
                Keywords = "imperiais dandelion coroa estado reino",
                Url = "/Pages/Factions/FactionList.aspx"
            });

            vm.Locations.Add(new FeaturedCardViewModel
            {
                Title = "Mansão DeRose",
                Badge = "Local-chave",
                Description = "Sede da família e centro do drama íntimo, das feridas familiares e da formação quebrada de Julian.",
                Keywords = "mansão derose família drama",
                Url = "/Pages/Locations/LocationList.aspx"
            });

            vm.Locations.Add(new FeaturedCardViewModel
            {
                Title = "Academia Lazarell",
                Badge = "Treinamento",
                Description = "Espaço onde jovens das três ordens são treinados e onde parte importante dos laços, rivalidades e humilhações nasce.",
                Keywords = "academia lazarell treino ordens",
                Url = "/Pages/Locations/LocationList.aspx"
            });

            vm.Locations.Add(new FeaturedCardViewModel
            {
                Title = "Ostium",
                Badge = "Centro do Reino",
                Description = "Cidade central onde comércio, conspirações, liturgia, metal e podridão política se entrelaçam como uma anatomia doente.",
                Keywords = "ostium capital cidade ferro liturgia",
                Url = "/Pages/Locations/LocationList.aspx"
            });

            vm.Locations.Add(new FeaturedCardViewModel
            {
                Title = "Pântano das Almas Perdidas",
                Badge = "Zona Hostil",
                Description = "Um ambiente corruptor e mentalmente hostil, associado ao Vínculo de Rosanera, criaturas perigosas e ruínas de poder antigo.",
                Keywords = "pântano almas perdidas rosanera gilderan",
                Url = "/Pages/Locations/LocationList.aspx"
            });

            vm.Locations.Add(new FeaturedCardViewModel
            {
                Title = "Releseares",
                Badge = "Fronteira",
                Description = "Vila decadente na borda do pântano, último sopro de civilização antes do mergulho no horror.",
                Keywords = "releseares fronteira decadência corvo ensopado",
                Url = "/Pages/Locations/LocationList.aspx"
            });

            vm.Locations.Add(new FeaturedCardViewModel
            {
                Title = "Catacumbas do Rei Morto",
                Badge = "Ruína Antiga",
                Description = "Complexo subterrâneo de pedra negra, runas, armaduras fantasmas e trono guardado por uma entidade antiga.",
                Keywords = "catacumbas rei morto gilderan",
                Url = "/Pages/Locations/LocationList.aspx"
            });

            vm.Systems.Add(new FeaturedCardViewModel
            {
                Title = "Aliança dos Três Caminhos",
                Badge = "Estrutura do Mundo",
                Description = "A paz tensa entre Executores, Paladinos e Imperiais define status, aparência, dever e conflito social.",
                Keywords = "aliança três caminhos executores paladinos imperiais"
            });

            vm.Systems.Add(new FeaturedCardViewModel
            {
                Title = "Os Doze Portões do Inferno",
                Badge = "Mitologia",
                Description = "Entidades primordiais, mais antigas e mais perigosas que demônios comuns, organizadas em hierarquia rígida e conflitos internos.",
                Keywords = "doze portões inferno mitologia zerodawn legião"
            });

            vm.Systems.Add(new FeaturedCardViewModel
            {
                Title = "Pactos",
                Badge = "Sistema de Poder",
                Description = "Humanos podem firmar pactos com entidades superiores, pagando um preço em troca de força, servidão ou transformação.",
                Keywords = "pactos poder fusão consciência"
            });

            vm.Systems.Add(new FeaturedCardViewModel
            {
                Title = "Artefatos",
                Badge = "Relíquias",
                Description = "Itens como a Espada Negra e o Vínculo de Rosanera funcionam como pivôs de poder, isca, memória e destruição.",
                Keywords = "artefatos espada negra vínculo de rosanera"
            });

            vm.Timeline.Add(new TimelineCardViewModel
            {
                Title = "Queda, humilhação e pacto",
                Description = "A jornada começa com Julian esmagado pelo próprio ambiente familiar e social, até tocar forças que quebram sua vida antiga."
            });

            vm.Timeline.Add(new TimelineCardViewModel
            {
                Title = "Nascimento da Brigada das Rosas Negras",
                Description = "Laços improváveis formam uma matilha funcional, onde inteligência, brutalidade, suporte e desvio viram sobrevivência."
            });

            vm.Timeline.Add(new TimelineCardViewModel
            {
                Title = "Conspirações de reino e Portões",
                Description = "A política da Coroa, casas nobres e entidades cósmicas se fundem num mesmo tabuleiro de guerra."
            });

            vm.Timeline.Add(new TimelineCardViewModel
            {
                Title = "Escalada para Ostium, Valachel e Xadir",
                Description = "A saga se expande em horror, intriga e liturgia profana, elevando o escopo do conflito e o preço do poder."
            });

            try
            {
                var characterService = new CharacterService();
                var featured = characterService.GetFeaturedCardsForHome(6);

                if (featured != null && featured.Count > 0)
                {
                    vm.FeaturedCharacters = featured;
                }
            }
            catch
            {
                vm.FeaturedCharacters = new List<FeaturedCardViewModel>
                {
                    new FeaturedCardViewModel
                    {
                        Title = "Julian DeRose",
                        Badge = "Protagonista",
                        Description = "Executor, aluno de Lazarell e líder da Brigada das Rosas Negras. Parte de um ponto de humilhação e sobrevivência para se tornar um lobo marcado pelo pacto.",
                        Keywords = "julian derose executor lobo zerodawn brigada rosas negras",
                        Url = "/Pages/Characters/CharacterDetails.aspx?slug=julian-derose"
                    },
                    new FeaturedCardViewModel
                    {
                        Title = "Zerodawn Archworth",
                        Badge = "Quarto Portão",
                        Description = "Entidade primordial ligada a Julian por pacto. Caótica, provocadora, letal e cada vez mais humana, torna-se parceira central da saga.",
                        Keywords = "zerodawn portão lua pacto caos espada negra",
                        Url = "/Pages/Characters/CharacterDetails.aspx?slug=zerodawn-archworth"
                    }
                };
            }

            return vm;
        }
    }
}
