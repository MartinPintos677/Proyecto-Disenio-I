<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="AltaMensajePrivado.aspx.cs" Inherits="AltaMensajePrivado" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        body{
            background-color: whitesmoke;
        }
        .styleUsuario{
            height: 34px;
            width: 374px;
            font-size: 33px;
            color: #1C5E55;
            text-shadow: 1px 1px #000000;
            text-align: center;
            text-decoration: underline;
        }
        .auto-style13 {
        font-weight: normal;
    }
    .auto-style14 {
        height: 24px;
        text-decoration: underline;
            text-align: left;
            color: #1C5E55;
        }
        .auto-style15 {
            height: 24px;
            text-align: center;
            width: 922px;
        }
        .auto-style16 {
            width: 922px;
        }
        .auto-style17 {
            text-align: right;
            width: 922px;
        }
        .auto-style18 {
            text-align: center;
            text-decoration: underline;
        }
        .auto-style19 {
            font-weight: normal;
            margin-left: 60;
        }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width:100%;">
        <tr>
            <td colspan="3" class="styleUsuario">Alta Mensaje Privado</td>
        </tr>
        <tr>
            <td class="auto-style16">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="text-center" colspan="3"><strong>Fecha de caducidad de mensaje(debe tener más de 24h a partir de la fecha actual): </strong><strong class="auto-style13"><asp:TextBox ID="txtFCaducidad" runat="server" Placeholder="dd/mm/aaaa" TextMode="DateTime"></asp:TextBox>
                </strong></td>
        </tr>
        <tr>
            <td class="auto-style16">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="text-center" colspan="3"><strong>Asunto: </strong><asp:TextBox ID="txtAsunto" runat="server" Width="1068px" MaxLength="30"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style16">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style18" colspan="3"><strong>Mensaje:</strong></td>
        </tr>
        <tr>
            <td class="text-center" colspan="3"><strong>
                <asp:TextBox ID="txtTextoMensaje" runat="server" CssClass="auto-style19" Height="184px" Width="1132px" TextMode="MultiLine"></asp:TextBox>
                </strong></td>
        </tr>
        <tr>
            <td class="auto-style16">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style15"><strong>Digite el&nbsp;Usuario que desea agregar a la lista de receptores: <asp:TextBox ID="txtUsuLogueo" runat="server" Width="186px" MaxLength="8"></asp:TextBox>
                <asp:Button ID="btnAgregarR" runat="server" CssClass="btn btn-dark" OnClick="btnAgregarR_Click" Text="Agregar" />
                </strong></td>
            <td class="auto-style14" colspan="2"><strong>LISTADO DE RECEPTORES:</strong></td>
        </tr>
        <tr>
            <td class="auto-style17">
                <asp:Button ID="btnEnviar" runat="server" CssClass="btn btn-success" OnClick="btnEnviar_Click" Text="Enviar Mensaje" />
                <asp:Button ID="btnLimpiar" runat="server" CssClass="btn btn-light" OnClick="btnLimpiar_Click" Text="Limpiar Página" BackColor="White" BorderColor="Black" BorderStyle="Ridge" BorderWidth="1px" ForeColor="Black" />
                </td>
            <td class="text-center" colspan="2">
                <asp:GridView ID="grvReceptores" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" OnSelectedIndexChanged="grvReceptores_SelectedIndexChanged" GridLines="None">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="UsuarioLogueo" HeaderText="Usuario de Logueo" />
                        <asp:BoundField DataField="NombreCompleto" HeaderText="Nombre" />
                        <asp:CommandField SelectText="Eliminar" ShowSelectButton="True" />
                    </Columns>
                    <EditRowStyle BackColor="#7C6F57" />
                    <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#E3EAEB" />
                    <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#F8FAFA" />
                    <SortedAscendingHeaderStyle BackColor="#246B61" />
                    <SortedDescendingCellStyle BackColor="#D4DFE1" />
                    <SortedDescendingHeaderStyle BackColor="#15524A" />
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td class="auto-style16">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="text-center" colspan="3">
                <asp:Label ID="lblMensaje" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
</asp:Content>

