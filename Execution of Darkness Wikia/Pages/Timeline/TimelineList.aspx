<%@ Page Title="Linha do Tempo" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TimelineList.aspx.cs" Inherits="Execution_of_Darkness_Wikia.Pages.Timeline.TimelineList" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link href="~/Content/eod-characters.css" rel="stylesheet" />

    <div class="eod-page-hero">
        <h1>Linha do Tempo</h1>
        <p>A cronologia dos eventos que moldaram o universo de Execution of Darkness, desde as eras antigas até os conflitos atuais.</p>

        <div class="eod-filter-grid" style="grid-template-columns: 1fr 1fr 1fr auto auto;">
            <asp:TextBox ID="txtQuery" runat="server" CssClass="eod-input" placeholder="Buscar evento..." />
            <asp:DropDownList ID="ddlEra" runat="server" CssClass="eod-select" />
            <asp:DropDownList ID="ddlImportance" runat="server" CssClass="eod-select" />
            <asp:Button ID="btnSearch" runat="server" CssClass="eod-btn-main" Text="Buscar" OnClick="btnSearch_Click" />
            <asp:Button ID="btnClear" runat="server" CssClass="eod-btn-ghost" Text="Limpar" OnClick="btnClear_Click" />
        </div>
    </div>

    <div class="eod-timeline-container">
        <asp:Repeater ID="rptEvents" runat="server">
            <ItemTemplate>
                <div class="eod-timeline-card">
                    <div class="eod-timeline-card-header">
                        <div class="eod-timeline-dot"></div>
                        <div class="eod-timeline-era"><%# string.IsNullOrWhiteSpace((string)Eval("Era")) ? "Era desconhecida" : Eval("Era") %></div>
                        <span class="eod-badge" runat="server" visible='<%# !string.IsNullOrWhiteSpace((string)Eval("ImportanceLevel")) %>'><%# Eval("ImportanceLevel") %></span>
                    </div>
                    <h3 class="eod-timeline-card-title"><%# Eval("Title") %></h3>
                    <p class="eod-timeline-card-summary"><%# Eval("Summary") %></p>
                    <p class="eod-timeline-card-desc" runat="server" visible='<%# !string.IsNullOrWhiteSpace((string)Eval("Description")) %>'><%# Eval("Description") %></p>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <asp:Panel ID="pnlEmpty" runat="server" Visible="false" CssClass="eod-empty mt-3">
        <p>Nenhum evento encontrado na linha do tempo. Os eventos serão exibidos aqui conforme forem cadastrados no banco de dados.</p>
    </asp:Panel>
</asp:Content>
