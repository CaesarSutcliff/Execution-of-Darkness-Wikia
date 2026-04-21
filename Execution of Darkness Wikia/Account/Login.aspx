<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Execution_of_Darkness_Wikia.Account.Login" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link href="~/Content/eod-characters.css" rel="stylesheet" />

    <div style="max-width:480px; margin:2rem auto;">
        <div class="eod-details-section" style="padding:2rem;">
            <h2 style="font-weight:900; margin-bottom:.5rem;">Login</h2>
            <p style="color:var(--eod-muted); margin-bottom:1.5rem;">Entre na sua conta para contribuir com a wiki.</p>

            <asp:Panel ID="pnlLogin" runat="server" DefaultButton="btnLogin">
                <div style="display:grid; gap:1rem;">
                    <div>
                        <label style="display:block; color:var(--eod-accent-2); font-weight:700; margin-bottom:.4rem;">Usuário ou Email</label>
                        <asp:TextBox ID="txtUsername" runat="server" CssClass="eod-input" required="required" placeholder="Seu nome de usuário ou email..." />
                    </div>
                    <div>
                        <label style="display:block; color:var(--eod-accent-2); font-weight:700; margin-bottom:.4rem;">Senha</label>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="eod-input" required="required" placeholder="Sua senha..." />
                    </div>
                </div>
                <div style="margin-top:1.25rem;">
                    <asp:Button ID="btnLogin" runat="server" Text="Entrar" CssClass="eod-btn-main" style="width:100%;" OnClick="btnLogin_Click" />
                    <asp:Label ID="lblError" runat="server" style="color:#ff6b6b; display:block; margin-top:.5rem;" Visible="false"></asp:Label>
                </div>
            </asp:Panel>
            <div style="margin-top:1.25rem; text-align:center;">
                <a class="eod-link" href="Register.aspx">Não tem conta? Registre-se</a>
            </div>
        </div>
    </div>
</asp:Content>
