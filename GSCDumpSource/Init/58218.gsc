// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    scripts\mp\killstreaks\killstreaks::registerkillstreak( "explosive_bow", ::_id_1297E, undefined, ::_id_12969 );
    init_fx();
}

init_fx()
{
    level._effect["vfx_explosive_bow_explosion"] = loadfx( "vfx/iw8/weap/_explo/vfx_explo_explosive_bow.vfx" );
}

_id_1297E( var_0 )
{
    var_1 = self;
    var_2 = var_1 _id_1297F( var_0 );

    if ( !var_2 )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "hud", "showErrorMessage" ) )
            self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "hud", "showErrorMessage" ) ]]( "KILLSTREAKS/CANNOT_BE_USED" );
    }

    return var_2;
}

_id_12969()
{
    var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo( "explosive_bow", self );
    var_0._id_120AA = 1;
    return _id_1297F( var_0, 1 );
}

defensefactormod()
{
    if ( self hasweapon( "iw8_sn_t9explosivebow_mp" ) )
        return 0;

    if ( self isonladder() )
        return 0;

    if ( self ismantling() )
        return 0;

    if ( !scripts\common\utility::is_weapon_switch_allowed() )
        return 0;

    if ( scripts\cp_mp\utility\player_utility::isusingremote() )
        return 0;

    if ( istrue( self.usingascender ) )
        return 0;

    return 1;
}

_id_1297F( var_0, var_1 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );

    if ( !defensefactormod() )
        return 0;

    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( var_0 ) )
            return 0;
    }

    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( var_0 ) )
            return 0;
    }

    var_2 = getgamewinnerprop();

    if ( !istrue( var_2 ) )
        return var_2;

    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "killstreak", "logKillstreakEvent" ) )
        self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "killstreak", "logKillstreakEvent" ) ]]( var_0.streakname, self.origin );

    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "hud", "teamPlayerCardSplash" ) )
        self thread [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "hud", "teamPlayerCardSplash" ) ]]( "used_" + var_0.streakname, self );

    return 1;
}

getgamewinnerprop()
{
    scripts\common\utility::bhasthermitestucktoshield( 0, "explosive_bow" );
    thread hostattackfactormod();
    var_0 = scripts\mp\utility\weapon::getweaponrootname( "iw8_sn_t9explosivebow_mp" );
    var_1 = scripts\mp\class::current_anim_ref( var_0, undefined, undefined, -1, undefined, undefined, 0 );
    self.briskillstreakallowed = 1;

    if ( self hasweapon( var_1 ) )
        scripts\cp_mp\utility\inventory_utility::_takeweapon( var_1 );

    self giveweapon( var_1 );

    if ( isdefined( self.place_traversal_badplace ) && self.place_traversal_badplace )
    {
        self setweaponammoclip( var_1, 1 );
        self setweaponammostock( var_1, self.place_traversal_badplace - 1 );
        self.place_traversal_badplace = undefined;
    }
    else
    {
        self setweaponammoclip( var_1, weaponclipsize( var_1 ) );
        self setweaponammostock( var_1, weaponstartammo( var_1, 0 ) );
    }

    scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate( var_1 );
    scripts\mp\weapons::fixupplayerweapons( self, var_0 );
    self.place_traversal_badplace = self getammocount( var_1 );
    self notify( "explosive_bow_equipped" );
    thread _id_12F65( var_1, "weapon_taken" );
    thread _id_12F65( var_1, "weapon_dropped" );
    thread _id_12F19( var_1 );
    thread _id_12F66( var_1 );
    thread _id_12F5E( var_1 );
    thread _id_12F14( var_1 );
    return 1;
}

hostattackfactormod()
{
    self endon( "disconnect" );
    wait 0.3;

    if ( isdefined( self ) )
        scripts\common\utility::bhasthermitestucktoshield( 1, "explosive_bow" );
}

_id_12F65( var_0, var_1 )
{
    self endon( "disconnect" );
    self endon( "exit_bow" );

    for (;;)
    {
        self waittill( var_1, var_2 );

        if ( var_2 == var_0 )
            _id_1251D( var_0 );

        waitframe();
    }
}

_id_12F19( var_0 )
{
    self endon( "disconnect" );
    self endon( "stop_explosive_bow_cancel_watcher" );
    self waittill( "cancel_all_killstreak_deployments" );
    self notify( "exit_bow" );
    thread empty_collision_handler();
    scripts\cp_mp\utility\inventory_utility::getridofweapon( var_0 );
    thread heli_screenshake();
}

_id_12F66( var_0 )
{
    self endon( "disconnect" );
    self endon( "exit_bow" );

    for (;;)
    {
        self waittill( "weapon_change", var_1 );

        if ( self hasweapon( var_0 ) && var_1 != var_0 )
        {
            if ( var_1.basename == "armor_plate_deploy_mp" )
            {
                self.checkdamagesourcerelicswat = self.lastdroppableweaponobj;
                scripts\mp\weapons::_id_11EBA( var_0 );
            }
            else if ( !self isonladder() && !( var_1.ismelee && self ismeleeing() ) )
                _id_1251D( var_0 );

            continue;
        }

        if ( var_1 == var_0 && isdefined( self.checkdamagesourcerelicswat ) )
        {
            scripts\mp\weapons::_id_11EBA( self.checkdamagesourcerelicswat );
            self.checkdamagesourcerelicswat = undefined;
        }
    }
}

_id_12F5E( var_0 )
{
    self endon( "disconnect" );
    self endon( "exit_bow" );

    for (;;)
    {
        self waittill( "weapon_fired" );

        if ( !self hasweapon( var_0 ) )
        {
            self notify( "stop_explosive_bow_cancel_watcher" );
            thread empty_collision_handler();
            return;
        }

        self.place_traversal_badplace = self getammocount( var_0 );

        if ( self.place_traversal_badplace == 0 )
        {
            self.place_traversal_badplace = undefined;
            thread empty_collision_handler();
            self takeweapon( var_0 );
            self notify( "stop_explosive_bow_cancel_watcher" );
            self notify( "exit_bow" );
        }

        waitframe();
    }
}

_id_12F14( var_0 )
{
    self endon( "disconnect" );
    self endon( "cleanup_explosive_bow" );

    for (;;)
    {
        self waittill( "bullet_first_impact", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 );

        if ( var_5 == var_0 )
        {
            var_9 = vectortoangles( var_3 );
            var_10 = anglestoforward( var_9 );
            var_11 = anglestoright( var_9 );
            var_12 = anglestoup( var_9 );
            var_13 = playfx( scripts\engine\utility::getfx( "vfx_explosive_bow_explosion" ), var_7, var_10, var_12 );
            var_13 forcenetfieldhighlod( 1 );
            playsoundatpos( var_7, "frag_grenade_expl_trans" );
            earthquake( 0.45, 0.7, var_7, 800 );
            playrumbleonposition( "grenade_rumble", var_7 );
            physicsexplosionsphere( var_7, 800, 0, 1 );
        }
    }
}

empty_collision_handler()
{
    self endon( "disconnect" );
    self endon( "explosive_bow_equipped" );
    self endon( "cleanup_explosive_bow" );
    self.briskillstreakallowed = 0;
    wait 6;
    self notify( "cleanup_explosive_bow" );
}

_id_1251D( var_0 )
{
    self takeweapon( var_0 );

    if ( isdefined( self.place_traversal_badplace ) && self.place_traversal_badplace != 0 )
    {
        self notify( "stop_explosive_bow_cancel_watcher" );
        isspecialcaseweapon();
    }

    thread empty_collision_handler();
    self notify( "exit_bow" );
}

heli_screenshake()
{
    var_0 = scripts\mp\gametypes\br_pickups.gsc::playersetattractiontime();
    var_1 = scripts\mp\gametypes\br_pickups.gsc::getitemdroporiginandangles( var_0, self.origin, self.angles, self );
    scripts\mp\gametypes\br_pickups.gsc::spawnpickup( "brloot_killstreak_explosive_bow", var_1 );
}

isspecialcaseweapon()
{
    var_0 = level.gametype == "br";

    if ( var_0 )
        scripts\mp\gametypes\br_pickups.gsc::isspecialistbonus( "explosive_bow", 1, 0 );
    else
    {
        scripts\mp\killstreaks\killstreaks::clearkillstreaks();
        scripts\mp\killstreaks\killstreaks::awardkillstreak( "explosive_bow", "other" );
    }
}
