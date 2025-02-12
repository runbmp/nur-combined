// begin
user_pref("browser.urlbar.suggest.topsites", false);
user_pref("browser.warnOnQuitShortcut", false);
user_pref("extensions.activeThemeID", "elemental-soft-colorway@mozilla.org");
/*** wavefox ***/
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
user_pref("layout.css.color-mix.enabled", true);
user_pref("layout.css.has-selector.enabled", true);
user_pref("svg.context-properties.content.enabled", true);
user_pref("userChrome.Tabs.Option7.Enabled", true);
user_pref("userChrome.TabSeparatorsMediumSaturation-Enabled", true);
user_pref("userChrome.CompactContextMenu-Enabled", true);
user_pref("userChrome.RegularMenuIcons-Enabled", true);
/*** [SECTION 0700]: DNS / DoH / PROXY / SOCKS / IPv6 ***/
user_pref("network.trr.mode", 5); // explicitly off
user_pref("network.proxy.no_proxies_on", "localhost,127.0.0.1,192.168.0.0/16");
/*** [SECTION 2700]: ETP (ENHANCED TRACKING PROTECTION) ***/
user_pref("browser.contentblocking.category", "standard");
/*** [SECTION 2800]: SHUTDOWN & SANITIZING ***/
user_pref("privacy.clearOnShutdown.history", false);
/*** [SECTION 5000]: OPTIONAL OPSEC ***/
user_pref("signon.rememberSignons", false);
// end
