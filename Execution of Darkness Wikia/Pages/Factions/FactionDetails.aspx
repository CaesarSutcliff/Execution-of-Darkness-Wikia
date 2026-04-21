<%@ Page Title="Facção" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FactionDetails.aspx.cs" Inherits="Execution_of_Darkness_Wikia.Pages.Factions.FactionDetails" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link href="~/Content/eod-characters.css" rel="stylesheet" />

    <asp:Panel ID="pnlFaction" runat="server" Visible="false">
        <div class="eod-details-layout">
            <div class="eod-details-card">
                <div class="eod-details-banner"></div>
                <div class="eod-details-card-body">
                    <h1 class="eod-details-name"><asp:Literal ID="litName" runat="server" /></h1>
                    <div class="eod-details-sub"><asp:Literal ID="litMotto" runat="server" /></div>
                    <div class="eod-badge-row">
                        <asp:Literal ID="litAlignmentBadge" runat="server" />
                    </div>
                    <p class="eod-details-summary"><asp:Literal ID="litSummary" runat="server" /></p>

                    <div class="eod-detail-grid">
                        <div class="eod-detail-fact"><strong>Alinhamento</strong><asp:Literal ID="litFactAlignment" runat="server" /></div>
                        <div class="eod-detail-fact"><strong>Lema</strong><asp:Literal ID="litFactMotto" runat="server" /></div>
                    </div>
                </div>
            </div>

            <div>
                <div class="eod-details-section">
                    <h3>Descrição</h3>
                    <p><asp:Literal ID="litDescription" runat="server" /></p>
                </div>

                <div class="eod-details-section">
                    <h3>Membros</h3>
                    <asp:Panel ID="pnlNoMembers" runat="server" CssClass="eod-empty">
                        Nenhum membro registrado para esta facção.
                    </asp:Panel>
                    <ul class="eod-rel-list">
                        <asp:Repeater ID="rptMembers" runat="server">
                            <ItemTemplate>
                                <li>
                                    <span class="eod-rel-type"><%# string.IsNullOrWhiteSpace((string)Eval("RankTitle")) ? "Membro" : Eval("RankTitle") %></span>
                                    <div><a class="eod-link" href='<%# Eval("DetailUrl") %>'><%# Eval("Name") %></a></div>
                                    <small style="color:#b7b0a9;"><%# Eval("Summary") %></small>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
        </div>

        <div class="mt-3">
            <a class="eod-btn-alt" href="/Pages/Factions/FactionList.aspx">Voltar à lista de facções</a>
        </div>
    </asp:Panel>

    <asp:Panel ID="pnlNotFound" runat="server" Visible="false" CssClass="eod-empty">
        <h2>Facção não encontrada</h2>
        <p>A facção solicitada não existe ou foi removida.</p>
        <a class="eod-btn-alt" href="/Pages/Factions/FactionList.aspx">Ver todas as facções</a>
    </asp:Panel>
</asp:Content>
