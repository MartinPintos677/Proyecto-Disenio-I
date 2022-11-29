using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EntidadesCompartidas;

namespace Persistencia
{
    public interface IPerEstadisticas
    {
        
        void Estadisticas(ref int usuario, ref int mensajesC, ref int mensajesP);

        void EstadisticasTipos(ref int tiposMensaje, TipodeMensaje tipoM);
    }
}
