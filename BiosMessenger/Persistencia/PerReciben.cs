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
    public class PerReciben
    {
        private static PerReciben _instancia = null;

        private PerReciben() { }

        public static PerReciben GetInstancia()
        {
            if (_instancia == null)
                _instancia = new PerReciben();

            return _instancia;
        }
        internal void Agregar(Usuario usuario, int codMensaje, SqlTransaction _pTransaccion)
        {
            SqlCommand _comando = new SqlCommand("AgregarReceptorParaMensaje", _pTransaccion.Connection);
            _comando.CommandType = CommandType.StoredProcedure;
            _comando.Parameters.AddWithValue("@codMensaje", codMensaje);
            _comando.Parameters.AddWithValue("@usuarioReceptor", usuario.UsuarioLogueo);           
            SqlParameter _ParamRetorno = new SqlParameter("@Retorno", SqlDbType.Int);
            _ParamRetorno.Direction = ParameterDirection.ReturnValue;
            _comando.Parameters.Add(_ParamRetorno);

            try
            {
                _comando.Transaction = _pTransaccion;
                _comando.ExecuteNonQuery();

                int retorno = Convert.ToInt32(_ParamRetorno.Value);
                if (retorno == -1)
                    throw new Exception("No existe usuario con el código ingresado.");
                else if (retorno == -2)
                    throw new Exception("No existe mensaje con el código ingresado.");
                else if (retorno == -3)
                    throw new Exception("Ya existe usuario ingresado en el código de mensaje indicado.");                
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        internal List<Usuario> ListadoReciben(int codMensaje)
        {
            List<Usuario> _lista = new List<Usuario>();

            SqlConnection _cnn = new SqlConnection(Conexion.Cnn);

            SqlCommand _comando = new SqlCommand("ListadoReceptoresParaMensaje", _cnn);
            _comando.CommandType = CommandType.StoredProcedure;
            _comando.Parameters.AddWithValue("@codigo", codMensaje);

            try
            {
                _cnn.Open();
                SqlDataReader _lector = _comando.ExecuteReader();

                if (_lector.HasRows)
                {
                    while (_lector.Read())
                    {
                        Usuario usuario = PerUsuario.GetInstancia().BuscarUsuario((string)_lector["UsuarioLogueo"]);

                        _lista.Add(usuario);
                    }
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
            return _lista;
        }
    }
}
