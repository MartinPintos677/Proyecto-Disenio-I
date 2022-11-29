<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AltaUsuario.aspx.cs" Inherits="AltaUsuario" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="Content/bootstrap.css" rel="stylesheet"/> 
    <script src="Scripts/bootstrap.min.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Alta Usuario</title>
    <style type="text/css">
        body{
            background-color: black;
            font-family: sans-serif;
            font: sans-serif;
        }
        .auto-style1 {
            width: 167px;
            height: 168px;
        }
        .auto-style2 {
            width: 613px;
        }
        .auto-style8 {
        height: 34px;
        font-size: 33px;
        color: ghostwhite;
        text-shadow: 1px 1px #000000;
        text-decoration: underline;
        text-align: center;
        }
        .auto-style9 {
            width: 613px;
            text-align: right;
            color: #FFFFFF;
            background-color: #000000;
        }
        .auto-style10 {
            width: 613px;
            text-align: right;
        }
        .auto-style11 {
            color: #FFFFFF;
            background-color: #000000;
        }
        .auto-style12 {
            width: 613px;
            text-align: left;
        }
        </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table style="width:100%;">
                <tr>
                    <td class="auto-style2">&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style2">&nbsp;</td>
                    <td>
                        <img alt="logo" class="auto-style1" longdesc="logo" src="img/logo%20rojo.jpg" /><img alt="messenger" class="auto-style1" longdesc="messenger" src="img/messenger%20logo.png" /></td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style2">&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style8" colspan="3">Registro de Usuario</td>
                </tr>
                <tr>
                    <td class="auto-style2">&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style9">Usuario de Logueo: </td>
                    <td>
                        &nbsp;<asp:TextBox ID="txtLogueo" runat="server" MaxLength="8" Width="216px" Placeholder="(8 caracteres)"></asp:TextBox>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style2">&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style10">&nbsp; <span class="auto-style11">Contraseña:</span></td>
                    <td>
                        &nbsp;<asp:TextBox ID="txtPass" runat="server" MaxLength="6" TextMode="Password" Width="216px" Placeholder="(5 letras y 1 número al final)"></asp:TextBox>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style2">&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style10"><span class="auto-style11">Nombre:</span></td>
                    <td>
                        &nbsp;<asp:TextBox ID="txtNombre" runat="server" MaxLength="50" Width="216px" Placeholder="Nombre"></asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnRegistrar" runat="server" CssClass="btn btn-primary" OnClick="btnRegistrar_Click" Text="Registrar" />
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style2">&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style10"><span class="auto-style11">Apellido:</span></td>
                    <td>
                        &nbsp;<asp:TextBox ID="txtApellido" runat="server" MaxLength="50" Width="216px" Placeholder="Apellido"></asp:TextBox>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style10">&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style10"><span class="auto-style11">Mail:</span></td>
                    <td>
                        &nbsp;<asp:TextBox ID="txtMail" runat="server" MaxLength="50" Width="216px" Placeholder="Mail"></asp:TextBox>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style10">&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style12">&nbsp;</td>
                    <td>
                        <asp:Label ID="lblMensaje" runat="server"></asp:Label>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style12">&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style12">&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style12">
                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Default.aspx">Volver a inicio</asp:HyperLink>
                    </td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style12">&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style12">&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
