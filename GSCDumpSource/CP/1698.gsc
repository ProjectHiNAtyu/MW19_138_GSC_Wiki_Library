// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init_drone_strike()
{
    createdronestrikeheightpoint();
    level.drone_strike_activate_function = ::dronestrikeactivatefunc;
    setdvarifuninitialized( "scr_cruise_3rd", 0 );
    setdvarifuninitialized( "scr_cruise_intro_anim", 0 );
    setdvarifuninitialized( "scr_cruise_detach_dist", 1000 );
    setdvarifuninitialized( "scr_cruise_detach_height", 0 );
    setdvarifuninitialized( "scr_cruise_impact_dist", 50 );
    setdvarifuninitialized( "scr_cruise_impact_boost_dist", 150 );
    setdvarifuninitialized( "scr_cruise_impact_type", 1 );
}

dronestrikeactivatefunc( var_0 )
{
    var_1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo( "cruise_predator", var_0 );
    thread tryusedronestrike( var_1 );
}

createdronestrikeheightpoint()
{
    var_0 = spawn( "script_origin", ( -16, 0, 2576 ) );
    var_0.angles = ( 0, 0, 0 );
    var_0.targetname = "drone_strike_height";
    level.vdronestrikeheight = var_0;
}

weapongivendronestrike( var_0 )
{

}

tryusedronestrike( var_0 )
{
    var_1 = playremotesequence( var_0 );
    thread runcruisepredator( var_0.streakname, var_0, undefined );

    foreach ( var_3 in level.players )
    {
        if ( var_3 != self )
            var_3 thread scripts\cp\cp_hud_message::showsplash( "cp_used_drone_strike", undefined, self );
    }
}

runcruisepredator( var_0, var_1, var_2 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_3 = "used_cruise_predator";
    self notifyonplayercommand( "missileTargetSet", "+attack" );
    self notifyonplayercommand( "missileTargetSet", "+attack_akimbo_accessible" );
    var_4 = getent( "drone_strike_height", "targetname" );
    var_5 = ( 0, 0, 10000 );

    if ( isdefined( var_4 ) )
        var_5 = var_4.origin[2] + 6000;
    else
        var_5 = self.origin[2] + 6000;

    var_6 = [];
    var_7 = ( 0, 0, 0 );
    var_8 = undefined;

    foreach ( var_10 in level.characters )
    {
        if ( var_10 == self )
            continue;

        if ( isplayer( var_10 ) )
            continue;

        var_7 = var_7 + ( var_10.origin - level.mapcenter );
        var_6[var_6.size] = var_10;
    }

    if ( isdefined( var_7 ) && var_6.size > 0 )
    {
        var_8 = vectornormalize( var_7 / var_6.size );
        var_8 = var_8 * ( 1, 1, 0 );
    }
    else
    {
        var_12 = randomint( 360 );
        var_8 = anglestoforward( ( 0, var_12, 0 ) );
    }

    if ( isdefined( self.drone_strike_dir_override ) )
    {
        var_8 = anglestoforward( self.drone_strike_dir_override.angles );
        var_8 = vectornormalize( var_8 );
        var_8 = var_8 * ( 1, 1, 0 );
    }

    var_13 = self.origin + ( 0, 0, var_5 );
    var_14 = var_13 + var_8 * -3000;
    var_14 = var_13 + var_8 * -3000;
    var_15 = var_13;
    var_16 = spawn( "script_model", var_14 );
    var_16 setmodel( "wmd_vm_missile_cruise" );
    var_16.owner = self;
    var_16.origin = var_14;
    var_16.angles = vectortoangles( var_15 - var_14 );
    var_16.type = "remote";
    var_16.team = self.team;
    var_16.entitynumber = var_16 getentitynumber();
    var_16.streakinfo = var_1;
    var_16.duration = 30;
    self.restoreangles = self getplayerangles();
    level.rockets[var_16.entitynumber] = var_16;
    level.remotemissileinprogress = 1;
    thread cruisepredator_followmissilepod( var_16, var_15, var_2, var_0 );
    thread cruisepredator_watchownerdisown( var_16 );
}

#using_animtree("script_model");

cruisepredator_followmissilepod( var_0, var_1, var_2, var_3 )
{
    var_0 endon( "death" );
    level endon( "game_ended" );
    var_4 = scripts\engine\utility::get_notetrack_time( %mp_cruise_missile_move_intro, "wingtrails" );
    var_5 = scripts\engine\utility::get_notetrack_time( %mp_cruise_missile_move_intro, "shell_break" );
    var_6 = scripts\engine\utility::get_notetrack_time( %mp_cruise_missile_move_intro, "second_missile_thruster" );
    var_7 = scripts\engine\utility::get_notetrack_time( %mp_cruise_missile_move_intro, "anim_end" );
    var_8 = var_4;
    var_9 = var_5 - var_4;
    var_10 = var_6 - var_5;
    var_11 = var_7 - var_6;
    var_12 = undefined;
    var_13 = undefined;

    if ( !istrue( var_2 ) )
    {
        scripts\common\utility::allow_fire( 0 );
        scripts\common\utility::allow_melee( 0 );
        scripts\common\utility::allow_weapon_switch( 0 );
        scripts\common\utility::allow_usability( 0 );
        self setclientomnvar( "ui_predator_missile", 1 );
        var_12 = mark_enemies( self );
        self playerlinkweaponviewtodelta( var_0, "tag_player", 1, 0, 0, 0, 0, 1 );
        self playerlinkedsetviewznear( 0 );
    }

    scripts\cp\utility::setdof_cruisethird();
    var_14 = "mp_cruise_missile_move_intro";
    var_15 = getdvarint( "scr_cruise_intro_anim", 0 );

    if ( var_15 == 1 )
        var_14 = "mp_cruise_missile_move_angle_intro";

    var_0 scriptmodelplayanimdeltamotion( var_14 );
    var_0 setscriptablepartstate( "main_thruster", "on", 0 );
    var_0 setscriptablepartstate( "clouds", "on", 0 );

    if ( !istrue( var_2 ) )
        self playlocalsound( "iw8_cruise_missile_plr_intro" );

    scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause( var_8 );
    var_0 setscriptablepartstate( "wing_trails", "on" );
    scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause( var_9 );
    var_0 setscriptablepartstate( "wing_trails", "off" );
    var_0 setscriptablepartstate( "main_thruster", "off", 0 );
    scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause( var_10 );
    var_0 setscriptablepartstate( "sub_thruster", "on", 0 );
    scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause( var_11 - 0.32 );

    if ( !istrue( var_2 ) )
    {

    }

    scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause( 0.1 );
    var_16 = scripts\cp_mp\utility\weapon_utility::_magicbullet( getcompleteweaponname( "cruise_proj_mp" ), var_0 gettagorigin( "tag_missile" ), var_0 gettagorigin( "tag_missile" ) + anglestoforward( var_0 gettagangles( "tag_missile" ) ) * 10, self );
    var_16.angles = var_0 gettagangles( "tag_missile" );
    var_16 setmissileminimapvisible( 1 );
    var_16 setotherent( self );
    var_16.team = self.team;
    var_16.owner = self;
    var_16.killcament = spawn( "script_model", var_16 gettagorigin( "tag_player" ) );
    var_16.killcament setmodel( "tag_origin" );
    var_16.killcament linkto( var_16, "tag_player" );
    var_17 = spawn( "script_model", var_16 gettagorigin( "tag_fx" ) );
    var_17 setmodel( "ks_cruise_predator_mp" );
    var_17.angles = var_16 gettagangles( "tag_fx" );
    var_17 linkto( var_16, "tag_fx" );
    var_17 setscriptablepartstate( "fake_trail", "on", 0 );
    var_17 setotherent( self );
    scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause( 0.1 );
    var_0 hide();

    if ( !istrue( var_2 ) )
    {

    }

    scripts\cp\utility::setdof_cruisefirst();
    var_0 setscriptablepartstate( "clouds", "off", 0 );
    var_0 setscriptablepartstate( "sub_thruster", "off", 0 );

    if ( !istrue( var_2 ) )
    {
        self cameraunlink();
        self cameralinkto( var_16, "tag_player", 1 );
        self controlslinkto( var_16 );
        self playlocalsound( "iw8_cruise_missile_plr" );
        self setclientomnvar( "ui_predator_missile", 2 );
        self setclientomnvar( "ui_killstreak_health", 1 );
        self setclientomnvar( "ui_killstreak_countdown", gettime() + int( 10000 ) );
        self setclientomnvar( "ui_predator_missiles_left", -1 );
        self visionsetkillstreakforplayer( "proto_cruise_mp" );

        if ( istrue( level.thermal ) )
        {
            self thermalvisionon();
            self visionsetthermalforplayer( "flir_0_black_to_white" );
        }

        self setplayerangles( var_16.angles );
        var_16 hidefromplayer( self );
    }

    var_18 = randomintrange( 1, 3 );
    var_16 enablemissileboosting();
    var_16 thread cruisepredator_watchexplosion( self, var_16.killcament, var_2, var_17, var_12, var_13 );
    var_16 thread cruisepredator_watchtimer( self );

    if ( isdefined( var_0 ) )
        var_0 delete();
}

cruisepredator_watchexplosion( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = var_1;
    var_7 = undefined;
    var_8 = undefined;
    var_9 = cruisepredator_waittillexplode( "missile_stuck", "explode" );

    if ( isdefined( var_4 ) )
        unmark_enemies( var_0 );

    if ( isdefined( var_5 ) )
    {

    }

    if ( isdefined( var_9 ) )
    {
        if ( isdefined( self ) )
        {
            var_7 = self.origin;
            var_8 = self.angles;

            if ( var_9.msg == "missile_stuck" )
            {
                var_10 = 400;
                var_11 = var_7 + ( 0, 0, int( var_10 / 8 ) );
                var_12 = [];
                var_13 = var_9.param1;

                if ( isdefined( var_13 ) )
                    var_13 dodamage( 10000, var_7, var_0, self, "MOD_EXPLOSIVE", "cruise_proj_mp" );

                foreach ( var_15 in level.characters )
                {
                    if ( !isdefined( var_15 ) || !var_15 scripts\cp_mp\utility\player_utility::_isalive() )
                        continue;

                    if ( isplayer( var_15 ) )
                        continue;

                    if ( distancesquared( var_11, var_15.origin ) > 320000 )
                        continue;

                    var_12[var_12.size] = var_15;
                }

                if ( isdefined( level.remote_tanks ) )
                {
                    foreach ( var_18 in level.remote_tanks )
                    {
                        if ( isdefined( var_18 ) )
                        {
                            if ( distancesquared( var_11, var_18.origin ) > 320000 )
                                continue;

                            var_12[var_12.size] = var_18;
                        }
                    }
                }

                if ( var_12.size > 0 )
                {
                    var_20 = scripts\engine\trace::create_contents( 0, 1, 1, 1, 1, 0, 1, 1 );

                    foreach ( var_22 in var_12 )
                    {
                        var_23 = var_22.origin + ( 0, 0, 10 );

                        if ( var_22.classname != "script_vehicle" )
                            var_23 = var_22 geteye();

                        var_24 = scripts\engine\trace::ray_trace_passed( var_11, var_23, self, var_20 );

                        if ( istrue( var_24 ) )
                            var_22 dodamage( 10000, var_7, var_0, self, "MOD_EXPLOSIVE", "cruise_proj_mp" );
                    }
                }

                playrumbleonposition( "artillery_rumble", var_7 );
                earthquake( 0.09, 1, var_7, 800 );
                self detonate();
            }
        }
    }

    var_3 thread cruisepredator_handlevfxstates( self, var_0, var_9 );

    if ( isdefined( var_0 ) )
    {
        var_0 thread cruisepredator_watchkills( var_9 );

        if ( !istrue( var_2 ) )
        {
            var_0 stoplocalsound( "iw8_cruise_missile_plr" );
            var_0 stoplocalsound( "iw8_cruise_missile_plr_lsrs" );
            var_0 stoplocalsound( "iw8_cruise_missile_plr_lfe" );
            var_0 setclientomnvar( "ui_predator_missile", 0 );
            var_0 visionsetkillstreakforplayer( "" );
            var_0 thermalvisionoff();
            var_26 = getdvarint( "scr_cruise_impact_type", 1 );

            if ( !isdefined( var_7 ) )
            {
                var_0 cruisepredator_returnplayer();
                return;
            }

            var_27 = spawn( "script_model", var_7 );
            var_27 setmodel( "tag_player" );
            var_28 = getdvarint( "scr_cruise_detach_dist", 1000 );
            var_29 = getdvarint( "scr_cruise_detach_height", 0 );

            if ( !isdefined( var_8 ) )
            {
                var_0 cruisepredator_returnplayer();
                return;
            }

            var_30 = anglestoforward( var_8 );
            var_31 = var_7 - var_30 * var_28;
            var_32 = ( 0, 0, var_29 );
            var_33 = var_31 + var_32;
            var_27.angles = vectortoangles( var_7 + ( 0, 0, 150 ) - var_33 );
            var_6 unlink();
            var_6 linkto( var_27, "tag_player", ( 0, 0, 0 ), ( 0, 0, 0 ) );
            var_0 cameraunlink();

            if ( var_26 == 1 || var_26 == 2 )
            {
                var_27.origin = var_33;
                var_0 playerlinkweaponviewtodelta( var_27, "tag_player", 1, 0, 0, 0, 0, 1 );
                var_0 playerlinkedsetviewznear( 0 );
                var_0 setplayerangles( var_27.angles );
                var_34 = "cruise_predator_static";

                if ( var_26 == 2 )
                    var_34 = "cruise_predator_flash";

                var_0 thread cruisepredator_startfadecamtransition( 0.4, 0.1, 0.05, var_34 );
                var_0 earthquakeforplayer( 0.3, 2, var_0.origin, 100 );
                var_0 playrumbleonpositionforclient( "artillery_rumble", var_0.origin );
                wait 0.1;
            }
            else
            {
                var_27 thread cruisepredator_cameramove( var_33, var_7 );
                var_0 thread cruisepredator_startexplodecamtransition();
                var_0 playerlinkweaponviewtodelta( var_27, "tag_player", 1, 0, 0, 0, 0, 1 );
                var_0 playerlinkedsetviewznear( 0 );
                var_0 setplayerangles( var_27.angles );
                var_0 playlocalsound( "iw8_cruise_missile_exp" );
                var_0 earthquakeforplayer( 0.25, 1.5, var_33, 5000 );
                wait 1.3;
                var_0 thread cruisepredator_startfadecamtransition();
                wait 0.5;
            }

            var_27 delete();
            var_0 cruisepredator_returnplayer();
        }
    }

    if ( isdefined( var_6 ) )
        var_6 delete();

    var_0 scripts\cp\crafting_system::remove_crafted_item_from_slot( scripts\cp\crafting_system::getitemslot( "drone_strike" ) );
}

mark_enemies( var_0 )
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

unmark_enemies( var_0 )
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

cruisepredator_cameramove( var_0, var_1 )
{
    self moveto( var_0, 0.2, 0, 0.05 );
    wait 0.15;
    self moveto( var_0 + vectornormalize( var_1 - var_0 ) * 24, 2 );
}

cruisepredator_returnplayer()
{
    self cameraunlink();
    self controlsunlink();
    self setplayerangles( self.restoreangles );
    self.restoreangles = undefined;
    scripts\common\utility::allow_fire( 1 );
    scripts\common\utility::allow_melee( 1 );
    scripts\common\utility::allow_weapon_switch( 1 );
    scripts\common\utility::allow_usability( 1 );
    scripts\cp\utility::setdof_default();
    thread stopremotesequence();
}

cruisepredator_watchtimer( var_0 )
{
    self endon( "death" );
    self endon( "missile_stuck" );
    scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause( 10.1 );
    self detonate();
}

cruisepredator_watchexplosiondistance( var_0, var_1 )
{
    self endon( "death" );
    var_0 endon( "disconnect" );
    level endon( "game_ended" );
    var_2 = [ self, var_1 ];
    var_3 = scripts\engine\trace::create_contents( 1, 1, 1, 1, 1, 1, 0, 0 );

    for (;;)
    {
        var_4 = anglestoforward( self.angles );
        var_5 = self gettagorigin( "tag_missile" );
        var_0.lastknownmissilepos = var_5;
        var_0.lastknownmissileangles = self.angles;
        var_6 = getdvarint( "scr_cruise_impact_dist", 50 );

        if ( isdefined( self.missilebooston ) )
            var_6 = getdvarint( "scr_cruise_impact_boost_dist", 150 );

        var_7 = var_5 + var_4 * var_6;
        var_8 = scripts\engine\trace::sphere_trace( var_5, var_7, 5, var_2, var_3 );

        if ( isdefined( var_8["hittype"] ) && var_8["hittype"] != "hittype_none" )
        {
            if ( isdefined( var_8["position"] ) )
            {
                var_0.lastknowntrace = var_8;
                self notify( "missile_close_explode", var_8["position"] );
                break;
            }
        }

        wait 0.05;
    }
}

cruisepredator_watchmissileboost( var_0 )
{
    var_0 endon( "disconnect" );
    self endon( "death" );
    level endon( "game_ended" );
    var_0 notifyonplayercommand( "missile_boost_on", "+attack" );

    for (;;)
    {
        var_0 waittill( "missile_boost_on" );
        self.missilebooston = 1;
        break;
    }
}

cruisepredator_watchownerdisown( var_0 )
{
    var_0 endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        var_1 = scripts\engine\utility::_id_12E48( "disconnect", "joined_team", "joined_spectators" );

        if ( !isdefined( var_1 ) )
            continue;

        if ( isdefined( var_0 ) )
            var_0 delete();
    }
}

cruisepredator_startexplodecamtransition()
{
    wait 0.1;
}

cruisepredator_startfadecamtransition( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0.5;

    if ( !isdefined( var_1 ) )
        var_1 = 0.5;

    if ( !isdefined( var_2 ) )
        var_2 = 0.05;

    if ( isdefined( var_3 ) )
        wait( var_1 );
    else
        wait( var_1 );
}

cruisepredator_shakerider( var_0 )
{
    self endon( "disconnect" );
    var_1 = 0;

    while ( var_1 < var_0 )
    {
        self playrumbleonpositionforclient( "damage_light", self.origin );
        var_1 = var_1 + 0.05;
        wait 0.05;
    }
}

cruisepredator_waittillexplode( var_0, var_1 )
{
    self endon( "death" );
    var_2 = spawnstruct();

    if ( isdefined( var_0 ) )
        thread waittill_explodestring( var_0, var_2 );

    if ( isdefined( var_1 ) )
        thread waittill_explodestring( var_1, var_2 );

    var_2 waittill( "returned", var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
    var_2 notify( "die" );
    var_10 = spawnstruct();
    var_10.msg = var_3;
    var_10.param1 = var_4;
    var_10.param2 = var_5;
    var_10.param3 = var_6;
    var_10.param4 = var_7;
    var_10.param5 = var_8;
    var_10.param6 = var_9;
    return var_10;
}

waittill_explodestring( var_0, var_1 )
{
    self endon( "death" );
    var_1 endon( "die" );
    self waittill( var_0, var_2, var_3, var_4, var_5, var_6, var_7 );
    var_1 notify( "returned", var_0, var_2, var_3, var_4, var_5, var_6, var_7 );
}

cruisepredator_handlevfxstates( var_0, var_1, var_2 )
{
    self endon( "death" );
    self unlink();

    if ( !isdefined( var_2 ) || var_2.msg == "explode" )
    {
        self setscriptablepartstate( "air_explosion", "on", 0 );
        scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause( 0.2 );
        self delete();
    }

    var_3 = ( 0, 0, 1 );
    var_4 = var_2.param6;
    self.angles = vectortoangles( var_4 );
    var_5 = vectordot( var_4, var_3 );

    if ( var_5 >= 0.7 )
        self setscriptablepartstate( "ground_explosion", "on", 0 );
    else
        self setscriptablepartstate( "air_explosion", "on", 0 );

    scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause( 0.2 );
    self delete();
}

cruisepredator_watchkills( var_0 )
{
    self endon( "disconnect" );
    scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause( 1 );
}

playremotesequence( var_0, var_1 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );

    if ( scripts\cp\utility::isusingremote() )
        return 0;

    if ( !scripts\cp_mp\utility\player_utility::_isalive() )
        return 0;

    self notify( "play_remote_sequence" );
    self playlocalsound( "mp_killstreak_tablet_gear" );
    var_2 = undefined;

    if ( self isonladder() || self ismantling() || !self isonground() )
        return 0;

    var_2 = "ks_remote_device_mp";
    scripts\cp\utility::_giveweapon( var_2, 0, 0, 1 );
    var_3 = int( tablelookup( "mp/killstreaktable.csv", 1, var_0.streakname, 0 ) );
    self setclientomnvar( "ui_remote_control_sequence", var_3 );
    var_4 = scripts\cp\cp_weapons::switchtoweaponreliable( var_2 );

    if ( istrue( var_4 ) )
        thread scripts\cp\cp_weapons::watchformanualweaponend( var_2 );

    scripts\cp\utility::setusingremote( var_0.streakname );
    scripts\cp\utility::_freezecontrols( 1 );
    thread scripts\cp\cp_weapons::unfreezeonroundend();
    thread scripts\cp\cp_weapons::startfadetransition( 1.3 );
    var_5 = scripts\engine\utility::_id_12E53( 1.8, "death" );
    self notify( "ks_freeze_end" );
    self setclientomnvar( "ui_remote_control_sequence", 0 );
    scripts\cp\utility::_freezecontrols( 0 );
    scripts\cp\utility::clearusingremote();
    scripts\cp_mp\utility\killstreak_utility::stoptabletscreen();

    if ( isdefined( var_2 ) )
        self takeweapon( var_2 );

    self stoplocalsound( "mp_killstreak_tablet_gear" );
    self setclientomnvar( "ui_remote_control_sequence", 0 );
    return 1;
}

watchvisordeath()
{
    self endon( "stop_remote_sequence" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self waittill( "death" );
    self setscriptablepartstate( "killstreak", "neutral", 0 );
}

stopremotesequence( var_0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self notify( "stop_remote_sequence" );

    if ( scripts\cp_mp\utility\player_utility::_isalive() )
    {
        if ( istrue( level.nukedetonated ) && !istrue( level.nukecancel ) )
        {

        }

        var_1 = "ks_remote_device_mp";

        if ( istrue( var_0 ) )
        {
            wait 0.1;
            self notify( "finished_with_manual_weapon_" + var_1 );
        }
        else
            self notify( "killstreak_finished_with_weapon_" + var_1 );
    }

    scripts\cp\utility::clearusingremote();
    scripts\engine\utility::_id_12E53( 1.3, "death" );
    self setclientomnvar( "ui_remote_control_sequence", 0 );
}
