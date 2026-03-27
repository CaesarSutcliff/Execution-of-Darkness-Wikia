<%@ Page Title="Execution of Darkness Wikia" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Execution_of_Darkness_Wikia._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main class="py-4">
        <section class="p-4 p-md-5 mb-4 rounded-3 bg-dark text-white">
            <div class="container-fluid py-3">
                <h1 class="display-5 fw-bold">Execution of Darkness Wikia</h1>
                <p class="col-md-9 fs-5">
                    Base inicial da wiki web de Execution of Darkness, preparada em ASP.NET WebForms + Entity Framework 6
                    para organizar lore, personagens, facções, locais e linha do tempo.
                </p>
                <p class="mb-0">
                    <a class="btn btn-outline-light btn-lg" href="~/Pages/Admin/SchemaCompare.aspx" runat="server">Abrir Schema Compare</a>
                </p>
            </div>
        </section>

        <div class="row g-4">
            <div class="col-md-6 col-lg-4">
                <div class="card h-100 shadow-sm">
                    <div class="card-body">
                        <h2 class="h4">Personagens</h2>
                        <p>Cadastre perfis completos, alianças, status, primeira aparição e biografia.</p>
                        <a class="btn btn-dark" href="~/Pages/Characters/CharacterList.aspx" runat="server">Abrir</a>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-4">
                <div class="card h-100 shadow-sm">
                    <div class="card-body">
                        <h2 class="h4">Facções</h2>
                        <p>Organize ordens, grupos, matilhas, alianças e vínculos de poder.</p>
                        <a class="btn btn-dark" href="~/Pages/Factions/FactionList.aspx" runat="server">Abrir</a>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-4">
                <div class="card h-100 shadow-sm">
                    <div class="card-body">
                        <h2 class="h4">Locais</h2>
                        <p>Documente cidades, reinos, fortalezas, ruínas, academias e regiões marcantes.</p>
                        <a class="btn btn-dark" href="~/Pages/Locations/LocationList.aspx" runat="server">Abrir</a>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-4">
                <div class="card h-100 shadow-sm">
                    <div class="card-body">
                        <h2 class="h4">Linha do Tempo</h2>
                        <p>Estruture eventos, eras, marcos históricos e acontecimentos principais da saga.</p>
                        <a class="btn btn-dark" href="~/Pages/Timeline/TimelineList.aspx" runat="server">Abrir</a>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-4">
                <div class="card h-100 shadow-sm">
                    <div class="card-body">
                        <h2 class="h4">Artigos</h2>
                        <p>Centralize páginas de lore geral, conceitos, itens, entidades e resumos do universo.</p>
                        <a class="btn btn-dark" href="~/Pages/Articles/ArticleList.aspx" runat="server">Abrir</a>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-4">
                <div class="card h-100 shadow-sm border-warning">
                    <div class="card-body">
                        <h2 class="h4">Administração</h2>
                        <p>Valide a estrutura do banco com o comparador de schema antes de evoluir a aplicação.</p>
                        <a class="btn btn-warning" href="~/Pages/Admin/SchemaCompare.aspx" runat="server">Comparar schema</a>
                    </div>
                </div>
            </div>
        </div>
    </main>
</asp:Content>
