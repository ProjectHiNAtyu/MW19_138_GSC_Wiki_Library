// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

precache( var_0 )
{
    scripts\sp\equipment\offhands::registeroffhandfirefunc( var_0, ::pipebombfiremain );
}

pipebombfiremain( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    thread scripts\anim\battlechatter_ai.gsc::evaluateattackevent( "frag" );
}
