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
    public class PerMensajePrivado : IPerMensajePrivado
    {
        private static PerMensajePrivado _instancia = null;

        private PerMensajePrivado() { }

        public static PerMensajePrivado GetInstancia()
        {
            if (_instancia == null)
                _instancia = new PerMensajePrivado();

            return _instancia;
        }
        public void AltaMensajePrivado(Privado privado)
        {
            SqlConnection _cnn = new SqlConnection(Conexion.Cnn);

            SqlCommand _comando = new SqlCommand("AltaMensajePrivado", _cnn);
            _comando.CommandType = CommandType.StoredProcedure;
            _comando.Parameters.AddWithValue("@texto", privado.TextoMensaje);
            _comando.Parameters.AddWithValue("@asunto", privado.Asunto);
            _comando.Parameters.AddWithValue("@fechaCaducidad", privado.FechaCaducidad);
            _comando.Parameters.AddWithValue("@usuarioEnvia", privado.Usuario.UsuarioLogueo);

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


                foreach (Usuario unUsuario in privado.UsuariosReciben)
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
        public List<Privado> ListadoMPrivadosEnviadosPorUsuario(Usuario usuario)
        {
            string _logueo;
            int _codigo;
            string _texto;
            string _asunto;
            DateTime _fechaHora;            
            List<Usuario> _reciben;
            DateTime _fechaCaducidad;

            List<Privado> _Lista = new List<Privado>();
            SqlConnection _Conexion = new SqlConnection(Conexion.Cnn);
            SqlCommand _Comando = new SqlCommand("ListadoMPrivadosEnviadosPorUsuario", _Conexion);
            _Comando.CommandType = CommandType.StoredProcedure;
            _Comando.Parameters.AddWithValue("@usuario", usuario.UsuarioLogueo);
            SqlDataReader _Reader;

            Privado privado = null;            

            try
            {
                _Conexion.Open();
                _Reader = _Comando.ExecuteReader();
                while (_Reader.Read())
                {
                    _logueo = (string)_Reader["UsuarioLogueo"];
                    usuario = PerUsuario.GetInstancia().BuscarUsuario(_logueo);                    

                    _codigo = (int)_Reader["Codigo"];
                    _texto = (string)_Reader["TextoMensaje"];
                    _asunto = (string)_Reader["Asunto"];
                    _fechaHora = (DateTime)_Reader["FechaHora"];
                    _fechaCaducidad = (DateTime)_Reader["FechaCaducidad"];

                    _reciben = PerReciben.GetInstancia().ListadoReciben(_codigo);

                    privado = new Privado(_codigo, _texto, _asunto, _fechaHora, usuario, _fechaCaducidad, _reciben);
                    _Lista.Add(privado);
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
        public List<Privado> ListadoMPrivadosRecibidosPorUsuario(Usuario usuario)
        {
            string _logueo;
            int _codigo;
            string _texto;
            string _asunto;
            DateTime _fechaHora;
            List<Usuario> _reciben;
            DateTime _fechaCaducidad;

            List<Privado> _Lista = new List<Privado>();
            SqlConnection _Conexion = new SqlConnection(Conexion.Cnn);
            SqlCommand _Comando = new SqlCommand("ListadoMPrivadosRecibidosPorUsuario", _Conexion);
            _Comando.CommandType = CommandType.StoredProcedure;
            _Comando.Parameters.AddWithValue("@usuario", usuario.UsuarioLogueo);
            SqlDataReader _Reader;

            Privado privado = null;

            try
            {
                _Conexion.Open();
                _Reader = _Comando.ExecuteReader();
                while (_Reader.Read())
                {
                    _logueo = (string)_Reader["UsuarioLogueo"];
                    usuario = PerUsuario.GetInstancia().BuscarUsuario(_logueo);

                    _codigo = (int)_Reader["Codigo"];
                    _texto = (string)_Reader["TextoMensaje"];
                    _asunto = (string)_Reader["Asunto"];
                    _fechaHora = (DateTime)_Reader["FechaHora"];
                    _fechaCaducidad = (DateTime)_Reader["FechaCaducidad"];

                    _reciben = PerReciben.GetInstancia().ListadoReciben(_codigo);

                    privado = new Privado(_codigo, _texto, _asunto, _fechaHora, usuario, _fechaCaducidad, _reciben);
                    _Lista.Add(privado);
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
