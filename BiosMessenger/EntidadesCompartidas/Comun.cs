using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EntidadesCompartidas
{
    public class Comun : Mensaje
    {
        private TipodeMensaje _tipodeMensaje;

        public TipodeMensaje TipodeMensaje
        {
            get { return _tipodeMensaje; }
            set
            {
                if (value == null)
                {
                    throw new Exception("Debe indicar el tipo de mensaje.");
                }
                _tipodeMensaje = value;
            }
        }

        public Comun(int codigo, string textoMensaje, string asunto, DateTime fechaHora, Usuario usuario, TipodeMensaje tipo,
            List<Usuario> usuariosReciben) : base(codigo, textoMensaje, asunto, fechaHora, usuario, usuariosReciben)
        {
            TipodeMensaje = tipo;
        }

        public override string ToString()
        {
            return "Común (" + TipodeMensaje.Nombre + ")";
        }
    }
}
