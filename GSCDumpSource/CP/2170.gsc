// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    scripts\cp_mp\utility\script_utility::registersharedfunc( "toma_strike", "munitionUsed", ::_id_12772 );
}

_id_12772( var_0, var_1 )
{
    self notify( "munitions_used", "cluster_strike" );
}
