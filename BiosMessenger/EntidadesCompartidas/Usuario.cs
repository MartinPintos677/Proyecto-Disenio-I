using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Text.RegularExpressions;

namespace EntidadesCompartidas
{
    public class Usuario
    {
        private string _usuarioLogueo;
        private string _contrasena;
        private string _nombre;
        private string _apellido;
        private string _mail;

        public string UsuarioLogueo
        {
            get { return _usuarioLogueo; }
            set
            {                
                if (value.Trim().Length != 8)
                {
                    throw new Exception("Logueo de usuario debe tener 8 caracteres.");
                }
                _usuarioLogueo = value.Trim();
            }
        }

        Regex regexPass = new Regex("[a-zA-Z][a-zA-Z][a-zA-Z][a-zA-Z][a-zA-Z][0-9]");
        public string Contrasena
        {
            get { return _contrasena; }
            set
            {                
                if (!regexPass.IsMatch(value))
                {
                    throw new Exception("La contraseña debe tener 6 caracteres, los primeros 5 deben ser letras y el " +
                                        "último debe ser un número.");
                }
                _contrasena = value.Trim();
            }
        }

        public string Nombre
        {
            get { return _nombre; }
            set
            {
                if (value.Trim() == string.Empty)
                {
                    throw new Exception("Debe indicar un nombre.");
                }
                else if (value.Length > 50)
                {
                    throw new Exception("El nombre no debe tener más de 50 caracteres.");
                }
                _nombre = value.Trim();
            }
        }
        public string Apellido
        {
            get { return _apellido; }
            set
            {
                if (value.Trim() == string.Empty)
                {
                    throw new Exception("Debe indicar un apellido.");
                }
                else if (value.Length > 50)
                {
                    throw new Exception("El apellido no puede tener más de 50 caracteres.");
                }
                _apellido = value.Trim();
            }
        }

        Regex regexMail1 = new Regex(@"^[^\s@]+@[^\s@]+\.[^\s@]+$");
        Regex regexMail2 = new Regex(@"^[^\s@]+@[^\s@]+\.[^\s@]+\.[^\s@]+$");
        public string Mail
        {
            get { return _mail; }
            set
            {
                if (value.Trim() == string.Empty)
                {
                    throw new Exception("Debe indicar un mail.");
                }
                else if (value.Trim().Length > 50)
                {
                    throw new Exception("El mail no puede tener más de 50 caracteres.");
                }
                else if (!regexMail1.IsMatch(value) && !regexMail2.IsMatch(value))
                {
                    throw new Exception("Mail incorrecto.");
                }
                _mail = value.Trim().ToLower();
            }
        }
        public Usuario(string usuarioLogueo, string contrasena, string nombre, string apellido, string mail)
        {
            UsuarioLogueo = usuarioLogueo;
            Contrasena = contrasena;
            Nombre = nombre;
            Apellido = apellido;
            Mail = mail;
        }
        public string NombreCompleto
        {
            get { return ToString(); }
        }

        public override string ToString()
        {
            return Nombre + " " + Apellido;
        }
    }
}
