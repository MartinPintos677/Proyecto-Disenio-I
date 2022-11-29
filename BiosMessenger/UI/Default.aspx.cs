using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Logica;
using EntidadesCompartidas;
using System.Xml;
using System.Xml.Linq;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["UsuarioMP"] = null;
        txtUsuario.Focus();

        if (!IsPostBack)
        {
            XmlNode _Documento = FabricaLogica.GetLogicaEstadisticas().Estadisticas();

            XElement _documento = XElement.Parse(_Documento.OuterXml);
            
            var usu = (from unU in _documento.Elements("Usuarios")
                       select unU.Value).First(); 

            var comun = (from unC in _documento.Elements("Comunes")
                         select unC.Value).First();

            var privado = (from unP in _documento.Elements("Privados")
                           select unP.Value).First();
            
            lblUsuarios.Text = "Usuarios Activos: ";
            lblUsu.Text = usu;
                        
            lblComun.Text = "Mensajes Comunes: ";
            lblComunes.Text = comun;
                        
            lblPrivados.Text = "Mensajes Privados: ";
            lblPri.Text = privado;
            
            List<object> tipos = (from unT in _documento.Elements("Tipos")
                                    select new
                                    {
                                        Tipo = unT.Attribute("TipoM").Value,
                                        Cantidad = unT.Value
                                    }
                                    ).ToList<object>();

            grvTiposM.DataSource = tipos;
            grvTiposM.DataBind();
        }
    }

    protected void btnEntrar_Click(object sender, EventArgs e)
    {
        try
        {
            string logueo = txtUsuario.Text.Trim();
            string pass = txtPass.Text.Trim();

            Usuario usuario = FabricaLogica.GetLogicaUsuario().Login(logueo, pass);

            if (usuario != null)
            {
                Session["UsuarioMP"] = usuario;
                Response.Redirect("~/BandejadeEntrada.aspx");
            }
            else
            {
                lblMensaje.Text = "Usuario y/o contraseña incorrectos.";
                lblMensaje.CssClass = "alert alert-danger";
            }
        }
        catch (Exception ex)
        {
            lblMensaje.Text = ex.Message;
            lblMensaje.CssClass = "alert alert-light";
        }
    }
}