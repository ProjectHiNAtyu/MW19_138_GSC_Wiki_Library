// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

sp_stealth_broken_listener()
{
    scripts\cp_mp\utility\script_utility::registersharedfunc( "motorcycle", "spawnCallback", ::spawn_ai_and_seat_in_vehicle );
    spawn_acceleration();
    spawn_additional_covernode();
    scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback( "motorcycle", scripts\cp_mp\vehicles\customization\battle_tracks::sort_wave_spawning_ai );
}

spawn_additional_covernode()
{
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle( "motorcycle", 1 );
    var_0.ai_goal_distribution_debug = scripts\cp_mp\vehicles\vehicle_spawn::_id_12CE3;
}

spawn_acceleration()
{
    var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle( "motorcycle", 1 );
    var_0.frontextents = 45;
    var_0.backextents = 45;
    var_0.leftextents = 28;
    var_0.rightextents = 28;
    var_0.bottomextents = 15;
    var_0.distancetobottom = 30;
    var_0.loscheckoffset = ( 0, 0, 30 );
}

spawn_ai_and_seat_in_vehicle( var_0, var_1 )
{
    var_2 = scripts\cp_mp\vehicles\customization\battle_tracks::sololink( var_0, var_1 );

    if ( isdefined( var_2 ) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn() )
        var_2.ondeathrespawn = ::spawn_addtoarrays;

    return var_2;
}

spawn_addtoarrays()
{
    thread spawn_ai_func_ref();
}

spawn_ai_func_ref()
{
    var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata( self );
    var_1 = spawnstruct();
    scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata( var_0, var_1 );
    var_2 = spawnstruct();
    var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_12CEC( "motorcycle", var_1, var_2 );
}
