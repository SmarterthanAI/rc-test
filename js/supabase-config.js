/**
 * Supabase Client Configuration for RC-99 Platform
 * Safe Public Client initialization with JWT auto-refresh and session persistence.
 */

(function () {
  'use strict';

  // =========================================================================
  // SUPABASE CREDENTIALS CONFIGURATION (Browser Vanilla JS)
  // Paste your Supabase Project URL & Anon Key below (or configure via window):
  // =========================================================================
  const CONFIGURED_URL = window.SUPABASE_URL || '';
  const CONFIGURED_ANON_KEY = window.SUPABASE_ANON_KEY || '';

  // Check localStorage for custom override if user set credentials via UI
  let userConfig = null;
  try {
    const stored = localStorage.getItem('rc99_supabase_config');
    if (stored) userConfig = JSON.parse(stored);
  } catch (e) {}

  const activeUrl = (userConfig && userConfig.url) || CONFIGURED_URL;
  const activeAnonKey = (userConfig && userConfig.anonKey) || CONFIGURED_ANON_KEY;

  // Validation function: checks if a valid real Supabase project is configured
  window.isSupabaseActive = function () {
    return !!(
      window.supabaseClient &&
      activeUrl &&
      activeUrl.startsWith('https://') &&
      activeUrl.includes('.supabase.co') &&
      !activeUrl.includes('rc99-assessment') &&
      activeAnonKey &&
      activeAnonKey.length > 30 &&
      !activeAnonKey.includes('dummy')
    );
  };

  // Initialize Supabase Client if library is available and credentials are set
  if (window.supabase && typeof window.supabase.createClient === 'function') {
    if (activeUrl && activeAnonKey && !activeUrl.includes('rc99-assessment') && !activeAnonKey.includes('dummy')) {
      try {
        window.supabaseClient = window.supabase.createClient(activeUrl, activeAnonKey, {
          auth: {
            persistSession: true,
            autoRefreshToken: true,
            detectSessionInUrl: true,
            storage: window.localStorage
          }
        });
        console.log('✓ Supabase Client initialized successfully.');
      } catch (err) {
        console.warn('Supabase initialization warning:', err);
        window.supabaseClient = null;
      }
    } else {
      window.supabaseClient = null;
      console.log('ℹ Supabase is in local standalone mode. Set SUPABASE_URL and SUPABASE_ANON_KEY to enable cloud sync.');
    }
  } else {
    window.supabaseClient = null;
  }

})();
