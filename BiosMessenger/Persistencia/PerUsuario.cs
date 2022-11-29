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
    public class PerUsuario : IPerUsuario
    {
        private static PerUsuario _instancia = null;

        private PerUsuario() { }

        public static PerUsuario GetInstancia()
        {
            if (_instancia == null)
                _instancia = new PerUsuario();

            return _instancia;
        }

        public void UsuarioAlta(Usuario usuario)
        {
            SqlConnection _cnn = new SqlConnection(Conexion.Cnn);

            SqlCommand _comando = new SqlCommand("AltaUsuario", _cnn);
            _comando.CommandType = CommandType.StoredProcedure;
            _comando.Parameters.AddWithValue("@logueo", usuario.UsuarioLogueo);
            _comando.Parameters.AddWithValue("@contrasena", usuario.Contrasena);
            _comando.Parameters.AddWithValue("@nombre", usuario.Nombre);
            _comando.Parameters.AddWithValue("@apellido", usuario.Apellido);
            _comando.Parameters.AddWithValue("@mail", usuario.Mail);

            SqlParameter _retorno = new SqlParameter("@Retorno", SqlDbType.Int);
            _retorno.Direction = ParameterDirection.ReturnValue;
            _comando.Parameters.Add(_retorno);

            try
            {
                _cnn.Open();
                _comando.ExecuteNonQuery();

                if ((int)_retorno.Value == 0)
                    throw new Exception("Error en alta de usuario.");
                else if ((int)_retorno.Value == -1)
                    throw new Exception("Usuario ya existe en el sistema.");
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
        public void UsuarioBaja(Usuario usuario)
        {
            SqlConnection _cnn = new SqlConnection(Conexion.Cnn);

            SqlCommand _comando = new SqlCommand("BajaUsuario", _cnn);
            _comando.CommandType = CommandType.StoredProcedure;
            _comando.Parameters.AddWithValue("@logueo", usuario.UsuarioLogueo);
            SqlParameter _retorno = new SqlParameter("@Retorno", SqlDbType.Int);
            _retorno.Direction = ParameterDirection.ReturnValue;
            _comando.Parameters.Add(_retorno);

            try
            {
                _cnn.Open();
                _comando.ExecuteNonQuery();
                if ((int)_retorno.Value == -1)
                    throw new Exception("Ningún usuario en el sistema con el código digitado.");
                else if ((int)_retorno.Value == -2)
                    throw new Exception("Error en baja de usuario.");
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
        public void UsuarioModificar(Usuario usuario)
        {
            SqlConnection _cnn = new SqlConnection(Conexion.Cnn);

            SqlCommand _comando = new SqlCommand("ModificarUsuario", _cnn);
            _comando.CommandType = CommandType.StoredProcedure;
            _comando.Parameters.AddWithValue("@logueo", usuario.UsuarioLogueo);
            _comando.Parameters.AddWithValue("@contrasena", usuario.Contrasena);
            _comando.Parameters.AddWithValue("@nombre", usuario.Nombre);
            _comando.Parameters.AddWithValue("@apellido", usuario.Apellido);
            _comando.Parameters.AddWithValue("@mail", usuario.Mail);
            SqlParameter _retorno = new SqlParameter("@Retorno", SqlDbType.Int);
            _retorno.Direction = ParameterDirection.ReturnValue;
            _comando.Parameters.Add(_retorno);

            try
            {
                _cnn.Open();
                _comando.ExecuteNonQuery();
                if ((int)_retorno.Value == -1)
                    throw new Exception("El usuario no existe en el sistema.");
                else if ((int)_retorno.Value == -2)
                    throw new Exception("Error en modificación de usuario.");
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
        public Usuario BuscarUsuarioActivo(string logueo)
        {
            SqlConnection _cnn = new SqlConnection(Conexion.Cnn);
            Usuario usuario = null;

            SqlCommand _comando = new SqlCommand("BuscarUsuarioActivo", _cnn);
            _comando.CommandType = CommandType.StoredProcedure;
            _comando.Parameters.AddWithValue("@logueo", logueo);

            try
            {
                _cnn.Open();
                SqlDataReader _lector = _comando.ExecuteReader();
                if (_lector.HasRows)
                {
                    _lector.Read();
                    usuario = new Usuario(logueo, (string)_lector["Contrasena"], (string)_lector["Nombre"], 
                                            (string)_lector["Apellido"], (string)_lector["Mail"]);
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
            return usuario;
        }
        internal Usuario BuscarUsuario(string logueo)
        {
            SqlConnection _cnn = new SqlConnection(Conexion.Cnn);
            Usuario usuario = null;

            SqlCommand _comando = new SqlCommand("BuscarUsuario", _cnn);
            _comando.CommandType = CommandType.StoredProcedure;
            _comando.Parameters.AddWithValue("@logueo", logueo);

            try
            {
                _cnn.Open();
                SqlDataReader _lector = _comando.ExecuteReader();
                if (_lector.HasRows)
                {
                    _lector.Read();
                    usuario = new Usuario(logueo, (string)_lector["Contrasena"], (string)_lector["Nombre"],
                                            (string)_lector["Apellido"], (string)_lector["Mail"]);
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
            return usuario;
        }
        public Usuario Login(string logueo, string password)
        {
            SqlConnection _cnn = new SqlConnection(Conexion.Cnn);

            SqlCommand command = new SqlCommand("LogueodeUsuario", _cnn);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add(new SqlParameter("logueo", logueo));
            command.Parameters.Add(new SqlParameter("contrasena", password));

            Usuario usuario = null;

            try
            {
                _cnn.Open();
                SqlDataReader _lector = command.ExecuteReader();
                if (_lector.HasRows)
                {
                    _lector.Read();
                    usuario = new Usuario(logueo, (string)_lector["Contrasena"], (string)_lector["Nombre"],
                                            (string)_lector["Apellido"], (string)_lector["Mail"]);
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
            return usuario;
        }
    }
}
