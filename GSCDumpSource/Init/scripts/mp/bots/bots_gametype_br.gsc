// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

main()
{
    if ( scripts\mp\utility\game::missions_clearinappropriaterewards() == "dmz" && scripts\mp\gametypes\br_public.gsc::prophaschangesleft() )
        [[ level.grenade_effect ]]();
    else
    {
        setup_callbacks();
        setup_bot_br();
    }
}

setup_callbacks()
{
    level.bot_funcs["gametype_think"] = ::bot_br_think;
}

setup_bot_br()
{
    setdvarifuninitialized( "br_infil_bot_solojump_chance", 0.25 );
}

bot_br_think()
{
    self notify( "bot_br_think" );
    self endon( "bot_br_think" );
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    var_0 = randomfloat( 1 ) < getdvarfloat( "br_infil_bot_solojump_chance", 0.0 );
    thread birds_in_square_monitor();
    self botsetflag( "ignore_nodes", 1 );

    for (;;)
    {
        if ( scripts\mp\gametypes\br_public.gsc::processvoqueue() && !scripts\mp\flags::gameflag( "graceperiod_done" ) )
        {
            self.ignoreall = 0;
            wait 0.05;
            continue;
        }

        if ( isdefined( self.br_infil_type ) )
        {
            if ( scripts\mp\gametypes\br_public.gsc::processvoqueue() && !isdefined( self.play_sparks_power ) )
            {
                self.ignoreall = 1;
                self botclearscriptgoal();
            }

            self botsetflag( "disable_all_ai", 1 );

            if ( ( scripts\mp\gametypes\br_public.gsc::questrewarduav() || var_0 ) && istrue( level.c130inbounds ) )
            {
                var_1 = level.br_ac130.origin;
                var_2 = vectornormalize( level.infilstruct.c130pathstruct.endpt - var_1 );
                var_3 = ( level.br_level.br_mapbounds[0][0] - var_1[0] ) / var_2[0];
                var_4 = ( level.br_level.br_mapbounds[0][1] - var_1[0] ) / var_2[0];
                var_5 = ( level.br_level.br_mapbounds[0][1] - var_1[1] ) / var_2[1];
                var_6 = ( level.br_level.br_mapbounds[1][1] - var_1[1] ) / var_2[1];
                var_7 = [ var_3, var_4, var_5, var_6 ];
                var_8 = -1;

                foreach ( var_10 in var_7 )
                {
                    if ( var_10 > 0 )
                    {
                        if ( var_8 < 0 || var_10 < var_8 )
                            var_8 = var_10;
                    }
                }

                var_12 = var_1 + var_2 * var_8;
                var_13 = scripts\mp\gametypes\br_c130.gsc::getc130speed();
                var_14 = var_8 / var_13;
                var_15 = randomfloatrange( 0.1, 0.9 ) * var_14;
                wait( var_15 );

                if ( scripts\mp\gametypes\br_public.gsc::questrewarduav() )
                    self notify( "halo_jump_c130" );
                else
                    self notify( "halo_jump_solo_c130" );

                self.gulaguses = 1;

                if ( getdvarint( "scr_bot_allow_gulag", 1 ) > 0 )
                    self.gulaguses = 0;

                self.registerpublicevent = 1;

                while ( isdefined( self.br_infil_type ) )
                    wait 0.05;
            }

            wait 0.05;
            continue;
        }

        if ( scripts\mp\gametypes\br_public.gsc::questtypes() )
        {
            thread cave_initial_enemy_goto_struct_on_spawn_and_wait_till_seen();
            scripts\engine\utility::_id_12E3F( "death_or_disconnect", "gulag_end" );
            wait 3;
        }
        else
            self botclearscriptenemy();

        if ( isdefined( level.br_circle ) && isscriptabledefined() )
        {
            var_16 = undefined;
            var_17 = self bothasscriptgoal();

            if ( var_17 )
                var_16 = self botgetscriptgoal();

            if ( !scripts\mp\bots\bots_strategy::bot_has_tactical_goal() && !scripts\mp\bots\bots_util::bot_is_remote_or_linked() )
            {
                if ( ( istrue( self isskydiving() ) || istrue( self isparachuting() ) ) && istrue( self.registerpublicevent ) && istrue( scripts\mp\gametypes\br_public.gsc::processvoqueue() ) )
                {
                    self botsetflag( "disable_all_ai", 0 );
                    self botclearscriptgoal();
                    changing_loadout();
                }

                if ( scripts\mp\gametypes\br_public.gsc::processvoqueue() && !isdefined( self.play_sparks_power ) )
                {
                    self.ignoreall = 1;
                    wait 1;
                    continue;
                }

                var_18 = self botpathexists();
                var_19 = !var_17 || !var_18 || !scripts\mp\gametypes\br_circle.gsc::ispointincurrentsafecircle( var_16 );

                if ( var_17 )
                {
                    var_20 = distancesquared( self.origin, var_16 );
                    var_21 = self botgetscriptgoalradius();
                    var_22 = var_20 < var_21 * var_21;

                    if ( !var_22 )
                        self.lasttimereachedscriptgoal = undefined;
                    else if ( !isdefined( self.lasttimereachedscriptgoal ) )
                        self.lasttimereachedscriptgoal = gettime();
                }

                var_23 = level.bot_personality_type[self.personality] == "stationary";

                if ( isdefined( self.lasttimereachedscriptgoal ) )
                {
                    var_24 = 0;

                    if ( var_23 )
                        var_24 = 20000;

                    var_19 = var_19 || gettime() - self.lasttimereachedscriptgoal >= var_24;
                }

                if ( var_19 )
                {
                    var_25 = scripts\mp\gametypes\br_circle.gsc::getrandompointincurrentcircle();
                    var_26 = self getclosestreachablepointonnavmesh( var_25 );

                    if ( isdefined( var_26 ) )
                    {
                        self botsetscriptgoal( var_26, 1024, "hunt", undefined, undefined, !var_23 );
                        self.lasttimereachedscriptgoal = gettime();
                    }
                }
            }
        }
        else
            scripts\mp\bots\bots_personality::update_personality_default();

        wait 0.05;
    }
}

changing_loadout()
{
    self endon( "death_or_disconnect" );
    self.ignoreall = 1;
    self.gethillspawnshutofforigin = cashleaderbag_attach();
    var_0 = gettime() + randomfloatrange( 5, 10 ) * 1000;
    var_1 = 0;

    while ( istrue( self isskydiving() ) || istrue( self isparachuting() ) )
    {
        if ( level.br_circle.circleindex > 0 && istrue( level.dropminigunondeath ) && !scripts\mp\gametypes\br_circle.gsc::ispointincurrentsafecircle( self.gethillspawnshutofforigin ) )
            self.gethillspawnshutofforigin = cashleaderbag_attach();

        var_2 = carryitemomnvar( self, self.gethillspawnshutofforigin );
        var_3 = 1;
        self botlookatpoint( self.gethillspawnshutofforigin, 0.05, "script_forced" );
        self botsetscriptmove( var_2[1], 0.05, var_3 );

        if ( gettime() > var_0 && !var_1 )
        {
            self botpressbutton( "jump", 1 );
            var_1 = 1;
        }

        wait 0.05;
    }

    self.play_sparks_power = 1;
    self botlookatpoint( undefined );
    self.ignoreall = 0;
    cave_combat();
}

cashleaderbag_attach( var_0 )
{
    if ( !isdefined( level.isusingremotekillstreak ) || level.isusingremotekillstreak.size < 1 )
    {
        level.isusingremotekillstreak = leave_pool_behind_after_deactivation();
        level.isusingremotekillstreak = scripts\engine\utility::array_randomize( level.isusingremotekillstreak );
    }

    if ( isdefined( level.br_circle ) && isscriptabledefined() )
    {
        var_1 = scripts\engine\utility::random( level.isusingremotekillstreak );

        if ( isdefined( var_1 ) )
        {
            var_2 = var_1.origin;
            level.isusingremotekillstreak = scripts\engine\utility::array_remove( level.isusingremotekillstreak, var_1 );
        }
        else
            var_2 = scripts\mp\gametypes\br_circle.gsc::getrandompointincurrentcircle();

        return getclosestpointonnavmesh( var_2, self );
    }

    return undefined;
}

leave_pool_behind_after_deactivation()
{
    var_0 = scripts\mp\gametypes\br_circle.gsc::getdangercircleradius();
    var_1 = scripts\mp\gametypes\br_circle.gsc::getdangercircleorigin();
    return scripts\engine\utility::get_array_of_closest( var_1, level.challengetrackerforjuggkills, undefined, undefined, var_0 );
}

carryitemomnvar( var_0, var_1 )
{
    var_2 = vectornormalize( var_1 - var_0.origin );
    return vectortoangles( var_2 );
}

carryobjects_onjuggernaut( var_0, var_1 )
{
    return distance( var_0.origin, var_1 );
}

cave_barrels()
{
    if ( !isdefined( level.cargo_truck_mg_deathcallback ) )
        level.cargo_truck_mg_deathcallback = [ "iw8_sm_papa90_mp", "iw8_sh_charlie725_mp", "iw8_ar_akilo47_mp+acog", "iw8_lm_mgolf34_mp", "iw8_sn_kilo98_mp+scope", "iw8_sm_beta_mp+reflexmini2", "iw8_sm_augolf_mp+acog", "iw8_sm_mpapa7_mp+acog", "iw8_ar_falima_mp+reflexmini", "iw8_ar_kilo433_mp+acog", "iw8_ar_scharlie_mp+reflexmini2", "iw8_lm_lima86_mp+acog" ];

    var_0 = scripts\engine\utility::random( level.cargo_truck_mg_deathcallback );

    switch ( var_0 )
    {
        case "iw8_sh_charlie725_mp":
            if ( !isdefined( level.check_for_damage_scalar_change ) )
                level.check_for_damage_scalar_change = 0;

            level.check_for_damage_scalar_change++;

            if ( level.check_for_damage_scalar_change >= 1 )
                level.cargo_truck_mg_deathcallback = scripts\engine\utility::array_remove( level.cargo_truck_mg_deathcallback, "iw8_sh_charlie725_mp" );

            break;
        case "iw8_sn_kilo98_mp+scope":
            if ( !isdefined( level.check_for_execution_allows ) )
                level.check_for_execution_allows = 0;

            level.check_for_execution_allows++;

            if ( level.check_for_execution_allows >= 1 )
                level.cargo_truck_mg_deathcallback = scripts\engine\utility::array_remove( level.cargo_truck_mg_deathcallback, "iw8_sn_kilo98_mp+scope" );

            break;
    }

    var_1 = [[ level.fnbuildweapon ]]( [[ level.fngetweaponrootname ]]( var_0 ), [], "none", "none", -1 );
    self giveweapon( var_1 );
    self setweaponammoclip( var_1, weaponclipsize( var_1 ) );
    self setweaponammostock( var_1, weaponclipsize( var_1 ) );
    self switchtoweapon( "none" );
}

cave_combat()
{
    self switchtoweapon( "none" );
    var_0 = lastweaponfiretimestart();

    if ( !isdefined( var_0 ) )
    {
        var_0 = spawnstruct();
        var_0.origin = mine_light_vfx();
    }

    var_0.claimed = 1;
    var_1 = level.bot_personality_type[self.personality] == "stationary";
    self botsetscriptgoal( self getclosestreachablepointonnavmesh( var_0.origin ), 256, "guard", undefined, undefined, !var_1 );
    scripts\engine\utility::_id_12E3F( "goal", "last_stand_start" );
    var_0.claimed = undefined;

    if ( !istrue( self.inlaststand ) )
        cave_barrels();

    cargo_truck_mg_enterend();
}

lastweaponfiretimestart()
{
    var_0 = lastweaponswitchnag();
    var_0 = sortbydistance( var_0, self.origin );
    var_1 = laststand_player_in_focus( var_0 );

    if ( !isdefined( var_1 ) )
        var_1 = lastspawnpos( var_0 );

    return var_1;
}

lastweaponswitchnag()
{
    var_0 = scripts\mp\gametypes\br_circle.gsc::getdangercircleradius();
    var_1 = scripts\mp\gametypes\br_circle.gsc::getdangercircleorigin();
    var_2 = scripts\engine\utility::get_array_of_closest( var_1, level.carriable_inactive_delete_wait, undefined, undefined, var_0 );
    return var_2;
}

laststand_player_in_focus( var_0 )
{
    foreach ( var_2 in var_0 )
    {
        if ( !istrue( var_2.claimed ) )
            return var_2;
    }

    return undefined;
}

lastspawnpos( var_0 )
{
    return scripts\engine\utility::getclosest( self.origin, var_0 );
}

hassquadmatepassengers()
{
    self endon( "death_or_disconnect" );

    for (;;)
        wait 0.05;
}

cargo_truck_mg_enterend()
{
    var_0 = level.bot_personality_type[self.personality] == "stationary";
    var_1 = 0;

    for (;;)
    {
        var_2 = mine_destroyed_vfx();
        var_1 = challengeevaluator() || istrue( level.dropminigunondeath );

        if ( var_1 )
            var_2 = mine_light_vfx();

        if ( isdefined( var_2 ) )
        {
            var_3 = cashtorefund();

            if ( istrue( level.checkamorused ) && isdefined( var_3 ) && !var_1 )
            {
                thread _id_12ACF();
                self getenemyinfo( var_3 );

                if ( self botgetpersonality() != "run_and_gun" )
                    scripts\mp\bots\bots_util::bot_set_personality( "run_and_gun" );

                if ( self bothasscriptgoal() )
                    self botclearscriptgoal();

                if ( !isdefined( self.trying_to_spawn_boss ) )
                {
                    self botsetscriptenemy( var_3 );
                    self.trying_to_spawn_boss = var_3;
                }
            }
            else
            {
                self.trying_to_spawn_boss = undefined;
                self notify( "update_on_death" );

                if ( self bothasscriptgoal() )
                    self botclearscriptgoal();

                self botclearscriptenemy();

                if ( var_1 )
                    self botsetscriptgoal( var_2, 128, "critical", undefined, undefined, 0 );
                else
                    self botsetscriptgoal( var_2, 400, "guard", undefined, undefined, 0 );

                if ( istrue( var_1 ) )
                    var_1 = 0;

                thread teamwipedobituary();
                var_4 = scripts\engine\utility::waittill_any_ents_return( self, "goal", self, "bad path", level, "br_circle_started", self, "last_stand_start", self, "path_timeout" );

                if ( isdefined( var_4 ) && ( var_4 != "bad path" && var_4 != "br_circle_started" && var_4 != "path_timeout" && var_4 != "last_stand_start" ) )
                {
                    var_5 = gettime() + randomintrange( 3, 8 ) * 1000;

                    while ( gettime() < var_5 )
                    {
                        if ( challengeevaluator() )
                        {
                            self.trying_to_spawn_boss = undefined;
                            self notify( "update_on_death" );
                            break;
                        }

                        wait 0.1;
                    }
                }
            }
        }

        wait 1;
    }
}

teamwipedobituary()
{
    self endon( "last_stand_start" );
    level endon( "game_ended" );
    self endon( "goal" );
    self endon( "bad path" );
    level endon( "br_circle_started" );
    wait 15;
    self notify( "path_timeout" );
}

cave_initial_enemy_goto_struct_on_spawn_and_wait_till_seen()
{
    self endon( "death_or_disconnect" );
    self endon( "gulag_end" );
    level endon( "game_ended" );
    var_0 = level.bot_personality_type[self.personality] == "stationary";
    self.trying_to_spawn_boss = undefined;
    self.ignoreme = 1;
    self.ignoreall = 1;
    self botclearscriptgoal();

    while ( !istrue( self.gulagarena ) )
        wait 1;

    self.ignoreme = 0;
    self.ignoreall = 0;
    scripts\mp\bots\bots_util::bot_set_personality( "run_and_gun" );

    for (;;)
    {
        var_1 = self.arena;

        foreach ( var_3 in var_1.arenaplayers )
        {
            if ( var_3 == self )
                continue;

            if ( istrue( var_1.overtime ) && isdefined( var_1.handle_no_ammo_mun ) && isdefined( var_1.handle_no_ammo_mun.arenaflag ) && isdefined( var_1.handle_no_ammo_mun.arenaflag.flagmodel ) )
            {
                self botsetscriptgoal( var_1.handle_no_ammo_mun.arenaflag.flagmodel.origin, 64, "objective" );
                self botclearscriptenemy();
                continue;
            }

            self getenemyinfo( var_3 );
            self botsetscriptgoal( self getclosestreachablepointonnavmesh( var_3.origin ), 256, "guard" );
            self botsetscriptenemy( var_3 );
        }

        wait 3;
    }
}

birds_in_square_monitor()
{
    self endon( "death_or_disconnect" );

    for (;;)
    {
        var_0 = self getweaponslistprimaries();

        if ( var_0.size == 1 && var_0[0].basename == "iw8_fists_mp" )
        {
            wait 1;
            continue;
        }

        foreach ( var_2 in var_0 )
        {
            if ( self getweaponammostock( var_2 ) < weaponclipsize( var_2 ) )
                self setweaponammostock( var_2, weaponclipsize( var_2 ) );
        }

        wait 0.1;
    }
}

cashtorefund()
{
    if ( isdefined( level.tryingtoleave ) && gettime() <= level.tryingtoleave )
        return undefined;

    var_0 = lightsshot02();

    if ( !isdefined( var_0 ) )
        return undefined;

    return var_0;
}

checkandreportchallengetimer()
{
    var_0 = 0;

    foreach ( var_2 in level.players )
    {
        if ( !isbot( var_2 ) )
            continue;

        if ( var_2 cdlgametuning() )
            var_0++;
    }

    return var_0;
}

cdlgametuning()
{
    return isdefined( self.trying_to_spawn_boss );
}

lightsshot02()
{
    var_0 = get_player();
    var_1 = squared( 3000 );

    if ( istrue( self.inlaststand ) || scripts\mp\gametypes\br_public.gsc::questtypes() )
        return undefined;

    if ( !isdefined( var_0 ) || istrue( var_0.inlaststand ) || !isalive( var_0 ) || var_0 scripts\mp\gametypes\br_public.gsc::questtypes() )
        return undefined;

    if ( challengeevaluator() )
        return undefined;

    var_2 = laser_vfx_think();

    if ( var_2 >= 3 )
    {
        if ( distancesquared( var_0.origin, self.origin ) > var_1 )
            return undefined;

        var_3 = checkandreportchallengetimer();

        if ( cdlgametuning() )
            return var_0;

        if ( var_3 >= 1 )
            return undefined;

        return var_0;
    }
    else
        return var_0;
}

get_player()
{
    foreach ( var_1 in level.players )
    {
        if ( !isbot( var_1 ) )
            return var_1;
    }
}

_id_12ACF()
{
    self notify( "update_on_death" );
    self endon( "update_on_death" );
    scripts\engine\utility::_id_12E40( "death", "death_or_disconnect", "last_stand_start" );
    self.trying_to_spawn_boss = undefined;
    level.tryingtoleave = gettime() + 7;
}

challengeevaluator()
{
    var_0 = scripts\mp\gametypes\br_circle.gsc::getdangercircleorigin();
    var_1 = scripts\mp\gametypes\br_circle.gsc::getdangercircleradius();

    if ( istrue( level.dropminigunondeath ) )
    {
        var_0 = scripts\mp\gametypes\br_circle.gsc::getsafecircleorigin();
        var_1 = scripts\mp\gametypes\br_circle.gsc::getsafecircleradius();
    }

    if ( scripts\mp\gametypes\br_public.gsc::questtypes() )
        return 0;

    if ( !isalive( self ) || self.sessionstate != "playing" )
        return 0;

    return !scripts\engine\utility::quit_game_in( self.origin, var_0, var_1 );
}

mine_explosion_vfx( var_0 )
{
    var_1 = scripts\mp\gametypes\br_circle.gsc::getrandompointincurrentcircle();

    if ( !isdefined( var_0 ) )
        var_0 = 1000;

    if ( distance2d( self.origin, var_1 ) > var_0 )
    {
        var_2 = vectortoangles( var_1 - self.origin );
        var_3 = anglestoforward( var_2 );
        var_1 = self.origin + var_3 * var_0;
    }

    return self getclosestreachablepointonnavmesh( var_1 );
}

mine_light_vfx()
{
    var_0 = scripts\mp\gametypes\br_circle.gsc::getsafecircleorigin();
    var_1 = scripts\mp\gametypes\br_circle.gsc::getsafecircleradius();
    var_2 = scripts\mp\gametypes\br_circle.gsc::getrandompointincircle( var_0, var_1, 0.75, 0.9, 1, 1 );
    return self getclosestreachablepointonnavmesh( var_2 );
}

mine_destroyed_vfx()
{
    var_0 = gettime() + 5000;

    while ( gettime() < var_0 )
    {
        var_1 = scripts\mp\gametypes\br_circle.gsc::getrandompointincircle( self.origin, 750, 0.6, 1, 1, 1 );
        var_2 = self getclosestreachablepointonnavmesh( var_1 );

        if ( quickdropremoverespawntokenfrominventory( var_2 ) )
            return var_2;

        wait 0.05;
    }

    var_3 = scripts\mp\gametypes\br_circle.gsc::getrandompointincurrentcircle();
    return self getclosestreachablepointonnavmesh( var_3 );
}

quickdropremoverespawntokenfrominventory( var_0 )
{
    var_1 = scripts\mp\gametypes\br_circle.gsc::getdangercircleorigin();
    var_2 = scripts\mp\gametypes\br_circle.gsc::getdangercircleradius();
    return scripts\engine\utility::quit_game_in( var_0, var_1, var_2 );
}

laser_vfx_think()
{
    var_0 = 0;

    foreach ( var_2 in level.players )
    {
        if ( !isbot( var_2 ) || !isalive( var_2 ) || var_2.sessionstate != "playing" )
            continue;

        var_0++;
    }

    return var_0;
}

check_missile_fire_vo( var_0 )
{
    var_1 = level.teamdata[var_0.team]["alivePlayers"];

    if ( scripts\engine\utility::array_contains( var_1, self ) )
        return 1;

    return 0;
}
