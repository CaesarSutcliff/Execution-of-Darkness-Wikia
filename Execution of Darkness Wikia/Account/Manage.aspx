<%@ Page Title="Minha Conta" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Manage.aspx.cs" Inherits="Execution_of_Darkness_Wikia.Account.Manage" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link href="~/Content/eod-characters.css" rel="stylesheet" />

    <div style="max-width:600px; margin:2rem auto;">
        <div class="eod-page-hero" style="text-align:center;">
            <h1>Minha Conta</h1>
            <p>Gerencie seus dados e acompanhe suas contribuições na wiki.</p>
        </div>

        <div class="eod-details-section">
            <h3>Dados do Perfil</h3>
            <div class="eod-meta-list">
                <div class="eod-meta-item">
                    <span>Usuário</span>
                    <span><asp:Literal ID="litUsername" runat="server" /></span>
                </div>
                <div class="eod-meta-item">
                    <span>Nome de Exibição</span>
                    <span><asp:Literal ID="litDisplayName" runat="server" /></span>
                </div>
                <div class="eod-meta-item">
                    <span>Email</span>
                    <span><asp:Literal ID="litEmail" runat="server" /></span>
                </div>
                <div class="eod-meta-item">
                    <span>Membro desde</span>
                    <span><asp:Literal ID="litMemberSince" runat="server" /></span>
                </div>
                <div class="eod-meta-item">
                    <span>Último login</span>
                    <span><asp:Literal ID="litLastLogin" runat="server" /></span>
                </div>
            </div>
        </div>

        <div class="eod-details-section">
            <h3>Ações Rápidas</h3>
            <div class="eod-detail-grid" style="grid-template-columns:1fr;">
                <div class="eod-detail-fact">
                    <a class="eod-link" href="/Pages/Articles/ArticleEdit.aspx">Criar novo artigo</a>
                </div>
                <div class="eod-detail-fact">
                    <a class="eod-link" href="/Pages/Articles/ArticleList.aspx">Ver meus artigos</a>
                </div>
                <div class="eod-detail-fact">
                    <a class="eod-link" href="/Help.aspx">Centro de ajuda</a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
