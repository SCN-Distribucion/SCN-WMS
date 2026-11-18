##### V6.6.3 Usuarios conectados a Supabase
- Alta real mediante la Edge Function admin-create-user.
- Creación vinculada en Supabase Auth y public.profiles con el mismo UID.
- Listado de usuarios obtenido desde profiles, sin localStorage.
- Activación y desactivación contra profiles.
- Eliminada la contraseña heredada guardada como texto en users.js.

##### V6.6.2 Correcciones móvil, sesión y contraseña
- Menú móvil superpuesto y cierre automático al elegir un módulo.
- Formularios y vistas móviles usan todo el ancho disponible sin deformarse.
- Restauración real de la sesión de Supabase al actualizar con F5.
- Pantalla de carga mientras se valida la sesión.
- Recuperación de contraseña desde el login y formulario para establecer la nueva clave.

#### V6.6.1 Roles corregidos
- Corregido SERVICIO_TECNICO para coincidir con el enum de Supabase.
- Corregido TRANSPORTE.
- Roles desconocidos quedan limitados a Inicio en lugar de mostrar módulos indebidos.
- SERVICIO_TECNICO ve Inicio, Servicio técnico, Base, Historial y Trazabilidad.

#### V6.6.0 Supabase Auth
- Login centralizado con Supabase Auth y perfiles.
- Sesión persistente y cierre seguro.
- Primera etapa: autenticación conectada. Los datos operativos todavía conservan el almacenamiento local hasta la siguiente migración.

#### V6.5.3
- Ícono de la pestaña del navegador reemplazado por el logo SCN.
- Incluye favicon.ico y favicon-192.png.

#### V6.5.2
- Corregido: index.html ahora carga v65.js.
- El botón Actualizar lista de precios vuelve a mostrarse para ADMIN.
- Conserva el lector Excel SheetJS 0.20.3.

#### V6.5.1
- Corregida la lectura de archivos Excel mediante SheetJS 0.20.3.
- Se mantiene soporte alternativo para CSV.

### V6.4.2
- Unificado el alta de reclamos en Solicitud de nota de crédito.
- Agregado PDV.
- Supervisor ve y autoriza reclamos pendientes.
- ADMIN ve NC pendientes luego de la autorización.
- Contadores y avisos en Servicio técnico.

### V6.4.1
- Login corregido: lee los usuarios creados desde localStorage en cada intento.
- Sincronización inmediata al crear usuarios.

### V6.3.3
- Eliminada la franja PRODUCCION.
- Logo transparente corregido.
- PDF con generador local de respaldo, sin dependencia externa.


## V6.3
- Menú lateral rebatible y estilo macOS.
- Importación masiva Excel con plantilla, validación y vista previa.
- Solicitudes de nota de crédito por mercadería perdida con valorización unitaria IVA incluido.
- Flujo de aprobación/rechazo por Supervisor.
- Catálogo FRIGOR integrado desde SEPTIEMBRE.xlsx.
