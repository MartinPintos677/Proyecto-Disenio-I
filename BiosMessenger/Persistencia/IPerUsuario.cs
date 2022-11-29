using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EntidadesCompartidas;

namespace Persistencia
{
    public interface IPerUsuario
    {
        void UsuarioAlta(Usuario usuario);
        void UsuarioBaja(Usuario usuario);
        void UsuarioModificar(Usuario usuario);
        Usuario BuscarUsuarioActivo(string logueo);
        Usuario Login(string logueo, string password);
    }
}
