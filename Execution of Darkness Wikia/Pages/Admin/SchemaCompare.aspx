<%@ Page Title="Schema Compare" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SchemaCompare.aspx.cs" Inherits="Execution_of_Darkness_Wikia.Pages.Admin.SchemaCompare" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="py-4">
        <div class="mb-4">
            <h1 class="display-6">Schema Compare</h1>
            <p class="text-muted">
                Compara a estrutura esperada pela aplicação com o banco atual usando INFORMATION_SCHEMA.
            </p>
        </div>

        <div class="row g-3 mb-4">
            <div class="col-md-4">
                <div class="card border-dark">
                    <div class="card-body">
                        <div class="text-muted">Tabelas esperadas</div>
                        <div class="display-6"><asp:Literal ID="litExpectedTables" runat="server" /></div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card border-dark">
                    <div class="card-body">
                        <div class="text-muted">Tabelas encontradas</div>
                        <div class="display-6"><asp:Literal ID="litActualTables" runat="server" /></div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card border-warning">
                    <div class="card-body">
                        <div class="text-muted">Diferenças</div>
                        <div class="display-6"><asp:Literal ID="litDifferenceCount" runat="server" /></div>
                    </div>
                </div>
            </div>
        </div>

        <asp:Panel ID="pnlOk" runat="server" Visible="false" CssClass="alert alert-success">
            Nenhuma divergência encontrada entre a estrutura esperada e o banco atual.
        </asp:Panel>

        <asp:Panel ID="pnlGrid" runat="server" Visible="false">
            <asp:GridView ID="gvSchemaDiffs" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-bordered">
                <Columns>
                    <asp:BoundField DataField="Type" HeaderText="Tipo" />
                    <asp:BoundField DataField="TableName" HeaderText="Tabela" />
                    <asp:BoundField DataField="ColumnName" HeaderText="Coluna" />
                    <asp:BoundField DataField="Expected" HeaderText="Esperado" />
                    <asp:BoundField DataField="Actual" HeaderText="Atual" />
                    <asp:BoundField DataField="Details" HeaderText="Detalhes" />
                </Columns>
            </asp:GridView>
        </asp:Panel>
    </div>
</asp:Content>
