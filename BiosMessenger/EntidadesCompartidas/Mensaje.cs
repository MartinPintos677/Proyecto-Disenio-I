using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EntidadesCompartidas
{
    public abstract class Mensaje
    {
        private int _codigo;
        private string _textoMensaje;
        private string _asunto;
        private DateTime _fechaHora;
        private Usuario _usuario;

        private List<Usuario> _usuariosReciben;

        public int Codigo
        {
            get { return _codigo; }
            set
            {
                if (value < 1)
                {
                    throw new Exception("Código incorrecto.");
                }
                _codigo = value;
            }
        }

        public string TextoMensaje
        {
            get { return _textoMensaje; }
            set
            {
                if (value == string.Empty)
                {
                    throw new Exception("Debe ingresar texto para el mensaje.");
                }
                _textoMensaje = value;
            }
        }

        public string Asunto
        {
            get { return _asunto; }
            set
            {
                if (value == string.Empty)
                {
                    throw new Exception("Debe ingresar asunto para el mensaje.");
                }
                else if (value.Length > 30)
                {
                    throw new Exception("El asunto debe tener un máximo de 30 caracteres.");
                }
                _asunto = value;
            }
        }
        public DateTime FechaHora
        {
            get { return _fechaHora; }
            set { _fechaHora = value; }            
        }
        public Usuario Usuario
        {
            get { return _usuario; }
            set
            {
                if (value == null)
                {
                    throw new Exception("Debe indicar un Usuario.");
                }
                _usuario = value;
            }
        }
        public List<Usuario> UsuariosReciben
        {
            get { return _usuariosReciben; }            
            set
            {
                if (value == null || value.Count() == 0)
                {
                    throw new Exception("La cantidad de usuarios receptores de mensaje no puede ser 0.");
                }
                _usuariosReciben = value;
            }
        }

        public Mensaje (int codigo, string textoMensaje, string asunto, DateTime fechaHora, Usuario usuario, 
                        List<Usuario> usuariosReciben)
        {
            Codigo = codigo;
            TextoMensaje = textoMensaje;
            Asunto = asunto;
            FechaHora = fechaHora;
            Usuario = usuario;
            UsuariosReciben = usuariosReciben;
        }        
    }
}
