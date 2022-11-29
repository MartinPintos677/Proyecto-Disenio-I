using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EntidadesCompartidas;
using Logica;

public partial class BandejadeEntrada : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                Usuario usuario = (Usuario)Session["UsuarioMP"];
                Session["ListaRecibidos"] = FabricaLogica.GetLogicaMensaje().MensajesRecibidosporUsuario(usuario);

                Session["Tipos"] = FabricaLogica.GetLogicaTipodeMensaje().ListaTipos();
                ddlTipos.DataSource = Session["Tipos"];
                ddlTipos.DataValueField = "Codigo";
                ddlTipos.DataTextField = "Nombre";
                ddlTipos.DataBind();

                Limpiar();
            }
            catch (Exception ex)
            {
                lblMensaje.Text = ex.Message;
                lblMensaje.CssClass = "alert alert-warning";
            }
        }
    }
    private void Limpiar()
    {
        Session["OtraLista"] = null;

        List<Mensaje> lista = (List<Mensaje>)Session["ListaRecibidos"];
        if (lista.Count == 0)
        {
            lblMensaje.Text = "Ningún mensaje recibido.";
            lblMensaje.CssClass = "alert alert-warning";
        }
        else
        {
            grvRecibidos.DataSource = Session["ListaRecibidos"];
            grvRecibidos.DataBind();
            lblMensaje.Text = string.Empty;
            lblMensaje.CssClass = null;
        }
        
        Session["Mensaje"] = null;
        MensajesCompletos1.CargoUC();
        grvRecibidos.SelectedIndex = -1;
        rbtnComun.Checked = false;
        rbtnPrivado.Checked = false;
        ddlTipos.Enabled = false;
        btnTipoC.Enabled = false;
        btnPriComun.Enabled = true;
        btnLimpiar.Enabled = false;        
        txtFecha.Text = string.Empty;
    }
    private void LimpiarPrivado()
    {
        btnPriComun.Enabled = true;
        btnTipoC.Enabled = false;
        btnLimpiar.Enabled = true;
        lblMensaje.Text = string.Empty;
        lblMensaje.CssClass = null;
        ddlTipos.Enabled = false;
        txtFecha.Text = string.Empty;
    }
    private void LimpiarComun()
    {
        btnPriComun.Enabled = true;
        btnTipoC.Enabled = true;
        btnLimpiar.Enabled = true;
        lblMensaje.Text = string.Empty;
        lblMensaje.CssClass = null;
        ddlTipos.Enabled = true;
        txtFecha.Text = string.Empty;
    }
    private void CargoGrilla()
    {
        Session["Mensaje"] = null;
        grvRecibidos.DataSource = Session["OtraLista"];
        grvRecibidos.DataBind();
        grvRecibidos.SelectedIndex = -1;
        MensajesCompletos1.CargoUC();
        lblMensaje.Text = string.Empty;
        lblMensaje.CssClass = null;
    }
    private void SinMensajes()
    {
        Session["Mensaje"] = null;
        MensajesCompletos1.CargoUC();
        grvRecibidos.DataSource = null;
        grvRecibidos.DataBind();
    }
    protected void grvRecibidos_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            List<Mensaje> mensajes = (List<Mensaje>)Session["OtraLista"];
            Mensaje mensaje = null;

            if (mensajes == null)
            {
                mensaje = ((List<Mensaje>)Session["ListaRecibidos"])[grvRecibidos.SelectedIndex];
            }
            else
            {
                mensaje = ((List<Mensaje>)Session["OtraLista"])[grvRecibidos.SelectedIndex];
            }

            Session["Mensaje"] = mensaje;
            MensajesCompletos1.CargoUC();

            btnLimpiar.Enabled = true;
            lblMensaje.Text = string.Empty;
            lblMensaje.CssClass = null;
        }
        catch (Exception ex)
        {
            lblMensaje.Text = ex.Message;
            lblMensaje.CssClass = "alert alert-warning";
        }
    }

    protected void btnPriComun_Click(object sender, EventArgs e)
    {
        try
        {
            if (rbtnPrivado.Checked)
            {
                List<Mensaje> mensajes = (List<Mensaje>)Session["ListaRecibidos"];

                List<Mensaje> privados = (from unP in mensajes
                                          where unP is Privado
                                          select unP).ToList<Mensaje>();

                if (privados.Count != 0)
                {
                    Session["OtraLista"] = privados;
                    LimpiarPrivado();
                    CargoGrilla();
                }
                else
                {
                    lblMensaje.Text = "Ningún mensaje privado recibido.";
                    lblMensaje.CssClass = "alert alert-warning";
                    SinMensajes();
                }
                
            }
            else if (rbtnComun.Checked)
            {
                List<Mensaje> mensajes = (List<Mensaje>)Session["ListaRecibidos"];

                List<Mensaje> comunes = (from unC in mensajes
                                         where unC is Comun
                                         select unC).ToList<Mensaje>();

                if (comunes.Count != 0)
                {
                    Session["OtraLista"] = comunes;
                    LimpiarComun();
                    CargoGrilla();
                }
                else
                {
                    lblMensaje.Text = "Ningún mensaje común recibido.";
                    lblMensaje.CssClass = "alert alert-warning";
                    SinMensajes();
                }
            }
            else
            {
                lblMensaje.Text = "Debe marcar una de las opciones.";
                lblMensaje.CssClass = "alert alert-warning";
            }
        }
        catch (Exception ex)
        {
            lblMensaje.Text = ex.Message;
            lblMensaje.CssClass = "alert alert-warning";
        }
    }

    protected void btnTipoC_Click(object sender, EventArgs e)
    {
        try
        {
            List<Mensaje> mensajes = (List<Mensaje>)Session["ListaRecibidos"];

            TipodeMensaje tipoM = ((List<TipodeMensaje>)Session["Tipos"])[ddlTipos.SelectedIndex];

            List<Comun> comunes = (from Mensaje mensaje in mensajes
                                   where mensaje is Comun
                                   select (Comun)mensaje).ToList<Comun>();

            List<Mensaje> comunesTipos = (from unC in comunes
                                          where unC.TipodeMensaje.Codigo == tipoM.Codigo
                                          select unC).ToList<Mensaje>();

            if (comunesTipos.Count != 0)
            {
                Session["OtraLista"] = comunesTipos;
                CargoGrilla();
            }
            else
            {
                lblMensaje.Text = "Ningún mensaje recibido de tipo " + tipoM.Nombre + ".";
                lblMensaje.CssClass = "alert alert-warning";
                SinMensajes();
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
        Limpiar();
    }

    protected void btnFecha_Click(object sender, EventArgs e)
    {
        try
        {
            List<Mensaje> mensajes = (List<Mensaje>)Session["ListaRecibidos"];

            DateTime fecha = Convert.ToDateTime(txtFecha.Text.Trim());

            List<Mensaje> porFecha = (from unP in mensajes
                                      where unP.FechaHora.Date == fecha.Date
                                      select unP).ToList<Mensaje>();

            if (porFecha.Count == 0)
            {
                lblMensaje.Text = "Ningún mensaje en la fecha indicada.";
                lblMensaje.CssClass = "alert alert-warning";                
                SinMensajes();
            }
            else
            {                
                Session["OtraLista"] = porFecha;                              
                CargoGrilla();
            }
            btnTipoC.Enabled = false;
            ddlTipos.Enabled = false;
            btnLimpiar.Enabled = true;
        }
        catch (Exception ex)
        {
            lblMensaje.Text = ex.Message;
            lblMensaje.CssClass = "alert alert-warning";
        }
    }
}