<%@ Page Title="Ficha de Personagem" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CharacterDetails.aspx.cs" Inherits="Execution_of_Darkness_Wikia.Pages.Characters.CharacterDetails" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link href="~/Content/eod-characters.css" rel="stylesheet" />

    <asp:Panel ID="pnlNotFound" runat="server" Visible="false" CssClass="eod-empty">
        <h2>Personagem não encontrado</h2>
        <p>O personagem solicitado não existe ou foi removido.</p>
        <a class="eod-btn-alt" href="/Pages/Characters/CharacterList.aspx">Ver todos os personagens</a>
    </asp:Panel>

    <asp:Panel ID="pnlCharacter" runat="server" Visible="false">

        <%-- Layout estilo Wiki: conteúdo à esquerda, infobox à direita --%>
        <div class="wiki-article-layout">

            <%-- Conteúdo principal --%>
            <div class="wiki-article-content">

                <h1 class="wiki-article-title"><asp:Literal ID="litName" runat="server" /></h1>

                <%-- Citação --%>
                <asp:Panel ID="pnlQuote" runat="server" CssClass="wiki-quote">
                    <div class="wiki-quote-text">"<asp:Literal ID="litQuote" runat="server" />"</div>
                    <div class="wiki-quote-author">— <asp:Literal ID="litQuoteAuthor" runat="server" /></div>
                </asp:Panel>

                <%-- Resumo --%>
                <p class="wiki-lead"><asp:Literal ID="litSummary" runat="server" /></p>

                <%-- Seções de conteúdo --%>
                <asp:Panel ID="pnlBiography" runat="server" CssClass="wiki-section">
                    <h2 class="wiki-section-title">Biografia</h2>
                    <div class="wiki-section-body"><asp:Literal ID="litBiography" runat="server" /></div>
                </asp:Panel>

                <asp:Panel ID="pnlPersonality" runat="server" CssClass="wiki-section">
                    <h2 class="wiki-section-title">Personalidade</h2>
                    <div class="wiki-section-body"><asp:Literal ID="litPersonality" runat="server" /></div>
                </asp:Panel>

                <asp:Panel ID="pnlAppearance" runat="server" CssClass="wiki-section">
                    <h2 class="wiki-section-title">Aparência</h2>
                    <div class="wiki-section-body"><asp:Literal ID="litAppearance" runat="server" /></div>
                </asp:Panel>

                <asp:Panel ID="pnlAbilities" runat="server" CssClass="wiki-section">
                    <h2 class="wiki-section-title">Habilidades e Poderes</h2>
                    <div class="wiki-section-body"><asp:Literal ID="litAbilities" runat="server" /></div>
                </asp:Panel>

                <%-- Relacionamentos --%>
                <div class="wiki-section">
                    <h2 class="wiki-section-title">Relacionamentos</h2>
                    <asp:Panel ID="pnlNoRelationships" runat="server" Visible="false">
                        <p style="color:var(--eod-muted);">Nenhum relacionamento registrado para este personagem.</p>
                    </asp:Panel>
                    <asp:Repeater ID="rptRelationships" runat="server">
                        <HeaderTemplate><div class="wiki-rel-grid"></HeaderTemplate>
                        <ItemTemplate>
                            <div class="wiki-rel-card">
                                <span class="wiki-rel-type"><%# Eval("RelationshipType") %></span>
                                <a class="wiki-rel-name" href="<%# Eval("DetailUrl") %>"><%# Eval("RelatedCharacterName") %></a>
                                <div class="wiki-rel-summary"><%# Eval("Summary") %></div>
                            </div>
                        </ItemTemplate>
                        <FooterTemplate></div></FooterTemplate>
                    </asp:Repeater>
                </div>
            </div>

            <%-- Infobox lateral (estilo wiki) --%>
            <aside class="wiki-infobox">
                <div class="wiki-infobox-header">
                    <asp:Literal ID="litInfoboxName" runat="server" />
                </div>
                <div class="wiki-infobox-image">
                    <div class="wiki-infobox-placeholder"></div>
                </div>

                <div class="wiki-infobox-section-title">Informações biográficas</div>
                <table class="wiki-infobox-table">
                    <tr><td class="wiki-ib-label">Nome completo</td><td class="wiki-ib-value"><asp:Literal ID="litFactName" runat="server" /></td></tr>
                    <tr><td class="wiki-ib-label">Alcunha</td><td class="wiki-ib-value"><asp:Literal ID="litFactAlias" runat="server" /></td></tr>
                    <tr><td class="wiki-ib-label">Raça</td><td class="wiki-ib-value"><asp:Literal ID="litFactRace" runat="server" /></td></tr>
                    <tr><td class="wiki-ib-label">Gênero</td><td class="wiki-ib-value"><asp:Literal ID="litFactGender" runat="server" /></td></tr>
                    <tr><td class="wiki-ib-label">Origem</td><td class="wiki-ib-value"><asp:Literal ID="litFactBirthPlace" runat="server" /></td></tr>
                    <tr><td class="wiki-ib-label">Residência</td><td class="wiki-ib-value"><asp:Literal ID="litFactResidence" runat="server" /></td></tr>
                </table>

                <div class="wiki-infobox-section-title">Informações de afiliação</div>
                <table class="wiki-infobox-table">
                    <tr><td class="wiki-ib-label">Status</td><td class="wiki-ib-value"><asp:Literal ID="litFactStatus" runat="server" /></td></tr>
                    <tr><td class="wiki-ib-label">Facção</td><td class="wiki-ib-value"><asp:Literal ID="litFactFaction" runat="server" /></td></tr>
                    <tr><td class="wiki-ib-label">Clã</td><td class="wiki-ib-value"><asp:Literal ID="litFactClan" runat="server" /></td></tr>
                    <tr><td class="wiki-ib-label">Cargo / Rank</td><td class="wiki-ib-value"><asp:Literal ID="litFactRank" runat="server" /></td></tr>
                    <tr><td class="wiki-ib-label">Local atual</td><td class="wiki-ib-value"><asp:Literal ID="litFactLocation" runat="server" /></td></tr>
                    <tr><td class="wiki-ib-label">Primeira aparição</td><td class="wiki-ib-value"><asp:Literal ID="litFactFirstAppearance" runat="server" /></td></tr>
                </table>
            </aside>
        </div>

        <div style="margin-top:1.5rem;">
            <a class="eod-btn-alt" href="/Pages/Characters/CharacterList.aspx">← Voltar à lista de personagens</a>
        </div>
    </asp:Panel>
</asp:Content>
