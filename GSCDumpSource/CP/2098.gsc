// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

setupagent( var_0 )
{
    if ( istrue( self.brjugg_setconfig ) )
        return anim.success;

    scripts\aitypes\combat::soldier_init_common();
    self.noattackeraccuracymod = 0;
    self.sharpturnnotifydist = 48;
    self.stopsoonnotifydist = 150;
    self.suppressionthreshold = 0.0;
    self.goalradius = 480;
    self.goalheight = 1024;
    self.moveplaybackrate = 1.0;
    self.animplaybackrate = self.moveplaybackrate;
    self.animplaybackrate = 1;
    self.movetransitionrate = 1;
    self.domagicdoorchecks = 1;
    self.binoculars_getmaxrange = 1;
    self.space = 0;
    self.nocorpse = undefined;
    self.dont_cleanup = 1;
    self.bsoldier = 1;
    self.fnplaceweaponon = scripts\anim\shared.gsc::placeweaponon;
    self.isnokillstreakprogressweapon = scripts\anim\shared.gsc::dropaiweapon;
    scripts\asm\shared\utility::setupsoldierdefaults();
    self.export = "agent";
    self.dropweapon = 0;
    thread scripts\anim\shared.gsc::default_weaponsetup();
    thread handledeathcleanup();
    thread scripts\anim\combat_utility.gsc::monitorflash();
    self enablemissedbulletclientonly( 1 );

    if ( isdefined( level.isparachutespawning ) )
        self thread [[ level.isparachutespawning ]]();

    self.brjugg_setconfig = 1;
    return anim.success;
}

handledeathcleanup()
{
    level endon( "game_ended" );
    self waittill( "death" );
    scripts\asm\asm_bb::bb_clearmeleetarget();
}
