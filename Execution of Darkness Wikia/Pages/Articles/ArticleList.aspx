<%@ Page Title="Artigos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ArticleList.aspx.cs" Inherits="Execution_of_Darkness_Wikia.Pages.Articles.ArticleList" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="py-4">
        <div class="mb-4">
            <h1 class="display-6">Artigos</h1>
            <p class="text-muted">Página base inicial da wiki. O próximo passo é plugar listagem real via Entity Framework.</p>
        </div>
        <div class="alert alert-secondary">
            Estrutura criada com sucesso. Aqui você pode evoluir para GridView, filtros, busca, cadastro e edição.
        </div>
    </div>
</asp:Content>
