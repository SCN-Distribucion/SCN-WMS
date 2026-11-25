(()=>{'use strict';
const $=s=>document.querySelector(s), $$=s=>[...document.querySelectorAll(s)];
const menus={
 deposito:[['entrada','Entrada / salida','📥'],['alta','Alta freezer nuevo','➕'],['ubicaciones','Ubicaciones','📍']],
 transporte:[['asignar','Asignar viaje','🚚'],['viajes','Historial de viajes','📋']],
 tecnico:[['gestion','Servicio técnico','🛠'],['reclamos','Historial de reclamos','🧾']],
 base:[['maestro','Base de freezers','🗄'],['qr','Etiquetas QR','🏷']],
 usuarios:[['nuevo','Agregar usuario nuevo','➕'],['lista','Usuarios','👥']]
};
let internal=false;
function mobile(){return matchMedia('(max-width:780px)').matches}
function closeAll(except=''){$$('.side-submenu-v772').forEach(x=>{if(x.dataset.owner!==except)x.hidden=true});$$('#sidebar nav>[data-v]').forEach(x=>x.classList.toggle('menu-expanded-v772',x.dataset.v===except));}
function nativeOpen(mod){const b=$(`#sidebar nav>[data-v="${mod}"]`);if(!b)return;internal=true;b.click();internal=false}
function showOnly(sec,els){if(!sec)return;[...sec.children].forEach(x=>x.hidden=true);els.filter(Boolean).forEach(x=>x.hidden=false)}
function select(mod,key,btn){nativeOpen(mod);const sec=$('#'+mod);if(!sec)return;
 if(mod==='deposito'){const articles=[...sec.querySelectorAll(':scope>article')], main=articles.find(x=>x.id!=='newWrap'&&x.id!=='warehouse677'), nw=$('#newWrap'), wh=$('#warehouse677'); if(key==='entrada')showOnly(sec,[main]); if(key==='alta')showOnly(sec,[nw]); if(key==='ubicaciones')showOnly(sec,[wh]); const sh=$('#showNew'); if(sh)sh.hidden=true;}
 if(mod==='transporte'){const article=sec.querySelector(':scope>article'), trips=$('#trips');showOnly(sec,key==='asignar'?[article]:[trips]);}
 if(mod==='tecnico'){const article=sec.querySelector(':scope>article'); if(article){[...article.children].forEach(x=>x.hidden=false); const form=$('#techForm'), divider=article.querySelector('.divider'), tools=article.querySelector('.tools'), list=$('#claimList'), head=article.querySelector('.section-head'); if(key==='gestion'){if(form)form.hidden=false;if(divider)divider.hidden=true;if(tools)tools.hidden=true;if(list)list.hidden=true;if(head)head.hidden=true}else{if(form)form.hidden=true;if(divider)divider.hidden=true;if(tools)tools.hidden=false;if(list)list.hidden=false;if(head)head.hidden=false}}}
 if(mod==='base'){if(key==='maestro'){const q=$('#qrManagerV7');if(q)q.hidden=true;[...sec.children].forEach(x=>{if(x!==q)x.hidden=false})}else{const q=$('#qrManagerV7');if(q){[...sec.children].forEach(x=>x.hidden=x!==q);q.hidden=false}else document.querySelector('#qrV7Button')?.click()}}
 if(mod==='usuarios'){const article=sec.querySelector(':scope>article'), form=$('#userForm'), list=$('#userList');if(article){[...article.children].forEach(x=>x.hidden=false);if(form)form.hidden=key!=='nuevo';if(list)list.hidden=key!=='lista'}}
 $$('.side-submenu-v772 button').forEach(x=>x.classList.toggle('on',x===btn));
 if(mobile())document.body.classList.add('sidebar-collapsed');
}
function build(){const nav=$('#sidebar nav');if(!nav||$('#subnav772-deposito'))return false;
 Object.entries(menus).forEach(([mod,items])=>{const parent=nav.querySelector(`:scope>[data-v="${mod}"]`);if(!parent)return;const sub=document.createElement('div');sub.id='subnav772-'+mod;sub.dataset.owner=mod;sub.className='side-submenu-v772';sub.hidden=true;sub.innerHTML=items.map(([k,l,i])=>`<button type="button" data-m772="${mod}" data-k772="${k}"><span>${i}</span><b>${l}</b></button>`).join('');parent.after(sub);});
 nav.addEventListener('click',e=>{const item=e.target.closest('[data-m772]');if(item){e.preventDefault();e.stopImmediatePropagation();select(item.dataset.m772,item.dataset.k772,item);return}const parent=e.target.closest(':scope>[data-v]');if(!parent||internal)return;const mod=parent.dataset.v;if(!menus[mod]){closeAll();return}e.preventDefault();e.stopImmediatePropagation();const sub=$('#subnav772-'+mod), open=!sub.hidden;closeAll(open?'':mod);sub.hidden=open;parent.classList.toggle('menu-expanded-v772',!open);},true);
 return true;}
function cleanLegacy(){ $$('.side-submenu-v703').forEach(x=>x.remove()); }
let tries=0;const timer=setInterval(()=>{tries++;if(window.WMS_RUNTIME?.currentUser&&build()){cleanLegacy();clearInterval(timer)}if(tries>120)clearInterval(timer)},250);
})();
