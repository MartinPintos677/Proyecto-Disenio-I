using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Logica;
using EntidadesCompartidas;

public partial class AltaUsuario : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {       
        if (!IsPostBack)
            Limpiar();
    }

    private void Limpiar()
    {
        txtLogueo.Text = string.Empty;
        txtPass.Text = string.Empty;
        txtNombre.Text = string.Empty;
        txtApellido.Text = string.Empty;
        txtMail.Text = string.Empty;
        txtLogueo.Focus();
    }
    protected void btnRegistrar_Click(object sender, EventArgs e)
    {
        try
        {
            string logueo = txtLogueo.Text.Trim();
            string pass = txtPass.Text.Trim();
            string nombre = txtNombre.Text.Trim();
            string apellido = txtApellido.Text.Trim();
            string mail = txtMail.Text.Trim();

            Usuario usuario = new Usuario(logueo, pass, nombre, apellido, mail);

            FabricaLogica.GetLogicaUsuario().UsuarioAlta(usuario);

            Limpiar();
            lblMensaje.Text = "Usuario registrado exitosamente, vuelva a la página de inicio si desea loguearse.";
            lblMensaje.CssClass = "alert alert-primary";
        }
        catch (Exception ex)
        {
            lblMensaje.Text = ex.Message;
            lblMensaje.CssClass = "alert alert-danger";
        }
    }
}