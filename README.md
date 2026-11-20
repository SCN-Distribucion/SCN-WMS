####### V6.7.4 Finalización persistente de entregas y retiros
- La confirmación del repartidor actualiza directamente `transport_trips` en Supabase.
- El viaje cambia a `COMPLETADO` antes de recargar la pantalla.
- Se guardan `completed_at`, `confirmation` y `updated_at` con PDV, local, receptor, fotos, firma y ubicación.
- Si Supabase rechaza la actualización, la pantalla muestra el error y no informa una finalización falsa.

####### V6.7.2 Viaje CAMBIO
- Nuevo tipo CAMBIO para entregar un freezer y retirar otro en la misma visita.
- Dos chapas obligatorias y diferentes.
- Una única asignación, fletero, vehículo, patente, PDV, firma y visita.
- Historial distingue entrega y retiro dentro del mismo viaje.

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
