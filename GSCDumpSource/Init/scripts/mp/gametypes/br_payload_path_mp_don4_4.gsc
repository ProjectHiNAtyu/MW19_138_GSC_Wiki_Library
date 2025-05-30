// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

playerwatchspectate( var_0, var_1, var_2 )
{
    if ( level.mapname != "mp_don4" )
        return;

    if ( level.cleanupswaploadoutflags.timetonextcheckpoint != var_1 && !isdefined( level.cleanupswaploadoutflags.technical_initdamage ) )
        return;

    if ( !isdefined( level.cleanupswaploadoutflags.paths ) )
        level.cleanupswaploadoutflags.paths = [];

    var_3 = spawnstruct();
    var_3.nodes = [];
    var_3.origin = ( -23409.8, -29035.3, -124.347 );
    var_3.script_index = var_0;
    var_3.freeze_bomb_vest_timer = var_2;
    var_3.nodes[0] = var_3;
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -23008, -28736.9, -124.214 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -22610.7, -28431, -124.868 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -22199.9, -28144, -128.476 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -21780.7, -27871.5, -136.555 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -21349.6, -27616.7, -145.37 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -20924.1, -27353.6, -148.346 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -20498.9, -27089.8, -149.418 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -20073.1, -26827.3, -157.885 );
    var_3.nodes[var_4].obstacle = spawnstruct();
    var_3.nodes[var_4].obstacle.origin = ( -19743, -26619.8, -167.83 );
    var_3.nodes[var_4].obstacle.angles = ( 361.714, 32.1592, 0 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -19648.6, -26560.4, -172.237 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -19233.4, -26281.6, -188.021 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -18813, -26010.7, -202.103 );
    var_3.nodes[var_4].checkpoint = 1;
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -18385.5, -25751, -216.147 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -17954.9, -25495.7, -231.798 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -17515.2, -25257.7, -248.685 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -17069.1, -25030, -266.414 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -16614.6, -24821, -276.177 );
    var_3.nodes[var_4].obstacle = spawnstruct();
    var_3.nodes[var_4].obstacle.origin = ( -16254.7, -24670.8, -273.998 );
    var_3.nodes[var_4].obstacle.angles = ( 360, 22.6585, 0 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -16151.8, -24627.8, -276.976 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -15679.7, -24462.5, -284.255 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -15208.8, -24290.2, -285.173 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -14766.2, -24057.5, -285.237 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -14324.2, -23820.3, -285.445 );
    var_3.nodes[var_4].obstacle = spawnstruct();
    var_3.nodes[var_4].obstacle.origin = ( -13981.1, -23634.8, -283.138 );
    var_3.nodes[var_4].obstacle.angles = ( 360.009, 28.3969, 0 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -13883.6, -23582.1, -285.461 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -13446.4, -23336.7, -285.016 );
    var_3.nodes[var_4].checkpoint = 1;
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -13013.3, -23083.9, -285.518 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -12586.6, -22821.5, -288.03 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -12163.4, -22554.9, -317.229 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -11740.4, -22288.5, -359.06 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -11314.7, -22024.3, -363.122 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -10851.2, -21833.7, -352.17 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -10357, -21762, -321.426 );
    var_3.nodes[var_4].obstacle = spawnstruct();
    var_3.nodes[var_4].obstacle.origin = ( -9967.89, -21758.3, -279.24 );
    var_3.nodes[var_4].obstacle.angles = ( 361.858, 0.551093, 0 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -9857.89, -21757.2, -281.936 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -9326.71, -21835.6, -283.641 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -8796.53, -21822.8, -287.253 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -8368.1, -21819.8, -288.495 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -7856.09, -21731.9, -292.09 );
    var_3.nodes[var_4].obstacle = spawnstruct();
    var_3.nodes[var_4].obstacle.origin = ( -7466.91, -21706.6, -290.001 );
    var_3.nodes[var_4].obstacle.angles = ( 360, 3.72055, 0 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -7356.3, -21699.4, -292.453 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -6856.2, -21660.7, -292.418 );
    scripts\mp\gametypes\br_gametype_payload.gsc::_id_11ED1( var_0, var_2 );
    level.cleanupswaploadoutflags.paths[level.cleanupswaploadoutflags.paths.size] = var_3;
}
