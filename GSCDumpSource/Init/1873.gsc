// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    level.lootweaponcache = [];
    level.lootweaponrefs = [];
    var_0 = 0;

    for (;;)
    {
        var_1 = tablelookupbyrow( "mp/loot/iw7_weapon_loot_master.csv", var_0, 0 );

        if ( !isdefined( var_1 ) || var_1 == "" )
            break;

        var_1 = int( var_1 );
        var_2 = tablelookupbyrow( "mp/loot/iw7_weapon_loot_master.csv", var_0, 1 );
        level.lootweaponrefs[var_1] = var_2;
        var_0++;
    }
}

getpassivesforweapon( var_0, var_1 )
{
    var_2 = getlootinfoforweapon( var_0, var_1 );

    if ( isdefined( var_2 ) )
        return var_2.passives;

    return undefined;
}

getlootinfoforweapon( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        return undefined;

    if ( isdefined( level.lootweaponcache[var_0] ) && isdefined( level.lootweaponcache[var_0][var_1] ) )
    {
        var_2 = level.lootweaponcache[var_0][var_1];
        return var_2;
    }

    var_2 = cachelootweaponweaponinfo( var_0, var_1 );

    if ( isdefined( var_2 ) )
        return var_2;

    return undefined;
}

getweaponassetfromrootweapon( var_0, var_1 )
{
    var_2 = "mp/loot/weapon/" + var_0 + ".csv";
    var_3 = tablelookup( var_2, 0, var_1, 3 );
    return var_3;
}

lookupvariantref( var_0, var_1 )
{
    var_2 = "mp/loot/weapon/" + var_0 + ".csv";
    var_3 = tablelookup( var_2, 0, var_1, 1 );
    return var_3;
}

isweaponitem( var_0 )
{
    return var_0 >= 1 && var_0 <= 9999;
}

iskillstreakitem( var_0 )
{
    return var_0 >= 10000 && var_0 <= 19999;
}

ispoweritem( var_0 )
{
    return var_0 >= 20000 && var_0 <= 29999;
}

isconsumableitem( var_0 )
{
    return var_0 >= 30000 && var_0 <= 39999;
}

iscosmeticitem( var_0 )
{
    return var_0 >= 40000 && var_0 <= 49999;
}

cachelootweaponweaponinfo( var_0, var_1 )
{
    if ( !isdefined( level.lootweaponcache[var_0] ) )
        level.lootweaponcache[var_0] = [];

    var_2 = getweaponloottable( var_0 );
    var_3 = readweaponinfofromtable( var_2, var_1 );
    level.lootweaponcache[var_0][var_1] = var_3;
    return var_3;
}

readweaponinfofromtable( var_0, var_1 )
{
    var_2 = tablelookuprownum( var_0, 0, var_1 );
    var_3 = spawnstruct();
    var_3.ref = tablelookupbyrow( var_0, var_2, 1 );
    var_3.weaponasset = tablelookupbyrow( var_0, var_2, 1 );
    var_3.passives = [];

    for ( var_4 = 0; var_4 < 3; var_4++ )
    {
        var_5 = tablelookupbyrow( var_0, var_2, 5 + var_4 );

        if ( isdefined( var_5 ) && var_5 != "" )
            var_3.passives[var_3.passives.size] = var_5;
    }

    var_3.quality = int( tablelookupbyrow( var_0, var_2, 4 ) );
    var_3.variantid = var_1;
    return var_3;
}

getweaponqualitybyid( var_0, var_1 )
{
    if ( !isdefined( var_1 ) || var_1 < 0 )
        return 0;

    var_2 = getweaponloottable( var_0 );
    var_3 = int( tablelookup( var_2, 0, var_1, 4 ) );
    return var_3;
}

getlootweaponref( var_0 )
{
    return level.lootweaponrefs[var_0];
}
