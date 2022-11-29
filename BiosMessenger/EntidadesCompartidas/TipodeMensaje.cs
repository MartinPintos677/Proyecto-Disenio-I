using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Text.RegularExpressions;


namespace EntidadesCompartidas
{
    public class TipodeMensaje
    {
        private string _codigo;
        private string _nombre;


        Regex regex = new Regex("[a-zA-Z][a-zA-Z][a-zA-Z]");

        public string Codigo
        {
            get { return _codigo; }
            set
            {                
                if (!regex.IsMatch(value))
                {
                    throw new Exception("El código debe tener 3 letras.");
                }
                _codigo = value.Trim().ToUpper();
            }
        }
        public string Nombre
        {
            get { return _nombre; }
            set
            {
                if (value == string.Empty)
                {
                    throw new Exception("Debe ingresar nombre para el tipo de mensaje.");
                }
                else if (value.Trim().Length > 20)
                {
                    throw new Exception("Nombre de tipo de mensaje no debe tener más de 20 caracteres.");
                }
                _nombre = value.Trim();
            }
        }

        public TipodeMensaje(string codigo, string nombre)
        {
            Codigo = codigo;
            Nombre = nombre;
        }
        
        public override string ToString()
        {
            return Nombre;
        }
    }
}
