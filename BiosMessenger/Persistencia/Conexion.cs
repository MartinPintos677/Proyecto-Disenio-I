using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Persistencia
{
    internal class Conexion
    {
        private static string _cnn = "Data Source=localhost\\SQLEXPRESS; Initial Catalog= BiosMessenger; Integrated Security = true";
        internal static string Cnn
        {
            get { return _cnn; }
        }
    }
}
