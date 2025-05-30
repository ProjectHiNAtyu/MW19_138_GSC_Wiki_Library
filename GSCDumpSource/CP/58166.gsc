// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

atv_vehicle( var_0, var_1, var_2, var_3 )
{
    var_4 = isdefined( self._blackboard.atvoriginsarray ) && self._blackboard.atvoriginsarray == 1;
    return var_4;
}

atv_outline( var_0, var_1, var_2, var_3 )
{
    var_4 = isdefined( self._blackboard.atvoriginsarray ) && self._blackboard.atvoriginsarray == 3;
    return var_4;
}

atv_trail( var_0, var_1, var_2, var_3 )
{
    var_4 = self._blackboard.atvanglesarray;
    var_5 = abs( var_4 getturretcurrentpitch() );
    var_6 = abs( var_4 getturretcurrentyaw() );
    var_7 = var_5 < 0.1 && var_6 < 0.1;
    return var_7;
}

triggered_module_spawn_cancel( var_0, var_1, var_2 )
{
    var_3 = self._blackboard.atvanglesarray;
    scripts\common\ai::atv_initdamage();
    scripts\asm\asm::asm_playanimstate( var_0, var_1, var_2 );
}

triggercombatarea( var_0, var_1, var_2 )
{
    var_3 = self._blackboard.atvanglesarray;
    var_4 = var_3 gettagorigin( "tag_gunner" );
    var_5 = var_3 gettagangles( "tag_gunner" );

    if ( self islinked() )
        self unlink();

    var_3.inuse = 1;
    var_3 setturretteam( self.team );
    var_3 setmode( "auto_nonai" );
    self forceteleport( var_4, var_5 );
    self linktoblendtotag( var_3, "tag_gunner", 0 );
    self useturret( var_3 );
    scripts\asm\asm::asm_playanimstate( var_0, var_1, var_2 );
}

triggeravailablekillstreaks( var_0, var_1, var_2 )
{
    var_3 = self._blackboard.atvanglesarray;
    var_3.inuse = 0;
    var_3 setturretteam( "neutral" );
    var_3 setmode( "manual" );
    self stopuseturret();
    scripts\asm\asm::asm_playanimstate( var_0, var_1, var_2 );
}

triggerbloodmoneyendcameras( var_0, var_1, var_2 )
{
    if ( self islinked() )
        self unlink();

    scripts\common\ai::atv_initcollision();
    scripts\asm\asm::asm_playanimstate( var_0, var_1, var_2 );
}

trophy_get_part_by_tag( var_0, var_1, var_2 )
{
    var_3 = self._blackboard.atvanglesarray;

    if ( isdefined( var_3 ) )
    {
        var_3.inuse = 0;
        var_3 setturretteam( "neutral" );
        var_3 setmode( "manual" );
    }

    scripts\asm\soldier\death::playdeathanim( var_0, var_1, var_2 );
}
