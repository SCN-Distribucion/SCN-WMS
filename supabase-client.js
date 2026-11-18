(()=>{
 const cfg=window.SCN_SUPABASE_CONFIG;
 if(!cfg?.url||!cfg?.publishableKey||!window.supabase){console.error('Configuración Supabase incompleta');return;}
 window.scnSupabase=window.supabase.createClient(cfg.url,cfg.publishableKey,{auth:{persistSession:true,autoRefreshToken:true,detectSessionInUrl:true}});
})();
