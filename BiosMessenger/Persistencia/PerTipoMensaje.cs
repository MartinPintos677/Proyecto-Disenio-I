using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EntidadesCompartidas;
using System.Data;
using System.Data.SqlClient;

namespace Persistencia
{
    public class PerTipoMensaje : IPerTipoMensaje
    {
        private static PerTipoMensaje _instancia = null;

        private PerTipoMensaje() { }

        public static PerTipoMensaje GetInstancia()
        {
            if (_instancia == null)
                _instancia = new PerTipoMensaje();

            return _instancia;
        }

        public TipodeMensaje Buscar(string codigo)
        {
            SqlConnection _cnn = new SqlConnection(Conexion.Cnn);
            TipodeMensaje tipoMensaje = null;

            SqlCommand _comando = new SqlCommand("BuscarTipodeMensaje", _cnn);
            _comando.CommandType = CommandType.StoredProcedure;
            _comando.Parameters.AddWithValue("@codigo", codigo);

            try
            {
                _cnn.Open();
                SqlDataReader _lector = _comando.ExecuteReader();
                if (_lector.HasRows)
                {
                    _lector.Read();
                    tipoMensaje = new TipodeMensaje(codigo, (string)_lector["Nombre"]);
                }
                _lector.Close();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                _cnn.Close();
            }
            return tipoMensaje;
        }
        public List<TipodeMensaje> ListaTipos()
        {
            string _codigo;
            string _nombre;            
            List<TipodeMensaje> _Lista = new List<TipodeMensaje>();
            SqlConnection _cnn = new SqlConnection(Conexion.Cnn);
            SqlCommand _Comando = new SqlCommand("ListadoTiposdeMensaje", _cnn);
            SqlDataReader _Reader;
            try
            {
                _cnn.Open();
                _Reader = _Comando.ExecuteReader();
                while (_Reader.Read())
                {
                    _codigo = (string)_Reader["Codigo"];
                    _nombre = (string)_Reader["Nombre"];                    
                    TipodeMensaje tipoMensaje = new TipodeMensaje(_codigo, _nombre);
                    _Lista.Add(tipoMensaje);
                }
                _Reader.Close();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                _cnn.Close();
            }
            return _Lista;
        }
    }
}
