// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    level thread onplayerconnect();
}

onplayerconnect()
{
    level.onplayerspawncallbacks = [];

    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0 thread onplayerspawned();
    }
}

registeronplayerspawncallback( var_0 )
{
    level.onplayerspawncallbacks[level.onplayerspawncallbacks.size] = var_0;
}

onplayerspawned()
{
    self endon( "disconnect" );

    for (;;)
    {
        scripts\engine\utility::_id_12E3F( "loadout_given", "spawned_player" );

        foreach ( var_1 in level.onplayerspawncallbacks )
            self [[ var_1 ]]();
    }
}
