using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Persistencia
{
    public class FabricaPersistencia
    {
        public static IPerUsuario GetPerUsuario()
        {
            return PerUsuario.GetInstancia();
        }
        public static IPerMensajeComun GetPerMensajeComun()
        {
            return PerMensajeComun.GetInstancia();
        }
        public static IPerMensajePrivado GetPerMensajePrivado()
        {
            return PerMensajePrivado.GetInstancia();
        }
        public static IPerTipoMensaje GetPerTipoMensaje()
        {
            return PerTipoMensaje.GetInstancia();
        }
        public static IPerEstadisticas GetPerEstadisticas()
        {
            return PerEstadisticas.GetInstancia();
        }
    }
}
