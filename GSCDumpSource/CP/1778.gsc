// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

scriptable_cpglobalcallback()
{
    scripts\engine\scriptable::scriptable_setinitcallback( ::scriptable_cpcallback );
}

scriptable_cpcallback()
{
    if ( !scripts\engine\utility::flag_exist( "scriptables_ready" ) )
        scripts\engine\utility::flag_init( "scriptables_ready" );

    scripts\engine\utility::flag_set( "scriptables_ready" );
}
