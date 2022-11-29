using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EntidadesCompartidas;

namespace Persistencia
{
    public interface IPerMensajePrivado
    {
        void AltaMensajePrivado(Privado privado);
        List<Privado> ListadoMPrivadosEnviadosPorUsuario(Usuario usuario);
        List<Privado> ListadoMPrivadosRecibidosPorUsuario(Usuario usuario);
    }
}
