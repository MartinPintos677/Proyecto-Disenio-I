using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Logica
{
    public class FabricaLogica
    {
        public static ILUsuario GetLogicaUsuario()
        {
            return LogicaUsuario.GetInstancia();
        }
        public static ILMensaje GetLogicaMensaje()
        {
            return LogicaMensaje.GetInstancia();
        }
        public static ILTipodeMensaje GetLogicaTipodeMensaje()
        {
            return LogicaTipodeMensaje.GetInstancia();
        }
        public static ILEstadisticas GetLogicaEstadisticas()
        {
            return LogicaEstadisticas.GetInstancia();
        }
    }
}
