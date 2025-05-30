// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    level thread col_createquestlocale();
    level thread col_localethink_itemspawn();
    level thread col_circletick();
    level thread col_createcircleobjectiveicon();
    setdvarifuninitialized( "scr_brmini_circle_setting", 0 );
    level.watch_for_driver_death = getdvarint( "scr_brmini_questDomDistMin", 2000 );
    level.watch_for_damage_on_turret = getdvarint( "scr_brmini_questDomDistMax", 4000 );
    level.watch_for_convoy_escape = getdvarint( "scr_brmini_questAssDistMin", 2500 );
    level.watch_for_attack = getdvarint( "scr_brmini_questAssDistMax", 5500 );
    level.watch_for_flash_detonation = getdvarint( "scr_brmini_questScavDistMin", 2000 );
    level.watch_for_driver_spawned = getdvarint( "scr_brmini_questScavDistMax", 4000 );
}

col_createquestlocale()
{
    if ( getdvarint( "scr_brmini_debug", 0 ) == 1 )
    {
        scripts\mp\gametypes\br_gametypes.gsc::give_fists( "circle" );
        scripts\mp\gametypes\br_gametypes.gsc::give_fists( "gulag" );
        scripts\mp\gametypes\br_gametypes.gsc::give_fists( "dropbag" );
        scripts\mp\gametypes\br_gametypes.gsc::give_fists( "oneLife" );
        scripts\mp\gametypes\br_gametypes.gsc::hostdamagepercentmedium( "allowLateJoiners" );
    }

    scripts\mp\gametypes\br_gametypes.gsc::give_fists( "plunderSites" );
    scripts\mp\gametypes\br_gametypes.gsc::give_fists( "randomizeCircleCenter" );
    scripts\mp\gametypes\br_gametypes.gsc::give_fists( "planeSnapToOOB" );
    scripts\mp\gametypes\br_gametypes.gsc::hostdamagepercentmedium( "tabletReplace" );
    scripts\mp\gametypes\br_gametypes.gsc::hostdamagepercentmedium( "planeUseCircleRadius" );
    scripts\mp\gametypes\br_gametypes.gsc::hostdamagepercentmedium( "circleEarlyStart" );
}

col_localethink_itemspawn()
{
    scripts\mp\gametypes\br_gametypes.gsc::zombienumhitshuman( "createC130PathStruct", ::col_checkiflocaleisavailable );
    scripts\mp\gametypes\br_gametypes.gsc::zombienumhitshuman( "addToC130Infil", ::codephonescriptableused );
    scripts\mp\gametypes\br_gametypes.gsc::zombienumhitshuman( "playerWelcomeSplashes", ::col_removequestinstance );
    scripts\mp\gametypes\br_gametypes.gsc::zombienumhitsheli( "dropBagDelay", 100 );
    waittillframeend;
    level.ontimelimit = ::col_removelocaleinstance;
    col();
    level._id_12BC4 = [];
    level._id_12BC4[0] = "assassination";
    level._id_12BC4[1] = "domination";
    level._id_12BC4[2] = "scavenger";
}

col_circletick()
{
    level endon( "game_ended" );
    level waittill( "br_dialog_initialized" );
}

col()
{
    scripts\cp_mp\utility\game_utility::_id_11A27( "delete_on_load", "targetname" );
    scripts\cp_mp\utility\game_utility::_id_11A28( "door_prison_cell_metal_mp", 1 );
    scripts\cp_mp\utility\game_utility::_id_11A28( "door_wooden_panel_mp_01", 1 );
    scripts\cp_mp\utility\game_utility::_id_11A28( "me_electrical_box_street_01", 1 );
}

col_createcircleobjectiveicon()
{

}

col_removequestinstance( var_0 )
{
    self endon( "disconnect" );
    self waittill( "spawned_player" );
    wait 1;
    scripts\mp\hud_message::showsplash( "br_gametype_mini_prematch_welcome" );

    if ( !istrue( level.br_infils_disabled ) )
    {
        self waittill( "br_jump" );

        while ( !self isonground() )
            waitframe();
    }
    else
        level waittill( "prematch_done" );

    scripts\mp\gametypes\br_analytics.gsc::choppersupport_watchleashrange( self );
    wait 1;
    scripts\mp\hud_message::showsplash( "br_gametype_mini_welcome" );
    scripts\mp\gametypes\br_public.gsc::cloud_cover( "primary_objective", self, 0 );
}

col_removelocaleinstance()
{
    if ( isdefined( level.numendgame ) )
        level thread scripts\mp\gametypes\br.gsc::startendgame( 1 );

    level.numendgame = undefined;
}

col_checkiflocaleisavailable()
{
    var_0 = ( level.br_level.checkpoint_create_carepackage[1][0], level.br_level.checkpoint_create_carepackage[1][1], 0 );
    var_1 = level.br_level.br_circleradii[1];
    var_2 = scripts\mp\gametypes\br_c130.gsc::createtestc130path( var_0, var_1 );
    return var_2;
}

codephonescriptableused()
{
    thread col_localethink_objectivevisibility();
}

col_localethink_objectivevisibility()
{
    level endon( "game_ended" );
    self endon( "death" );
    var_0 = distance( self.teleport_text_updated.startpt, self.teleport_text_updated.hvt_delayed_cig );
    var_1 = var_0 / scripts\mp\gametypes\br_c130.gsc::getc130speed() - 5;
    wait( var_1 );

    foreach ( var_3 in level.players )
    {
        if ( isdefined( var_3 ) && isdefined( var_3.br_infil_type ) && var_3.br_infil_type == "c130" && !isdefined( var_3.jumptype ) )
        {
            var_3.jumptype = "outOfBounds";
            var_3 notify( "halo_kick_c130" );
        }
    }
}
