<%@ Page Title="Sobre" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="Execution_of_Darkness_Wikia.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link href="~/Content/eod-characters.css" rel="stylesheet" />

    <div class="eod-page-hero">
        <h1>Sobre a Wiki</h1>
        <p>Execution of Darkness Wikia é a base de conhecimento oficial do universo de dark fantasy criado na saga Execution of Darkness.</p>
    </div>

    <div class="eod-details-layout">
        <div>
            <div class="eod-details-section">
                <h3>O Universo</h3>
                <p>Execution of Darkness é uma saga de dark fantasy ambientada em Ostium e arredores, onde demônios, trevas, hierarquia social, sangue nobre e degradação espiritual coexistem de forma brutal. A história acompanha Julian DeRose, um executor marcado por um pacto com Zerodawn Archworth, o Quarto Portão do Inferno.</p>
            </div>

            <div class="eod-details-section">
                <h3>A Wiki</h3>
                <p>Esta wiki foi criada para documentar e organizar todo o conhecimento sobre o universo da saga. Aqui você encontra informações sobre personagens, facções, locais, eventos, artefatos, poderes e toda a mitologia da obra.</p>
                <p>A wiki é colaborativa — qualquer usuário registrado pode contribuir com artigos, edições e comentários. Todas as edições são versionadas e rastreáveis.</p>
            </div>

            <div class="eod-details-section">
                <h3>Funcionalidades</h3>
                <div class="eod-detail-grid">
                    <div class="eod-detail-fact"><strong>Artigos</strong>Crie e edite artigos sobre qualquer aspecto do universo</div>
                    <div class="eod-detail-fact"><strong>Versionamento</strong>Histórico completo de todas as edições</div>
                    <div class="eod-detail-fact"><strong>Comentários</strong>Discussões organizadas em threads por artigo</div>
                    <div class="eod-detail-fact"><strong>Personagens</strong>Fichas detalhadas com relações e metadados</div>
                    <div class="eod-detail-fact"><strong>Facções</strong>Ordens, casas e grupos com membros vinculados</div>
                    <div class="eod-detail-fact"><strong>Linha do Tempo</strong>Eventos cronológicos filtráveis por era</div>
                </div>
            </div>
        </div>

        <div>
            <div class="eod-details-section">
                <h3>Como Contribuir</h3>
                <ol style="color:var(--eod-muted); line-height:2.2; padding-left:1.2rem;">
                    <li><a class="eod-link" href="/Account/Register.aspx">Crie sua conta</a></li>
                    <li>Explore o conteúdo existente</li>
                    <li>Edite artigos ou crie novos</li>
                    <li>Participe das discussões</li>
                </ol>
            </div>

            <div class="eod-details-section">
                <h3>Tecnologia</h3>
                <div class="eod-meta-list">
                    <div class="eod-meta-item"><span>Framework</span><span>ASP.NET WebForms 4.8</span></div>
                    <div class="eod-meta-item"><span>Banco de Dados</span><span>SQL Server</span></div>
                    <div class="eod-meta-item"><span>ORM</span><span>Entity Framework 6</span></div>
                    <div class="eod-meta-item"><span>Frontend</span><span>Bootstrap 5</span></div>
                    <div class="eod-meta-item"><span>Tema</span><span>Dark Fantasy Custom</span></div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
