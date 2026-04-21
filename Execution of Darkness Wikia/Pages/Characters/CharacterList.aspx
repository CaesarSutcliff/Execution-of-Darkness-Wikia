<%@ Page Title="Personagens" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CharacterList.aspx.cs" Inherits="Execution_of_Darkness_Wikia.Pages.Characters.CharacterList" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="MainContent" runat="server">
    <link href="~/Content/eod-characters.css" rel="stylesheet" />
    <section class="eod-page-hero">
        <h1>Personagens</h1>
        <p>
            Navegue pelos perfis da saga com busca, filtros e fichas conectadas ao banco de dados.
            A home também usa esta mesma base para destacar os personagens principais.
        </p>

        <div class="eod-filter-grid">
            <asp:TextBox ID="txtQuery" runat="server" CssClass="eod-input" placeholder="Buscar por nome, alcunha, clã, cargo..." />
            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="eod-select" />
            <asp:DropDownList ID="ddlFaction" runat="server" CssClass="eod-select" />
            <asp:Button ID="btnSearch" runat="server" CssClass="eod-btn-main" Text="Buscar" OnClick="btnSearch_Click" />
            <asp:Button ID="btnClear" runat="server" CssClass="eod-btn-ghost" Text="Limpar" OnClick="btnClear_Click" CausesValidation="false" />
        </div>
    </section>

    <asp:Panel ID="pnlEmpty" runat="server" Visible="false" CssClass="eod-empty">
        Nenhum personagem encontrado com os filtros atuais.
    </asp:Panel>

    <div class="eod-character-grid">
        <asp:Repeater ID="rptCharacters" runat="server">
            <ItemTemplate>
                <article class="eod-character-card">
                    <div class="eod-character-banner"></div>
                    <div class="eod-character-body">
                        <div class="eod-character-name"><%# Eval("Name") %></div>
                        <div class="eod-character-alias"><%# string.IsNullOrWhiteSpace(Eval("Alias") as string) ? "Sem alcunha registrada" : Eval("Alias") %></div>

                        <div class="eod-badge-row">
                            <%# string.IsNullOrWhiteSpace(Eval("StatusText") as string) ? "" : "<span class='eod-badge'>" + Eval("StatusText") + "</span>" %>
                            <%# string.IsNullOrWhiteSpace(Eval("RankTitle") as string) ? "" : "<span class='eod-badge'>" + Eval("RankTitle") + "</span>" %>
                            <%# string.IsNullOrWhiteSpace(Eval("FactionName") as string) ? "" : "<span class='eod-badge'>" + Eval("FactionName") + "</span>" %>
                        </div>

                        <div class="eod-meta-list">
                            <div class="eod-meta-item"><span>Clã</span><span><%# Eval("Clan") ?? "-" %></span></div>
                            <div class="eod-meta-item"><span>Facção</span><span><%# Eval("FactionName") ?? "-" %></span></div>
                            <div class="eod-meta-item"><span>Local</span><span><%# Eval("LocationName") ?? "-" %></span></div>
                        </div>

                        <div class="eod-character-summary"><%# Eval("Summary") %></div>
                        <a class="eod-btn-main" href="<%# Eval("DetailUrl") %>">Abrir ficha completa</a>
                    </div>
                </article>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>
