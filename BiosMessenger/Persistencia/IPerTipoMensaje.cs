using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EntidadesCompartidas;

namespace Persistencia
{
    public interface IPerTipoMensaje
    {
        TipodeMensaje Buscar(string codigo);
        List<TipodeMensaje> ListaTipos();
    }
}
