<%@ Page Title="Editar Artigo" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ArticleEdit.aspx.cs" Inherits="Execution_of_Darkness_Wikia.Pages.Articles.ArticleEdit" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link href="~/Content/eod-characters.css" rel="stylesheet" />

    <div class="eod-page-hero" style="margin-bottom:1.5rem;">
        <h1><asp:Literal ID="litTitle" runat="server" Text="Editar Artigo" /></h1>
        <p>Use o editor abaixo para criar ou editar conteúdo da wiki. Lembre-se de descrever suas mudanças no resumo.</p>
    </div>

    <div class="eod-details-layout">
        <div>
            <asp:Panel ID="pnlEdit" runat="server">
                <div class="eod-details-section">
                    <h3>Conteúdo do Artigo</h3>
                    <div style="display:grid; gap:1rem;">
                        <div>
                            <label style="display:block; color:var(--eod-accent-2); font-weight:700; margin-bottom:.4rem;">Título</label>
                            <asp:TextBox ID="txtArticleTitle" runat="server" CssClass="eod-input" MaxLength="200" placeholder="Título do artigo..." />
                        </div>
                        <div>
                            <label style="display:block; color:var(--eod-accent-2); font-weight:700; margin-bottom:.4rem;">Resumo</label>
                            <asp:TextBox ID="txtSummary" runat="server" CssClass="eod-textarea" TextMode="MultiLine" Rows="3" MaxLength="500" placeholder="Resumo breve do artigo (máx. 500 caracteres)..." />
                        </div>
                        <div>
                            <label style="display:block; color:var(--eod-accent-2); font-weight:700; margin-bottom:.4rem;">Conteúdo</label>
                            <asp:TextBox ID="txtContent" runat="server" CssClass="eod-textarea" TextMode="MultiLine" Rows="18" placeholder="Escreva o conteúdo do artigo aqui..." />
                            <small style="color:#9f9aa2;">Use Markdown para formatação: **negrito**, *itálico*, # Título, [link](url)</small>
                        </div>
                        <div>
                            <label style="display:block; color:var(--eod-accent-2); font-weight:700; margin-bottom:.4rem;">Resumo da Mudança</label>
                            <asp:TextBox ID="txtChangeSummary" runat="server" CssClass="eod-input" MaxLength="500" placeholder="Descreva brevemente o que foi alterado..." />
                        </div>
                    </div>
                    <div style="margin-top:1.25rem; display:flex; gap:.75rem; flex-wrap:wrap; align-items:center;">
                        <asp:Button ID="btnSave" runat="server" Text="Salvar Artigo" CssClass="eod-btn-main" OnClick="btnSave_Click" />
                        <asp:Button ID="btnPreview" runat="server" Text="Visualizar" CssClass="eod-btn-alt" OnClick="btnPreview_Click" />
                        <a href="ArticleList.aspx" class="eod-btn-ghost">Cancelar</a>
                        <asp:Label ID="lblError" runat="server" style="color:#ff6b6b;" Visible="false"></asp:Label>
                    </div>
                </div>
            </asp:Panel>

            <asp:Panel ID="pnlPreview" runat="server" Visible="false">
                <div class="eod-article-view">
                    <span class="eod-eyebrow">Visualização Prévia</span>
                    <h1><asp:Literal ID="litPreviewTitle" runat="server" /></h1>
                    <p style="color:var(--eod-accent-2); font-style:italic;"><asp:Literal ID="litPreviewSummary" runat="server" /></p>
                    <div class="eod-article-content" style="margin-top:1rem;">
                        <asp:Literal ID="litPreviewContent" runat="server" />
                    </div>
                </div>
                <div style="margin-top:1rem;">
                    <asp:Button ID="btnBackToEdit" runat="server" Text="Voltar à Edição" CssClass="eod-btn-main" OnClick="btnBackToEdit_Click" />
                </div>
            </asp:Panel>
        </div>

        <div>
            <div class="eod-details-section">
                <h3>Guia de Formatação</h3>
                <div class="eod-detail-grid" style="grid-template-columns:1fr;">
                    <div class="eod-detail-fact"><strong>Negrito</strong><code>**texto**</code></div>
                    <div class="eod-detail-fact"><strong>Itálico</strong><code>*texto*</code></div>
                    <div class="eod-detail-fact"><strong>Título</strong><code># Título</code></div>
                    <div class="eod-detail-fact"><strong>Subtítulo</strong><code>## Subtítulo</code></div>
                    <div class="eod-detail-fact"><strong>Link</strong><code>[texto](url)</code></div>
                    <div class="eod-detail-fact"><strong>Lista</strong><code>- Item</code></div>
                    <div class="eod-detail-fact"><strong>Riscado</strong><code>~~texto~~</code></div>
                </div>
            </div>

            <asp:Panel ID="pnlHistory" runat="server" CssClass="eod-details-section" Visible="false">
                <h3>Histórico de Versões</h3>
                <asp:Repeater ID="rptVersions" runat="server">
                    <ItemTemplate>
                        <div style="padding:.75rem 0; border-bottom:1px solid rgba(255,255,255,.06);">
                            <div style="display:flex; justify-content:space-between; align-items:center;">
                                <span class="eod-badge">v<%# Eval("VersionNumber") %></span>
                                <small style="color:#9f9aa2;"><%# Eval("CreatedAt", "{0:dd/MM/yyyy HH:mm}") %></small>
                            </div>
                            <div style="margin-top:.3rem; color:var(--eod-muted); font-size:.9rem;">
                                <%# Eval("AuthorName") ?? "Anônimo" %> — <%# Eval("ChangeSummary") %>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </asp:Panel>
        </div>
    </div>
</asp:Content>
