<%@ Page Title="Locais" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LocationList.aspx.cs" Inherits="Execution_of_Darkness_Wikia.Pages.Locations.LocationList" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link href="~/Content/eod-characters.css" rel="stylesheet" />

    <div class="eod-page-hero">
        <h1>Locais do Universo</h1>
        <p>Cidades, ruínas, acadêmias, mansões, pântanos e fortalezas que compõem a geografia sombria de Execution of Darkness.</p>

        <div class="eod-filter-grid" style="grid-template-columns: 1fr 1fr auto auto;">
            <asp:TextBox ID="txtQuery" runat="server" CssClass="eod-input" placeholder="Buscar local por nome, região ou descrição..." />
            <asp:DropDownList ID="ddlRegion" runat="server" CssClass="eod-select" />
            <asp:Button ID="btnSearch" runat="server" CssClass="eod-btn-main" Text="Buscar" OnClick="btnSearch_Click" />
            <asp:Button ID="btnClear" runat="server" CssClass="eod-btn-ghost" Text="Limpar" OnClick="btnClear_Click" />
        </div>
    </div>

    <div class="eod-character-grid">
        <asp:Repeater ID="rptLocations" runat="server">
            <ItemTemplate>
                <article class="eod-character-card">
                    <div class="eod-character-banner"></div>
                    <div class="eod-character-body">
                        <div class="eod-character-name"><%# Eval("Name") %></div>
                        <div class="eod-character-alias"><%# string.IsNullOrWhiteSpace((string)Eval("Region")) ? "Região desconhecida" : Eval("Region") %></div>
                        <div class="eod-badge-row">
                            <span class="eod-badge" runat="server" visible='<%# !string.IsNullOrWhiteSpace((string)Eval("DangerLevel")) %>'><%# Eval("DangerLevel") %></span>
                        </div>
                        <div class="eod-meta-list">
                            <div class="eod-meta-item">
                                <span>Residentes conhecidos</span>
                                <span><%# Eval("ResidentCount") %></span>
                            </div>
                        </div>
                        <p class="eod-character-summary"><%# Eval("Summary") %></p>
                        <a class="eod-link" href='<%# Eval("DetailUrl") %>'>Explorar local</a>
                    </div>
                </article>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <asp:Panel ID="pnlEmpty" runat="server" Visible="false" CssClass="eod-empty mt-3">
        <p>Nenhum local encontrado. Os locais serão exibidos aqui conforme forem cadastrados no banco de dados.</p>
    </asp:Panel>
</asp:Content>
