// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    scripts\cp_mp\utility\script_utility::registersharedfunc( "gunship", "findBoxCenter", ::gunship_findboxcenter );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "gunship", "getBombingPoint", ::gunship_getbombingpoints );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "gunship", "br_respawn", ::gunship_startbrrespawn );

    if ( !scripts\cp\utility::prematchintiallandingcomplete() )
        scripts\cp_mp\utility\script_utility::registersharedfunc( "gunship", "assignTargetMarkers", ::gunship_assigntargetmarkers );
}

gunship_findboxcenter( var_0, var_1 )
{
    return scripts\cp\cp_globallogic::findboxcenter( var_0, var_1 );
}

gunship_getbombingpoints( var_0, var_1, var_2 )
{
    var_3 = [];
    var_0 = var_0 - anglestoforward( self.angles ) * 100;

    for ( var_4 = 0; var_4 < var_1; var_4++ )
    {
        var_5 = randomint( var_2 );
        var_6 = randomint( 360 );
        var_7 = var_0[0] + var_5 * cos( var_6 );
        var_8 = var_0[1] + var_5 * sin( var_6 );
        var_9 = var_0[2];
        var_10 = ( var_7, var_8, var_9 );
        var_11 = scripts\engine\trace::ray_trace( var_10 + ( 0, 0, 2000 ), var_10 - ( 0, 0, 10000 ), level.players );

        if ( isdefined( var_11["position"] ) )
            var_10 = var_11["position"];

        var_3[var_3.size] = var_10;
    }

    return var_3;
}

gunship_startbrrespawn( var_0 )
{
    if ( isdefined( var_0 ) && isplayer( var_0 ) )
    {
        if ( !istrue( var_0.fauxdead ) )
            var_0.shouldskiplaststand = 0;
    }
}

gunship_assigntargetmarkers( var_0 )
{
    var_1 = [];
    var_2 = [];
    var_3 = [];
    var_4 = scripts\cp\cp_agent_utils::getactiveenemyagents( "allies" );
    var_5 = level.players;
    var_6 = [];

    if ( isdefined( level.relicsquadlink ) )
    {
        foreach ( var_8 in level.relicsquadlink )
            var_6 = scripts\engine\utility::array_add( var_6, var_8 );
    }

    var_3 = scripts\engine\utility::array_combine( var_6, var_4, var_5 );

    foreach ( var_11 in var_3 )
    {
        if ( level.teambased && var_11.team == self.team )
            continue;

        if ( var_11 == self.owner )
            continue;

        if ( var_11 scripts\cp\utility::_hasperk( "specialty_noscopeoutline" ) )
            continue;

        var_1[var_1.size] = var_11;
    }

    foreach ( var_14 in var_5 )
    {
        if ( level.teambased && var_14.team != self.team )
            continue;

        var_2[var_2.size] = var_14;
    }

    self.enemytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on( "thermalvisionenemydefault", self.owner, var_1, self.owner, 1, 1 );
    self.friendlytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on( "thermalvisionfriendlydefault", self.owner, var_2, self.owner, 1, 1 );
    level thread musictriggerthink( self.enemytargetmarkergroup, 0 );
}

musictriggerthink( var_0, var_1 )
{
    level endon( "game_ended " );
    level endon( "removed_targetMarkerGroup_" + var_0 );

    for (;;)
    {
        level waittill( "spawned_group_soldier", var_2 );
        scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity( var_2, var_0, var_1 );
    }
}

incendiary_pickup_watcher( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( !istrue( var_5 ) )
    {
        if ( isdefined( var_0 ) && ( isint( var_0 ) || isfloat( var_0 ) ) )
            wait( var_0 );

        if ( isdefined( var_1 ) && isstring( var_1 ) )
            level waittill( var_1 );
    }

    var_6 = randomint( 360 );
    var_7 = 15000;

    if ( isdefined( var_3 ) )
        var_7 = var_3;

    var_8 = cos( var_6 ) * var_7;
    var_9 = sin( var_6 ) * var_7;
    var_10 = 8000;

    if ( isdefined( var_4 ) )
        var_10 = var_4;

    var_11 = vectornormalize( ( var_8, var_9, var_10 ) );
    var_11 = var_11 * var_10;
    var_12 = "veh8_mil_air_acharlie130_small_east";
    var_13 = level.gunship.origin;

    if ( isdefined( var_2 ) && isvector( var_2 ) )
    {
        var_13 = var_2;
        level.gunship.origin = var_2;
    }

    var_14 = spawn( "script_model", var_13 );
    var_14 setmodel( "tag_origin" );
    var_14.team = "axis";
    var_15 = spawn( "script_model", var_13 );
    var_15 setmodel( var_12 );
    var_15 setcandamage( 1 );
    var_15.currenthealth = 1000;
    var_15.maxhealth = var_15.currenthealth;
    var_15.health = 9999999;
    var_15.owner = var_14;
    var_15.timeout = 6669;
    var_15.currentdamagestate = 0;
    var_15.team = "axis";
    var_15.startpayloadtanksobjective = 2;
    var_15.flaresreservecount = 2;
    var_15 scriptmoveroutline();
    var_15 scriptmoverthermal();
    var_16 = undefined;

    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "createObjective" ) )
        var_16 = var_15 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "createObjective" ) ]]( "icon_minimap_dropship", var_15.team, 1, 1, 1 );

    if ( isdefined( var_16 ) )
        objective_setshowoncompass( var_16, 1 );

    var_15.minimapid = var_16;
    var_14 linkto( level.gunship, "tag_origin" );
    var_15 linkto( level.gunship, "tag_origin", var_11, ( 0, var_6 + 90, -30 ) );
    var_14.pers = [];
    var_15.streakinfo = var_14 scripts\cp_mp\utility\killstreak_utility::createstreakinfo( "gunship", var_14 );
    var_15 thread incomingremovedcallback();
    var_15 thread scripts\cp_mp\killstreaks\gunship::nakeddrophandleloadout( undefined );

    if ( level.script == "cp_arms_dealer" )
        var_15 thread incorrectswitch( undefined, 1 );
    else
        var_15 thread incorrectswitch( undefined );

    var_15 thread scripts\cp_mp\killstreaks\gunship::gunship_linklightfxent();
    var_15 thread scripts\cp_mp\killstreaks\gunship::gunship_linkwingfxents();
    var_15 thread scripts\cp_mp\killstreaks\gunship::gunship_trackvelocity();
    var_15 thread scripts\cp\cp_flares::flares_monitor( var_15.flaresreservecount );
    var_15 thread increase_hp_from_relic_mythic();
    scripts\cp\cp_weapon::add_to_special_lockon_target_list( var_15 );

    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "flares", "handleIncomingStinger" ) )
        var_15 thread [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "flares", "handleIncomingStinger" ) ]]( ::in_world_scriptables_visible );

    var_15 playloopsound( "iw8_ks_ac130_lp" );
}

trial_flares()
{
    var_0 = "ping_killstreaks_gunship";
    var_1 = self;
    var_2 = var_1;
    var_3 = var_2 scripts\cp\equipment\cp_incendiarylauncher::debug_kill_tromeo( var_0 );
    var_4 = var_2 scripts\cp\equipment\cp_incendiarylauncher::debug_listing_helis( var_0 );
    var_5 = soundexists( var_3 );
    var_6 = soundexists( var_4 );
    var_7 = scripts\cp\equipment\cp_incendiarylauncher::debug_mine_caves( var_5, var_3, var_6, var_4 );
    var_8 = 1;

    if ( istrue( var_8 ) )
    {
        var_9 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "getFriendlyPlayers" ) ]]( self.team, 1 );

        foreach ( var_11 in var_9 )
        {
            if ( var_2 == var_11 )
            {
                if ( var_5 )
                    var_2 playsoundtoplayer( var_3, var_11 );

                continue;
            }

            if ( var_6 )
                var_2 playsoundtoplayer( var_4, var_11 );
        }
    }
}

incorrectswitch( var_0, var_1 )
{
    self endon( "death" );
    self endon( "leaving" );
    self endon( "crashing" );

    if ( istrue( var_1 ) )
    {
        for (;;)
        {
            level waittill( "exfil_sequence_started" );

            if ( istrue( level.callback ) )
                continue;

            break;
        }
    }
    else
        level waittill( "exfil_sequence_started" );

    thread scripts\cp_mp\killstreaks\gunship::gunship_leave( var_0 );
}

incomingremovedcallback( var_0 )
{
    self endon( "death" );
    self endon( "crashing" );
    level endon( "game_ended" );
    self.damagetaken = 0;
    self.attractor = missile_createattractorent( self, 1000, 8192 );
    self setcandamage( 1 );

    for (;;)
    {
        self waittill( "damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 );

        if ( isdefined( level.teambased ) && isplayer( var_2 ) && var_2.team == self.team )
            continue;

        if ( var_5 == "MOD_RIFLE_BULLET" || var_5 == "MOD_PISTOL_BULLET" || var_5 == "MOD_EXPLOSIVE_BULLET" )
            continue;

        if ( isplayer( var_2 ) )
        {
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "damage", "updateDamageFeedback" ) )
                var_2 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "damage", "updateDamageFeedback" ) ]]( "hitequip" );
        }

        thread _id_11BD7( 7 );
        self.wasdamaged = 1;
        var_11 = undefined;

        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "killstreak", "getModifiedAntiKillstreakDamage" ) )
            var_11 = self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "killstreak", "getModifiedAntiKillstreakDamage" ) ]]( var_2, var_10, var_5, var_1, self.maxhealth, 4, 5, 6 );

        self.damagetaken = self.damagetaken + var_11;
        self.currenthealth = self.maxhealth - self.damagetaken;

        if ( self.currenthealth <= 500 && self.currentdamagestate == 0 )
        {
            self.currentdamagestate = 1;
            self setscriptablepartstate( "body_damage_light", "on" );
        }
        else if ( self.currenthealth <= 250 && self.currentdamagestate == 1 )
        {
            self.currentdamagestate = 2;
            self setscriptablepartstate( "body_damage_light", "off" );
            self setscriptablepartstate( "body_damage_medium", "on" );
        }
        else if ( self.currenthealth <= 0 && self.currentdamagestate == 2 )
        {
            self.currentdamagestate = 3;
            self setscriptablepartstate( "body_damage_medium", "off" );
            self setscriptablepartstate( "contrails", "off" );
            thread scripts\cp_mp\killstreaks\gunship::gunship_startengineblowoutfx();
        }

        if ( self.damagetaken >= self.maxhealth )
        {
            var_12 = self.streakinfo.streakname;
            var_13 = undefined;
            var_14 = "destroyed_" + var_12;
            var_15 = undefined;
            var_16 = "callout_destroyed_" + var_12;
            var_17 = 1;

            if ( isplayer( var_2 ) )
            {
                if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "hud", "teamPlayerCardSplash" ) )
                    thread [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "hud", "teamPlayerCardSplash" ) ]]( var_16, var_2 );
            }

            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "damage", "onKillstreakKilled" ) )
                var_18 = self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "damage", "onKillstreakKilled" ) ]]( var_12, var_2, var_10, var_13, var_1, var_14, var_15, var_16, var_17 );

            self.owner delete();
            level.getvehicleplayercamo = 1;
            thread scripts\cp\cp_relics::_id_123E3( 1 );
            thread scripts\cp_mp\killstreaks\gunship::gunship_crash( 8, var_0 );
        }
    }
}

_id_11BD7( var_0 )
{
    self notify( "run_suppression_logic" );
    self endon( "run_suppression_logic" );
    self endon( "death" );
    level endon( "game_ended" );
    self._id_125AC = 1;
    childthread removesuppressioneffectsaftertimeout( var_0 );
}

removesuppressioneffectsaftertimeout( var_0 )
{
    self notify( "removeSuppressionEffectsAfterTimeout" );
    self endon( "removeSuppressionEffectsAfterTimeout" );
    self endon( "death" );
    level endon( "game_ended" );
    wait( var_0 );
    self._id_125AC = undefined;
}

in_world_scriptables_visible( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );

    for (;;)
    {
        if ( !isdefined( var_2 ) )
            break;

        var_4 = var_2 getpointinbounds( 0, 0, 0 );
        var_5 = distance( self.origin, var_4 );

        if ( var_5 < 4000 && var_2.flaresreservecount > 0 )
        {
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "flares", "reduceReserves" ) )
                [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "flares", "reduceReserves" ) ]]( var_2 );

            var_2 scripts\cp_mp\killstreaks\gunship::gunship_playflaresfx( var_3 );

            if ( isdefined( var_2.owner ) && isplayer( var_2.owner ) )
                var_2 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog( "gunship_flares", 1 );

            var_6 = undefined;

            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "flares", "deploy" ) )
                var_6 = var_2 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "flares", "deploy" ) ]]();

            self missile_settargetent( var_6 );
            self notify( "missile_pairedWithFlare" );
            return;
        }
        else if ( var_5 < 300 && var_2.flaresreservecount <= 0 )
        {
            var_2 thread scripts\cp_mp\killstreaks\gunship::gunship_playfakebodyexplosion();
            var_7 = weapongetdamagemax( self.weapon_name );

            if ( isdefined( self.owner ) && isplayer( self.owner ) )
                var_2 dodamage( var_7, self.owner.origin, self.owner, self, "MOD_EXPLOSIVE", self.weapon_name );
            else
                var_2 dodamage( var_7, var_2.origin, undefined, self, "MOD_EXPLOSIVE", self.weapon_name );

            self delete();
        }

        waitframe();
    }
}

gunship_lockedoncallback()
{
    scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog( "gunship_missile_lock" );
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning( "missileLocking", self.owner, "killstreak" );
}

gunship_lockedonremovedcallback()
{
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning( "missileLocking", self.owner, "killstreak" );
}

increase_hp_from_relic_mythic( var_0 )
{
    self endon( "death" );
    self endon( "leaving" );
    self endon( "crashing" );
    level endon( "game_ended" );
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( 5 );

    for (;;)
    {
        var_1 = [];

        foreach ( var_3 in level.players )
        {
            if ( !isdefined( var_3 ) || !var_3 scripts\cp_mp\utility\player_utility::_isalive() )
                continue;

            if ( level.teambased && var_3.team == self.team )
                continue;

            if ( istrue( var_3.respawn_in_progress ) )
                continue;

            if ( istrue( var_3.inlaststand ) )
                continue;

            if ( var_3 isskydiving() )
                continue;

            if ( isdefined( var_3.vehicle ) && isent( var_3.vehicle ) )
            {

            }
            else if ( var_3 scripts\cp\utility::is_indoors( var_3 ) )
                continue;
            else if ( !sighttracepassed( self.origin, var_3.origin, 0, undefined, 1 ) )
                continue;

            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "perk", "hasPerk" ) )
            {
                if ( var_3 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "perk", "hasPerk" ) ]]( "specialty_blindeye" ) || var_3 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "perk", "hasPerk" ) ]]( "specialty_ghost" ) )
                {
                    if ( var_3._id_124C6 <= 3.0 )
                    {
                        var_3._id_124C6 = var_3._id_124C6 + 0.05;
                        continue;
                    }
                    else
                        var_3._id_124C6 = 0.0;
                }
            }

            var_1 = impulsefx( var_3 );
            break;
            wait 0.05;
        }

        if ( var_1.size > 0 && var_1.size < 2 )
        {
            foreach ( var_6 in var_1 )
            {
                if ( isplayer( var_6 ) )
                {
                    var_6 thread trial_flares();
                    thread impairedkill( var_6 );
                    var_6 thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog( "gunship_single_spotted" );
                    self notify( "gunship_shoot_debug_location" );
                }
            }
        }
        else if ( var_1.size >= 2 )
        {
            foreach ( var_6 in var_1 )
            {
                if ( isplayer( var_6 ) )
                {
                    thread impairedkill( var_6 );
                    var_6 thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog( "gunship_multi_spotted" );
                    self notify( "gunship_shoot_debug_location" );
                }
            }
        }

        wait( randomintrange( 3, 15 ) );
    }
}

impulsefx( var_0 )
{
    var_1 = scripts\common\utility::playersinsphere( var_0.origin, 666 );
    var_2 = [];

    foreach ( var_4 in var_1 )
    {
        if ( level.teambased && var_4.team != var_0.team )
            continue;

        var_2[var_2.size] = var_4;
    }

    return var_2;
}

increase_accuracy_after_delay()
{
    self endon( "death" );
    self.owner endon( "gunship_switch_debug_weapon" );
    self.owner endon( "gunship_shoot_debug_location" );

    for (;;)
    {
        var_0 = scripts\engine\trace::ray_trace( self.origin, self.origin - ( 0, 0, 40000 ), self );
        waitframe();
    }
}

incorrectcodeentered( var_0, var_1 )
{
    self endon( "death" );

    for (;;)
    {
        var_2 = self.origin;

        if ( isdefined( var_0 ) )
            var_2 = self gettagorigin( var_0 );

        if ( istrue( var_1 ) )
        {
            var_3 = anglestoforward( self.angles );
            var_4 = anglestoright( self.angles );
            var_5 = anglestoup( self.angles );
        }

        wait 0.05;
    }
}

impairedkill( var_0 )
{
    self endon( "death" );
    self endon( "leaving" );
    self endon( "crashing" );
    self notify( var_0.name + "enemyGunship_fireRounds" );
    self endon( var_0.name + "enemyGunship_fireRounds" );

    if ( !isdefined( self.fuselit ) )
    {
        self._id_12FF4 = [ "ac130_105mm_mp", "ac130_40mm_mp", "ac130_25mm_mp" ];
        self.fulton_repositoryextractcallback = 0;
        self.fulton_repositorycountdownendcallback = self._id_12FF4[0];
        self.fuselit = self.fulton_repositorycountdownendcallback;
    }

    for (;;)
    {
        var_1 = scripts\engine\utility::_id_12E47( "gunship_switch_debug_weapon", "gunship_shoot_debug_location" );

        if ( !isdefined( var_1 ) )
        {
            waitframe();
            continue;
        }

        if ( var_1 == "gunship_switch_debug_weapon" )
        {
            self.fulton_repositoryextractcallback++;

            if ( self.fulton_repositoryextractcallback > 2 )
                self.fulton_repositoryextractcallback = 0;

            self.fulton_repositorycountdownendcallback = self._id_12FF4[self.fulton_repositoryextractcallback];
            self.fuselit = self.fulton_repositorycountdownendcallback;
            continue;
        }

        if ( istrue( self._id_125AC ) )
        {
            waitframe();
            continue;
        }

        var_2 = in_realism_mode( var_0 );
        thread impactwatcher( var_2, self.fulton_repositorycountdownendcallback );
    }
}

implement_cointoss( var_0 )
{
    return weaponfiretime( var_0 );
}

in_realism_mode( var_0 )
{
    var_1 = [ "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle" ];
    var_2 = physics_createcontents( var_1 );
    var_3 = self.origin;
    var_4 = vectornormalize( var_0.origin - self.origin );
    var_5 = var_3 + var_4 * 50000;
    var_6 = scripts\engine\trace::ray_trace( var_3, var_5, self, var_2 );
    var_7 = var_6["position"];
    return var_7;
}

impactwatcher( var_0, var_1 )
{
    self endon( "death" );
    self endon( "leaving" );
    self endon( "crashing" );
    self endon( "gunship_shoot_debug_location" );
    self endon( "gunship_switch_debug_weapon" );

    for (;;)
    {
        var_2 = weaponmaxammo( var_1 );

        while ( var_2 > 0 )
        {
            if ( istrue( self._id_125AC ) )
            {
                waitframe();
                continue;
            }

            var_3 = undefined;
            var_4 = scripts\cp_mp\killstreaks\toma_strike::_id_12776( var_0, 333 );
            var_3 = var_4.point;
            var_5 = undefined;
            var_6 = scripts\cp_mp\utility\weapon_utility::_magicbullet( getcompleteweaponname( var_1 ), self.origin, var_3, var_5 );
            var_6.weapon_name = var_1;
            var_6.team = self.team;
            thread increase_max_count_per_kill( var_6 );
            var_2--;

            if ( var_2 == 0 )
            {
                wait 1;
                self notify( "gunship_switch_debug_weapon" );
                var_7 = level.weaponreloadtime[var_1] + getdvarint( "scr_dfa_reloadTimerAdd", 0 );

                while ( var_7 > 0 )
                {
                    var_7--;
                    wait 1;
                }
            }

            wait( implement_cointoss( var_1 ) );
        }
    }
}

increase_max_count_per_kill( var_0, var_1 )
{
    level endon( "game_ended" );
    self endon( "leaving" );
    var_2 = getcompleteweaponname( self.fuselit );
    var_0 waittill( "missile_stuck", var_3, var_4, var_5, var_6, var_7, var_8 );
    var_9 = 0.5;
    var_10 = 100;

    if ( isdefined( var_2 ) && isdefined( var_2.basename ) )
    {
        switch ( var_2.basename )
        {
            case "ac130_105mm_mp":
                var_9 = 1.5;
                var_10 = 500;
                break;
            case "ac130_40mm_mp":
                var_9 = 1;
                var_10 = 300;
                break;
        }
    }

    var_11 = spawn( "script_model", var_0.origin );
    var_11 setmodel( "ks_ac130_target_mp" );
    var_11.angles = vectortoangles( var_8 );
    var_11 linkto( var_0, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_11 setotherent( self );
    var_11 thread scripts\cp_mp\killstreaks\gunship::deleteaftertime( 5 );
    var_12 = "on";

    if ( istrue( var_1 ) )
        var_12 = "debug_ground_fx";

    var_11 setscriptablepartstate( var_0.weapon_name, var_12, 0 );

    if ( isdefined( self ) )
        var_0 detonate();
    else
        var_0 delete();

    var_13 = var_11.origin;
    var_14 = scripts\cp_mp\killstreaks\gunship::getmissileexplscale( var_0.weapon_name );
    var_15 = 0.75;
    var_16 = scripts\cp_mp\killstreaks\gunship::getmissileexplradius( var_0.weapon_name );

    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "shellshock", "artillery_earthQuake" ) )
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "shellshock", "artillery_earthQuake" ) ]]( var_13, var_14, var_15, var_16 );
}

incomingcallback( var_0 )
{
    self endon( "death" );
    self endon( "leaving" );
    self endon( "crashing" );
    self.owner endon( "gunship_switch_debug_weapon" );
    self.owner endon( "gunship_shoot_debug_location" );

    for (;;)
    {
        self.flashlight.angles = vectortoangles( var_0 - self.origin );
        waitframe();
    }
}
