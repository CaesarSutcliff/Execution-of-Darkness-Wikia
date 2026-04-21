<%@ Page Title="Artigo" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ArticleView.aspx.cs" Inherits="Execution_of_Darkness_Wikia.Pages.Articles.ArticleView" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link href="~/Content/eod-characters.css" rel="stylesheet" />

    <div class="eod-details-layout">
        <div>
            <div class="eod-article-view">
                <h1><asp:Literal ID="litArticleTitle" runat="server" /></h1>
                <p style="color:#9f9aa2; font-size:.9rem;"><asp:Literal ID="litArticleMeta" runat="server" /></p>
                <div class="eod-badge-row" style="margin-bottom:1rem;">
                    <asp:Literal ID="litCategoryBadge" runat="server" />
                </div>
                <div style="margin-bottom:1.5rem;">
                    <p style="color:var(--eod-accent-2); font-style:italic;"><asp:Literal ID="litArticleSummary" runat="server" /></p>
                </div>
                <div class="eod-article-content">
                    <asp:Literal ID="litArticleContent" runat="server" Mode="PassThrough" />
                </div>

                <div style="margin-top:1.5rem; display:flex; gap:.75rem; flex-wrap:wrap;">
                    <asp:LoginView runat="server">
                        <LoggedInTemplate>
                            <asp:HyperLink ID="hlEditArticle" runat="server" CssClass="eod-btn-main">Editar Artigo</asp:HyperLink>
                        </LoggedInTemplate>
                        <AnonymousTemplate>
                            <a href="/Account/Login.aspx" class="eod-btn-alt">Faça login para editar</a>
                        </AnonymousTemplate>
                    </asp:LoginView>
                    <a class="eod-btn-ghost" href="ArticleList.aspx">Voltar à lista</a>
                </div>
            </div>

            <div class="eod-comment-section">
                <h3 style="margin-bottom:1rem;">Comentários e Discussão</h3>

                <asp:LoginView runat="server">
                    <AnonymousTemplate>
                        <div class="eod-empty" style="margin-bottom:1rem;">
                            <a class="eod-link" href="/Account/Login.aspx">Faça login</a> para participar da discussão.
                        </div>
                    </AnonymousTemplate>
                    <LoggedInTemplate>
                        <asp:Button ID="btnShowCommentForm" runat="server" Text="Escrever Comentário" CssClass="eod-btn-alt" style="margin-bottom:1rem;" OnClick="btnShowCommentForm_Click" />
                    </LoggedInTemplate>
                </asp:LoginView>

                <asp:Panel ID="pnlCommentForm" runat="server" Visible="false" style="margin-bottom:1rem;">
                    <asp:TextBox ID="txtComment" runat="server" TextMode="MultiLine" CssClass="eod-textarea" Rows="4" placeholder="Escreva seu comentário sobre este artigo..."></asp:TextBox>
                    <div style="margin-top:.75rem; display:flex; gap:.5rem; align-items:center;">
                        <asp:Button ID="btnSaveComment" runat="server" Text="Enviar Comentário" CssClass="eod-btn-main" OnClick="btnSaveComment_Click" />
                        <asp:Label ID="lblCommentError" runat="server" style="color:#ff6b6b;" Visible="false"></asp:Label>
                    </div>
                </asp:Panel>

                <asp:Repeater ID="rptComments" runat="server">
                    <ItemTemplate>
                        <div class="eod-comment-item" style="margin-left:<%# Eval("Indent") %>px;">
                            <div class="eod-comment-header">
                                <div>
                                    <span class="eod-comment-author"><%# Eval("UserName") %></span>
                                    <span class="eod-comment-date"> — <%# Eval("CreatedAt", "{0:dd/MM/yyyy HH:mm}") %></span>
                                </div>
                                <asp:LoginView runat="server">
                                    <LoggedInTemplate>
                                        <asp:Button ID="btnReply" runat="server" Text="Responder" CssClass="eod-btn-ghost" style="padding:.3rem .7rem; font-size:.8rem;" CommandName="Reply" CommandArgument='<%# Eval("Id") %>' OnCommand="CommentCommand" />
                                    </LoggedInTemplate>
                                </asp:LoginView>
                            </div>
                            <div class="eod-comment-body"><%# Eval("Content") %></div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>

        <div>
            <div class="eod-details-section">
                <h3>Informações do Artigo</h3>
                <div class="eod-meta-list">
                    <div class="eod-meta-item">
                        <span>Título</span>
                        <span><asp:Literal ID="litInfoTitle" runat="server" /></span>
                    </div>
                    <div class="eod-meta-item">
                        <span>Última edição</span>
                        <span><asp:Literal ID="litInfoUpdated" runat="server" /></span>
                    </div>
                    <div class="eod-meta-item">
                        <span>Versões</span>
                        <span><asp:Literal ID="litInfoVersions" runat="server" /></span>
                    </div>
                </div>
            </div>

            <div class="eod-details-section">
                <h3>Navegação</h3>
                <ul class="eod-rel-list">
                    <li>
                        <asp:LoginView runat="server">
                            <LoggedInTemplate>
                                <asp:HyperLink ID="hlEditSideLink" runat="server" CssClass="eod-link">Editar este artigo</asp:HyperLink>
                            </LoggedInTemplate>
                            <AnonymousTemplate>
                                <a class="eod-link" href="/Account/Login.aspx">Faça login para editar</a>
                            </AnonymousTemplate>
                        </asp:LoginView>
                    </li>
                    <li><a class="eod-link" href="ArticleList.aspx">Lista de artigos</a></li>
                    <li><a class="eod-link" href="/Help.aspx">Guia de edição</a></li>
                </ul>
            </div>
        </div>
    </div>
</asp:Content>
