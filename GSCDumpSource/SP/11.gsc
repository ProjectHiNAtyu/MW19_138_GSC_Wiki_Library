// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

scriptable_initialize()
{
    scripts\engine\scriptable::scriptable_engineinitialize();
}

scriptable_post_initialize()
{
    scripts\engine\scriptable::scriptable_enginepostinitialize();
}

scriptable_used( var_0, var_1, var_2, var_3 )
{
    scripts\engine\scriptable::scriptable_engineused( var_0, var_1, var_2, var_3 );
}

scriptable_touched( var_0, var_1, var_2, var_3 )
{
    scripts\engine\scriptable::scriptable_enginetouched( var_0, var_1, var_2, var_3 );
}

scriptable_notify_callback( var_0, var_1, var_2 )
{
    scripts\engine\scriptable::scriptable_enginenotifycallback( var_0, var_1, var_2 );
}
