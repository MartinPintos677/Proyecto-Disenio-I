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
    public class PerMensajeComun : IPerMensajeComun
    {
        private static PerMensajeComun _instancia = null;

        private PerMensajeComun() { }

        public static PerMensajeComun GetInstancia()
        {
            if (_instancia == null)
                _instancia = new PerMensajeComun();

            return _instancia;
        }
        public void AltaMensajeComun(Comun comun)
        {
            SqlConnection _cnn = new SqlConnection(Conexion.Cnn);

            SqlCommand _comando = new SqlCommand("AltaMensajeComun", _cnn);
            _comando.CommandType = CommandType.StoredProcedure;
            _comando.Parameters.AddWithValue("@texto", comun.TextoMensaje);
            _comando.Parameters.AddWithValue("@asunto", comun.Asunto);
            _comando.Parameters.AddWithValue("@tipoMensaje", comun.TipodeMensaje.Codigo);
            _comando.Parameters.AddWithValue("@usuarioEnvia", comun.Usuario.UsuarioLogueo);
            
            SqlParameter _ParmRetorno = new SqlParameter("@Retorno", SqlDbType.Int);
            _ParmRetorno.Direction = ParameterDirection.ReturnValue;
            _comando.Parameters.Add(_ParmRetorno);

            SqlTransaction _miTransaccion = null;

            try
            {
                _cnn.Open();
                _miTransaccion = _cnn.BeginTransaction();
                _comando.Transaction = _miTransaccion;
                _comando.ExecuteNonQuery();

                int _codMensaje = Convert.ToInt32(_ParmRetorno.Value);

                if (_codMensaje == 0)
                    throw new Exception("Error no especificado.");
                else if (_codMensaje == -1)
                    throw new Exception("No existe usuario ingresado.");
                else if (_codMensaje == -2)
                    throw new Exception("No existe el tipo de mensaje ingresado.");


                foreach (Usuario unUsuario in comun.UsuariosReciben)
                {
                    PerReciben.GetInstancia().Agregar(unUsuario, _codMensaje, _miTransaccion);
                }

                _miTransaccion.Commit();
            }
            catch (Exception ex)
            {
                _miTransaccion.Rollback();
                throw ex;
            }
            finally
            {
                _cnn.Close();
            }
        }
        public List<Comun> ListadoMComunesEnviadosPorUsuario(Usuario usuario)
        {
            string _logueo;
            int _codigo;
            string _texto;
            string _asunto;
            DateTime _fechaHora;
            string _tipoMensaje;
            List<Usuario> _reciben;

            List<Comun> _Lista = new List<Comun>();
            SqlConnection _Conexion = new SqlConnection(Conexion.Cnn);
            SqlCommand _Comando = new SqlCommand("ListadoMComunesEnviadosPorUsuario", _Conexion);
            _Comando.CommandType = CommandType.StoredProcedure;
            _Comando.Parameters.AddWithValue("@usuario", usuario.UsuarioLogueo);
            SqlDataReader _Reader;

            Comun comun = null;
            TipodeMensaje tipoM = null;

            try
            {
                _Conexion.Open();
                _Reader = _Comando.ExecuteReader();
                while (_Reader.Read())
                {
                    _logueo = (string)_Reader["UsuarioLogueo"];
                    usuario = PerUsuario.GetInstancia().BuscarUsuario(_logueo);

                    _tipoMensaje = (string)_Reader["TipoMensaje"];
                    tipoM = PerTipoMensaje.GetInstancia().Buscar(_tipoMensaje);

                    _codigo = (int)_Reader["Codigo"];
                    _texto = (string)_Reader["TextoMensaje"];
                    _asunto = (string)_Reader["Asunto"];
                    _fechaHora = (DateTime)_Reader["FechaHora"];

                    _reciben = PerReciben.GetInstancia().ListadoReciben(_codigo);

                    comun = new Comun(_codigo, _texto, _asunto, _fechaHora, usuario, tipoM, _reciben);
                    _Lista.Add(comun);
                }
                _Reader.Close();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                _Conexion.Close();
            }
            return _Lista;
        }
        public List<Comun> ListadoMComunesRecibidosPorUsuario(Usuario usuario)
        {
            string _logueo;
            int _codigo;
            string _texto;
            string _asunto;
            DateTime _fechaHora;
            string _tipoMensaje;
            List<Usuario> _reciben;

            List<Comun> _Lista = new List<Comun>();
            SqlConnection _Conexion = new SqlConnection(Conexion.Cnn);
            SqlCommand _Comando = new SqlCommand("ListadoMComunesRecibidosPorUsuario", _Conexion);
            _Comando.CommandType = CommandType.StoredProcedure;
            _Comando.Parameters.AddWithValue("@usuario", usuario.UsuarioLogueo);
            SqlDataReader _Reader;

            Comun comun = null;
            TipodeMensaje tipoM = null;

            try
            {
                _Conexion.Open();
                _Reader = _Comando.ExecuteReader();
                while (_Reader.Read())
                {
                    _logueo = (string)_Reader["UsuarioLogueo"];
                    usuario = PerUsuario.GetInstancia().BuscarUsuario(_logueo);

                    _tipoMensaje = (string)_Reader["TipoMensaje"];
                    tipoM = PerTipoMensaje.GetInstancia().Buscar(_tipoMensaje);

                    _codigo = (int)_Reader["Codigo"];
                    _texto = (string)_Reader["TextoMensaje"];
                    _asunto = (string)_Reader["Asunto"];
                    _fechaHora = (DateTime)_Reader["FechaHora"];

                    _reciben = PerReciben.GetInstancia().ListadoReciben(_codigo);

                    comun = new Comun(_codigo, _texto, _asunto, _fechaHora, usuario, tipoM, _reciben);
                    _Lista.Add(comun);
                }
                _Reader.Close();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                _Conexion.Close();
            }
            return _Lista;
        }
    }
}
