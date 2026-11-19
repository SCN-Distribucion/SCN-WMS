(()=>{'use strict';
const $=s=>document.querySelector(s),rt=()=>window.WMS_RUNTIME,role=()=>String(rt()?.currentUser?.role||'').toUpperCase();
function improveEmptyStates(){
 const box=$('#trips'); if(!box)return;
 const cards=box.querySelectorAll('.trip-card').length;
 if(cards)return;
 if(role()==='TRANSPORTE')box.innerHTML='<div class="empty-trip-state"><b>No tenés viajes asignados</b><p>Cuando LOGÍSTICA te asigne una entrega o un retiro, aparecerá en esta pantalla.</p></div>';
 else if(['ADMIN','LOGISTICA','SUPERVISOR'].includes(role()))box.innerHTML='<div class="empty-trip-state"><b>No hay viajes asignados</b><p>Seleccioná un fletero activo y completá la chapa y el tipo de operación.</p></div>';
}
function improveDriverSelect(){
 const sel=$('#driverSelect');if(!sel||!['ADMIN','LOGISTICA'].includes(role()))return;
 if(sel.options.length===1&&sel.value===''){
  const txt=sel.options[0].textContent;
  if(txt==='Seleccionar fletero…')sel.options[0].textContent='No hay fleteros visibles. Ejecutá el SQL V671 o revisá usuarios TRANSPORTE activos.';
 }
}
document.querySelector('[data-v="transporte"]')?.addEventListener('click',()=>setTimeout(()=>{improveEmptyStates();improveDriverSelect()},900));
setInterval(()=>{if($('#transporte')?.classList.contains('on')){improveEmptyStates();improveDriverSelect()}},1500);
})();