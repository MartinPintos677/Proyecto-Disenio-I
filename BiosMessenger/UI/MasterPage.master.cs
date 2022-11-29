using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Logica;
using EntidadesCompartidas;

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!(Session["UsuarioMP"] is Usuario))
            {
                Response.Redirect("~/Default.aspx");
            }
            else
            {
                lblUsuario.Text = Session["UsuarioMP"].ToString();
            }
        }
        catch
        {
            Response.Redirect("~/Default.aspx");
        }
    }
}
