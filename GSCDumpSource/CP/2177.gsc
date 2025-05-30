// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

tac_cover_init()
{
    if ( !isdefined( level.taccovercollision ) )
    {
        var_0 = getentarray( "tactical_cover_col", "targetname" );

        if ( isdefined( var_0 ) )
            level.taccovercollision = var_0[0];
    }
}

tac_cover_on_give( var_0, var_1 )
{
    self notify( "tac_cover_given" );
}

tac_cover_on_take( var_0, var_1, var_2 )
{
    self notify( "tac_cover_taken" );
    self.taccoverrefund = undefined;
}

tac_cover_used( var_0 )
{
    waitframe();

    foreach ( var_2 in self.offhandinventory )
    {
        if ( isdefined( var_2.basename ) && var_2.basename == "tac_cover_mp" )
            self takeweapon( "tac_cover_mp" );
    }

    if ( isdefined( self.wait_for_elevator ) )
    {
        self switchtoweapon( self.wait_for_elevator );
        self.wait_for_elevator = undefined;
    }

    if ( isdefined( var_0 ) )
        var_0 delete();
}

tac_cover_on_fired( var_0, var_1, var_2, var_3 )
{
    self.taccoverrefund = 1;
    var_4 = physics_createcontents( [ "physicscontents_player", "physicscontents_solid", "physicscontents_playerclip", "physicscontents_water", "physicscontents_sky", "physicscontents_vehicle" ] );
    var_5 = anglestoforward( self.angles );
    var_6 = self.origin + var_5 * 32;
    var_7 = scripts\mp\trials\trial_utility::_id_11CE5( var_6, 140, 20 );
    var_8 = undefined;
    var_9 = 0;

    foreach ( var_11 in var_7 )
    {
        var_12 = distancesquared( var_11.origin, var_6 );

        if ( isdefined( var_8 ) && var_9 <= var_12 )
            continue;

        var_8 = var_11;
        var_9 = var_12;
    }

    if ( isdefined( var_8 ) )
    {
        var_14 = var_8 scriptabledoorangle();
        var_15 = abs( var_14 ) > 65;
        var_16 = undefined;

        foreach ( var_18 in var_7 )
        {
            if ( var_8 scripts\mp\trials\trial_utility::_id_11CE6( var_18 ) )
            {
                var_16 = var_18;
                break;
            }
        }

        var_20 = 1;

        if ( isdefined( var_16 ) )
        {
            var_21 = var_16 scriptabledoorangle();
            var_20 = abs( var_21 ) > 65;
        }

        if ( var_9 < 1600 && var_15 && var_20 )
        {
            var_8.processscrapassist = 1;
            self.taccoverrefund = undefined;
            thread _id_125E8( var_8, var_16, var_3, var_4 );

            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "challenges", "onFieldUpgradeEnd" ) )
                self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "challenges", "onFieldUpgradeEnd" ) ]]( "super_tac_cover", 1 );

            scripts\mp\ammorestock::incpersstat( "deployableCoverUsed", 1 );
            return 1;
        }
        else if ( var_9 < 6400 )
        {
            tac_cover_fire_failed( 1 );
            return 0;
        }
    }

    var_22 = tac_cover_ignore_list( self );
    var_23 = self getplayerangles() * ( 0, 1, 0 );
    var_24 = self.origin + ( 0, 0, 24 );
    var_25 = anglestoforward( var_23 );
    var_26 = 29.5;
    var_27 = var_24 + var_25 * var_26;
    var_28 = physics_raycast( var_24, var_27, var_4, var_22, 0, "physicsquery_closest", 1 );

    if ( isdefined( var_28 ) && var_28.size > 0 )
    {
        tac_cover_fire_failed();
        return 0;
    }

    var_29 = undefined;
    var_30 = undefined;
    var_24 = var_27;
    var_25 = anglestoright( var_23 );
    var_26 = 55.5;
    var_31 = var_24 + var_25 * var_26;
    var_28 = physics_spherecast( var_24, var_31, 2.5, var_4, var_22, "physicsquery_closest" );

    if ( isdefined( var_28 ) && var_28.size > 0 )
    {
        var_32 = var_28[0]["shape_position"];
        var_29 = var_28[0]["fraction"];
    }
    else
        var_29 = 1;

    var_24 = var_27;
    var_25 = -1 * anglestoright( var_23 );
    var_26 = 55.5;
    var_31 = var_24 + var_25 * var_26;
    var_28 = physics_spherecast( var_24, var_31, 2.5, var_4, var_22, "physicsquery_closest" );

    if ( isdefined( var_28 ) && var_28.size > 0 )
    {
        var_32 = var_28[0]["shape_position"];
        var_30 = var_28[0]["fraction"];
    }
    else
        var_30 = 1;

    if ( var_30 + var_29 < 1 )
    {
        tac_cover_fire_failed();
        return 0;
    }
    else if ( var_29 < 0.5 )
        var_27 = var_27 + var_25 * var_26 * ( 0.5 - var_29 );
    else if ( var_30 < 0.5 )
        var_27 = var_27 + var_25 * var_26 * ( 0.5 - var_30 ) * -1;

    var_33 = var_23;
    var_24 = var_27;
    var_25 = ( 0, 0, -1 );
    var_26 = 60;
    var_31 = var_24 + var_25 * var_26;
    var_34 = combineangles( var_33, ( 0, 0, 90 ) );
    var_28 = physics_capsulecast( var_24, var_31, 2.5, 16.8, var_34, var_4, var_22, "physicsquery_closest" );

    if ( !isdefined( var_28 ) || var_28.size <= 0 )
    {
        tac_cover_fire_failed();
        return 0;
    }

    var_35 = var_28[0]["entity"];

    if ( isdefined( var_35 ) && !_id_125E3( var_35 ) )
    {
        tac_cover_fire_failed();
        return 0;
    }

    var_36 = var_28[0]["shape_position"];
    var_32 = var_28[0]["position"];
    var_37 = var_36 - ( 0, 0, 2.5 );
    var_38 = 25.025;
    var_39 = pow( var_38 * 0.14, 2 );
    var_40 = var_36;
    var_41 = distance2dsquared( var_40, var_32 );
    var_42 = var_36 + anglestoright( var_23 ) * 14.3 * 1.75;
    var_43 = distance2dsquared( var_42, var_32 );
    var_44 = var_36 + anglestoright( var_23 ) * 14.3 * 1.75 * -1;
    var_45 = distance2dsquared( var_44, var_32 );
    var_46 = [];
    var_47 = 0;

    if ( var_43 <= var_39 && var_43 < var_41 && var_43 < var_45 )
    {
        var_47++;
        var_46 = [ var_40, var_44 ];
    }
    else if ( var_45 <= var_39 && var_45 < var_41 && var_45 < var_43 )
    {
        var_47++;
        var_46 = [ var_40, var_42 ];
    }
    else if ( var_41 <= var_39 )
    {
        var_47++;
        var_46 = [ var_44, var_42 ];
    }
    else
        var_46 = [ var_40, var_44, var_42 ];

    var_25 = ( 0, 0, -1 );
    var_26 = 8.5;

    foreach ( var_24 in var_46 )
    {
        var_31 = var_24 + var_25 * var_26;
        var_28 = physics_raycast( var_24, var_31, var_4, var_22, 0, "physicsquery_closest", 1 );

        if ( !isdefined( var_28 ) || var_28.size <= 0 )
            continue;

        var_35 = var_28[0]["entity"];

        if ( isdefined( var_35 ) && !_id_125E3( var_35 ) )
        {
            tac_cover_fire_failed();
            return 0;
        }

        var_47++;

        if ( var_47 >= 2 )
            break;
    }

    if ( var_47 < 2 )
    {
        tac_cover_fire_failed();
        return 0;
    }

    self.taccoverrefund = undefined;
    thread tac_cover_spawn( var_37, var_33, undefined, var_3, var_4 );

    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "challenges", "onFieldUpgradeEnd" ) )
        self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "challenges", "onFieldUpgradeEnd" ) ]]( "super_tac_cover", 1 );

    scripts\mp\ammorestock::incpersstat( "deployableCoverUsed", 1 );
    return 1;
}

tac_cover_adjust_for_player_space( var_0, var_1, var_2 )
{
    var_3 = tac_cover_get_free_space( 1, var_0, var_1, var_2, 32 );

    if ( !isdefined( var_3 ) )
        return var_0;

    var_4 = tac_cover_get_free_space( 0, var_0, var_1, var_2, 32 );

    if ( !isdefined( var_4 ) )
        return var_0;

    var_5 = min( var_3, 15 );
    var_6 = anglestoforward( var_1 );
    var_7 = var_0 + var_6 * var_5;
    return var_7;
}

tac_cover_get_free_space( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = anglestoleft( var_2 );
    var_6 = anglestoforward( var_2 );
    var_7 = -1 * var_6;
    var_8 = undefined;

    if ( var_0 )
        var_8 = var_6 * var_4;
    else
        var_8 = var_7 * var_4;

    var_9 = var_1 + ( 0, 0, 48 );
    var_10 = var_9;
    var_11 = var_9 + var_8;
    var_12 = 2.5;
    var_13 = 29.0 + var_4;
    var_14 = combineangles( var_2, ( 0, 0, 90 ) );
    var_3 = var_3;
    var_15 = [ self ];
    var_16 = "physicsquery_closest";
    var_17 = physics_capsulecast( var_10, var_11, var_12, var_13, var_14, var_3, var_15, var_16 );
    var_18 = var_17.size == 0;

    if ( var_18 )
        return undefined;

    var_25 = var_17[0]["shape_position"];
    var_26 = distance( var_25, var_9 );
    return var_26;
}

tac_cover_fire_failed( var_0 )
{
    var_1 = scripts\engine\utility::ter_op( istrue( var_0 ), "MP/TAC_COVER_PLACE_IN_DOORWAY", "MP/TAC_COVER_CANNOT_PLACE" );

    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "hud", "showErrorMessage" ) )
        self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "hud", "showErrorMessage" ) ]]( var_1 );

    if ( soundexists( "iw8_deployable_cover_plant_fail" ) )
        self playsoundtoplayer( "iw8_deployable_cover_plant_fail", self );
}

_id_125E5()
{
    if ( self hasweapon( "tac_cover_mp" ) )
        self takeweapon( "tac_cover_mp" );

    var_0 = scripts\cp\loot_system::get_empty_munition_slot( self );

    if ( isdefined( var_0 ) )
        scripts\cp\cp_munitions::give_munition_to_slot( "deployable_cover", var_0 );
}

tac_cover_entmanagerdelete()
{
    thread tac_cover_delete( 0 );
}

_id_125E8( var_0, var_1, var_2, var_3 )
{
    self endon( "death_or_disconnect" );
    self endon( "tac_cover_taken" );
    level endon( "game_ended" );
    var_4 = anglestoforward( self.angles );
    var_5 = var_0.enemy_push_players_logic + ( 0, 90, 0 );
    var_6 = anglestoforward( var_5 );
    var_7 = vectordot( var_4, var_6 );
    var_8 = var_7 > 0;
    var_9 = var_0 scriptabledoorangle();
    var_0 scriptabledoorfreeze( 1 );

    if ( isdefined( var_1 ) )
        var_1 scriptabledoorfreeze( 1 );

    var_10 = scripts\engine\utility::ter_op( var_8, ( 0, 90, 0 ), ( 0, -90, 0 ) );
    var_11 = ( 0, 0, -1 );
    var_12 = var_0.enemy_respawn_manager + var_11;
    var_13 = combineangles( var_0.enemy_push_players_logic, var_10 );
    var_14 = undefined;
    tac_cover_spawn( var_12, var_13, var_14, var_2, var_3, var_0, var_1 );
}

tac_cover_spawn( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    self endon( "death_or_disconnect" );
    self endon( "tac_cover_taken" );
    level endon( "game_ended" );
    wait 0.05;
    var_0 = tac_cover_adjust_for_player_space( var_0, var_1, var_4 );
    self notify( "tac_cover_spawned" );
    var_3 = istrue( var_3 );
    var_7 = spawn( "script_model", var_0 );
    var_7.angles = var_1;
    var_7.owner = self;
    var_7.team = self.team;
    var_7.slot = "primary";
    var_7.exploding = 1;
    var_7.issuper = scripts\engine\utility::ter_op( var_3, 1, undefined );
    var_7 scripts\cp\utility::make_entity_sentient_cp( var_7.owner.team );
    var_7 setentityowner( self );
    var_7 setotherent( self );
    var_7 setmodel( "offhand_wm_deployable_cover" );
    var_7.equipmentref = "equip_tac_cover";

    if ( isdefined( var_2 ) )
    {
        var_7 linkto( var_2 );
        var_7 thread tac_cover_destroy_on_unstuck();
    }

    var_8 = tac_cover_spawn_collision( var_7 );
    var_7 validatecollision( var_8, level.taccovercollision );
    var_7.collision = var_8;
    var_8.cover = var_7;
    var_8.moverdoesnotkill = 1;

    if ( isdefined( var_5 ) )
    {
        if ( isdefined( var_5.calloutmarkerping_enemytodangerdecaycreate ) )
            var_5.calloutmarkerping_enemytodangerdecaycreate tac_cover_destroy();

        var_7.called90percentprogress = var_5;
        var_5.calloutmarkerping_enemytodangerdecaycreate = var_7;
    }

    if ( isdefined( var_6 ) )
    {
        var_7.calloutmarkerping_canplayerping = var_6;
        var_6.calloutmarkerping_enemytodangerdecaycreate = var_7;
    }

    var_7.streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo( "tac_cover", var_7.owner );

    if ( isdefined( self.taccovers ) && self.taccovers.size + 1 > 2 )
    {
        var_9 = self.taccovers.size + 1 - 2;
        var_10 = self.taccovers;

        for ( var_11 = 0; var_11 < var_9; var_11++ )
            var_12 = var_10[var_11];
    }

    thread scripts\cp\cp_weapon::monitordisownedequipment( self, var_7 );
    var_7 tac_cover_add_to_list( self );

    if ( var_3 )
    {
        var_7 thread tac_cover_destroy_on_disowned( self );
        var_7 thread tac_cover_destroy_on_timeout();
    }

    var_7 thread tac_cover_destroy_on_game_end();
    thread tac_cover_spawn_internal( var_7 );
}

tac_cover_spawn_internal( var_0 )
{
    var_0 endon( "death" );

    if ( 1 && 0 )
        var_0 tac_cover_set_can_damage( 1 );

    if ( isdefined( var_0.called90percentprogress ) )
        var_0 setscriptablepartstate( "effects", "plantStartDoor", 0 );
    else
        var_0 setscriptablepartstate( "effects", "plantStart", 0 );

    wait( tac_cover_get_deploy_anim_dur() );

    if ( 1 && !0 )
        var_0 tac_cover_set_can_damage( 1 );

    if ( isdefined( var_0.called90percentprogress ) )
        var_0 setscriptablepartstate( "effects", "plantEndDoor", 0 );
    else
        var_0 setscriptablepartstate( "effects", "plantEnd", 0 );
}

tac_cover_spawn_collision( var_0 )
{
    if ( !isdefined( level.taccovercollision ) )
        return;

    var_1 = spawn( "script_model", var_0.origin );
    var_1 dontinterpolate();
    var_1.angles = var_0.angles;
    var_1 clonebrushmodeltoscriptmodel( level.taccovercollision );
    var_1 linkto( var_0 );
    var_1 setentityowner( self );
    var_1 disconnectpaths();
    return var_1;
}

tac_cover_destroy( var_0, var_1 )
{
    var_2 = 0;

    if ( !istrue( var_0 ) )
        var_2 = 0.2 + tac_cover_get_destroy_anim_dur();

    var_3 = self.maxhealth;

    if ( isdefined( self.damagetaken ) && self.damagetaken < self.maxhealth )
        var_3 = self.damagetaken;

    self.owner scripts\cp_mp\utility\killstreak_utility::x1loadout( self.streakinfo );
    thread tac_cover_destroy_internal( var_2 );
    thread tac_cover_delete( var_2 );
}

tac_cover_destroy_internal( var_0 )
{
    if ( isdefined( self.called90percentprogress ) )
    {
        self.called90percentprogress scriptabledoorfreeze( 0 );
        self.called90percentprogress.calloutmarkerping_enemytodangerdecaycreate = undefined;
    }

    if ( isdefined( self.calloutmarkerping_canplayerping ) )
    {
        self.calloutmarkerping_canplayerping scriptabledoorfreeze( 0 );
        self.calloutmarkerping_canplayerping.calloutmarkerping_enemytodangerdecaycreate = undefined;
    }

    if ( var_0 > 0 )
    {
        self setscriptablepartstate( "effects", "destroyStart" );
        wait( tac_cover_get_destroy_anim_dur() );
        self setscriptablepartstate( "effects", "destroyEnd" );
    }

    if ( isdefined( self.collision ) )
        self.collision delete();
}

tac_cover_delete( var_0 )
{
    self notify( "death" );
    level.mines[self getentitynumber()] = undefined;
    var_1 = self.owner;

    if ( 1 )
        self thermaldrawdisable();

    if ( isdefined( self.collision ) )
        self.collision delete();

    wait( var_0 );
    self delete();
}

tac_cover_destroy_on_timeout()
{
    self endon( "death" );
    wait 150;
    tac_cover_destroy( undefined, 0 );
}

tac_cover_destroy_on_game_end()
{
    self endon( "death" );
    level waittill( "game_ended" );
    tac_cover_destroy( undefined, 0 );
}

tac_cover_destroy_on_unstuck()
{
    self endon( "death" );

    while ( isdefined( self getlinkedparent() ) )
        waitframe();

    tac_cover_destroy( undefined, 0 );
}

tac_cover_set_can_damage( var_0 )
{
    if ( 1 )
    {
        if ( var_0 )
        {
            var_1 = scripts\cp\utility::_hasperk( "specialty_rugged_eqp" );
            var_2 = scripts\engine\utility::ter_op( var_1, 1250, 1000 );
            var_3 = "hitequip";
            thread scripts\cp\cp_weapon::monitordamage( var_2, var_3, ::tac_cover_handle_fatal_damage, ::tac_cover_handle_damage, 0 );
            self thermaldrawenable();
        }
        else
            self thermaldrawdisable();
    }
}

tac_cover_handle_damage( var_0 )
{
    var_1 = var_0.attacker;
    var_2 = var_0.objweapon;
    var_3 = var_0.meansofdeath;
    var_4 = var_0.damage;
    var_5 = var_0.point;

    if ( !isdefined( var_2 ) )
        return var_4;

    if ( var_2.basename == "thermite_av_mp" )
        return 200.0;

    if ( var_2.basename == "throwingknife_mp" )
        return 0;

    if ( var_2.basename == "iw8_sn_crossbow_mp" )
        return 0;

    if ( var_3 == "MOD_IMPACT" && var_2.classname == "grenade" )
        return var_4;

    if ( var_3 == "MOD_CRUSH" && isdefined( var_0.inflictor ) && var_0.inflictor.classname == "script_vehicle" )
    {
        if ( isdefined( var_1 ) && !scripts\cp\cp_damage::friendlyfirecheck( self.owner, var_1 ) )
        {
            if ( isdefined( var_0.inflictor.vehiclename ) && _id_125E2( var_0.inflictor.vehiclename ) )
                return var_4;
            else
                return 0;
        }
    }

    if ( isexplosivedamagemod( var_0.meansofdeath ) )
        return 700.0;

    if ( var_3 == "MOD_MELEE" || var_3 == "MOD_IMPACT" )
        var_4 = 333.333;

    if ( isdefined( var_1 ) && isdefined( self.owner ) && var_1 == self.owner )
        var_4 = var_4 * 1;

    return var_4;
}

tac_cover_handle_fatal_damage( var_0 )
{
    var_1 = var_0.attacker;

    if ( istrue( scripts\cp_mp\utility\player_utility::playersareenemies( self.owner, var_1 ) ) )
    {
        if ( isplayer( var_1 ) )
        {
            var_1 thread scripts\mp\brmatchdata::giveunifiedpoints( "destroyed_equipment" );
            var_1 thread scripts\cp\cp_player_battlechatter::equipmentdestroyed( self );
        }

        var_1 notify( "destroyed_equipment" );
    }

    thread tac_cover_destroy( undefined, 1 );
}

_id_125E2( var_0 )
{
    switch ( var_0 )
    {
        case "light_tank":
        case "apc_russian":
            return 1;
        default:
            break;
    }

    return 0;
}

tac_cover_ignore_list( var_0 )
{
    var_1 = [ var_0 ];

    if ( isdefined( level.grenades ) )
    {
        foreach ( var_3 in level.grenades )
        {
            if ( isdefined( var_3 ) )
                var_1[var_1.size] = var_3;
        }
    }

    if ( isdefined( level.missiles ) )
    {
        foreach ( var_6 in level.missiles )
        {
            if ( isdefined( var_6 ) )
                var_1[var_1.size] = var_6;
        }
    }

    if ( isdefined( level.mines ) )
    {
        foreach ( var_9 in level.mines )
        {
            if ( !isdefined( var_9 ) )
                continue;

            var_10 = isdefined( var_9.owner ) && var_9.owner == var_0;
            var_11 = isdefined( var_9.equipmentref ) && var_9.equipmentref == "equip_tac_cover";
            var_12 = isdefined( var_9.equipmentref ) && var_9.equipmentref == "equip_ammo_box";

            if ( !var_10 && ( var_11 || var_12 ) )
                continue;

            var_1[var_1.size] = var_9;

            if ( isdefined( var_9.collision ) )
                var_1[var_1.size] = var_9.collision;
        }
    }

    return var_1;
}

_id_125E3( var_0 )
{
    if ( isplayer( var_0 ) )
        return 0;

    if ( var_0 getnonstick() )
        return 0;

    if ( istrue( var_0.mountmantlemodel ) )
        return 0;

    if ( var_0.classname == "misc_turret" )
        return 0;

    if ( var_0.classname == "script_vehicle" )
        return 0;

    return 1;
}

#using_animtree("scriptables");

tac_cover_get_deploy_anim_dur()
{
    return getanimlength( %wm_deployable_cover_deploy );
}

tac_cover_get_destroy_anim_dur()
{
    return 0;
}

tac_cover_on_fired_super()
{
    return tac_cover_on_fired( undefined, undefined, undefined, 1 );
}

tac_cover_on_take_super()
{
    tac_cover_on_take( undefined, undefined, 1 );
}

tac_cover_destroy_on_disowned( var_0 )
{
    self endon( "death" );
    var_0 endon( "tac_cover_taken" );
    var_0 scripts\engine\utility::_id_12E3F( "joined_team", "disconnect" );
    thread tac_cover_destroy( undefined, 0 );
}

tac_cover_add_to_list( var_0 )
{
    if ( !isdefined( var_0.taccovers ) )
        var_0.taccovers = [];

    var_0.taccovers[var_0.taccovers.size] = self;

    if ( !isdefined( level.taccovers ) )
        level.taccovers = [];

    var_1 = self getentitynumber();
    level.taccovers[var_1] = self;
}

tac_cover_remove_from_list( var_0, var_1 )
{
    if ( isdefined( var_0.taccovers ) )
    {
        var_2 = [];

        foreach ( var_4 in var_0.taccovers )
        {
            if ( isdefined( var_4 ) && var_4 != self )
                var_2[var_2.size] = var_4;
        }

        var_0.taccovers = var_2;
    }

    if ( isdefined( level.taccovers ) )
        level.taccovers[var_1] = undefined;
}

ricochet_bullet( var_0, var_1, var_2, var_3 )
{
    var_4 = scripts\engine\math::vector_reflect( var_0, var_1 );
    magicbullet( var_3, var_2 + var_0 * 10, var_2 + var_0 * 10 + var_4 );
}
