<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MensajesCompletos.ascx.cs" Inherits="UserControl_MensajesCompletos" %>
<table style="width:100%;">
    <tr>
        <td>
            <asp:Label ID="lblCod" runat="server"></asp:Label>
&nbsp;<asp:Label ID="lblCodigo" runat="server" ForeColor="#1C5E55"></asp:Label>
        </td>
        <td rowspan="7">
<asp:GridView ID="grvReciben" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" GridLines="Horizontal">
    <Columns>
        <asp:BoundField DataField="UsuarioLogueo" HeaderText="Receptores    |  " />
        <asp:BoundField DataField="NombreCompleto" HeaderText="Nombres" />
    </Columns>
    <FooterStyle BackColor="White" ForeColor="#333333" />
    <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
    <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
    <RowStyle BackColor="White" ForeColor="#333333" />
    <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
    <SortedAscendingCellStyle BackColor="#F7F7F7" />
    <SortedAscendingHeaderStyle BackColor="#487575" />
    <SortedDescendingCellStyle BackColor="#E5E5E5" />
    <SortedDescendingHeaderStyle BackColor="#275353" />
</asp:GridView>

        </td>
    </tr>
    <tr>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;<asp:Label ID="lblFec" runat="server"></asp:Label>
&nbsp;<asp:Label ID="lblFecha" runat="server" ForeColor="#1C5E55"></asp:Label>
                </td>
    </tr>
    <tr>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;<asp:Label ID="lblAsu" runat="server"></asp:Label>
&nbsp;<asp:Label ID="lblAsunto" runat="server" ForeColor="#1C5E55"></asp:Label>
                </td>
    </tr>
    <tr>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;<asp:Label ID="lblTex" runat="server"></asp:Label>
&nbsp;<asp:Label ID="lblTexto" runat="server" ForeColor="#1C5E55"></asp:Label>
            </td>
    </tr>
</table>





