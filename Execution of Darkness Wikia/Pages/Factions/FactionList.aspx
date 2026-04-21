<%@ Page Title="Facções" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FactionList.aspx.cs" Inherits="Execution_of_Darkness_Wikia.Pages.Factions.FactionList" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link href="~/Content/eod-characters.css" rel="stylesheet" />

    <div class="eod-page-hero">
        <h1>Facções e Ordens</h1>
        <p>Casas nobres, ordens militares, alianças secretas e núcleos de poder que moldam o destino de Ostium e seus habitantes.</p>

        <div class="eod-filter-grid" style="grid-template-columns: 1fr auto auto;">
            <asp:TextBox ID="txtQuery" runat="server" CssClass="eod-input" placeholder="Buscar facção por nome, lema ou descrição..." />
            <asp:Button ID="btnSearch" runat="server" CssClass="eod-btn-main" Text="Buscar" OnClick="btnSearch_Click" />
            <asp:Button ID="btnClear" runat="server" CssClass="eod-btn-ghost" Text="Limpar" OnClick="btnClear_Click" />
        </div>
    </div>

    <div class="eod-character-grid">
        <asp:Repeater ID="rptFactions" runat="server">
            <ItemTemplate>
                <article class="eod-character-card">
                    <div class="eod-character-banner"></div>
                    <div class="eod-character-body">
                        <div class="eod-character-name"><%# Eval("Name") %></div>
                        <div class="eod-character-alias"><%# string.IsNullOrWhiteSpace((string)Eval("Motto")) ? "Sem lema registrado" : Eval("Motto") %></div>
                        <div class="eod-badge-row">
                            <span class="eod-badge" runat="server" visible='<%# !string.IsNullOrWhiteSpace((string)Eval("Alignment")) %>'><%# Eval("Alignment") %></span>
                        </div>
                        <div class="eod-meta-list">
                            <div class="eod-meta-item">
                                <span>Membros conhecidos</span>
                                <span><%# Eval("MemberCount") %></span>
                            </div>
                        </div>
                        <p class="eod-character-summary"><%# Eval("Summary") %></p>
                        <a class="eod-link" href='<%# Eval("DetailUrl") %>'>Ver detalhes</a>
                    </div>
                </article>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <asp:Panel ID="pnlEmpty" runat="server" Visible="false" CssClass="eod-empty mt-3">
        <p>Nenhuma facção encontrada. As facções serão exibidas aqui conforme forem cadastradas no banco de dados.</p>
    </asp:Panel>
</asp:Content>
