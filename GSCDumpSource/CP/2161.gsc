// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    cruisepredator_createbackupheight();
    scripts\cp_mp\utility\script_utility::registersharedfunc( "cruise_predator", "directionOverride", ::cruisepredator_directionoverride );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "cruise_predator", "aICharacterChecks", ::cruisepredator_aicharacterchecks );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "cruise_predator", "CPMarkEnemies", ::cruisepredator_cpmarkenemies );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "cruise_predator", "CPUnMarkEnemies", ::cruisepredator_cpunmarkenemies );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "cruise_predator", "removeItemFromSlot", ::cruisepredator_removeitemfromslot );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "cruise_predator", "assignTargetMarkers", ::forceunsetdemeanor );
}

cruisepredator_directionoverride( var_0 )
{
    if ( isdefined( self.drone_strike_dir_override ) )
    {
        var_0 = anglestoforward( self.drone_strike_dir_override.angles );
        var_0 = vectornormalize( var_0 );
        var_0 = var_0 * ( 1, 1, 0 );
    }

    return var_0;
}

cruisepredator_aicharacterchecks( var_0 )
{
    if ( isai( var_0 ) || isplayer( var_0 ) )
        return 1;
    else
        return 0;
}

cruisepredator_createbackupheight()
{
    var_0 = spawn( "script_origin", level.mapcenter + ( 0, 0, 2576 ) );
    var_0.angles = ( 0, 0, 0 );
    var_0.targetname = "drone_strike_height";
    level.vdronestrikeheight = var_0;
}

forceunsetdemeanor( var_0 )
{
    var_1 = [];
    var_2 = [];
    var_3 = level.characters;
    var_4 = [];
    var_5 = level.players;
    var_6 = spawnstruct();

    if ( isdefined( level.remote_tanks ) )
    {
        foreach ( var_8 in level.remote_tanks )
        {
            if ( isdefined( var_8 ) )
                var_4 = scripts\engine\utility::array_add( var_4, var_8 );
        }
    }

    if ( isdefined( level.mark_heli ) && isdefined( level.heli ) )
        var_4 = scripts\engine\utility::array_add( var_4, level.heli );

    if ( isdefined( level.relicsquadlink ) )
    {
        foreach ( var_11 in level.relicsquadlink )
            var_4 = scripts\engine\utility::array_add( var_4, var_11 );
    }

    foreach ( var_14 in var_3 )
    {
        if ( level.teambased && var_14.team == var_0.team || var_14 == var_0 )
        {
            var_2[var_2.size] = var_14;
            continue;
        }

        if ( cruisepredator_aicharacterchecks( var_14 ) )
            var_1[var_1.size] = var_14;
    }

    var_16 = scripts\engine\utility::array_combine( var_4, var_1 );

    foreach ( var_14 in var_5 )
    {
        if ( level.teambased && var_14.team != var_0.team )
            continue;

        var_2[var_2.size] = var_14;
    }

    var_6.enemytargetmarkergroup = var_16;
    var_6.friendlytargetmarkergroup = var_2;
    return var_6;
}

cruisepredator_cpmarkenemies( var_0 )
{
    var_0.enemy_list = [];

    if ( isdefined( level.spawned_enemies ) )
    {
        for ( var_1 = 0; var_1 < level.spawned_enemies.size; var_1++ )
        {
            level.spawned_enemies[var_1] hudoutlineenableforclient( var_0, "outlinefill_depth_red" );
            var_0.enemy_list[var_0.enemy_list.size] = level.spawned_enemies[var_1];
        }
    }

    if ( isdefined( level.remote_tanks ) )
    {
        foreach ( var_3 in level.remote_tanks )
        {
            if ( isdefined( var_3 ) )
            {
                var_3 hudoutlineenableforclient( var_0, "outlinefill_depth_red" );
                var_0.enemy_list[var_0.enemy_list.size] = var_3;
            }
        }
    }

    if ( isdefined( level.mark_heli ) && isdefined( level.heli ) )
    {
        level.heli hudoutlineenableforclient( var_0, "outlinefill_depth_red" );
        var_0.enemy_list[var_0.enemy_list.size] = level.heli;
    }

    return var_0.enemy_list;
}

cruisepredator_cpunmarkenemies( var_0 )
{
    if ( isdefined( var_0.enemy_list ) )
    {
        foreach ( var_2 in var_0.enemy_list )
        {
            if ( isdefined( var_2 ) )
                var_2 hudoutlinedisableforclient( var_0 );
        }
    }
}

cruisepredator_removeitemfromslot( var_0 )
{
    var_0 scripts\cp\crafting_system::remove_crafted_item_from_slot( scripts\cp\crafting_system::getitemslot( "drone_strike" ) );
}
