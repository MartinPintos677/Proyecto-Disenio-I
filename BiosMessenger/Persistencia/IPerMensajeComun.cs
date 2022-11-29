using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EntidadesCompartidas;

namespace Persistencia
{
    public interface IPerMensajeComun
    {
        void AltaMensajeComun(Comun comun);
        List<Comun> ListadoMComunesEnviadosPorUsuario(Usuario usuario);
        List<Comun> ListadoMComunesRecibidosPorUsuario(Usuario usuario);
    }
}
