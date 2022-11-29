using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EntidadesCompartidas;
using Persistencia;

namespace Logica
{
    internal class LogicaUsuario : ILUsuario
    {
        private static LogicaUsuario _instancia = null;

        private LogicaUsuario() { }

        public static LogicaUsuario GetInstancia()
        {
            if (_instancia == null)
                _instancia = new LogicaUsuario();

            return _instancia;
        }
        public void UsuarioAlta(Usuario usuario)
        {
            FabricaPersistencia.GetPerUsuario().UsuarioAlta(usuario);
        }
        public void UsuarioBaja(Usuario usuario)
        {
            FabricaPersistencia.GetPerUsuario().UsuarioBaja(usuario);
        }
        public void UsuarioModificar(Usuario usuario)
        {
            FabricaPersistencia.GetPerUsuario().UsuarioModificar(usuario);
        }
        public Usuario BuscarUsuarioActivo(string logueo)
        {
            return FabricaPersistencia.GetPerUsuario().BuscarUsuarioActivo(logueo);
        }
        public Usuario Login(string logueo, string password)
        {
            return FabricaPersistencia.GetPerUsuario().Login(logueo, password);
        }
    }
}
