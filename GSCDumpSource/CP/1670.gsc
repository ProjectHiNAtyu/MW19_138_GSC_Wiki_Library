// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init_spawn_anim_skits()
{
    ai_door_spawn_anims();
    door_script_model_anims();
    grenade_model_anims();
}

#using_animtree("generic_human");

ai_door_spawn_anims()
{
    level.scr_animtree["ai_spawn_door_soldier"] = #animtree;
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_smoke_A"] = %sdr_com_inter_rdoor_smoke_a;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_smoke_A"] = "sdr_com_inter_rdoor_smoke_A";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_flash_A"] = %sdr_com_inter_rdoor_flash_a;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_flash_A"] = "sdr_com_inter_rdoor_flash_A";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_smoke_A"] = %sdr_com_inter_ldoor_smoke_a;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_smoke_A"] = "sdr_com_inter_ldoor_smoke_A";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_flash_A"] = %sdr_com_inter_ldoor_flash_a;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_flash_A"] = "sdr_com_inter_ldoor_flash_A";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_shoulder_ex_run_C"] = %sdr_com_inter_rdoor_wall_shoulder_ex_run_c;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_shoulder_ex_run_C"] = "sdr_com_inter_rdoor_wall_shoulder_ex_run_C";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_shoulder_ex_run_B"] = %sdr_com_inter_rdoor_wall_shoulder_ex_run_b;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_shoulder_ex_run_B"] = "sdr_com_inter_rdoor_wall_shoulder_ex_run_B";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_shoulder_ex_run_A"] = %sdr_com_inter_rdoor_wall_shoulder_ex_run_a;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_shoulder_ex_run_A"] = "sdr_com_inter_rdoor_wall_shoulder_ex_run_A";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_shoulder_ex_run_C"] = %sdr_com_inter_ldoor_shoulder_ex_run_c;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_shoulder_ex_run_C"] = "sdr_com_inter_ldoor_shoulder_ex_run_C";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_shoulder_ex_run_B"] = %sdr_com_inter_ldoor_shoulder_ex_run_b;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_shoulder_ex_run_B"] = "sdr_com_inter_ldoor_shoulder_ex_run_B";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_shoulder_ex_run_A"] = %sdr_com_inter_ldoor_shoulder_ex_run_a;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_shoulder_ex_run_A"] = "sdr_com_inter_ldoor_shoulder_ex_run_A";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_shoulder_ex_run_C"] = %sdr_com_inter_ldoor_wall_shoulder_ex_run_c;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_shoulder_ex_run_C"] = "sdr_com_inter_ldoor_wall_shoulder_ex_run_C";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_shoulder_ex_run_B"] = %sdr_com_inter_ldoor_wall_shoulder_ex_run_b;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_shoulder_ex_run_B"] = "sdr_com_inter_ldoor_wall_shoulder_ex_run_B";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_shoulder_ex_run_A"] = %sdr_com_inter_ldoor_wall_shoulder_ex_run_a;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_shoulder_ex_run_A"] = "sdr_com_inter_ldoor_wall_shoulder_ex_run_A";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_tac_ex_cqb_C"] = %sdr_com_inter_rdoor_tac_ex_cqb_c;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_tac_ex_cqb_C"] = "sdr_com_inter_rdoor_tac_ex_cqb_C";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_tac_ex_cqb_B"] = %sdr_com_inter_rdoor_tac_ex_cqb_b;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_tac_ex_cqb_B"] = "sdr_com_inter_rdoor_tac_ex_cqb_B";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_tac_ex_cqb_A"] = %sdr_com_inter_rdoor_tac_ex_cqb_a;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_tac_ex_cqb_A"] = "sdr_com_inter_rdoor_tac_ex_cqb_A";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_tac_ex_cqb_C"] = %sdr_com_inter_rdoor_wall_tac_ex_cqb_c;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_tac_ex_cqb_C"] = "sdr_com_inter_rdoor_wall_tac_ex_cqb_C";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_tac_ex_cqb_B"] = %sdr_com_inter_rdoor_wall_tac_ex_cqb_b;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_tac_ex_cqb_B"] = "sdr_com_inter_rdoor_wall_tac_ex_cqb_B";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_tac_ex_cqb_A"] = %sdr_com_inter_rdoor_wall_tac_ex_cqb_a;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_tac_ex_cqb_A"] = "sdr_com_inter_rdoor_wall_tac_ex_cqb_A";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_tac_ex_cqb_C"] = %sdr_com_inter_ldoor_tac_ex_cqb_c;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_tac_ex_cqb_C"] = "sdr_com_inter_ldoor_tac_ex_cqb_C";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_tac_ex_cqb_B"] = %sdr_com_inter_ldoor_tac_ex_cqb_b;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_tac_ex_cqb_B"] = "sdr_com_inter_ldoor_tac_ex_cqb_B";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_tac_ex_cqb_A"] = %sdr_com_inter_ldoor_tac_ex_cqb_a;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_tac_ex_cqb_A"] = "sdr_com_inter_ldoor_tac_ex_cqb_A";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_tac_ex_cqb_C"] = %sdr_com_inter_ldoor_wall_tac_ex_cqb_c;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_tac_ex_cqb_C"] = "sdr_com_inter_ldoor_wall_tac_ex_cqb_C";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_tac_ex_cqb_B"] = %sdr_com_inter_ldoor_wall_tac_ex_cqb_b;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_tac_ex_cqb_B"] = "sdr_com_inter_ldoor_wall_tac_ex_cqb_B";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_tac_ex_cqb_A"] = %sdr_com_inter_ldoor_wall_tac_ex_cqb_a;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_tac_ex_cqb_A"] = "sdr_com_inter_ldoor_wall_tac_ex_cqb_A";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_kick_ex_cqb_C"] = %sdr_com_inter_rdoor_wall_kick_ex_cqb_c;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_kick_ex_cqb_C"] = "sdr_com_inter_rdoor_wall_kick_ex_cqb_C";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_kick_ex_cqb_B"] = %sdr_com_inter_rdoor_wall_kick_ex_cqb_b;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_kick_ex_cqb_B"] = "sdr_com_inter_rdoor_wall_kick_ex_cqb_B";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_kick_ex_cqb_A"] = %sdr_com_inter_rdoor_wall_kick_ex_cqb_a;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_kick_ex_cqb_A"] = "sdr_com_inter_rdoor_wall_kick_ex_cqb_A";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_kick_ex_run_C"] = %sdr_com_inter_rdoor_wall_kick_ex_run_c;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_kick_ex_run_C"] = "sdr_com_inter_rdoor_wall_kick_ex_run_C";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_kick_ex_run_B"] = %sdr_com_inter_rdoor_wall_kick_ex_run_b;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_kick_ex_run_B"] = "sdr_com_inter_rdoor_wall_kick_ex_run_B";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_kick_ex_run_A"] = %sdr_com_inter_rdoor_wall_kick_ex_run_a;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_kick_ex_run_A"] = "sdr_com_inter_rdoor_wall_kick_ex_run_A";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_kick_ex_cqb_C"] = %sdr_com_inter_ldoor_wall_kick_ex_cqb_c;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_kick_ex_cqb_C"] = "sdr_com_inter_ldoor_wall_kick_ex_cqb_C";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_kick_ex_cqb_B"] = %sdr_com_inter_ldoor_wall_kick_ex_cqb_b;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_kick_ex_cqb_B"] = "sdr_com_inter_ldoor_wall_kick_ex_cqb_B";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_kick_ex_cqb_A"] = %sdr_com_inter_ldoor_wall_kick_ex_cqb_a;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_kick_ex_cqb_A"] = "sdr_com_inter_ldoor_wall_kick_ex_cqb_A";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_kick_ex_run_C"] = %sdr_com_inter_ldoor_wall_kick_ex_run_c;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_kick_ex_run_C"] = "sdr_com_inter_ldoor_wall_kick_ex_run_C";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_kick_ex_run_B"] = %sdr_com_inter_ldoor_wall_kick_ex_run_b;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_kick_ex_run_B"] = "sdr_com_inter_ldoor_wall_kick_ex_run_B";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_kick_ex_run_A"] = %sdr_com_inter_ldoor_wall_kick_ex_run_a;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_kick_ex_run_A"] = "sdr_com_inter_ldoor_wall_kick_ex_run_A";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_dbldoor_kick_ex_cqb_C"] = %sdr_com_inter_dbldoor_kick_ex_cqb_c;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_dbldoor_kick_ex_cqb_C"] = "sdr_com_inter_dbldoor_kick_ex_cqb_C";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_dbldoor_kick_ex_cqb_B"] = %sdr_com_inter_dbldoor_kick_ex_cqb_b;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_dbldoor_kick_ex_cqb_B"] = "sdr_com_inter_dbldoor_kick_ex_cqb_B";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_dbldoor_kick_ex_cqb_A"] = %sdr_com_inter_dbldoor_kick_ex_cqb_a;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_dbldoor_kick_ex_cqb_A"] = "sdr_com_inter_dbldoor_kick_ex_cqb_A";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_dbldoor_kick_ex_run_C"] = %sdr_com_inter_dbldoor_kick_ex_run_c;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_dbldoor_kick_ex_run_C"] = "sdr_com_inter_dbldoor_kick_ex_run_C";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_dbldoor_kick_ex_run_B"] = %sdr_com_inter_dbldoor_kick_ex_run_b;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_dbldoor_kick_ex_run_B"] = "sdr_com_inter_dbldoor_kick_ex_run_B";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_dbldoor_kick_ex_run_A"] = %sdr_com_inter_dbldoor_kick_ex_run_a;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_dbldoor_kick_ex_run_A"] = "sdr_com_inter_dbldoor_kick_ex_run_A";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_kick_ex_cqb_C"] = %sdr_com_inter_ldoor_kick_ex_cqb_c;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_kick_ex_cqb_C"] = "sdr_com_inter_ldoor_kick_ex_cqb_C";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_kick_ex_cqb_B"] = %sdr_com_inter_ldoor_kick_ex_cqb_b;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_kick_ex_cqb_B"] = "sdr_com_inter_ldoor_kick_ex_cqb_B";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_kick_ex_cqb_A"] = %sdr_com_inter_ldoor_kick_ex_cqb_a;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_kick_ex_cqb_A"] = "sdr_com_inter_ldoor_kick_ex_cqb_A";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_kick_ex_run_C"] = %sdr_com_inter_ldoor_kick_ex_run_c;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_kick_ex_run_C"] = "sdr_com_inter_ldoor_kick_ex_run_C";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_kick_ex_run_B"] = %sdr_com_inter_ldoor_kick_ex_run_b;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_kick_ex_run_B"] = "sdr_com_inter_ldoor_kick_ex_run_B";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_kick_ex_run_A_alt"] = %sdr_com_inter_ldoor_kick_ex_run_a_alt;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_kick_ex_run_A_alt"] = "sdr_com_inter_ldoor_kick_ex_run_A_alt";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_kick_ex_run_A"] = %sdr_com_inter_ldoor_kick_ex_run_a;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_kick_ex_run_A"] = "sdr_com_inter_ldoor_kick_ex_run_A";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_90_pull_ex_idle_A"] = %sdr_com_inter_ldoor_90_pull_ex_idle_a;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_90_pull_ex_idle_A"] = "sdr_com_inter_ldoor_90_pull_ex_idle_A";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_90_pull_ex_idle_B"] = %sdr_com_inter_ldoor_90_pull_ex_idle_b;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_90_pull_ex_idle_B"] = "sdr_com_inter_ldoor_90_pull_ex_idle_B";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_90_pull_ex_idle_C"] = %sdr_com_inter_ldoor_90_pull_ex_idle_c;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_90_pull_ex_idle_C"] = "sdr_com_inter_ldoor_90_pull_ex_idle_C";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_90_pull_ex_idle_A"] = %sdr_com_inter_rdoor_90_pull_ex_idle_a;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_90_pull_ex_idle_A"] = "sdr_com_inter_rdoor_90_pull_ex_idle_A";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_90_pull_ex_idle_B"] = %sdr_com_inter_rdoor_90_pull_ex_idle_b;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_90_pull_ex_idle_B"] = "sdr_com_inter_rdoor_90_pull_ex_idle_B";
    level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_90_pull_ex_idle_C"] = %sdr_com_inter_rdoor_90_pull_ex_idle_c;
    level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_90_pull_ex_idle_C"] = "sdr_com_inter_rdoor_90_pull_ex_idle_C";
}

#using_animtree("script_model");

door_script_model_anims()
{
    level.scr_animtree["ai_spawn_door"] = #animtree;
    level.scr_anim["ai_spawn_door"]["sdr_com_inter_rdoor_smoke_door"] = %sdr_com_inter_rdoor_smoke_door;
    level.scr_animname["ai_spawn_door"]["sdr_com_inter_rdoor_smoke_door"] = "sdr_com_inter_rdoor_smoke_door";
    level.scr_anim["ai_spawn_door"]["sdr_com_inter_rdoor_flash_door"] = %sdr_com_inter_rdoor_flash_door;
    level.scr_animname["ai_spawn_door"]["sdr_com_inter_rdoor_flash_door"] = "sdr_com_inter_rdoor_flash_door";
    level.scr_anim["ai_spawn_door"]["sdr_com_inter_ldoor_flash_door"] = %sdr_com_inter_ldoor_flash_door;
    level.scr_animname["ai_spawn_door"]["sdr_com_inter_ldoor_flash_door"] = "sdr_com_inter_ldoor_flash_door";
    level.scr_anim["ai_spawn_door"]["sdr_com_inter_ldoor_smoke_door"] = %sdr_com_inter_ldoor_smoke_door;
    level.scr_animname["ai_spawn_door"]["sdr_com_inter_ldoor_smoke_door"] = "sdr_com_inter_ldoor_smoke_door";
    level.scr_anim["ai_spawn_door"]["sdr_com_inter_rdoor_tac_ex_cqb_door"] = %sdr_com_inter_rdoor_tac_ex_cqb_door;
    level.scr_animname["ai_spawn_door"]["sdr_com_inter_rdoor_tac_ex_cqb_door"] = "sdr_com_inter_rdoor_tac_ex_cqb_door";
    level.scr_anim["ai_spawn_door"]["sdr_com_inter_ldoor_tac_ex_cqb_door"] = %sdr_com_inter_ldoor_tac_ex_cqb_door;
    level.scr_animname["ai_spawn_door"]["sdr_com_inter_ldoor_tac_ex_cqb_door"] = "sdr_com_inter_ldoor_tac_ex_cqb_door";
    level.scr_anim["ai_spawn_door"]["sdr_com_inter_ldoor_shoulder_ex_run_door"] = %sdr_com_inter_ldoor_shoulder_ex_run_door;
    level.scr_animname["ai_spawn_door"]["sdr_com_inter_ldoor_shoulder_ex_run_door"] = "sdr_com_inter_ldoor_shoulder_ex_run_door";
    level.scr_anim["ai_spawn_door"]["sdr_com_inter_rdoor_wall_shoulder_ex_run_door"] = %sdr_com_inter_rdoor_wall_shoulder_ex_run_door;
    level.scr_animname["ai_spawn_door"]["sdr_com_inter_rdoor_wall_shoulder_ex_run_door"] = "sdr_com_inter_rdoor_wall_shoulder_ex_run_door";
    level.scr_anim["ai_spawn_door"]["sdr_com_inter_ldoor_wall_shoulder_ex_run_door"] = %sdr_com_inter_ldoor_wall_shoulder_ex_run_door;
    level.scr_animname["ai_spawn_door"]["sdr_com_inter_ldoor_wall_shoulder_ex_run_door"] = "sdr_com_inter_ldoor_wall_shoulder_ex_run_door";
    level.scr_anim["ai_spawn_door"]["sdr_com_inter_rdoor_wall_tac_ex_cqb_door"] = %sdr_com_inter_rdoor_wall_tac_ex_cqb_door;
    level.scr_animname["ai_spawn_door"]["sdr_com_inter_rdoor_wall_tac_ex_cqb_door"] = "sdr_com_inter_rdoor_wall_tac_ex_cqb_door";
    level.scr_anim["ai_spawn_door"]["sdr_com_inter_ldoor_wall_tac_ex_cqb_door"] = %sdr_com_inter_ldoor_wall_tac_ex_cqb_door;
    level.scr_animname["ai_spawn_door"]["sdr_com_inter_ldoor_wall_tac_ex_cqb_door"] = "sdr_com_inter_ldoor_wall_tac_ex_cqb_door";
    level.scr_anim["ai_spawn_door"]["sdr_com_inter_rdoor_wall_kick_ex_cqb_door"] = %sdr_com_inter_rdoor_wall_kick_ex_cqb_door;
    level.scr_animname["ai_spawn_door"]["sdr_com_inter_rdoor_wall_kick_ex_cqb_door"] = "sdr_com_inter_rdoor_wall_kick_ex_cqb_door";
    level.scr_anim["ai_spawn_door"]["sdr_com_inter_rdoor_wall_kick_ex_run_door"] = %sdr_com_inter_rdoor_wall_kick_ex_run_door;
    level.scr_animname["ai_spawn_door"]["sdr_com_inter_rdoor_wall_kick_ex_run_door"] = "sdr_com_inter_rdoor_wall_kick_ex_run_door";
    level.scr_anim["ai_spawn_door"]["sdr_com_inter_ldoor_wall_kick_ex_cqb_door"] = %sdr_com_inter_ldoor_wall_kick_ex_cqb_door;
    level.scr_animname["ai_spawn_door"]["sdr_com_inter_ldoor_wall_kick_ex_cqb_door"] = "sdr_com_inter_ldoor_wall_kick_ex_cqb_door";
    level.scr_anim["ai_spawn_door"]["sdr_com_inter_ldoor_wall_kick_ex_run_door"] = %sdr_com_inter_ldoor_wall_kick_ex_run_door;
    level.scr_animname["ai_spawn_door"]["sdr_com_inter_ldoor_wall_kick_ex_run_door"] = "sdr_com_inter_ldoor_wall_kick_ex_run_door";
    level.scr_anim["ai_spawn_door"]["sdr_com_inter_dbldoor_kick_ex_cqb_doorr"] = %sdr_com_inter_dbldoor_kick_ex_cqb_doorr;
    level.scr_animname["ai_spawn_door"]["sdr_com_inter_dbldoor_kick_ex_cqb_doorr"] = "sdr_com_inter_dbldoor_kick_ex_cqb_doorr";
    level.scr_anim["ai_spawn_door"]["sdr_com_inter_dbldoor_kick_ex_cqb_doorl"] = %sdr_com_inter_dbldoor_kick_ex_cqb_doorl;
    level.scr_animname["ai_spawn_door"]["sdr_com_inter_dbldoor_kick_ex_cqb_doorl"] = "sdr_com_inter_dbldoor_kick_ex_cqb_doorl";
    level.scr_anim["ai_spawn_door"]["sdr_com_inter_dbldoor_kick_ex_run_doorr"] = %sdr_com_inter_dbldoor_kick_ex_run_doorr;
    level.scr_animname["ai_spawn_door"]["sdr_com_inter_dbldoor_kick_ex_run_doorr"] = "sdr_com_inter_dbldoor_kick_ex_run_doorr";
    level.scr_anim["ai_spawn_door"]["sdr_com_inter_dbldoor_kick_ex_run_doorl"] = %sdr_com_inter_dbldoor_kick_ex_run_doorl;
    level.scr_animname["ai_spawn_door"]["sdr_com_inter_dbldoor_kick_ex_run_doorl"] = "sdr_com_inter_dbldoor_kick_ex_run_doorl";
    level.scr_anim["ai_spawn_door"]["sdr_com_inter_ldoor_kick_ex_cqb_door"] = %sdr_com_inter_ldoor_kick_ex_cqb_door;
    level.scr_animname["ai_spawn_door"]["sdr_com_inter_ldoor_kick_ex_cqb_door"] = "sdr_com_inter_ldoor_kick_ex_cqb_door";
    level.scr_anim["ai_spawn_door"]["sdr_com_inter_ldoor_kick_ex_run_door"] = %sdr_com_inter_ldoor_kick_ex_run_door;
    level.scr_animname["ai_spawn_door"]["sdr_com_inter_ldoor_kick_ex_run_door"] = "sdr_com_inter_ldoor_kick_ex_run_door";
    level.scr_anim["ai_spawn_door"]["sdr_com_inter_ldoor_90_pull_ex_idle_door"] = %sdr_com_inter_ldoor_90_pull_ex_idle_door;
    level.scr_animname["ai_spawn_door"]["sdr_com_inter_ldoor_90_pull_ex_idle_door"] = "sdr_com_inter_ldoor_90_pull_ex_idle_door";
    level.scr_anim["ai_spawn_door"]["sdr_com_inter_rdoor_90_pull_ex_idle_door"] = %sdr_com_inter_rdoor_90_pull_ex_idle_door;
    level.scr_animname["ai_spawn_door"]["sdr_com_inter_rdoor_90_pull_ex_idle_door"] = "sdr_com_inter_rdoor_90_pull_ex_idle_door";
}

grenade_model_anims()
{
    level.scr_animtree["ai_spawn_door_grenade"] = #animtree;
    level.scr_anim["ai_spawn_door_grenade"]["sdr_com_inter_rdoor_flash_grenade"] = %sdr_com_inter_rdoor_flash_grenade;
    level.scr_animname["ai_spawn_door_grenade"]["sdr_com_inter_rdoor_flash_grenade"] = "sdr_com_inter_rdoor_flash_grenade";
    level.scr_anim["ai_spawn_door_grenade"]["sdr_com_inter_rdoor_flash_grenade"] = %sdr_com_inter_ldoor_flash_grenade;
    level.scr_animname["ai_spawn_door_grenade"]["sdr_com_inter_rdoor_flash_grenade"] = "sdr_com_inter_ldoor_flash_grenade";
    level.scr_anim["ai_spawn_door_grenade"]["sdr_com_inter_ldoor_smoke_grenade"] = %sdr_com_inter_ldoor_smoke_grenade;
    level.scr_animname["ai_spawn_door_grenade"]["sdr_com_inter_ldoor_smoke_grenade"] = "sdr_com_inter_ldoor_smoke_grenade";
    level.scr_anim["ai_spawn_door_grenade"]["sdr_com_inter_ldoor_smoke_grenade"] = %sdr_com_inter_rdoor_smoke_grenade;
    level.scr_animname["ai_spawn_door_grenade"]["sdr_com_inter_ldoor_smoke_grenade"] = "sdr_com_inter_rdoor_smoke_grenade";
}

should_use_door_spawn_anim( var_0 )
{
    if ( istrue( var_0.use_spawn_anim ) )
        return 1;
    else if ( isdefined( var_0.script_linkto ) )
    {
        var_0.use_spawn_anim = 1;
        return 1;
    }
    else
        return 0;
}

is_double_door( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( isdefined( var_0.script_linkto ) )
    {
        var_1 = scripts\engine\utility::getstructarray( var_0.script_linkto, "script_linkname" );

        if ( var_1.size < 1 )
            var_1 = getentarray( var_0.script_linkto, "script_linkname" );

        return var_1.size >= 2;
    }

    return 0;
}

is_left_door( var_0, var_1 )
{
    return var_0 scripts\engine\math::is_point_on_right( var_1 );
}

is_right_door( var_0, var_1 )
{
    return !var_0 scripts\engine\math::is_point_on_right( var_1 );
}

get_double_door_mid_point( var_0 )
{
    if ( isdefined( var_0.script_linkto ) )
    {
        var_1 = scripts\engine\utility::getstructarray( var_0.script_linkto, "script_linkname" );

        if ( var_1.size < 1 )
            var_1 = getentarray( var_0.script_linkto, "script_linkname" );

        if ( var_1.size >= 2 )
            return scripts\engine\math::get_mid_point( var_1[0].origin, var_1[1].origin );
    }
    else
        return undefined;
}

get_spawn_anim( var_0, var_1, var_2 )
{
    var_3 = level.spawn_door_anims;

    if ( is_double_door( var_1 ) )
        var_3 = level.spawn_dbldoor_anims;
    else if ( isdefined( var_0 ) && is_left_door( var_0, var_1.origin ) )
        var_3 = level.spawn_ldoor_anims;
    else if ( isdefined( var_0 ) && is_right_door( var_0, var_1.origin ) )
        var_3 = level.spawn_rdoor_anims;

    return scripts\engine\utility::random( var_3 );
}
