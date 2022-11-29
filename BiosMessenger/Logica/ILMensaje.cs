using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EntidadesCompartidas;

namespace Logica
{
    public interface ILMensaje
    {
        void AltaMensaje(Mensaje mensaje);
        List<Mensaje> MensajesEnviadosporUsuario(Usuario usuario);
        List<Mensaje> MensajesRecibidosporUsuario(Usuario usuario);
    }
}
