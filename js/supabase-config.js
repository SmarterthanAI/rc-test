/**
 * Supabase Client Configuration for RC-99 Platform
 * Injected by Vercel Production Build.
 */

(function () {
  'use strict';

  const BUILD_SUPABASE_URL = "https://zfprqrpeoyzdlvxayjdv.supabase.co";
  const BUILD_SUPABASE_ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpmcHJxcnBlb3l6ZGx2eGF5amR2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODY5Nzc2NjYsImV4cCI6MjEwMjU1MzY2Nn0.SgS4BvlvqIGnpeYE3nm6H4V3wd13JcnDaoJSTPgjJsg";

  let userConfig = null;
  try {
    const stored = localStorage.getItem('rc99_supabase_config');
    if (stored) userConfig = JSON.parse(stored);
  } catch (e) {}

  const activeUrl = (userConfig && userConfig.url) || window.SUPABASE_URL || BUILD_SUPABASE_URL;
  const activeAnonKey = (userConfig && userConfig.anonKey) || window.SUPABASE_ANON_KEY || BUILD_SUPABASE_ANON_KEY;

  window.isSupabaseActive = function () {
    return !!(
      window.supabaseClient &&
      activeUrl &&
      activeUrl.startsWith('https://') &&
      activeUrl.includes('.supabase.co') &&
      activeAnonKey &&
      activeAnonKey.length > 30
    );
  };

  if (window.supabase && typeof window.supabase.createClient === 'function') {
    try {
      window.supabaseClient = window.supabase.createClient(activeUrl, activeAnonKey, {
        auth: {
          persistSession: true,
          autoRefreshToken: true,
          detectSessionInUrl: true,
          storage: window.localStorage
        }
      });
      console.log('✓ Supabase Client active on: ' + activeUrl);
    } catch (err) {
      console.error('Supabase initialization failed:', err);
      window.supabaseClient = null;
    }
  } else {
    window.supabaseClient = null;
  }

})();
