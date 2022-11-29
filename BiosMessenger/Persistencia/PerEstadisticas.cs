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
    public class PerEstadisticas : IPerEstadisticas
    {
        private static PerEstadisticas _instancia = null;

        private PerEstadisticas() { }

        public static PerEstadisticas GetInstancia()
        {
            if (_instancia == null)
                _instancia = new PerEstadisticas();

            return _instancia;
        }
        
        public void Estadisticas(ref int usuario, ref int mensajesC, ref int mensajesP)
        {
            SqlConnection _cnn = new SqlConnection(Conexion.Cnn);
            SqlCommand _comando = new SqlCommand("Estadisticas", _cnn);
            _comando.CommandType = CommandType.StoredProcedure;           

            SqlParameter _ParmUsuarios = new SqlParameter("@usuActivos", SqlDbType.Int);
            _ParmUsuarios.Direction = ParameterDirection.Output;
            _comando.Parameters.Add(_ParmUsuarios);

            SqlParameter _ParmComunes = new SqlParameter("@mComunes", SqlDbType.Int);
            _ParmComunes.Direction = ParameterDirection.Output;
            _comando.Parameters.Add(_ParmComunes);

            SqlParameter _ParmPrivados = new SqlParameter("@mPrivados", SqlDbType.Int);
            _ParmPrivados.Direction = ParameterDirection.Output;
            _comando.Parameters.Add(_ParmPrivados);
            
            try
            {
                _cnn.Open();
                _comando.ExecuteScalar();

                usuario = Convert.ToInt32(_ParmUsuarios.Value);

                mensajesC = Convert.ToInt32(_ParmComunes.Value);

                mensajesP = Convert.ToInt32(_ParmPrivados.Value);                
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                _cnn.Close();
            }
        }
        public void EstadisticasTipos(ref int tiposMensaje, TipodeMensaje tipoM)
        {
            SqlConnection _cnn = new SqlConnection(Conexion.Cnn);
            SqlCommand _comando = new SqlCommand("Estadisticas2", _cnn);
            _comando.CommandType = CommandType.StoredProcedure;
            _comando.Parameters.AddWithValue("@tipoMensaje", tipoM.Codigo);
            
            SqlParameter _ParmtipoMensaje = new SqlParameter("@mTiposMensaje", SqlDbType.Int);
            _ParmtipoMensaje.Direction = ParameterDirection.Output;
            _comando.Parameters.Add(_ParmtipoMensaje);

            try
            {
                _cnn.Open();
                _comando.ExecuteScalar();                

                tiposMensaje = Convert.ToInt32(_ParmtipoMensaje.Value);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                _cnn.Close();
            }
        }
    }
}
