using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EntidadesCompartidas
{
    public class Privado : Mensaje
    {
        private DateTime _fechaCaducidad;

        public DateTime FechaCaducidad
        {
            get { return _fechaCaducidad; }
            set { _fechaCaducidad = value; }
        }

        public Privado(int codigo, string textoMensaje, string asunto, DateTime fechaHora, Usuario usuario, DateTime fCaducidad,
            List<Usuario> usuariosReciben) : base(codigo, textoMensaje, asunto, fechaHora, usuario, usuariosReciben)
        {
            FechaCaducidad = fCaducidad;
        }
    }
}
