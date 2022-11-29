using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EntidadesCompartidas;
using Persistencia;

namespace Logica
{
    internal class LogicaMensaje : ILMensaje
    {
        private static LogicaMensaje _instancia = null;

        private LogicaMensaje() { }

        public static LogicaMensaje GetInstancia()
        {
            if (_instancia == null)
                _instancia = new LogicaMensaje();

            return _instancia;
        }
        public void AltaMensaje(Mensaje mensaje)
        {            
            if (mensaje is Privado)
            {
                FabricaPersistencia.GetPerMensajePrivado().AltaMensajePrivado((Privado)mensaje);
            }
            else
            {
                FabricaPersistencia.GetPerMensajeComun().AltaMensajeComun((Comun)mensaje);
            }
        }
        public List<Mensaje> MensajesEnviadosporUsuario(Usuario usuario)
        {
            List<Mensaje> mensajes = new List<Mensaje>();
            
            List<Comun> mComun = FabricaPersistencia.GetPerMensajeComun().ListadoMComunesEnviadosPorUsuario(usuario);
            
            List<Privado> mPrivado = FabricaPersistencia.GetPerMensajePrivado().ListadoMPrivadosEnviadosPorUsuario(usuario);

            mensajes.AddRange(mComun);
            mensajes.AddRange(mPrivado);

            List<Mensaje> mensajesOrdenadosFecha = (from unM in mensajes
                                                    orderby unM.FechaHora descending
                                                    select unM).ToList<Mensaje>();

            return mensajesOrdenadosFecha;
        }
        public List<Mensaje> MensajesRecibidosporUsuario(Usuario usuario)
        {
            List<Mensaje> mensajes = new List<Mensaje>();

            List<Comun> mComun = FabricaPersistencia.GetPerMensajeComun().ListadoMComunesRecibidosPorUsuario(usuario);

            List<Privado> mPrivado = FabricaPersistencia.GetPerMensajePrivado().ListadoMPrivadosRecibidosPorUsuario(usuario);
                        
            mensajes.AddRange(mComun);
            mensajes.AddRange(mPrivado);

            List<Mensaje> mensajesOrdenadosFecha = (from unM in mensajes
                                                    orderby unM.FechaHora descending
                                                    select unM).ToList<Mensaje>();                               

            return mensajesOrdenadosFecha;
        }
    }
}
