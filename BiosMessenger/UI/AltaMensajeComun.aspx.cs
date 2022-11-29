using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EntidadesCompartidas;
using Logica;

public partial class AltaMensajeComun : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                Session["TiposdeMensaje"] = FabricaLogica.GetLogicaTipodeMensaje().ListaTipos();
                ddlTiposMensaje.DataSource = Session["TiposdeMensaje"];
                ddlTiposMensaje.DataValueField = "Codigo";
                ddlTiposMensaje.DataTextField = "Nombre";
                ddlTiposMensaje.DataBind();
                LimpioPantalla();
            }
            catch (Exception ex)
            {
                lblMensaje.Text = ex.Message;
            }
        }        
    }
    protected void LimpioPantalla()
    {
        btnEnviar.Enabled = false;
        lblMensaje.Text = null;
        lblMensaje.CssClass = null;
        txtAsunto.Text = string.Empty;
        txtTextoMensaje.Text = string.Empty;
        txtUsuLogueo.Text = string.Empty;
        txtAsunto.Focus();
        grvReceptores.DataSource = null;
        grvReceptores.DataBind();
        List<Usuario> listaReceptores = new List<Usuario>();
        Session["ListaReceptores"] = listaReceptores;
    }
    protected void CargoGrilla()
    {
        grvReceptores.DataSource = Session["ListaReceptores"];
        grvReceptores.DataBind();
        btnEnviar.Enabled = true;
        grvReceptores.SelectedIndex = -1;
    }

    protected void btnEnviar_Click(object sender, EventArgs e)
    {
        try
        {
            List<Usuario> reciben = (List<Usuario>)Session["ListaReceptores"];
            int codigo = 1;
            string asunto = txtAsunto.Text.Trim();
            string textoMensaje = txtTextoMensaje.Text.Trim();
            DateTime fechaHora = DateTime.Now;
            TipodeMensaje tipoM = ((List<TipodeMensaje>)Session["TiposdeMensaje"])[ddlTiposMensaje.SelectedIndex];
            Usuario usuario = (Usuario)Session["UsuarioMP"];

            Comun mComun = new Comun(codigo, textoMensaje, asunto, fechaHora, usuario, tipoM, reciben);

            FabricaLogica.GetLogicaMensaje().AltaMensaje(mComun);            

            LimpioPantalla();

            lblMensaje.Text = "Mensaje enviado!";
            lblMensaje.CssClass = "alert alert-success";
        }
        catch (Exception ex)
        {
            lblMensaje.Text = ex.Message;
            lblMensaje.CssClass = "alert alert-warning";
        }
    }

    protected void grvReceptores_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            List<Usuario> reciben = (List<Usuario>)Session["ListaReceptores"];            
            Usuario usuario = ((List<Usuario>)Session["ListaReceptores"])[grvReceptores.SelectedIndex];
            reciben.Remove(usuario);
            CargoGrilla();

            if (reciben.Count == 0)
                btnEnviar.Enabled = false;

            lblMensaje.Text = null;
            lblMensaje.CssClass = null;
        }
        catch (Exception ex)
        {
            lblMensaje.Text = ex.Message;
            lblMensaje.CssClass = "alert alert-warning";
        }
    }

    protected void btnAgregarR_Click(object sender, EventArgs e)
    {
        try
        {            
            string logueo = txtUsuLogueo.Text.Trim();

            if (logueo != string.Empty)
            {
                List<Usuario> reciben = (List<Usuario>)Session["ListaReceptores"];
                Usuario usuario = FabricaLogica.GetLogicaUsuario().BuscarUsuarioActivo(logueo);

                if (usuario != null)
                {
                    reciben.Add(usuario);
                    CargoGrilla();
                    lblMensaje.Text = null;
                    lblMensaje.CssClass = null;
                }
                else
                {
                    lblMensaje.Text = "Usuario no encontrado en el sistema.";
                    lblMensaje.CssClass = "alert alert-warning";
                }
            }
            else
            {
                lblMensaje.Text = "Debe indicar un usuario de logueo.";
                lblMensaje.CssClass = "alert alert-warning";
            }
        }
        catch (Exception ex)
        {
            lblMensaje.Text = ex.Message;
            lblMensaje.CssClass = "alert alert-warning";
        }
    }

    protected void btnLimpiar_Click(object sender, EventArgs e)
    {
        LimpioPantalla();
    }
}