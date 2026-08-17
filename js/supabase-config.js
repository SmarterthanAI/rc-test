/**
 * Supabase Client Configuration for RC-99 Platform
 * Safe Public Client initialization with JWT auto-refresh and session persistence.
 */

(function () {
  'use strict';

  // Default configuration (can be overridden via window.SUPABASE_CONFIG or Vercel ENV injection)
  const defaultConfig = {
    url: window.SUPABASE_URL || 'https://rc99-assessment.supabase.co',
    anonKey: window.SUPABASE_ANON_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJjOTkiLCJyb2xlIjoiYW5vbiIsImlhdCI6MTY4MDAwMDAwMCwiZXhwIjoxOTk1NTU1NTU1fQ.dummyKey'
  };

  // Check localStorage for custom override if user provided their credentials
  let userConfig = null;
  try {
    const stored = localStorage.getItem('rc99_supabase_config');
    if (stored) userConfig = JSON.parse(stored);
  } catch (e) {}

  const activeConfig = userConfig || defaultConfig;

  // Initialize Supabase Client if library is available
  if (window.supabase && typeof window.supabase.createClient === 'function') {
    try {
      window.supabaseClient = window.supabase.createClient(activeConfig.url, activeConfig.anonKey, {
        auth: {
          persistSession: true,
          autoRefreshToken: true,
          detectSessionInUrl: true,
          storage: window.localStorage
        }
      });
      console.log('✓ Supabase Client initialized successfully.');
    } catch (err) {
      console.warn('Supabase initialization fallback:', err);
      window.supabaseClient = null;
    }
  } else {
    window.supabaseClient = null;
  }

  // Global helper to check if Supabase is active
  window.isSupabaseActive = function () {
    return !!(window.supabaseClient && activeConfig.url && !activeConfig.url.includes('dummy'));
  };

})();
