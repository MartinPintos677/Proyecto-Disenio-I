# Proyecto-Diseño-I

Proyecto de la primer materia del segundo año de la carrera de Analista de Sistemas. 

Se desea generar el sistema para un sitio de intercambio de mensajes. Todo el acceso será mediante un único sitio web. 

DESCRIPCIÓN DE LA REALIDAD:
Existen usuarios que mandan mensajes. Existen 2 tipos de mensajes: comunes y privados.
De los mensajes en general se sabe: 
1. Código Interno (único en el sistema – autogenerado )
2. Fecha y hora de generado el mensaje (automático en el momento de crearlo)
3. Asunto (no puede estar vacío) 
4. Texto del mensaje (no puede estar vacío) 
5. Usuario que lo envía 
6. Usuario/os que reciben el mensaje (un mensaje puede tener varios receptores, y un usuario 
puede enviar muchos mensajes)
De los mensajes comunes, se sabe además su tipo de mensaje. De los mensajes privados, se sabe
cuándo caducan (es decir cuando ya no podrán mostrarse en las consultas – no implica que se 
eliminen). Un mensaje privado al menos deberá ser accesible un día. 
Los tipos de mensajes son datos ya existentes en la base de datos, y que por ahora NO podrán 
generarse ABM’s desde el sitio. Se sabe su código (3 letras) y su nombre. Debe crearse la estructura 
necesaria para poder consultar/usar este concepto tanto en la base de datos como en el sistema. 
Ejemplos: URG (urgente), IVT (invitación), EVT (eventos), etc

FUNCIONALIDADES DEL SITIO WEB:

Página Web: Pagina Inicial del sitio (Default).
Actor Participante: publico.
Resumen: Esta página permite que un usuario se loguee y acceda a la página principal de su 
mensajería. Para ello se deberá solicitar nombre de usuario y contraseña. La autenticación del usuario
se deberá realizar manualmente y mediante el repositorio de datos del propio sistema. También 
deberá tenerse un acceso a la página de Alta Usuario. 
Además se mostraran estadísticas del sitio: cantidad de usuarios activos en el sistema; cantidad de mensajes
enviados de tipo común y de tipo privado; cantidad de mails por tipo de mail (mensajes comunes). El 
formulario recibe un documento con formato XML (alojado en la memoria, no físicamente), el 
cual contendrá un nodo por cada dato estadístico a desplegar. Dicho documento se deberá generar 
en la operación correspondiente en la lógica de negocio del sistema. La información deberá 
generarse en un único Procedimiento almacenado, y usar parámetros de tipo output para 
devolver los datos. 

Página Web: Alta Usuario.
Actor Participante: publi.co
Resumen: Esta página permite que un visitante se cree un usuario en nuestro sistema. El nombre de 
usuario para loguearse debe ser único en el sistema (identificador) y contar con 8 caracteres 
exactamente. La contraseña debe ser de 6 de largo (5 letras y un número). También interesa saber su 
nombre completo y un mail de contacto. 

Página Web: Baja y Modificación Usuario Logueado.
Actor Participante: Usuario.
Resumen: Esta página permite modificar la información del usuario actualmente logueado, o que el 
mismo usuario se auto elimine del sistema. En este último caso, luego de la eliminación deberá 
desloguearse el usuario y volver a la página principal del sitio.

Página Web: Alta Mensaje Común.
Actor Participante: Usuario.
Resumen: Esta página permite mantener información de los mensajes comunes que envía el 
usuario. Se deberán determinar los datos del mensaje y los específicos del mensaje común, 
mencionados en el apartado “Descripción de la Realidad”. NO se podrán eliminar ni 
modificar mensajes. Como un mensaje puede estar destinado a más de un usuario, esta lista 
debe manejarse conjuntamente con el mensaje; obligatorio manejo de transacción lógica.

Página Web: Alta Mensaje Privado.
Actor Participante: Usuario.
Resumen: Esta página permite mantener información de los mensajes privados que envía el 
usuario. Se deberán determinar los datos del mensaje y los específicos del mensaje privado, 
mencionados en el apartado “Descripción de la Realidad”. NO se podrán eliminar ni modificar 
mensajes. Como un mensaje puede estar destinado a más de un usuario, esta lista debe manejarse 
conjuntamente con el mensaje; obligatorio manejo de transacción lógica.

Página Web: Bandeja de entrada.
Actor Participante: Usuario.
Resumen: Esta página permite mostrar todos los mail recibidos por el usuario actualmente 
logueado. La lista se despliega ordenada por fecha, siendo el primero en desplegarse el último 
mensaje en recibirse. Deberá desplegarse esta información en una grilla, con los siguientes datos: 
Fecha – Asunto – Remitente (usuario que lo envía). Si el usuario selecciona uno de estos mensajes, 
en un Control de tipo UserControl, se desplegara el mensaje completo (incluye texto del mensaje, y 
todos los destinatarios del mismo). Tomar en cuenta que los mensajes privados tienen fecha de 
caducidad, luego de la cual el mensaje no se mostrara en esa lista.
Además deberá contar al principio de la página con un cuadro de búsqueda, que poseerá: 
a) Filtro por tipo (común o privado). Puede utilizarse un radioButton para la selección
b) En caso de seleccionar tipo Común, se habilitara la posibilidad de filtrar por tipo de 
Mensaje
c) Filtro por fecha de recepción (una fecha específica).
d) Botón de limpiar filtros (vuelve a mostrar todos los mensajes como al principio) 
El usuario podrá realizar siempre estos tipos de búsquedas, realizándose el filtrado mediante Linq to 
Objects (obligatorio).

Página Web: Bandeja de Salida.
Actor Participante: Usuario.
Resumen: Esta página permite mostrar todos los mail enviados por el usuario actualmente 
logueado. La lista se despliega ordenada por fecha, siendo el primero en desplegarse el último 
mensaje en enviarse. Deberá desplegarse esta información en una grilla, con los siguientes datos: 
Fecha – Asunto). Si el usuario selecciona uno de estos mensajes, en un Control de tipo 
UserControl, se desplegara el mensaje completo (incluye texto del mensaje, y todos los destinatarios 
del mismo).
Además deberá contar al principio de la página con un cuadro de búsqueda, que poseerá: 
a) Filtro por tipo (común o privado). Puede utilizarse un radioButton para la selección
b) En caso de seleccionar tipo Común, se habilitara la posibilidad de filtrar por tipo de 
Mensaje
c) Filtro por fecha de envío (una fecha específica).
d) Botón de limpiar filtros (vuelve a mostrar todos los mensajes como al principio) 
El usuario podrá realizar siempre estos tipos de búsquedas, realizándose el filtrado mediante Linq to 
Objects (obligatorio).

** Tomar en cuenta que deberá tenerse una Master Page (para páginas del sitio no públicas), con:
1. Nombre del usuario actualmente logueado
2. Acceso para desloguearse del sitio
3. Menú principal con todas las acciones que pueda realizar el usuario.

