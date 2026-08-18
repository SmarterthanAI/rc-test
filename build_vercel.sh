#!/usr/bin/env bash
set -e

echo "--- RC-99 Vercel Production Build Starting ---"

SUPA_URL="${SUPABASE_URL:-${NEXT_PUBLIC_SUPABASE_URL:-}}"
SUPA_KEY="${SUPABASE_ANON_KEY:-${NEXT_PUBLIC_SUPABASE_ANON_KEY:-}}"

echo "Supabase URL in build: $SUPA_URL"

mkdir -p js dist/js

cat <<EOF > js/supabase-config.js
/**
 * Supabase Client Configuration for RC-99 Platform
 * Injected by Vercel Production Build.
 */

(function () {
  'use strict';

  const BUILD_SUPABASE_URL = "${SUPA_URL}";
  const BUILD_SUPABASE_ANON_KEY = "${SUPA_KEY}";

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
    if (activeUrl && activeAnonKey && activeUrl.startsWith('https://') && activeAnonKey.length > 30) {
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
      console.log('ℹ Supabase is unconfigured. Set SUPABASE_URL and SUPABASE_ANON_KEY in Vercel to activate cloud authentication.');
    }
  } else {
    window.supabaseClient = null;
  }

})();
EOF

cp js/supabase-config.js dist/js/supabase-config.js

echo "✓ Supabase configuration generated."
echo "--- RC-99 Vercel Production Build Completed ---"
