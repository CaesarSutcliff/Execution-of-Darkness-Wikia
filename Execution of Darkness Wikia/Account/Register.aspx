<%@ Page Title="Registro" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Execution_of_Darkness_Wikia.Account.Register" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link href="~/Content/eod-characters.css" rel="stylesheet" />

    <div style="max-width:480px; margin:2rem auto;">
        <div class="eod-details-section" style="padding:2rem;">
            <h2 style="font-weight:900; margin-bottom:.5rem;">Criar Conta</h2>
            <p style="color:var(--eod-muted); margin-bottom:1.5rem;">Registre-se para contribuir com artigos, comentários e conteúdo da wiki.</p>

            <asp:Panel ID="pnlRegister" runat="server" DefaultButton="btnRegister">
                <div style="display:grid; gap:1rem;">
                    <div>
                        <label style="display:block; color:var(--eod-accent-2); font-weight:700; margin-bottom:.4rem;">Nome de Usuário</label>
                        <asp:TextBox ID="txtUsername" runat="server" CssClass="eod-input" required="required" placeholder="Escolha um nome de usuário..." />
                    </div>
                    <div>
                        <label style="display:block; color:var(--eod-accent-2); font-weight:700; margin-bottom:.4rem;">Email</label>
                        <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="eod-input" required="required" placeholder="Seu email..." />
                    </div>
                    <div>
                        <label style="display:block; color:var(--eod-accent-2); font-weight:700; margin-bottom:.4rem;">Nome de Exibição (opcional)</label>
                        <asp:TextBox ID="txtDisplayName" runat="server" CssClass="eod-input" placeholder="Como você quer ser chamado na wiki..." />
                    </div>
                    <div>
                        <label style="display:block; color:var(--eod-accent-2); font-weight:700; margin-bottom:.4rem;">Senha</label>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="eod-input" required="required" placeholder="Crie uma senha segura..." />
                    </div>
                    <div>
                        <label style="display:block; color:var(--eod-accent-2); font-weight:700; margin-bottom:.4rem;">Confirmar Senha</label>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="eod-input" required="required" placeholder="Repita a senha..." />
                    </div>
                </div>
                <div style="margin-top:1.25rem;">
                    <asp:Button ID="btnRegister" runat="server" Text="Criar Conta" CssClass="eod-btn-main" style="width:100%;" OnClick="btnRegister_Click" />
                    <asp:Label ID="lblError" runat="server" style="color:#ff6b6b; display:block; margin-top:.5rem;" Visible="false"></asp:Label>
                </div>
            </asp:Panel>
            <div style="margin-top:1.25rem; text-align:center;">
                <a class="eod-link" href="Login.aspx">Já tem conta? Faça login</a>
            </div>
        </div>
    </div>
</asp:Content>
