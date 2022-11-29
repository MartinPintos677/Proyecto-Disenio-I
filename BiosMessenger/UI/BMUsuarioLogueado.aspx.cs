using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Logica;
using EntidadesCompartidas;

public partial class BMUsuarioLogueado : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            Limpiar();
    }

    private void Limpiar()
    {
        Usuario usuario = (Usuario)Session["UsuarioMP"];

        txtNombre.Text = usuario.Nombre;
        txtApellido.Text = usuario.Apellido;
        txtPass.Text = usuario.Contrasena;
        txtMail.Text = usuario.Mail;
        txtPass.Focus();
    }
    protected void btnModificar_Click(object sender, EventArgs e)
    {
        try
        {
            Usuario usuario = (Usuario)Session["UsuarioMP"];

            usuario.Nombre = txtNombre.Text.Trim();
            usuario.Apellido = txtApellido.Text.Trim();
            usuario.Contrasena = txtPass.Text.Trim();
            usuario.Mail = txtMail.Text.Trim();

            FabricaLogica.GetLogicaUsuario().UsuarioModificar(usuario);

            Limpiar();
            lblMensaje.Text = "Modificación correcta.";
            lblMensaje.CssClass = "alert alert-success";
        }
        catch (Exception ex)
        {
            lblMensaje.Text = ex.Message;
            lblMensaje.CssClass = "alert alert-warning";
        }
    }

    protected void btnEliminar_Click(object sender, EventArgs e)
    {
        try
        {
            Usuario usuario = (Usuario)Session["UsuarioMP"];

            FabricaLogica.GetLogicaUsuario().UsuarioBaja(usuario);

            Response.Redirect("~/Default.aspx");
        }
        catch (Exception ex)
        {
            lblMensaje.Text = ex.Message;
            lblMensaje.CssClass = "alert alert-warning";
        }
    }
}