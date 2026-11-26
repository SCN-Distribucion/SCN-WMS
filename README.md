##### SCN-WMS V7.8.6
- Estabilización previa al APK: elimina el clonado de formularios operativos dentro de Inicio.
- TRANSPORTE no puede asignar viajes ni consultar la Base completa.
- Mis viajes muestra Por aceptar, Activos, Completados y No cumplidos.
- Historial y Trazabilidad abren sus módulos funcionales reales.
- Atrás del navegador/celular vuelve a Inicio y evita pantallas vacías.
- LOGISTICA conserva autocompletado PDV y datos de fletero en el formulario real.
- Depósito, alta y reclamos habilitan cámara móvil o selección de archivo.
- Mantiene impresión A4/A3, buscador de chapas, permisos RLS y preparación Capacitor.

#### SCN-WMS V7.8.5
- Impresión QR configurable: A4/A3, vertical/horizontal y separación 3/4/5/6 mm.
- Cálculo automático de columnas, filas y etiquetas estimadas por hoja manteniendo 70 × 50 mm.
- Fleteros: mensaje de error visible, detalle técnico y botón Reintentar.
- Nuevo SQL idempotente para que LOGISTICA/SUPERVISOR lean TRANSPORTE activos.

#### SCN-WMS V7.8.4
- Etiquetas A4: QR contenido dentro del marco, 3.5 mm de margen interno y 4/5 mm de separación para recorte.
- Asignación de viajes: buscador predictivo por chapa reemplaza el desplegable de freezers disponibles.
- RETIRO/CAMBIO: búsqueda limitada a equipos ENTREGADOS del PDV ingresado.
- Mantiene las validaciones y RPC existentes; no requiere SQL nuevo.

#### SCN-WMS V7.8.3
- Unifica version interna, cache y SCN Services en 7.8.3.
- El dashboard ya no simula clics en el menu lateral para las acciones de segundo nivel.
- Operacion progresiva: Inicio > bloque > funcion > operacion dentro del panel central.
- Conserva menu lateral como navegacion alternativa y no requiere SQL nuevo.

#### SCN-WMS V7.8.1
- Inicio progresivo por rol: muestra un resumen corto y bloques de decisión.
- Las opciones y estadísticas se abren sólo cuando el usuario las elige.
- Incorpora Volver a Inicio y elimina el pantallazo de funciones simultáneas.
- No requiere SQL nuevo.

#### SCN-WMS V7.8
- Inicio operativo personalizado según ADMIN, SUPERVISOR, LOGISTICA, DEPOSITO, SERVICIO_TECNICO y TRANSPORTE.
- KPIs clickeables, accesos por rol, estadísticas de colocación y movimientos, alertas de reclamos y actividad reciente.
- Conserva navegación lateral V7.7.2, responsive, viajes, CAMBIO, reclamos, QR, ubicaciones y SCN Services.
- No requiere SQL nuevo.

#### SCN-WMS V7.7.2
- Rehace el menu lateral como acordeon interactivo visible.
- Submenus reales para Deposito, Transporte, Servicio tecnico, Base y Usuarios.
- En movil, el menu permanece abierto hasta seleccionar la opcion y luego se cierra.
- Conserva responsive V7.7 y SCN Services.

#### SCN-WMS V7.7.1
- Corrige la interaccion del menu lateral: los modulos con submenus ahora activan la vista y despliegan opciones correctamente.
- En movil, el menu se cierra al elegir una opcion del submenu, no antes.
- Mantiene sin cambios el responsive y la capa SCN Services incorporados en V7.7.

### SCN-WMS V7.6
- Rediseño exclusivo de etiquetas QR para mejorar lectura y estética.
- Etiqueta física 70 x 50 mm.
- Logo SCN más grande, FREEZER SCN, CHAPA, número destacado y QR de 34 mm.
- Se elimina cualquier dato variable de la etiqueta.
- Impresión A4 en 2 columnas para preservar tamaño real y legibilidad.
- No cambia el valor interno del QR ni requiere SQL nuevo.

### SCN-WMS V7.5
- Depósito ahora tiene 3 submenús laterales independientes: Entrada / salida, Alta freezer nuevo y Ubicaciones.
- Entrada / salida ya no muestra el botón + Alta freezer nuevo.
- Alta freezer nuevo abre exclusivamente el formulario de alta existente.
- Ubicaciones conserva sin cambios la lógica validada V6.7.7.
- No requiere SQL nuevo.

## SCN-WMS V7.4
- Corrige el pantallazo y la pantalla en blanco al elegir un submenú.
- Elimina de la carga web el controlador anterior v701.js, que competía con v703.js.
- Conserva el submenú lateral: módulo > opción > pantalla correspondiente.
- Traslada al controlador estable los filtros de Historial y el acceso QR de Depósito.
- No requiere SQL nuevo.

# SCN-WMS V7
- Corrige la impresión QR en navegador eliminando el motor Node incompatible de V6.7.9.
- Panel ADMIN de etiquetas QR visible dentro de Base.
- Impresión individual y masiva con vista previa en la aplicación.
- Impresión mediante iframe interno, evitando la pestaña about:blank vacía.
- QR único por freezer: SCN-WMS:FREEZER:[chapa].
- Conserva V6.7.8/V6.7.7, roles, ubicaciones, viajes, trazabilidad y estructura Android.
- No requiere SQL nuevo si SUPABASE-V678-QR-FREEZERS.sql ya fue ejecutado.

####### V6.7.9 Etiquetas QR individuales y masivas
- Generación de QR estándar y escaneable por freezer con valor SCN-WMS:FREEZER:[chapa].
- Impresión individual desde el nuevo panel de etiquetas.
- Impresión masiva con selección, filtro y selección de visibles.
- Hoja A4 preparada en etiquetas de 70 x 50 mm, tres columnas.
- QR permanente: no cambia con estado, PDV ni ubicación.
- Mantiene lector Honeywell EDA51/cámara y toda la funcionalidad V6.7.8.
- No requiere SQL adicional respecto de SUPABASE-V678-QR-FREEZERS.sql.

####### V6.7.8 Mobile / Android / QR
- QR estable por freezer con formato SCN-WMS:FREEZER:[chapa].
- Lector universal: Honeywell EDA51 por entrada de scanner/teclado y cámara cuando Android ofrece BarcodeDetector.
- Ficha móvil de freezer desde QR o chapa.
- Usuario conectado y rol visibles también en pantallas móviles.
- Popup global de éxito ¡BUEN TRABAJO! para operaciones confirmadas como exitosas.
- Overlay de carga/spinner con logo y colores SCN disponible para operaciones asíncronas.
- SQL freezer_qr_registry preparado para persistencia única en Supabase.
- La V6.7.7 de ubicaciones se conserva sin alterar su RPC ni control de capacidad.
- Base preparada para empaquetado Android con Capacitor; el APK firmado requiere compilación Android externa.

####### V6.7.7 Ubicaciones fisicas de Deposito
- Maestro de ubicaciones con codigo, nombre, tipo y capacidad.
- Zonas iniciales REC-INGRESO, REC-CONTROL y PRE-DESPACHO.
- Asignacion y traslado de freezers por chapa y codigo de ubicacion.
- Consulta por chapa o ubicacion, ocupacion y responsable.
- Codigo de barras Code 39 imprimible sin dependencia externa.
- Historial de ubicacion integrado a la trazabilidad local.
- Todos los roles pueden consultar. SUPERVISOR y TRANSPORTE no pueden modificar.
- Solo ADMIN crea ubicaciones.
- Persistencia y control de capacidad mediante Supabase RPC.

####### V6.7.6 Asignación inteligente por PDV y operación CAMBIO
- ADMIN y LOGISTICA asignan ENTREGA, RETIRO y CAMBIO.
- El PDV completa razón social y dirección desde la base maestra local.
- El campo Vendedor queda visible y preparado; cuando la base no lo contiene muestra NO INFORMADO EN BASE MAESTRA.
- ENTREGA solo permite equipos RECIBIDO, RECIBIDO - NUEVO o DISPONIBLE en Ancaste 3023.
- RETIRO valida que la chapa esté asociada al PDV.
- CAMBIO vincula una chapa a retirar y otra a entregar en un mismo viaje.
- Inconsistencias generan incidencias persistentes para DEPOSITO o ADMINISTRACION.
- La asignación y finalización usan funciones atómicas en Supabase y bloquean chapas con viajes activos.
- Se conservó la finalización estable de V6.7.5 y se agregaron parámetros de versión a los archivos web.

####### V6.7.5 Finalización atómica de viajes
- Base estable V6.7.1, sin incorporar todavía la operación CAMBIO.
- ENTREGA y RETIRO se completan mediante la función SQL `complete_own_transport_trip`.
- Supabase verifica que el viaje esté EN CURSO y asignado al usuario autenticado.
- La interfaz no modifica el estado local ni recarga hasta recibir `COMPLETADO` desde Supabase.
- Eliminado el temporizador de sincronización que podía perder la actualización.
- Eliminada la referencia faltante a `vendor/jspdf.umd.min.js`; se conserva el PDF nativo de respaldo.

####### V6.7.1 Visibilidad de fleteros para LOGÍSTICA
- Política RLS adicional para que ADMIN vea perfiles y LOGÍSTICA/SUPERVISOR consulten transportistas activos.
- Selector informa claramente cuando no existen fleteros visibles.
- Estado vacío específico para TRANSPORTE sin viajes asignados.
- Versión de prueba.

####### V6.7.0 Usuarios, fleteros, viajes compartidos y cola de correo
- ADMIN edita perfiles, vehículo y patente.
- LOGISTICA asigna desde lista de transportistas activos.
- TRANSPORTE ve únicamente sus viajes y no ve el formulario de asignación.
- Flujo Aceptar → Iniciar → Confirmar entrega/retiro.
- Viajes compartidos en Supabase por assigned_driver_id.
- Cola notification_queue preparada para Power Automate + Outlook.
- Versión de prueba.

####### V6.6.9 Depósito, transporte e historial auditable
- Foto real obligatoria en alta y movimientos de Depósito.
- Confirmación de entrega/retiro con PDV, local, receptor, DNI, cargo, firma, fotos y ubicación opcional.
- Firma y fotos privadas en freezer-evidence mediante URL temporal.
- Historial detallado con estado anterior/nuevo y evidencias para roles habilitados.
- Versión de prueba, no producción.

####### V6.6.8 Evidencias reales en Supabase Storage
- Fotos subidas al bucket privado technical-claim-evidence.
- Supervisor y ADMIN pueden abrirlas mediante URL firmada temporal.
- Los reclamos anteriores que solo guardaron el nombre no pueden recuperar la imagen.

####### V6.6.7 Detalle de reclamos para Supervisor y ADMIN
- UUID técnico oculto en las tarjetas; se muestra únicamente la chapa.
- Botón Ver detalle / Ocultar detalle.
- Detalle auditable con PDV, fecha, motivo, evidencias, productos, cantidades, precios y subtotales.
- Autorizar, Rechazar y acciones de ADMIN dentro del detalle desplegado.
- Diseño responsive para escritorio y móvil.

###### V6.6.6 UUID de reclamos compatible con Supabase
- El identificador técnico usa crypto.randomUUID().
- Corrige invalid input syntax for type uuid causado por IDs NC-...
- Conserva las relaciones con claim_items y las políticas RLS existentes.
- Mantiene el flujo Servicio Técnico → Supervisor → ADMIN y el diagnóstico visible.

##### V6.6.5 Diagnóstico y confirmación de envío de reclamos
- Estado visible dentro de la ventana: Guardando, Enviando, éxito o error exacto de Supabase.
- Validación visible y foco automático en campos inválidos.
- El UID del creador se obtiene de la sesión real de Supabase.
- Tiempo máximo de espera de 15 segundos para evitar botones aparentemente congelados.

##### V6.6.4 Reclamos compartidos en Supabase
- Reclamos guardados en public.technical_claims, visibles según RLS.
- Servicio Técnico envía a PENDIENTE_SUPERVISOR.
- Supervisor autoriza o rechaza y ADMIN recibe los autorizados.
- ADMIN gestiona NC_PENDIENTE y NC_EMITIDA.
- Cantidad perdida editable manualmente sin restablecerse a 1 durante la escritura.

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
