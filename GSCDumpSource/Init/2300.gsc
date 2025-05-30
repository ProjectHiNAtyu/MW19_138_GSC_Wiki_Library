// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

checkkillrespawn()
{
    var_0 = scripts\mp\equipment::getequipmentslotammo( "health" );

    if ( var_0 <= 0 )
        return;

    if ( self isparachuting() )
    {
        self notify( "br_try_armor_cancel" );
        return;
    }

    if ( isdefined( self.bot_gametype_allied_defenders_for_team ) )
        self.bot_gametype_allied_defenders_for_team--;

    var_1 = self.br_armorhealth + 5;
    var_2 = clamp( var_1, 0, self.br_maxarmorhealth );
    var_3 = max( 1, getdvarint( "scr_br_armor_heal_amount", 50 ) );
    var_2 = int( var_2 / var_3 ) * var_3 + var_3;
    self.br_armorhealth = clamp( var_2, 0, self.br_maxarmorhealth );
    checkifteamrewardsareenabled( self.br_armorhealth );
    scripts\mp\equipment::decrementequipmentslotammo( "health", 1 );
    scripts\cp\helicopter\chopper_boss::supportbox_updateheadiconallplayers( "armor_plate" );
    scripts\mp\gametypes\br_gametypes.gsc::_id_11BE4( "onArmorPlate" );
    self notify( "armor_plate_inserted" );
}

checkifvalidpropspectate()
{
    var_0 = self.br_armorhealth + 5;
    var_1 = clamp( var_0, 0, self.br_maxarmorhealth );
    var_2 = max( 1, getdvarint( "scr_br_armor_heal_amount", 50 ) );
    var_1 = int( var_1 / var_2 ) * var_2;
    var_3 = clamp( var_1, 0, self.br_maxarmorhealth );

    if ( var_3 >= self.br_armorhealth )
        return;
    else
        self.br_armorhealth = var_3;

    checkifteamrewardsareenabled( self.br_armorhealth );
}

checkifteamrewardsareenabled( var_0 )
{
    self setclientomnvar( "ui_br_armor_amount", int( var_0 ) );
    scripts\mp\gametypes\br_public.gsc::updatebrscoreboardstat( "armorHealthRatio", int( var_0 ) );
}

chopper_playfx( var_0, var_1 )
{
    self endon( "disconnect" );

    if ( var_1 == 0 )
        return;
    else if ( istrue( self.playlandingbreath ) )
        return;
    else if ( self isswitchingweapon() )
        return;

    if ( !checkpoints_init() )
        return;

    var_2 = getcompleteweaponname( "armor_plate_deploy_mp" );
    var_3 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo( "", self );
    var_3.bot_gametype_allowed_to_switch_to_defender = var_2;
    chopper_kill( 1 );
    thread chopper_sound_fade_and_delete();
    var_4 = scripts\cp_mp\killstreaks\killstreakdeploy::switchtodeployweapon( var_2, var_3, ::checkpoints_count, undefined, undefined, undefined, undefined, 0 );
}

chopper_sound_fade_and_delete()
{
    self endon( "br_armor_repair_end" );
    self endon( "disconnect" );
    checkforactiveobjicon();
    thread chopper_watch_death();
    self._id_124F8 = 0;
    scripts\engine\utility::_id_12E43( "death", "mantle_start", "last_stand_start", "special_weapon_fired", "br_try_armor_cancel", "br_armor_plate_done" );
    self._id_124F8 = 1;
    thread checklethalequipmentachievement();
}

chopper_watch_death()
{
    self endon( "disconnect" );
    self endon( "br_armor_repair_end" );

    while ( isdefined( self.currentweapon ) && isdefined( self.currentweapon.basename ) && self.currentweapon.basename != "armor_plate_deploy_mp" )
    {
        if ( self isonladder() )
            self notify( "br_try_armor_cancel" );

        waitframe();
    }

    while ( isdefined( self.currentweapon ) && isdefined( self.currentweapon.basename ) && self.currentweapon.basename == "armor_plate_deploy_mp" )
    {
        if ( self isonladder() )
            self notify( "br_try_armor_cancel" );

        waitframe();
    }

    self notify( "br_try_armor_cancel" );
}

chopper_kill( var_0 )
{
    scripts\common\utility::allow_melee( !var_0 );
    scripts\common\utility::allow_killstreaks( !var_0 );
    scripts\common\utility::allow_crate_use( !var_0 );
    scripts\mp\equipment::allow_equipment( !var_0 );
    scripts\common\utility::allow_offhand_weapons( !var_0 );
    scripts\common\utility::binoculars_checkexpirationtimer( !var_0 );
    self.playlandingbreath = var_0;
}

checkpoints_count( var_0 )
{
    self endon( "disconnect" );
    self endon( "br_armor_repair_end" );

    if ( !checkpoints_init() || istrue( self._id_124F8 ) )
        return;

    var_1 = gettime();
    var_2 = var_1 + 1860.0;
    var_3 = 2000.0;
    var_4 = 1860.0;

    for ( var_5 = 0; var_1 < var_2; var_1 = gettime() )
    {
        if ( !isdefined( var_0.bot_gametype_allowed_to_switch_to_defender ) || var_0.bot_gametype_allowed_to_switch_to_defender != self getcurrentweapon() )
            return;

        waitframe();
    }

    checkkillrespawn();
    var_6 = ( var_3 - var_4 ) / 1000;
    wait( var_6 );

    while ( chopper_carepackage_pilot_selected() )
    {
        var_7 = self.equipment["health"];
        var_8 = scripts\mp\equipment::getequipmentslotammo( "health" );

        if ( isdefined( var_7 ) && isdefined( var_8 ) && var_8 > 0 && self.br_armorhealth < self.br_maxarmorhealth )
        {
            var_9 = gettime() + 1250.0;

            while ( gettime() < var_9 )
            {
                if ( !isdefined( var_0.bot_gametype_allowed_to_switch_to_defender ) || var_0.bot_gametype_allowed_to_switch_to_defender != self getcurrentweapon() )
                    return;

                waitframe();
            }

            checkkillrespawn();
            var_10 = 0.25;
            wait( var_10 );
            continue;
        }

        break;
    }

    self notify( "br_armor_plate_done" );
}

checkpoints_init()
{
    if ( isdefined( self.vehicle ) )
    {
        var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat( self.vehicle, self );

        if ( var_0 == "driver" )
            return 0;
    }

    var_1 = self isskydiving() || self isonladder();
    var_2 = istrue( self._id_11B13 ) || istrue( self.isjuggernaut ) || scripts\mp\supers::issuperinuse() && self.super.staticdata.ref != "super_deadsilence";

    if ( var_1 || var_2 )
        return 0;

    if ( self.br_armorhealth == self.br_maxarmorhealth )
    {
        scripts\mp\hud_message::showerrormessage( level.br_pickups.choosepubliceventtype );
        return 0;
    }

    return 1;
}

chopper_carepackage_pilot_selected()
{
    var_0 = scripts\engine\utility::is_player_gamepad_enabled() && self weaponswitchbuttonpressed();
    var_1 = isdefined( self.bot_gametype_allied_defenders_for_team ) && self.bot_gametype_allied_defenders_for_team > 0;
    return var_0 || var_1;
}

checkforactiveobjicon()
{
    self notifyonplayercommand( "br_try_armor_cancel", "+weapnext" );
    self notifyonplayercommand( "br_try_armor_cancel", "+weapprev" );
    self notifyonplayercommand( "br_try_armor_cancel", "+attack" );
    self notifyonplayercommand( "br_try_armor_cancel", "+smoke" );
    self notifyonplayercommand( "br_try_armor_cancel", "+frag" );
    self notifyonplayercommand( "br_try_armor_cancel", "+melee_zoom" );
}

chopper_boss_target_tag()
{
    self notifyonplayercommandremove( "br_try_armor_cancel", "+weapnext" );
    self notifyonplayercommandremove( "br_try_armor_cancel", "+weapprev" );
    self notifyonplayercommandremove( "br_try_armor_cancel", "+attack" );
    self notifyonplayercommandremove( "br_try_armor_cancel", "+smoke" );
    self notifyonplayercommandremove( "br_try_armor_cancel", "+frag" );
    self notifyonplayercommandremove( "br_try_armor_cancel", "+melee_zoom" );
}

checklethalequipmentachievement()
{
    self endon( "disconnect" );
    self notify( "br_armor_repair_end" );
    chopper_boss_target_tag();

    while ( isdefined( self.currentweapon ) && isdefined( self.currentweapon.basename ) && self.currentweapon.basename == "armor_plate_deploy_mp" )
        waitframe();

    waitframe();

    if ( istrue( self.bot_gametype_allied_defenders_for_team ) )
        self.bot_gametype_allied_defenders_for_team = 0;

    chopper_kill( 0 );
}
