using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Logica;
using EntidadesCompartidas;

public partial class UserControl_MensajesCompletos : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public void CargoUC()
    {
        try
        {
            Mensaje mensaje = (Mensaje)Session["Mensaje"];

            if (mensaje != null)
            {
                lblCod.Text = "Código: ";
                lblFec.Text = "Fecha: ";
                lblAsu.Text = "Asunto: ";
                lblTex.Text = "Texto: ";
                    
                lblTexto.Text = mensaje.TextoMensaje;
                lblCodigo.Text = mensaje.Codigo.ToString();
                lblAsunto.Text = mensaje.Asunto;
                lblFecha.Text = mensaje.FechaHora.ToString();

                grvReciben.DataSource = mensaje.UsuariosReciben;
                grvReciben.DataBind();
            }
            else
            {
                lblCod.Text = string.Empty;
                lblFec.Text = string.Empty;
                lblAsu.Text = string.Empty;
                lblTex.Text = string.Empty;

                lblTexto.Text = string.Empty;
                lblCodigo.Text = string.Empty;
                lblAsunto.Text = string.Empty;
                lblFecha.Text = string.Empty;

                grvReciben.DataSource = null;
                grvReciben.DataBind();                
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}