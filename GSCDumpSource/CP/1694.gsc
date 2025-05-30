// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init_dev_hud()
{
    if ( istrue( level.dev_debug_menus ) )
        return;

    level.dev_debug_menus = 1;
    level.hudelems = [];
    level.hudelem_count = 16;
    var_0 = [];
    var_1 = [];
    var_0[0] = 0;
    var_1[0] = 0;
    var_0[1] = 1;
    var_1[1] = 1;
    var_0[2] = -2;
    var_1[2] = 1;
    var_0[3] = 1;
    var_1[3] = -1;
    var_0[4] = -2;
    var_1[4] = -1;
    level.cleartextmarker = newhudelem();
    level.cleartextmarker.alpha = 0;
    level.cleartextmarker.archived = 0;

    for ( var_2 = 0; var_2 < level.hudelem_count; var_2++ )
    {
        var_3 = [];

        for ( var_4 = 0; var_4 < 1; var_4++ )
        {
            var_5 = newhudelem();
            var_5.alignx = "left";
            var_5.aligny = "middle";
            var_5.archived = 0;
            var_5.location = 0;
            var_5.foreground = 1;
            var_5.fontscale = 0.75;
            var_5.sort = 20 - var_4;
            var_5.alpha = 1;
            var_5.x = -70 + var_0[var_4];
            var_5.y = 30 + var_1[var_4] + var_2 * 10;

            if ( var_4 > 0 )
                var_5.color = ( 0, 0, 0 );

            var_3[var_3.size] = var_5;
        }

        level.hudelems[var_2] = var_3;
    }

    var_6 = newhudelem();
    var_6.archived = 0;
    var_6.alignx = "center";
    var_6.location = 0;
    var_6.foreground = 1;
    var_6.fontscale = 1.4;
    var_6.sort = 20;
    var_6.alpha = 1;
    var_6.x = 320;
    var_6.y = 40;
    level.centerprint = var_6;
}

highlight_current_selection( var_0, var_1 )
{
    var_0 notify( "highlight_current_selection" );
    var_0 endon( "highlight_current_selection" );
    var_0 endon( "disconnect" );
    level endon( "game_ended" );

    if ( !isdefined( level.slot ) )
        level.slot = 0;

    if ( !isdefined( level.slot_cap ) )
        level.slot_cap = 14;

    setdvar( "scr_door_anim_override", "" );
    var_0 notifyonplayercommand( "B", "+stance" );
    var_0 notifyonplayercommand( "LT", "+speed_throw" );
    var_0 notifyonplayercommand( "A", "+goStand" );
    var_0 notifyonplayercommand( "X", "+usereload" );
    var_0 notifyonplayercommand( "X", "+activate" );
    var_0 notifyonplayercommand( "RS", "+melee_zoom" );
    var_0 notifyonplayercommand( "LS", "+breath_sprint" );
    var_0 notifyonplayercommand( "RT", "+attack" );
    var_0 notifyonplayercommand( "RB", "+frag" );
    var_0 notifyonplayercommand( "LB", "+smoke" );
    var_0 notifyonplayercommand( "Y", "+weapnext" );
    var_0 notifyonplayercommand( "UP", "+actionslot 1" );
    var_0 notifyonplayercommand( "DOWN", "+actionslot 2" );
    var_0 notifyonplayercommand( "LEFT", "+actionslot 3" );
    var_0 notifyonplayercommand( "RIGHT", "+actionslot 4" );
    var_0 notifyonplayercommand( "BACK", "+focus" );
    var_0 notifyonplayercommand( "START", "pause" );
    level thread show_selection_menu( level.slot, var_1 );

    for (;;)
    {
        var_2 = var_0 scripts\engine\utility::waittill_any_in_array_return( [ "A", "B", "Y", "X", "LB", "RB", "RT", "LT", "RS", "LS", "UP", "DOWN", "LEFT", "RIGHT", "BACK" ] );

        if ( !isdefined( var_2 ) )
            continue;

        switch ( var_2 )
        {
            case "Y":
            case "B":
                clear_hud_elements();
                return;
            case "A":
                clear_hud_elements();
                return level.menu_current_selection;
            case "DOWN":
                level.slot++;
                level.slot = scripts\engine\math::wrap( 0, var_1.size - 1, level.slot );
                thread show_selection_menu( level.slot, var_1 );
                break;
            case "UP":
                level.slot--;
                level.slot = scripts\engine\math::wrap( 0, var_1.size - 1, level.slot );
                thread show_selection_menu( level.slot, var_1 );
                break;
            case "RIGHT":
                break;
            case "LEFT":
                break;
        }
    }
}

show_selection_menu( var_0, var_1 )
{
    clear_hud_elements();
    var_2 = [];
    var_3 = clamp( var_1.size, 0, level.slot_cap );
    var_4 = var_1.size - 1;
    var_5 = scripts\engine\math::wrap( 0, var_4, var_0 );
    var_6 = var_1[var_5];
    var_7 = min( level.slot_cap, var_1.size );
    var_8 = int( var_7 / 2 );
    var_9 = var_0 - var_8;
    var_9 = scripts\engine\math::wrap( 0, var_4, var_9 );

    for ( var_10 = 0; var_10 < var_7; var_10++ )
    {
        if ( !isdefined( var_1[var_9] ) )
            continue;

        var_2[var_2.size] = var_1[var_9];
        var_9++;
        var_9 = scripts\engine\math::wrap( 0, var_4, var_9 );
    }

    for ( var_10 = 0; var_10 < var_2.size; var_10++ )
    {
        var_11 = var_2[var_10];

        if ( var_10 == var_8 )
        {
            level.menu_current_selection = var_11;
            var_11 = "->" + var_11;
            var_12 = ( 1, 1, 0 );
        }
        else
            var_12 = ( 1, 1, 1 );

        set_hud_element( var_11, var_12 );
    }
}

set_hud_element( var_0, var_1 )
{
    for ( var_2 = 0; var_2 < 1; var_2++ )
    {
        if ( isdefined( var_1 ) )
            level.hudelems[level.placementhudelements][var_2].color = var_1;
    }

    level.placementhudelements++;
}

clear_hud_elements()
{
    level.cleartextmarker clearalltextafterhudelem();

    for ( var_0 = 0; var_0 < level.hudelem_count; var_0++ )
    {
        for ( var_1 = 0; var_1 < 1; var_1++ )
            level.hudelems[var_0][var_1].color = ( 1, 1, 1 );
    }

    level.placementhudelements = 0;
}
