<%@ Page Title="Artigos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ArticleList.aspx.cs" Inherits="Execution_of_Darkness_Wikia.Pages.Articles.ArticleList" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link href="~/Content/eod-characters.css" rel="stylesheet" />

    <div class="eod-page-hero">
        <div style="display:flex; justify-content:space-between; align-items:start; flex-wrap:wrap; gap:1rem;">
            <div>
                <h1>Artigos da Wiki</h1>
                <p>Explore o conhecimento sobre o universo de Execution of Darkness. Artigos sobre lore, eventos, sistemas de poder e muito mais.</p>
            </div>
            <asp:LoginView runat="server">
                <LoggedInTemplate>
                    <a href="ArticleEdit.aspx" class="eod-btn-main">Criar Novo Artigo</a>
                </LoggedInTemplate>
            </asp:LoginView>
        </div>

        <div class="eod-filter-grid" style="grid-template-columns: 1fr auto;">
            <asp:TextBox ID="txtSearch" runat="server" CssClass="eod-input" placeholder="Buscar artigos por título ou conteúdo..." />
            <asp:Button ID="btnSearch" runat="server" CssClass="eod-btn-main" Text="Buscar" OnClick="btnSearch_Click" />
        </div>
    </div>

    <div class="eod-character-grid">
        <asp:Repeater ID="rptArticles" runat="server">
            <ItemTemplate>
                <article class="eod-article-card">
                    <span class="eod-chip" runat="server" visible='<%# !string.IsNullOrWhiteSpace((string)Eval("Category")) %>'><%# Eval("Category") %></span>
                    <h3><%# Eval("Title") %></h3>
                    <p><%# Eval("Summary") %></p>
                    <div class="eod-article-card-footer">
                        <small>Atualizado em <%# Eval("UpdatedAt", "{0:dd/MM/yyyy}") %></small>
                        <a class="eod-link" href='<%# "ArticleView.aspx?id=" + Eval("Id") %>'>Ler artigo</a>
                    </div>
                </article>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <asp:Panel ID="pnlEmpty" runat="server" Visible="false" CssClass="eod-empty mt-3" style="text-align:center;">
        <h3>Nenhum artigo encontrado</h3>
        <p>Seja o primeiro a contribuir criando um novo artigo sobre o universo de Execution of Darkness.</p>
        <asp:LoginView runat="server">
            <LoggedInTemplate>
                <a href="ArticleEdit.aspx" class="eod-btn-main" style="display:inline-block; margin-top:.5rem;">Criar Primeiro Artigo</a>
            </LoggedInTemplate>
            <AnonymousTemplate>
                <a href="/Account/Login.aspx" class="eod-btn-alt" style="display:inline-block; margin-top:.5rem;">Faça Login para Contribuir</a>
            </AnonymousTemplate>
        </asp:LoginView>
    </asp:Panel>
</asp:Content>
