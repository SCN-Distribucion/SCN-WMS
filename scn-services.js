(() => {
  'use strict';
  const client = () => window.scnSupabase;
  const requireClient = () => {
    const db = client();
    if (!db) throw new Error('SCN Services no pudo iniciar la conexion con Supabase.');
    return db;
  };
  const detectChannel = () => {
    if (window.Capacitor?.isNativePlatform?.()) return 'MOBILE';
    return matchMedia('(max-width: 780px)').matches ? 'MOBILE' : 'WEB';
  };
  const context = { channel: detectChannel(), version: '7.8.4', app: 'SCN-WMS' };
  const withMeta = payload => ({ ...payload, _scn: { ...context, at: new Date().toISOString() } });
  const services = {
    get client() { return requireClient(); },
    context,
    setChannel(channel) {
      const value = String(channel || '').trim().toUpperCase();
      if (!['WEB', 'MOBILE', 'BOT', 'API'].includes(value)) throw new Error('Canal SCN invalido.');
      context.channel = value;
      return { ...context };
    },
    auth: {
      session: async () => (await requireClient().auth.getSession()).data.session,
      signIn: (email, password) => requireClient().auth.signInWithPassword({ email, password }),
      signOut: () => requireClient().auth.signOut(),
      updatePassword: password => requireClient().auth.updateUser({ password })
    },
    data: {
      select(table, columns = '*') { return requireClient().from(table).select(columns); },
      insert(table, payload) { return requireClient().from(table).insert(payload); },
      update(table, payload) { return requireClient().from(table).update(payload); },
      rpc(name, payload = {}) { return requireClient().rpc(name, withMeta(payload)); }
    },
    storage: {
      upload(bucket, path, file, options = {}) { return requireClient().storage.from(bucket).upload(path, file, options); },
      signedUrl(bucket, path, seconds = 120) { return requireClient().storage.from(bucket).createSignedUrl(path, seconds); }
    },
    bot: {
      contractVersion: '2026-11-25',
      capabilities: ['FREEZER_LOOKUP', 'TRACEABILITY', 'TRIPS', 'CLAIMS', 'WAREHOUSE_LOCATIONS'],
      describe() { return { app: context.app, version: context.version, channel: context.channel, capabilities: [...this.capabilities] }; }
    }
  };
  window.SCN = Object.freeze({ services });
  window.scnServices = services;
})();
