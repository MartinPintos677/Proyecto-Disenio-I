using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EntidadesCompartidas;
using Persistencia;

namespace Logica
{
    internal class LogicaTipodeMensaje : ILTipodeMensaje
    {
        private static LogicaTipodeMensaje _instancia = null;

        private LogicaTipodeMensaje() { }

        public static LogicaTipodeMensaje GetInstancia()
        {
            if (_instancia == null)
                _instancia = new LogicaTipodeMensaje();

            return _instancia;
        }
        public TipodeMensaje Buscar(string codigo)
        {
            return FabricaPersistencia.GetPerTipoMensaje().Buscar(codigo);
        }
        public List<TipodeMensaje> ListaTipos()
        {
            return FabricaPersistencia.GetPerTipoMensaje().ListaTipos();
        }
    }
}
