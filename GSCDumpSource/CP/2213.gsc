// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

van_cp_init()
{
    scripts\cp_mp\utility\script_utility::registersharedfunc( "van", "initLate", ::van_cp_initlate );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "van", "create", ::van_cp_create );
    scripts\engine\utility::create_func_ref( "van", ::spawn_and_enter_van );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "van", "spawnCallback", ::van_cp_spawncallback );
    scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback( "van", scripts\cp_mp\vehicles\van::van_explode );
}

van_cp_initlate()
{
    if ( 1 )
        return;

    level.vans = [];
    var_0 = scripts\engine\utility::getstructarray( "van_spawn", "targetname" );
    thread van_cp_createfromstructs( var_0, 3 );
}

van_cp_createfromstructs( var_0, var_1 )
{
    wait( var_1 );
    var_2 = getdvarint( "LLQQOPKTKM", 0 ) == 0;

    if ( var_2 )
    {
        foreach ( var_4 in var_0 )
        {
            var_5 = spawnstruct();
            var_5.origin = var_4.origin;
            var_5.angles = var_4.angles;
            var_6 = scripts\cp_mp\vehicles\van::van_create( var_5 );

            if ( isdefined( var_6 ) )
                level.vans = scripts\engine\utility::array_add( level.vans, var_6 );
        }
    }
}

van_cp_create( var_0 )
{
    var_0.maxhealth = 1350;
    var_0.health = var_0.maxhealth;
}

spawn_and_enter_van( var_0 )
{
    var_1 = spawnstruct();
    var_1.origin = var_0.origin + ( 0, 0, 100 );
    var_1.angles = var_0.angles * ( 0, 1, 0 );
    var_1.owner = var_0;
    var_2 = scripts\cp_mp\vehicles\van::van_create( var_1 );

    if ( isdefined( var_2 ) )
        thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter( var_2, "driver", var_0, undefined, 1 );
}

van_cp_spawncallback( var_0, var_1 )
{
    if ( 1 )
        return;

    var_2 = scripts\cp_mp\vehicles\van::van_create( var_0, var_1 );

    if ( isdefined( var_2 ) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn() )
        var_2.ondeathrespawn = ::van_cp_ondeathrespawncallback;

    return var_2;
}

van_cp_ondeathrespawncallback()
{
    thread van_cp_waitandspawn();
}

van_cp_waitandspawn()
{
    var_0 = spawnstruct();
    scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata( scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata( self ), var_0 );
    var_1 = spawnstruct();

    for (;;)
    {
        wait 60;

        if ( scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnvehicle( "van" ) )
        {
            var_2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnvehicle( "van", var_0, var_1 );

            if ( !isdefined( var_2 ) )
                continue;

            break;
        }
    }
}
