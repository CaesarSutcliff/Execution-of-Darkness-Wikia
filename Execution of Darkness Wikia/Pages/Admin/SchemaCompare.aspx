<%@ Page Title="Schema Compare" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SchemaCompare.aspx.cs" Inherits="Execution_of_Darkness_Wikia.Pages.Admin.SchemaCompare" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link href="~/Content/eod-characters.css" rel="stylesheet" />

    <div class="eod-page-hero">
        <h1>Schema Compare</h1>
        <p>Compara a estrutura esperada pela aplicação com o banco de dados atual usando INFORMATION_SCHEMA. Permite aplicar scripts de upgrade, sincronizar automaticamente e gerenciar usuários administradores.</p>
    </div>

    <div class="eod-character-grid" style="grid-template-columns: repeat(3, 1fr); margin-bottom: 1.5rem;">
        <div class="eod-details-section" style="text-align:center;">
            <h3 style="color:var(--eod-accent-2);">Tabelas Esperadas</h3>
            <div style="font-size:2.5rem; font-weight:900;"><asp:Literal ID="litExpectedTables" runat="server" /></div>
        </div>
        <div class="eod-details-section" style="text-align:center;">
            <h3 style="color:var(--eod-accent-2);">Tabelas no Banco</h3>
            <div style="font-size:2.5rem; font-weight:900;"><asp:Literal ID="litActualTables" runat="server" /></div>
        </div>
        <div class="eod-details-section" style="text-align:center;">
            <h3 style="color:#f0ca7d;">Diferenças</h3>
            <div style="font-size:2.5rem; font-weight:900; color:#f0ca7d;"><asp:Literal ID="litDifferenceCount" runat="server" /></div>
        </div>
    </div>

    <asp:Panel ID="pnlOk" runat="server" Visible="false" CssClass="eod-details-section" style="border-color: rgba(100,200,100,.3);">
        <h3 style="color:#7ddf7d;">Banco sincronizado</h3>
        <p>Nenhuma divergência encontrada entre a estrutura esperada e o banco atual.</p>
    </asp:Panel>

    <%-- Resultado de operações --%>
    <asp:Panel ID="pnlResult" runat="server" Visible="false" CssClass="eod-details-section mb-3">
        <asp:Label ID="lblUpgradeResult" runat="server" style="white-space:pre-wrap;"></asp:Label>
    </asp:Panel>

    <%-- Ações principais — sempre visível --%>
    <div class="eod-details-section mb-3">
        <h3>Ações de Banco</h3>
        <p style="color:var(--eod-muted); margin-bottom:1rem;">Use os botões abaixo para criar, atualizar ou sincronizar o banco de dados.</p>
        <div style="display:flex; gap:.75rem; flex-wrap:wrap; align-items:center;">
            <asp:Button ID="btnFullSync" runat="server" Text="⚡ Sincronizar Tudo" CssClass="eod-btn-main" OnClick="btnFullSync_Click"
                OnClientClick="return confirm('Isso vai executar todos os scripts de upgrade em sequência. Continuar?');" />
            <asp:Button ID="btnCreateDatabase" runat="server" Text="Criar Banco do Zero" CssClass="eod-btn-main" style="background:linear-gradient(135deg,#8a1f35,#c43353);" OnClick="btnCreateDatabase_Click"
                OnClientClick="return confirm('ATENÇÃO: Isso vai DROPAR e RECRIAR todas as tabelas. Todos os dados serão perdidos. Continuar?');" />
            <asp:Button ID="btnApplyUpgrade" runat="server" Text="Aplicar Upgrade (11)" CssClass="eod-btn-alt" OnClick="btnApplyUpgrade_Click" />
            <asp:Button ID="btnGenerateScript" runat="server" Text="Gerar Script de Correção" CssClass="eod-btn-ghost" OnClick="btnGenerateScript_Click" />
        </div>
    </div>

    <%-- Criar usuário admin --%>
    <div class="eod-details-section mb-3">
        <h3>Criar Usuário Administrador</h3>
        <p style="color:var(--eod-muted); margin-bottom:1rem;">Crie ou atualize um usuário com permissão de administrador para acessar esta tela e gerenciar a wiki.</p>
        <div style="display:flex; gap:.75rem; align-items:end; flex-wrap:wrap;">
            <div>
                <label style="display:block; color:var(--eod-accent-2); font-weight:700; margin-bottom:.3rem; font-size:.85rem;">Usuário</label>
                <asp:TextBox ID="txtAdminUsername" runat="server" CssClass="eod-input" style="min-width:200px;" placeholder="Nome de usuário..." />
            </div>
            <div>
                <label style="display:block; color:var(--eod-accent-2); font-weight:700; margin-bottom:.3rem; font-size:.85rem;">Senha</label>
                <asp:TextBox ID="txtAdminPassword" runat="server" CssClass="eod-input" TextMode="Password" style="min-width:200px;" placeholder="Senha..." />
            </div>
            <asp:Button ID="btnCreateAdmin" runat="server" Text="Criar Admin" CssClass="eod-btn-alt" OnClick="btnCreateAdmin_Click" />
        </div>
        <asp:Label ID="lblAdminResult" runat="server" Visible="false" style="display:block; margin-top:.5rem;"></asp:Label>
    </div>

    <%-- Seletor de scripts --%>
    <div class="eod-details-section mb-3">
        <h3>Scripts Disponíveis</h3>
        <p style="color:var(--eod-muted);">Selecione um script SQL da pasta Database/Scripts para executar diretamente.</p>
        <div style="display:flex; gap:.75rem; align-items:center; flex-wrap:wrap;">
            <asp:DropDownList ID="ddlScripts" runat="server" CssClass="eod-select" style="max-width:400px;" />
            <asp:Button ID="btnRunScript" runat="server" Text="Executar Script" CssClass="eod-btn-alt" OnClick="btnRunScript_Click" />
        </div>
    </div>

    <%-- Grid de diferenças --%>
    <asp:Panel ID="pnlGrid" runat="server" Visible="false">
        <div class="eod-details-section">
            <h3>Diferenças Encontradas</h3>
            <div style="overflow-x:auto;">
                <asp:GridView ID="gvSchemaDiffs" runat="server" AutoGenerateColumns="false"
                    CssClass="table table-striped eod-schema-grid">
                    <Columns>
                        <asp:BoundField DataField="Type" HeaderText="Tipo" />
                        <asp:BoundField DataField="TableName" HeaderText="Tabela" />
                        <asp:BoundField DataField="ColumnName" HeaderText="Coluna" />
                        <asp:BoundField DataField="Expected" HeaderText="Esperado" />
                        <asp:BoundField DataField="Actual" HeaderText="Atual" />
                        <asp:BoundField DataField="Details" HeaderText="Detalhes" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </asp:Panel>

    <%-- Script gerado --%>
    <asp:Panel ID="pnlGeneratedScript" runat="server" Visible="false" CssClass="eod-details-section mt-3">
        <h3>Script de Correção Gerado</h3>
        <p style="color:var(--eod-muted);">Copie e execute este script no SQL Server Management Studio ou aplique diretamente.</p>
        <pre style="background:rgba(0,0,0,.4); border:1px solid rgba(255,255,255,.08); border-radius:14px; padding:1.2rem; color:#e0d8c8; overflow-x:auto; white-space:pre-wrap; font-size:.9rem;"><asp:Literal ID="litGeneratedScript" runat="server" /></pre>
    </asp:Panel>
</asp:Content>
