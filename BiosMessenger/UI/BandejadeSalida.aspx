<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="BandejadeSalida.aspx.cs" Inherits="BandejadeSalida" %>

<%@ Register src="UserControl/MensajesCompletos.ascx" tagname="MensajesCompletos" tagprefix="uc2" %>


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
            text-decoration: underline;
        }
        .style4
        {
            height: 172px;
        }
        .auto-style16 {
            width: 489px;
        }
        .auto-style17 {
            height: 63px;
        }
        .auto-style18 {
            height: 55px;
            width: 295px;
            font-size: 33px;
            color: #1C5E55;
            text-shadow: 1px 1px #000000;
            text-decoration: underline;
        }
        .auto-style21 {
            font-size: large;
        }
        .auto-style22 {
            color: #1C5E55;
            text-decoration: underline;
            font-size: x-large;
        }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width:100%;">
        <tr>
            <td colspan="4" class="auto-style17">
                <asp:Panel ID="Panel1" runat="server" BorderColor="Black" BorderWidth="2px" BackColor="White" Height="105px">
                    <div class="text-center">
                        <strong><span><span class="auto-style22">Filtro de los mensajes por tipo o fecha</span></span><span class="auto-style21"><br /> </span>
                        <br />
                        Mensaje:</strong>
                        <asp:RadioButton ID="rbtnComun" runat="server" Text="Común" GroupName="MComunPrivado" />
                        <asp:RadioButton ID="rbtnPrivado" runat="server" Text="Privado" GroupName="MComunPrivado" />
                        <asp:Button ID="btnPriComun" runat="server" CssClass="btn btn-success" Text="Enter" OnClick="btnPriComun_Click" />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>Tipo: </strong><asp:DropDownList ID="ddlTipos" runat="server" CssClass="btn btn-dark" Enabled="False">
                        </asp:DropDownList>
                        &nbsp;<asp:Button ID="btnTipoC" runat="server" CssClass="btn btn-success" Text="Enter" OnClick="btnTipoC_Click" />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>Fecha de envío: </strong><asp:TextBox ID="txtFecha" runat="server" Placeholder="dd/mm/aaaa" TextMode="DateTime"></asp:TextBox>
                        <asp:Button ID="btnFecha" runat="server" CssClass="btn btn-success" Text="Enter" OnClick="btnFecha_Click" />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnLimpiar" runat="server" CssClass="btn btn-light" Text="Limpiar Filtros" OnClick="btnLimpiar_Click" BorderColor="Black" BorderStyle="Groove" BorderWidth="2px" ForeColor="Black" />
                        <br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </div>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td colspan="3" class="style4"><br />
                <br />
                <div class="auto-style18">
                    Bandeja de Salida</div>
                <div class="text-center">
                <asp:GridView ID="grvEnviados" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="grvEnviados_SelectedIndexChanged" PageSize="8">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="FechaHora" HeaderText="Fecha" />
                        <asp:BoundField DataField="Asunto" HeaderText="Asunto" />
                        <asp:CommandField ShowSelectButton="True" />
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
                </div>
            </td>
            <td class="style4">
                <uc2:MensajesCompletos ID="MensajesCompletos1" runat="server" />
            </td>
        </tr>
        <tr>
            <td colspan="3" class="auto-style12">
                </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblMensaje" runat="server"></asp:Label>
            </td>
            <td>&nbsp;</td>
            <td class="auto-style16">&nbsp;</td>
        </tr>
    </table>
</asp:Content>

