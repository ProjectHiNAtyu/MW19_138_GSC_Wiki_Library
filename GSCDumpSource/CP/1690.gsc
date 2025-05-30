// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    level.hitmarkerpriorities = [];
    level.hitmarkerpriorities["standard"] = 40;
    level.hitmarkerpriorities["standardspread"] = 50;
    level.hitmarkerpriorities["hitequip"] = 30;
}

gethitmarkerpriority( var_0 )
{
    if ( !isdefined( level.hitmarkerpriorities[var_0] ) )
        return 0;

    return level.hitmarkerpriorities[var_0];
}

hudicontype( var_0 )
{
    var_1 = 0;

    if ( isdefined( level.damagefeedbacknosound ) && level.damagefeedbacknosound )
        var_1 = 1;

    if ( !isplayer( self ) )
        return;

    switch ( var_0 )
    {
        case "crossbowbolt":
        case "ammobox":
        case "scavenger":
        case "throwingknife":
            if ( !var_1 )
                self playlocalsound( "scavenger_pack_pickup" );

            if ( !level.hardcoremode )
                self setclientomnvar( "damage_feedback_other", var_0 );

            break;
        case "eqp_ping":
            if ( !level.hardcoremode )
                self setclientomnvar( "damage_feedback_other", var_0 );

            break;
        case "suppression":
            var_0 = "suppression";

            if ( !level.hardcoremode )
                self setclientomnvar( "damage_feedback_other", var_0 );

            break;
    }
}

process_damage_feedback( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 )
{
    var_11 = isdefined( var_1 ) && isdefined( var_1.classname ) && isdefined( var_1.classname ) && !isdefined( var_1.gunner ) && ( var_1.classname == "script_vehicle" || var_1.classname == "misc_turret" || var_1.classname == "script_model" );
    var_12 = undefined;

    if ( var_11 && isdefined( var_1.gunner ) )
        var_12 = var_1.gunner;
    else if ( isdefined( var_1 ) && isdefined( var_1.owner ) )
        var_12 = var_1.owner;
    else
        var_12 = var_1;

    var_13 = scripts\engine\utility::isbulletdamage( var_4 );
    var_14 = scripts\engine\utility::ter_op( var_13 && scripts\cp\cp_weapon::isprimaryweapon( var_5 ), "standardspread", "standard" );
    var_15 = 0;

    if ( isdefined( var_1 ) && isdefined( var_1.class ) && var_1.class == "engineer" )
    {
        if ( isdefined( var_4 ) && scripts\engine\utility::isbulletdamage( var_4 ) )
            var_15 = 1;
    }

    if ( isdefined( var_12 ) && var_12 != var_10 && var_2 > 0 && ( !isdefined( var_8 ) || var_8 != "shield" ) )
    {
        var_16 = !var_10 scripts\cp_mp\utility\player_utility::_isalive() || isagent( var_10 ) && var_2 >= var_10.health;

        if ( istrue( var_10.isjuggernaut ) )
            var_14 = "hitjuggernaut";
        else if ( var_3 & level.idflags_stun )
            var_14 = "stun";
        else if ( scripts\cp\cp_damage::istacticaldamage( var_5, var_4 ) && var_10 scripts\cp\utility::_hasperk( "specialty_stun_resistance" ) )
            var_14 = "hittacresist";
        else if ( isexplosivedamagemod( var_4 ) && var_10 scripts\cp\utility::_hasperk( "specialty_blastshield" ) && !scripts\cp\cp_damage::damage_should_ignore_blast_shield( var_1, var_10, var_5, var_4, var_0, var_8 ) )
            var_14 = "hitblastshield";
        else if ( !var_15 && scripts\cp\cp_modular_spawning::is_armored() )
            var_14 = "hitarmorheavy";
        else if ( var_10 scripts\cp\utility::_hasperk( "specialty_pistoldeath" ) && isdefined( var_10.inlaststand ) && var_10.inlaststand == 1 && !var_10.hasshownlaststandicon )
        {
            var_10.hasshownlaststandicon = 1;
            var_14 = "hitlaststand";
        }

        if ( isdefined( var_10.isplayerinsiderectangularzone ) && var_10.isplayerinsiderectangularzone.size > 1 )
            var_14 = "cp_relic_buff";

        var_17 = "standard";
        var_18 = weaponclass( var_5 );
        var_19 = var_18 == "spread";
        var_20 = !var_19 && scripts\cp\utility::isheadshot( var_5, var_8, var_4, var_1 );
        var_21 = 1;
        var_22 = var_4 == "MOD_MELEE";
        var_23 = "" + gettime();

        if ( !var_22 && var_19 && isdefined( var_12.pelletdmg ) && isdefined( var_12.pelletdmg[var_23] ) && isdefined( var_12.pelletdmg[var_23][var_10.guid] ) && var_12.pelletdmg[var_23][var_10.guid] > 1 )
        {
            if ( var_16 )
                var_22 = 1;
            else
                var_21 = 0;
        }

        var_24 = undefined;

        if ( var_10.health <= var_2 )
            var_24 = 1;

        var_20 = scripts\cp\utility::isheadshot( var_5, var_8, var_4, var_1 );

        if ( var_21 )
        {
            if ( isdefined( var_1 ) )
            {
                if ( isdefined( var_1.owner ) )
                    var_1.owner thread updatedamagefeedback( var_14, var_24, var_2, var_20, 0, var_1, var_0, var_1, 0 );
                else
                    var_1 thread updatedamagefeedback( var_14, var_24, var_2, var_20, 0, var_1, var_0, var_1, 0 );
            }
        }
    }
}

updatedamagefeedback( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( isdefined( level.friendly_damage_check ) && [[ level.friendly_damage_check ]]( var_5, var_6, var_7 ) )
        return;

    if ( !isplayer( self ) )
        return;

    if ( !isdefined( var_0 ) )
        var_0 = "standard";

    if ( !isdefined( var_8 ) )
        var_8 = 0;

    if ( ( !isdefined( level.damagefeedbacknosound ) || !level.damagefeedbacknosound ) && !var_8 )
    {
        if ( !isdefined( self.hitmarkeraudioevents ) )
            self.hitmarkeraudioevents = 0;

        self.hitmarkeraudioevents++;
        self setclientomnvar( "ui_hitmarker_audio_events", self.hitmarkeraudioevents % 16 );
    }

    switch ( var_0 )
    {
        case "none":
            break;
        case "hitcritical":
            var_0 = "standard";
            var_3 = 1;
            break;
        case "hitnooutline":
        case "hithelmetheavybreak":
        case "hithelmetheavy":
        case "hithelmetlightbreak":
        case "hithelmetlight":
        case "hitarmorheavybreak":
        case "hitarmorlightbreak":
        case "hitarmorlight":
        case "hittrophysystem":
        case "hitadrenaline":
        case "hitspawnprotect":
        case "hitlaststand":
        case "hitarmorheavy":
        case "hitblastshield":
        case "hittacresist":
        case "hitjuggernaut":
        case "hitequip":
            if ( !istrue( var_1 ) )
            {
                self setclientomnvar( "damage_feedback_icon", var_0 );
                self setclientomnvar( "damage_feedback_icon_notify", gettime() );
            }

            break;
        default:
            break;
    }

    updatehitmarker( var_0, var_3, var_2, var_4, var_1, 0 );
}

updatehitmarker( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( var_0 == "" )
        var_0 = "standard";

    if ( !isdefined( var_0 ) )
        return;

    if ( !isdefined( var_4 ) )
        var_4 = 0;

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    if ( !isdefined( var_5 ) )
        var_5 = 0;

    if ( !isplayer( self ) )
    {
        if ( isdefined( self.owner ) && isplayer( self.owner ) )
            return;
    }

    var_6 = gethitmarkerpriority( var_0 );

    if ( isdefined( self.lasthitmarkertime ) && self.lasthitmarkertime == gettime() && var_6 <= self.lasthitmarkerpriority && !var_4 )
        return;

    self.lasthitmarkertime = gettime();
    self.lasthitmarkerpriority = var_6;
    self setclientomnvar( "damage_feedback", var_0 );
    self setclientomnvar( "damage_feedback_notify", gettime() );

    if ( var_4 )
        self setclientomnvar( "damage_feedback_kill", 1 );
    else
        self setclientomnvar( "damage_feedback_kill", 0 );

    if ( var_1 )
        self setclientomnvar( "damage_feedback_headshot", 1 );
    else
        self setclientomnvar( "damage_feedback_headshot", 0 );

    if ( var_5 )
        self setclientomnvar( "damage_feedback_nonplayer", 1 );
    else
        self setclientomnvar( "damage_feedback_nonplayer", 0 );

    if ( isdefined( var_2 ) )
        self setclientomnvar( "ui_damage_amount", int( var_2 ) );
}
