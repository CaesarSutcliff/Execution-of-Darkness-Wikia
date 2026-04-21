<%@ Page Title="Local" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LocationDetails.aspx.cs" Inherits="Execution_of_Darkness_Wikia.Pages.Locations.LocationDetails" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link href="~/Content/eod-characters.css" rel="stylesheet" />

    <asp:Panel ID="pnlLocation" runat="server" Visible="false">
        <div class="eod-details-layout">
            <div class="eod-details-card">
                <div class="eod-details-banner"></div>
                <div class="eod-details-card-body">
                    <h1 class="eod-details-name"><asp:Literal ID="litName" runat="server" /></h1>
                    <div class="eod-details-sub"><asp:Literal ID="litRegion" runat="server" /></div>
                    <div class="eod-badge-row">
                        <asp:Literal ID="litDangerBadge" runat="server" />
                    </div>
                    <p class="eod-details-summary"><asp:Literal ID="litSummary" runat="server" /></p>

                    <div class="eod-detail-grid">
                        <div class="eod-detail-fact"><strong>Região</strong><asp:Literal ID="litFactRegion" runat="server" /></div>
                        <div class="eod-detail-fact"><strong>Nível de Perigo</strong><asp:Literal ID="litFactDanger" runat="server" /></div>
                    </div>
                </div>
            </div>

            <div>
                <div class="eod-details-section">
                    <h3>Descrição</h3>
                    <p><asp:Literal ID="litDescription" runat="server" /></p>
                </div>

                <div class="eod-details-section">
                    <h3>Residentes Conhecidos</h3>
                    <asp:Panel ID="pnlNoResidents" runat="server" CssClass="eod-empty">
                        Nenhum residente registrado para este local.
                    </asp:Panel>
                    <ul class="eod-rel-list">
                        <asp:Repeater ID="rptResidents" runat="server">
                            <ItemTemplate>
                                <li>
                                    <span class="eod-rel-type"><%# string.IsNullOrWhiteSpace((string)Eval("RankTitle")) ? "Residente" : Eval("RankTitle") %></span>
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
            <a class="eod-btn-alt" href="/Pages/Locations/LocationList.aspx">Voltar à lista de locais</a>
        </div>
    </asp:Panel>

    <asp:Panel ID="pnlNotFound" runat="server" Visible="false" CssClass="eod-empty">
        <h2>Local não encontrado</h2>
        <p>O local solicitado não existe ou foi removido.</p>
        <a class="eod-btn-alt" href="/Pages/Locations/LocationList.aspx">Ver todos os locais</a>
    </asp:Panel>
</asp:Content>
