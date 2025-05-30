// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    scripts\cp_mp\utility\script_utility::registersharedfunc( "airdrop", "airdropMultipleInit", ::airdrop_airdropmultipleinit );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "airdrop", "registerScoreInfo", ::airdrop_registerscoreinfo );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "airdrop", "registerActionSet", ::airdrop_registeractionset );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "airdrop", "updateUIProgress", ::airdrop_updateuiprogress );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "airdrop", "allowActionSet", ::airdrop_allowactionset );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "airdrop", "unresolvedCollisionNearestNode", ::airdrop_unresolvedcollisionnearestnode );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "airdrop", "showErrorMessage", ::airdrop_showerrormessage );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "airdrop", "awardKillstreak", ::airdrop_awardkillstreak );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "airdrop", "showKillstreakSplash", ::airdrop_showkillstreaksplash );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "airdrop", "getTargetMarker", ::airdrop_gettargetmarker );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "airdrop", "airdropMultipleDropCrates", ::airdrop_airdropmultipledropcrates );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "airdrop", "registerCrateForCleanup", ::airdrop_registercrateforcleanup );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "airdrop", "makeWeaponFromCrate", ::airdrop_makeweaponfromcrate );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "airdrop", "makeItemFromCrate", ::airdrop_makeitemfromcrate );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "airdrop", "outlineDisable", ::airdrop_outlinedisable );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "airdrop", "br_forceGiveWeapon", ::airdrop_br_forcegiveweapon );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "airdrop", "captureLootCacheCallback", ::airdrop_capturelootcachecallback );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "airdrop", "isKillstreakBlockedForBots", ::airdrop_iskillstreakblockedforbots );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "airdrop", "botIsKillstreakSupported", ::airdrop_botiskillstreaksupported );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "airdrop", "getGameModeSpecificCrateData", ::airdrop_getgamemodespecificcratedata );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "airdrop", "specialCase_canUseCrate", ::bankingoverlimitwillendot );
    level.crate_random_weapons = [ "brloot_weapon_ak47", "brloot_weapon_as50", "brloot_weapon_aug", "brloot_weapon_dp12", "brloot_weapon_famas", "brloot_weapon_g21", "brloot_weapon_hk121", "brloot_weapon_kar98", "brloot_weapon_m14", "brloot_weapon_m4", "brloot_weapon_m870", "brloot_weapon_marlin", "brloot_weapon_mcx", "brloot_weapon_mp5", "brloot_weapon_mp7", "brloot_weapon_p90", "brloot_weapon_pkm", "brloot_weapon_python", "brloot_weapon_p320" ];
}

initcpcratedata()
{
    var_0 = scripts\cp_mp\killstreaks\airdrop::getleveldata( "cp" );
    var_0.capturestring = &"MP/BR_CRATE";
    var_0.enemymodel = undefined;
    var_0.supportsownercapture = 0;
    var_0.headicon = undefined;
    var_0.usepriority = -10000;
    var_0.timeout = undefined;
    var_0.activatecallback = ::cpcrateactivatecallback;
    var_0.capturecallback = ::cpcratecapturecallback;
}

getcpcratedatabytype( var_0 )
{
    var_1 = spawnstruct();
    var_1.type = var_0;
    return var_1;
}

cpcrateactivatecallback( var_0 )
{
    if ( istrue( var_0 ) )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "airdrop", "registerCrateForCleanup" ) )
            [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "airdrop", "registerCrateForCleanup" ) ]]( self );
    }
}

cpcratecapturecallback( var_0 )
{
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "airdrop", "makeItemsFromCrate" ) )
        self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "airdrop", "makeItemsFromCrate" ) ]]( var_0 );

    var_0 [[ level.custom_giveloadout ]]( 0 );
}

initcparmsraceemptycrate()
{
    var_0 = scripts\cp_mp\killstreaks\airdrop::getleveldata( "cp_armsrace_crate" );
    var_0.capturestring = "";
    var_0.enemymodel = undefined;
    var_0.supportsownercapture = 0;
    var_0.headicon = undefined;
    var_0.usepriority = -10000;
    var_0.timeout = undefined;
    var_0.friendlyuseonly = 1;
    var_0.hasnointeraction = 1;
    var_0.activatecallback = undefined;
    var_0.capturecallback = undefined;
    var_0.destroyoncapture = 0;
    var_0.onecaptureperplayer = 0;
}

players_inside()
{
    var_0 = scripts\cp_mp\killstreaks\airdrop::getleveldata( "cp_resources_crate" );
    var_0.capturestring = &"MP/BR_CRATE";
    var_0.enemymodel = undefined;
    var_0.supportsownercapture = 0;
    var_0.headicon = "hud_icon_head_killstreak_carepackage";
    var_0.usepriority = -10000;
    var_0.timeout = undefined;
    var_0.friendlyuseonly = 1;
    var_0.activatecallback = ::cploadoutcrateactivatecallback;
    var_0.capturecallback = ::fakeprops;
    var_0.destroyoncapture = 0;
    var_0.onecaptureperplayer = 1;
}

fakeprops( var_0 )
{
    if ( istrue( var_0.inlaststand ) )
        return;

    if ( !isdefined( self.numuses ) )
        self.numuses = 0;

    if ( !isdefined( self.playersused ) )
        self.playersused = [];

    self.playersused[self.playersused.size] = var_0;
    var_0 scripts\cp\cp_ammo_crate::give_ammo_to_player_through_crate();
    scripts\cp\cp_armor::givearmor( var_0, 100, 1 );
    var_1 = var_0 getweaponslistprimaries();

    foreach ( var_3 in var_1 )
    {
        if ( weapontype( var_3 ) == "projectile" )
        {
            if ( var_3.basename == "iw8_la_mike32_mp" )
            {
                if ( var_0.gl_proj_override == "thermite" )
                    continue;
            }

            var_4 = weaponclipsize( var_3 );
            var_0 givemaxammo( var_3 );
        }
    }

    foreach ( var_7 in var_0.powers )
    {
        if ( var_7.charges < var_7.maxcharges )
            var_8 = 0;
    }

    thread scripts\cp\cp_grenade_crate::refill_grenades( var_0 );
    var_0 playlocalsound( "weap_ammo_pickup" );
    self.numuses++;

    if ( self.numuses >= level.players.size )
    {
        if ( isdefined( self.outlines ) )
        {
            foreach ( var_11 in self.outlines )
            {
                if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "airdrop", "outlineDisable" ) )
                    [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "airdrop", "outlineDisable" ) ]]( var_11, self );
            }
        }

        thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
    }
}

initcploadoutcratedata()
{
    var_0 = scripts\cp_mp\killstreaks\airdrop::getleveldata( "cp_loadout" );
    var_0.capturestring = &"COOP_GAME_PLAY/CHANGE_LOADOUT";
    var_0.enemymodel = undefined;
    var_0.supportsownercapture = 0;
    var_0.headicon = undefined;
    var_0.usepriority = -10000;
    var_0.timeout = undefined;
    var_0.friendlyuseonly = 1;
    var_0.activatecallback = ::cploadoutcrateactivatecallback;
    var_0.capturecallback = ::cploadoutcratecapturecallback;
    var_0.destroyoncapture = 0;
    var_0.onecaptureperplayer = 1;
}

playerwaittillspectatecycle()
{
    var_0 = scripts\cp_mp\killstreaks\airdrop::getleveldata( "operation_crates" );
    var_0.capturestring = &"MP/ESC_CACHE_USE_HINT";
    var_0.enemymodel = undefined;
    var_0.supportsownercapture = 0;
    var_0.headicon = "hud_icon_head_killstreak_carepackage";
    var_0.usepriority = -10000;
    var_0.timeout = 90;
    var_0.friendlyuseonly = 1;
    var_0.activatecallback = ::fallback_index;
    var_0.capturecallback = ::falling_xyratio;
    var_0.destroyoncapture = 0;
    var_0.onecaptureperplayer = 0;
    var_0.nextplayertospectate = 55;
    var_0.heliheightoffset = 12000;
}

players_monitor()
{
    var_0 = scripts\cp_mp\killstreaks\airdrop::getleveldata( "cp_rooftop_crate" );
    var_0.capturestring = &"CP_DWN_TWN_OBJECTIVES/TAKE_ROOFTOP_CRATE";
    var_0.enemymodel = undefined;
    var_0.supportsownercapture = 0;
    var_0.headicon = "hud_icon_head_killstreak_carepackage";
    var_0.usepriority = -10000;
    var_0.timeout = 99999;
    var_0.friendlyuseonly = 1;
    var_0.activatecallback = ::cploadoutcrateactivatecallback;
    var_0.capturecallback = ::fananim;
    var_0.destroyoncapture = 1;
    var_0.onecaptureperplayer = 0;
}

fallback_index( var_0 )
{
    thread scripts\cp_mp\killstreaks\airdrop::final_radius_think();

    if ( istrue( var_0 ) )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "airdrop", "registerCrateForCleanup" ) )
            [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "airdrop", "registerCrateForCleanup" ) ]]( self );
    }

    if ( !isdefined( self.angles ) )
        self.angles = ( 0, 0, 0 );
}

fananim( var_0 )
{
    [[ level._id_11B75 ]]( var_0 );
}

falling_xyratio( var_0 )
{
    if ( istrue( var_0.inlaststand ) )
        return;

    if ( !isdefined( self.numuses ) )
        self.numuses = 0;

    if ( !isdefined( self.playersused ) )
        self.playersused = [];

    self.playersused[self.playersused.size] = var_0;

    if ( isdefined( self.gas_attack ) )
    {
        self thread [[ self.gas_attack ]]( var_0 );
        return;
    }

    if ( !istrue( level.getsubgametype ) )
        var_0 scripts\cp\cp_ammo_crate::give_ammo_to_player_through_crate();

    scripts\cp\cp_armor::givearmor( var_0, 100, 1 );
    var_1 = var_0 getweaponslistprimaries();

    foreach ( var_3 in var_1 )
    {
        if ( weapontype( var_3 ) == "projectile" )
        {
            if ( var_3.basename == "iw8_la_mike32_mp" )
            {
                if ( var_0.gl_proj_override == "thermite" )
                    continue;
            }

            var_4 = weaponclipsize( var_3 );
            var_0 givemaxammo( var_3 );
        }
    }

    foreach ( var_7 in var_0.powers )
    {
        if ( var_7.charges < var_7.maxcharges )
            var_8 = 0;
    }

    thread scripts\cp\cp_grenade_crate::refill_grenades( var_0 );
    var_0 playlocalsound( "weap_ammo_pickup" );
    var_10 = [ "precision_airstrike", "juggernaut", "cruise_missile", "cluster_strike" ];

    if ( isdefined( self.wave_goto_on_spawn ) )
        var_10 = self.wave_goto_on_spawn;

    var_11 = scripts\engine\utility::random( var_10 );
    var_12 = undefined;
    var_13 = var_0 getplayerdata( "cp", "inventorySlots", "totalSlots" );

    if ( var_13 < 4 )
        var_12 = var_13;
    else
        var_12 = var_0.dpad_selection_index - 1;

    var_14 = scripts\cp\loot_system::get_empty_munition_slot( var_0 );

    if ( isdefined( var_14 ) )
        var_12 = var_14;
    else
    {
        var_0 scripts\cp\utility::hint_prompt( "munition_slots_full", 1, 2 );
        return;
    }

    if ( var_11 == "sentry_turret" )
        var_0 scripts\cp\loot_system::try_give_munition_to_slot( var_11, var_12, "sentry_turret" );
    else
        var_0 scripts\cp\loot_system::try_give_munition_to_slot( var_11, var_12 );

    self.numuses++;

    if ( self.numuses >= level.players.size )
    {
        if ( isdefined( self.outlines ) )
        {
            foreach ( var_16 in self.outlines )
            {
                if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "airdrop", "outlineDisable" ) )
                    [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "airdrop", "outlineDisable" ) ]]( var_16, self );
            }
        }

        thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
    }
}

cploadoutcrateactivatecallback( var_0 )
{
    if ( istrue( var_0 ) )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "airdrop", "registerCrateForCleanup" ) )
            [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "airdrop", "registerCrateForCleanup" ) ]]( self );
    }
}

cploadoutcratecapturecallback( var_0 )
{
    if ( !isdefined( self.numuses ) )
        self.numuses = 0;

    if ( !isdefined( self.playersused ) )
        self.playersused = [];

    self.playersused[self.playersused.size] = var_0;

    if ( !scripts\cp\cp_endgame::gamealreadyended() )
        var_0 setclientomnvar( "ui_options_menu", 2 );

    self.numuses++;

    if ( self.numuses >= level.players.size )
    {
        if ( isdefined( self.outlines ) )
        {
            foreach ( var_2 in self.outlines )
            {
                if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "airdrop", "outlineDisable" ) )
                    [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "airdrop", "outlineDisable" ) ]]( var_2, self );
            }
        }

        thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
    }
}

airdrop_airdropmultipleinit()
{
    scripts\cp_mp\killstreaks\airdrop_multiple::airdrop_multiple_init();
}

airdrop_registerscoreinfo()
{

}

airdrop_registeractionset()
{
    var_0 = getdvarint( "scr_airDrop_use_weapon", 1 );

    if ( var_0 )
        scripts\mp\playeractions::registeractionset( "crateUse", [ "offhand_weapons", "fire", "melee", "weapon_switch", "killstreaks", "supers" ] );
    else
        scripts\mp\playeractions::registeractionset( "crateUse", [ "offhand_weapons", "weapon", "killstreaks", "supers" ] );
}

airdrop_updateuiprogress( var_0, var_1 )
{
    if ( !scripts\cp\utility::preventleave() && !scripts\cp\utility::prematchintiallandingcomplete() )
        updateuiprogress( var_0, var_1 );
}

updateuiprogress( var_0, var_1 )
{
    if ( !isdefined( level.hostmigrationtimer ) )
    {
        if ( isdefined( var_0.interactteam ) && var_0.interactteam == "none" )
        {
            self setclientomnvar( "ui_objective_state", 0 );
            return;
        }

        var_2 = undefined;

        if ( isdefined( var_0.objidnum ) )
            var_2 = var_0.objidnum;

        var_3 = 0;

        if ( isdefined( var_0.teamprogress ) && isdefined( var_0.claimteam ) )
        {
            if ( var_0.teamprogress[var_0.claimteam] > var_0.usetime )
                var_0.teamprogress[var_0.claimteam] = var_0.usetime;

            var_3 = var_0.teamprogress[var_0.claimteam] / var_0.usetime;
        }
        else
        {
            if ( var_0.curprogress > var_0.usetime )
                var_0.curprogress = var_0.usetime;

            var_3 = var_0.curprogress / var_0.usetime;

            if ( var_0.usetime <= 1000 )
                var_3 = min( var_3 + 0.05, 1 );
            else
                var_3 = min( var_3 + 0.01, 1 );
        }

        if ( isdefined( var_0.id ) )
        {
            var_4 = 0;

            switch ( var_0.id )
            {
                case "care_package":
                    var_4 = 1;
                    break;
                case "intel":
                    var_4 = 2;
                    break;
                case "support_box":
                    var_4 = 3;
                    break;
                case "deployable_weapon_crate":
                    var_4 = 4;
                    break;
                case "use":
                    var_4 = 8;
                    break;
            }

            updateuisecuring( var_3, var_1, var_4, var_0, var_0.usetime );
        }
    }
}

isrevivetrigger()
{
    if ( isdefined( self.id ) && self.id == "laststand_reviver" )
        return 1;

    return 0;
}

existinarray( var_0, var_1 )
{
    if ( var_1.size > 0 )
    {
        foreach ( var_3 in var_1 )
        {
            if ( var_3 == var_0 )
                return 1;
        }
    }

    return 0;
}

updateuisecuring( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = undefined;

    if ( var_1 )
    {
        if ( !isdefined( var_3.usedby ) )
            var_3.usedby = [];

        if ( !isdefined( self.migrationcapturereset ) )
            var_3 thread migrationcapturereset( self );

        if ( !existinarray( self, var_3.usedby ) )
            var_3.usedby[var_3.usedby.size] = self;

        if ( !isdefined( self.ui_securing ) )
        {
            self setclientomnvar( "ui_securing", var_2 );
            self.ui_securing = 1;

            if ( isdefined( var_3.trigger ) && var_3.trigger isrevivetrigger() )
            {
                if ( isdefined( var_3.trigger.owner ) )
                {
                    var_3.trigger.owner setclientomnvar( "ui_reviver_id", self getentitynumber() );
                    var_3.trigger.owner setclientomnvar( "ui_securing", 6 );
                }
            }
        }
    }
    else
    {
        if ( isdefined( var_3.usedby ) && existinarray( self, var_3.usedby ) )
            var_3.usedby = scripts\engine\utility::array_remove( var_3.usedby, self );

        self setclientomnvar( "ui_securing", 0 );
        self.ui_securing = undefined;

        if ( isdefined( var_3.trigger ) && var_3.trigger isrevivetrigger() )
        {
            if ( isdefined( var_3.trigger.owner ) )
            {
                var_3.trigger.owner setclientomnvar( "ui_reviver_id", -1 );
                var_3.trigger.owner setclientomnvar( "ui_securing", 0 );
            }
        }

        var_0 = 0.01;

        if ( isdefined( var_3.objidnum ) )
            var_5 = var_3.objidnum;
    }

    if ( var_4 == 500 )
        var_0 = min( var_0 + 0.15, 1 );

    if ( var_0 != 0 )
    {
        self setclientomnvar( "ui_securing_progress", var_0 );

        if ( isdefined( var_3.trigger ) && var_3.trigger isrevivetrigger() )
        {
            if ( isdefined( var_3.trigger.owner ) )
                var_3.trigger.owner setclientomnvar( "ui_securing_progress", var_0 );
        }

        if ( isdefined( var_3.objidnum ) )
            scripts\mp\objidpoolmanager::objective_set_progress( var_3.objidnum, var_0 );
    }
}

migrationcapturereset( var_0 )
{
    var_0.migrationcapturereset = 1;
    level waittill( "host_migration_begin" );

    if ( !isdefined( var_0 ) || !isdefined( self ) )
        return;

    var_0 setclientomnvar( "ui_securing", 0 );
    var_0 setclientomnvar( "ui_securing_progress", 0 );
    self.migrationcapturereset = undefined;
}

airdrop_allowactionset( var_0, var_1 )
{
    scripts\mp\playeractions::allowactionset( var_0, var_1 );
}

airdrop_unresolvedcollisionnearestnode( var_0, var_1, var_2 )
{
    childthread scripts\cp\cp_movers::unresolved_collision_nearest_node( var_0, var_1, var_2 );
}

airdrop_showerrormessage( var_0 )
{

}

airdrop_awardkillstreak( var_0, var_1, var_2 )
{

}

airdrop_showkillstreaksplash( var_0, var_1, var_2 )
{

}

airdrop_gettargetmarker( var_0 )
{
    return scripts\cp\inventory\cp_target_marker::gettargetmarker( var_0 );
}

airdrop_airdropmultipledropcrates( var_0, var_1, var_2, var_3, var_4 )
{
    scripts\cp_mp\killstreaks\airdrop_multiple::airdrop_multiple_dropcrates( var_0, var_1, var_2, var_3, var_4 );
}

airdrop_registercrateforcleanup( var_0 )
{

}

airdrop_makeweaponfromcrate()
{

}

airdrop_makeitemfromcrate()
{

}

airdrop_outlinedisable( var_0, var_1 )
{
    scripts\cp\cp_outline_utility::outlinedisable( var_0, var_1 );
}

airdrop_br_forcegiveweapon( var_0, var_1, var_2 )
{

}

airdrop_capturelootcachecallback()
{

}

airdrop_iskillstreakblockedforbots( var_0 )
{

}

airdrop_botiskillstreaksupported( var_0 )
{

}

airdrop_getgamemodespecificcratedata()
{
    initcpcratedata();
    initcploadoutcratedata();
    playerwaittillspectatecycle();
    initcparmsraceemptycrate();
    players_inside();
    players_monitor();
}

bankingoverlimitwillendot()
{
    if ( !isplayer( self ) )
        return 0;

    if ( isdefined( level.nuclear_core_carrier ) && level.nuclear_core_carrier == self )
        return 0;

    return 1;
}

makeitemsfromcrate( var_0 )
{
    var_1 = self.data;

    if ( var_1.type == "weapon" )
    {
        var_2 = randomintrange( 2, 4 );
        var_3 = 6 - var_2;
    }
    else if ( var_1.type == "attachment" )
    {
        var_2 = randomintrange( 1, 2 );
        var_3 = 6 - var_2;
    }
    else
    {

    }
}

createdropweapon( var_0, var_1, var_2, var_3, var_4 )
{

}

managedroppedents()
{
    if ( !isdefined( level.droppedweapons ) )
        level.droppedweapons = [];

    if ( level.droppedweapons.size > 63 )
    {
        var_0 = [];

        for ( var_1 = 0; var_1 < level.droppedweapons.size; var_1++ )
        {
            if ( var_1 < 16 )
            {
                if ( isdefined( level.droppedweapons[var_1] ) )
                {
                    if ( isdefined( level.droppedweapons[var_1].pickupent ) )
                        level.droppedweapons[var_1].pickupent delete();

                    level.droppedweapons[var_1] delete();
                }

                continue;
            }

            var_0[var_0.size] = level.droppedweapons[var_1];
        }

        level.droppedweapons = var_0;
    }
}
