<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <script src="Scripts/bootstrap.min.js"></script>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Default</title>
    <style type="text/css">
        body {
            background-color: black;
            font-family: sans-serif;
            font: sans-serif;
        }

        .auto-style1 {
            width: 167px;
            height: 169px;
        }

        .auto-style3 {
            width: 613px;
        }

        .auto-style4 {
            color: #FFFFFF;
            background-color: #000000;
        }

        .auto-style7 {
            text-align: center;
        }

        .auto-style8 {
            height: 34px;
            width: 374px;
            font-size: 33px;
            color: ghostwhite;
            text-shadow: 1px 1px #000000;
            text-decoration: underline;
            text-align: center;
        }

        .auto-style9 {
            width: 30px;
            height: 30px;
            float: right;
        }

        .auto-style10 {
            width: 613px;
            height: 34px;
        }

        .auto-style11 {
            height: 34px;
        }

        .auto-style12 {
            color: #FFFFFF;
            background-color: #000000;
            font-size: medium;
        }

        .auto-style14 {
            width: 613px;
            height: 25px;
        }

        .auto-style15 {
            height: 25px;
        }

        .auto-style16 {
            height: 25px;
            text-align: center;
        }

        .auto-style18 {
            font-size: 16px;
        }

        .auto-style19 {
            height: 24px;
            text-align: center;
            width: 580px;
        }

        .auto-style20 {
            color: #2ECC71;
            background-color: #000000;
            font-size: 25px;
        }

        .auto-style21 {
            margin-left: 0px;
        }

        .auto-style22 {
            height: 24px;
            text-align: center;
            width: 218px;
        }

        .auto-style23 {
            height: 24px;
            text-align: center;
            width: 469px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table style="width: 100%;">
                <tr>
                    <td class="auto-style3">&nbsp;</td>
                    <td colspan="2">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style3">&nbsp;</td>
                    <td colspan="2">
                        <img alt="logo" class="auto-style1" longdesc="logo" src="img/logo%20rojo.jpg" /><img alt="messenger" class="auto-style1" longdesc="messenger" src="img/messenger%20logo.png" /></td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style3">&nbsp;</td>
                    <td colspan="2">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style8" colspan="4"><span class="auto-style8"><span class="auto-style8">¡Bienvenidos</span><span class="auto-style8"> a BiosMessenger!</span></span></td>
                </tr>
                <tr>
                    <td class="auto-style3">&nbsp;</td>
                    <td colspan="2">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style7" colspan="4"><span class="auto-style4">Para ingresar al sitio ingrese su usuario, contraseña y haga click en &quot;Entrar&quot;, si no está ingresado en el sistema y desea darse de alta click en
                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/AltaUsuario.aspx">Registro de Usuario</asp:HyperLink>
                        .</span></td>
                </tr>
                <tr>
                    <td class="auto-style3">&nbsp;</td>
                    <td colspan="2">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style10">
                        <img alt="usu" class="auto-style9" longdesc="usu" src="img/icons8-online-support-30.png" /></td>
                    <td class="auto-style11" colspan="2">
                        <asp:TextBox ID="txtUsuario" runat="server" Width="216px" Placeholder="Usuario" Height="28px" MaxLength="8"></asp:TextBox>
                    </td>
                    <td class="auto-style11"></td>
                </tr>
                <tr>
                    <td class="auto-style3">&nbsp;</td>
                    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnEntrar" runat="server" Text="Entrar" CssClass="btn btn-primary" OnClick="btnEntrar_Click" />
                        &nbsp;&nbsp;&nbsp;
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style3">
                        <img alt="pass" class="auto-style9" longdesc="pass" src="img/icons8-portrait-orientation-lock-30.png" /></td>
                    <td colspan="2">
                        <asp:TextBox ID="txtPass" runat="server" Width="216px" Placeholder="Contraseña" Height="29px" MaxLength="6" TextMode="Password"></asp:TextBox>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style3">&nbsp;</td>
                    <td colspan="2">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style3">&nbsp;</td>
                    <td colspan="2">
                        <asp:Label ID="lblMensaje" runat="server"></asp:Label>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style14"></td>
                    <td class="auto-style15" colspan="2"></td>
                    <td class="auto-style15"></td>
                </tr>
                <tr>
                    <td colspan="4" class="auto-style16">
                        <span class="auto-style20"><span class="text-decoration-underline">Estadísticas del Sitio</span><br class="text-decoration-underline" />
                        </span></td>
                </tr>
                <tr>
                    <td colspan="4" class="auto-style19">
                        <span class="auto-style12">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <strong>
                        <asp:Label ID="lblUsuarios" runat="server" CssClass="auto-style18" ForeColor="White"></asp:Label>
                            <asp:Label ID="lblUsu" runat="server" ForeColor="#2ECC71" CssClass="auto-style18"></asp:Label>
                            </strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <strong>
                        <asp:Label ID="lblComun" runat="server" CssClass="auto-style18"></asp:Label>
                            <asp:Label ID="lblComunes" runat="server" ForeColor="#2ECC71" CssClass="auto-style18"></asp:Label>
                            </strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <strong>
                        <asp:Label ID="lblPrivados" runat="server" CssClass="auto-style18" ForeColor="White"></asp:Label>
                            <asp:Label ID="lblPri" runat="server" ForeColor="#2ECC71" CssClass="auto-style18"></asp:Label>
                            </strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </span></td>
                </tr>
                <tr>
                    <td class="auto-style22">&nbsp;</td>
                    <td class="auto-style23">
                        <span class="auto-style12">
                            <asp:GridView ID="grvTiposM" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" CssClass="auto-style21" BorderColor="#666666" BorderWidth="3px">
                                <AlternatingRowStyle BackColor="black" Font-Bold="True" ForeColor="white"/>
                                <EditRowStyle BackColor="#7C6F57" />
                                <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle BackColor="black" Font-Bold="True" ForeColor="#2ECC71" />
                                <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                                <RowStyle BackColor="black" Font-Bold="True" ForeColor="white"/>
                                <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                                <SortedAscendingCellStyle BackColor="#F8FAFA" />
                                <SortedAscendingHeaderStyle BackColor="#246B61" />
                                <SortedDescendingCellStyle BackColor="#D4DFE1" />
                                <SortedDescendingHeaderStyle BackColor="#15524A" />
                            </asp:GridView>
                        </span></td>
                    <td colspan="2" class="auto-style19">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="4" class="auto-style19">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="4">&nbsp;</td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
