// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

#using_animtree("generic_human");

main()
{
    self setmodel( "body_spetsnaz_cqc" );
    self attach( "head_spetsnaz_cqc", "", 1 );
    self.headmodel = "head_spetsnaz_cqc";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self.animationarchetype = "soldier_cp";
    self.voice = "russian";
    self setclothtype( "vestlight" );

    if ( issentient( self ) )
        self sethitlocdamagetable( "ai_lochit_dmgtable" );

    self useanimtree( #animtree );
}

precache()
{
    precachemodel( "body_spetsnaz_cqc" );
    precachemodel( "head_spetsnaz_cqc" );
}

main_mp()
{
    self.animationarchetype = "soldier_cp";
    self.voice = "russian";
    self setmodel( "body_spetsnaz_cqc" );
    self attach( "head_spetsnaz_cqc", "", 1 );
    self.headmodel = "head_spetsnaz_cqc";
}

precache_mp( var_0 )
{
    level.agent_definition[var_0]["animclass"] = "soldier_cp";
}
