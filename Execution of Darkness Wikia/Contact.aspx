<%@ Page Title="Contato" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Execution_of_Darkness_Wikia.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link href="~/Content/eod-characters.css" rel="stylesheet" />

    <div style="max-width:600px; margin:2rem auto;">
        <div class="eod-page-hero" style="text-align:center;">
            <h1>Contato</h1>
            <p>Tem sugestões, encontrou um erro ou quer contribuir de forma especial? Entre em contato.</p>
        </div>

        <div class="eod-details-section">
            <h3>Formas de Contato</h3>
            <div class="eod-detail-grid" style="grid-template-columns:1fr;">
                <div class="eod-detail-fact">
                    <strong>Comentários na Wiki</strong>
                    A forma mais rápida de se comunicar é deixar um comentário em qualquer artigo da wiki. Basta estar logado.
                </div>
                <div class="eod-detail-fact">
                    <strong>Contribuições</strong>
                    Para contribuir com conteúdo, <a class="eod-link" href="/Account/Register.aspx">crie uma conta</a> e comece a editar artigos ou criar novos.
                </div>
                <div class="eod-detail-fact">
                    <strong>Reportar Problemas</strong>
                    Se encontrou um bug ou problema técnico, use os comentários ou entre em contato diretamente com a equipe de desenvolvimento.
                </div>
            </div>
        </div>

        <div class="eod-details-section">
            <h3>Links Úteis</h3>
            <ul class="eod-rel-list">
                <li><a class="eod-link" href="/Help.aspx">Centro de Ajuda</a></li>
                <li><a class="eod-link" href="/About.aspx">Sobre a Wiki</a></li>
                <li><a class="eod-link" href="/Pages/Articles/ArticleList.aspx">Artigos</a></li>
            </ul>
        </div>
    </div>
</asp:Content>
