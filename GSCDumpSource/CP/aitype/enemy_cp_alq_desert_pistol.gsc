// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

main()
{
    self.additionalassets = "";
    self.subclass = "regular";
    self.defaultcoverselector = "cover_default_cp";
    self.enemyselector = "enemyselector_default_cp";
    self.unittype = "soldier";
    self setengagementmindist( 256.0, 0.0 );
    self setengagementmaxdist( 768.0, 1024.0 );
    self.accuracy = 0.2;

    switch ( scripts\code\character::get_random_weapon( 2 ) )
    {
        case 0:
            self.weapon = scripts\cp\cp_weapon::buildweapon( "iw8_pi_mike1911_mp", [ "none", "none", "none", "none", "none", "none" ], "none", "none" );
            break;
        case 1:
            self.weapon = scripts\cp\cp_weapon::buildweapon( "iw8_pi_golf21_mp", [ "none", "none", "none", "none", "none", "none" ], "none", "none" );
            break;
    }

    self giveweapon( self.weapon );
    self setspawnweapon( self.weapon );
    self.bulletsinclip = weaponclipsize( self.weapon );
    self.primaryweapon = self.weapon;
    self.sidearm = scripts\cp\cp_weapon::buildweapon( "iw8_pi_mike1911_mp", [ "none", "none", "none", "none", "none", "none" ], "none", "none" );
    self.grenadeweapon = getcompleteweaponname( "frag_grenade_mp" );
    self.grenadeammo = 2;
}

setup_model( var_0 )
{
    var_1 = undefined;
    var_2 = [ "character_cp_al_qatala_desert_ar", "character_cp_al_qatala_desert_ar_2", "character_cp_al_qatala_desert_ar_3", "character_cp_al_qatala_desert_ar_4", "character_cp_al_qatala_desert_dmr", "character_cp_al_qatala_desert_cqc" ];

    switch ( scripts\code\character::get_random_character( 6, var_1, var_2, "actor_enemy_cp_alq_desert_pistol" ) )
    {
        case 0:
            character\character_cp_al_qatala_desert_ar::main_mp();
            break;
        case 1:
            character\character_cp_al_qatala_desert_ar_2::main_mp();
            break;
        case 2:
            character\character_cp_al_qatala_desert_ar_3::main_mp();
            break;
        case 3:
            character\character_cp_al_qatala_desert_ar_4::main_mp();
            break;
        case 4:
            character\character_cp_al_qatala_desert_dmr::main_mp();
            break;
        case 5:
            character\character_cp_al_qatala_desert_cqc::main_mp();
            break;
    }
}

precache()
{
    var_0 = "actor_enemy_cp_alq_desert_pistol";

    if ( !isdefined( level.agent_definition ) )
        level.agent_definition = [];

    if ( !isdefined( level.agent_definition[var_0] ) )
    {
        level.agent_definition[var_0] = [];
        level.agent_definition[var_0]["species"] = "human";
        level.agent_definition[var_0]["traversal_unit_type"] = "soldier";
        level.agent_definition[var_0]["health"] = 180;
        level.agent_definition[var_0]["xp"] = 50;
        level.agent_definition[var_0]["reward"] = 100;
        level.agent_definition[var_0]["asm"] = "soldier_cp";
        level.agent_definition[var_0]["radius"] = 15;
        level.agent_definition[var_0]["height"] = 70;
        level.agent_definition[var_0]["behaviorTree"] = "soldier_agent";
        level.agent_definition[var_0]["team"] = "axis";
        level.agent_definition[var_0]["setup_func"] = ::main;
        level.agent_definition[var_0]["setup_model_func"] = ::setup_model;
        character\character_cp_al_qatala_desert_ar::precache_mp( var_0 );
        character\character_cp_al_qatala_desert_ar_2::precache_mp( var_0 );
        character\character_cp_al_qatala_desert_ar_3::precache_mp( var_0 );
        character\character_cp_al_qatala_desert_ar_4::precache_mp( var_0 );
        character\character_cp_al_qatala_desert_dmr::precache_mp( var_0 );
        character\character_cp_al_qatala_desert_cqc::precache_mp( var_0 );
    }

    scripts\aitypes\bt_util::init();
    behaviortree\soldier_agent::registerbehaviortree();
    aiasm\soldier_cp_mp::asm_register();
    scripts\cp_mp\agents\agent_init::agent_init();

    if ( !isdefined( level.species_funcs ) )
        level.species_funcs = [];

    if ( !isdefined( level.species_funcs["human"] ) )
        level.species_funcs["human"] = [];

    scripts\aitypes\assets::soldier();
}
