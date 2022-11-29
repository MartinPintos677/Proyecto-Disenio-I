using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EntidadesCompartidas;
using Persistencia;
using System.Xml;
using System.Xml.Linq;

namespace Logica
{
    internal class LogicaEstadisticas : ILEstadisticas
    {
        private static LogicaEstadisticas _instancia = null;

        private LogicaEstadisticas() { }

        public static LogicaEstadisticas GetInstancia()
        {
            if (_instancia == null)
                _instancia = new LogicaEstadisticas();

            return _instancia;
        }
        public XmlDocument Estadisticas()
        {
            int usuario = 0;
            int mensajesC = 0;
            int mensajesP = 0;
            int tiposMensaje = 0;            

            FabricaPersistencia.GetPerEstadisticas().Estadisticas(ref usuario, ref mensajesC, ref mensajesP);            

            XmlDocument _Documento = new XmlDocument();
            _Documento.LoadXml("<?xml version='1.0' encoding='utf-8' ?> <Estadisticas> </Estadisticas>");
            XmlNode _raiz = _Documento.DocumentElement;
                        
            XmlNode _estadisticas3 = _Documento.CreateNode(XmlNodeType.Element, "Usuarios", "");
            _estadisticas3.InnerText = usuario.ToString();            
            _raiz.AppendChild(_estadisticas3);

            _estadisticas3 = _Documento.CreateNode(XmlNodeType.Element, "Comunes", "");
            _estadisticas3.InnerText = mensajesC.ToString();            
            _raiz.AppendChild(_estadisticas3);

            _estadisticas3 = _Documento.CreateNode(XmlNodeType.Element, "Privados", "");
            _estadisticas3.InnerText = mensajesP.ToString();            
            _raiz.AppendChild(_estadisticas3);


            List<TipodeMensaje> lista = FabricaPersistencia.GetPerTipoMensaje().ListaTipos();
            TipodeMensaje tipo = null;

            foreach (TipodeMensaje v in lista) 
            {
                tipo = v;
                FabricaPersistencia.GetPerEstadisticas().EstadisticasTipos(ref tiposMensaje, tipo);
                XmlNode _tiposMensaje = _Documento.CreateNode(XmlNodeType.Element, "Tipos", "");                
                _tiposMensaje.InnerText = tiposMensaje.ToString();
                XmlAttribute attribute = _Documento.CreateAttribute("TipoM");
                attribute.Value = tipo.ToString();
                _tiposMensaje.Attributes.Append(attribute);                
                _raiz.AppendChild(_tiposMensaje);
            }            
            
            return _Documento;
        }
    }
}
