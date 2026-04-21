<%@ Page Title="Início" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Execution_of_Darkness_Wikia._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <section class="eod-hero">
            <span class="eod-eyebrow">Wiki Oficial do Universo</span>
            <h1 class="eod-title"><asp:Literal ID="litTitle" runat="server" /></h1>
            <p class="eod-subtitle"><asp:Literal ID="litSubtitle" runat="server" /></p>

            <div class="eod-search-wrap" style="grid-template-columns: 1fr auto auto;">
                <input id="wikiSearch" class="eod-search" type="text" placeholder="Buscar personagens, pactos, lugares, facções..." />
                <button type="button" id="btnSearchHomeCharacters" class="eod-btn-main">Buscar personagens</button>
                <a class="eod-btn-alt" runat="server" href="~/Pages/Articles/ArticleList.aspx">Explorar artigos</a>
            </div>

            <div class="eod-stat-grid">
                <div class="eod-stat">
                    <span class="label">Ordens centrais</span>
                    <span class="value">3</span>
                </div>
                <div class="eod-stat">
                    <span class="label">Portões do Inferno</span>
                    <span class="value">12</span>
                </div>
                <div class="eod-stat">
                    <span class="label">Eixos da wiki</span>
                    <span class="value">6</span>
                </div>
                <div class="eod-stat">
                    <span class="label">Modo</span>
                    <span class="value">Dark Fantasy</span>
                </div>
            </div>
        </section>

        <section class="eod-section">
            <div class="eod-section-head">
                <div>
                    <h2>Núcleo do universo</h2>
                    <p>Uma visão completa do mundo de Execution of Darkness: conflitos, sociedade, magia e os seres que habitam este universo sombrio.</p>
                </div>
                <a class="eod-btn-alt" runat="server" href="~/Pages/Admin/SchemaCompare.aspx">Validar banco</a>
            </div>

            <div class="eod-two-col">
                <div class="eod-highlight">
                    <h3>O mundo em uma visão só</h3>
                    <ul class="eod-list">
                        <li>
                            <span class="item-title">Ostium e arredores</span>
                            <span class="item-text">Fantasia sombria onde demônios, trevas, hierarquia social, sangue nobre e degradação espiritual coexistem de forma brutal.</span>
                        </li>
                        <li>
                            <span class="item-title">Ordens em paz tensa</span>
                            <span class="item-text">Executores, Paladinos e Imperiais não são só facções; eles moldam aparência, status, expectativa social e poder.</span>
                        </li>
                        <li>
                            <span class="item-title">Pacto como ruptura</span>
                            <span class="item-text">O elo entre Julian e Zerodawn transforma o protagonista em um ponto de colisão entre humanidade, caos e sobrevivência.</span>
                        </li>
                    </ul>
                </div>

                <div class="eod-section-box">
                    <h3 class="mb-3">Atalhos estratégicos</h3>
                    <div class="eod-mini-grid">
                        <div class="eod-mini-card">
                            <h4>Personagens</h4>
                            <p>Perfis, relações, facções, status, primeiras aparições e trajetória.</p>
                        </div>
                        <div class="eod-mini-card">
                            <h4>Facções</h4>
                            <p>Casas, ordens, grupos, alianças e núcleos de poder.</p>
                        </div>
                        <div class="eod-mini-card">
                            <h4>Locais</h4>
                            <p>Acadêmias, mansões, cidades, ruínas, pântanos e fortalezas.</p>
                        </div>
                        <div class="eod-mini-card">
                            <h4>Cronologia</h4>
                            <p>Eventos centrais, escalada do conflito e arcos por volume.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="eod-section">
            <div class="eod-section-head">
                <div>
                    <h2>Ordens e facções</h2>
                    <p>O equilíbrio violento do mundo passa por hierarquia, linhagem, prestígio e necessidade. Cada facção representa valores e poderes distintos na luta pela supremacia.</p>
                </div>
            </div>

            <div class="eod-card-grid">
                <asp:Repeater ID="rptFactions" runat="server">
                    <ItemTemplate>
                        <article class="eod-card" data-searchable="true" data-keywords="<%# Eval("Keywords") %>">
                            <span class="eod-chip"><%# Eval("Badge") %></span>
                            <h3><%# Eval("Title") %></h3>
                            <p><%# Eval("Description") %></p>
                            <a class="eod-link" href="<%# Eval("Url") %>">Explorar</a>
                        </article>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </section>

        <section class="eod-section">
            <div class="eod-section-head">
                <div>
                    <h2>Personagens em destaque</h2>
                    <p>Conheça os protagonistas e antagonistas que moldam o destino de Ostium. Cada personagem carrega segredos, motivações e conexões profundas com o universo.</p>
                </div>
                <a class="eod-btn-alt" runat="server" href="~/Pages/Characters/CharacterList.aspx">Ver todos</a>
            </div>

            <div class="eod-card-grid">
                <asp:Repeater ID="rptCharacters" runat="server">
                    <ItemTemplate>
                        <article class="eod-card" data-searchable="true" data-keywords="<%# Eval("Keywords") %>">
                            <span class="eod-chip"><%# Eval("Badge") %></span>
                            <h3><%# Eval("Title") %></h3>
                            <p><%# Eval("Description") %></p>
                            <a class="eod-link" href="<%# Eval("Url") %>">Abrir ficha</a>
                        </article>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </section>

        <section class="eod-section">
            <div class="eod-section-head">
                <div>
                    <h2>Locais importantes</h2>
                    <p>Do drama íntimo da Mansão DeRose até o horror cósmico das zonas corrompidas, explore os cenários que testemunham a queda e a redenção.</p>
                </div>
            </div>

            <div class="eod-card-grid">
                <asp:Repeater ID="rptLocations" runat="server">
                    <ItemTemplate>
                        <article class="eod-card" data-searchable="true" data-keywords="<%# Eval("Keywords") %>">
                            <span class="eod-chip"><%# Eval("Badge") %></span>
                            <h3><%# Eval("Title") %></h3>
                            <p><%# Eval("Description") %></p>
                            <a class="eod-link" href="<%# Eval("Url") %>">Explorar</a>
                        </article>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </section>

        <section class="eod-section">
            <div class="eod-two-col">
                <div class="eod-section-box">
                    <div class="eod-section-head">
                        <div>
                            <h2>Mitologia e sistema</h2>
                            <p>As estruturas que dão sustentação a todo o horror da obra.</p>
                        </div>
                    </div>

                    <div class="eod-card-grid" style="grid-template-columns: repeat(2, minmax(0, 1fr));">
                        <asp:Repeater ID="rptSystems" runat="server">
                            <ItemTemplate>
                                <article class="eod-card" data-searchable="true" data-keywords="<%# Eval("Keywords") %>">
                                    <span class="eod-chip"><%# Eval("Badge") %></span>
                                    <h3><%# Eval("Title") %></h3>
                                    <p><%# Eval("Description") %></p>
                                </article>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>

                <div class="eod-section-box">
                    <div class="eod-section-head">
                        <div>
                            <h2>Linha de força da saga</h2>
                            <p>Uma cronologia curta para orientar a home antes do aprofundamento por artigos.</p>
                        </div>
                    </div>

                    <div class="eod-timeline">
                        <asp:Repeater ID="rptTimeline" runat="server">
                            <ItemTemplate>
                                <div class="eod-timeline-item">
                                    <h4><%# Eval("Title") %></h4>
                                    <p><%# Eval("Description") %></p>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <script src="/Scripts/eod-wiki-home.js"></script>
</asp:Content>
