/*
 * Bomb Plant Sound Plugin
 * Plays custom sounds when the bomb is planted
 * - CT team hears sound_ct
 * - T team (except planter) hears sound_tt
 * - Planter hears sound_planter
 */

#include <amxmodx>
#include <amxmisc>
#include <cstrike>

#define PLUGIN "Bomb Plant - Papaj"
#define VERSION "0.2"
#define AUTHOR "bordeux"

new const sound_ct[] = "bencownia/papaj_bp_ct.wav"
new const sound_tt[] = "bencownia/papaj_bp_tt.wav"
new const sound_planter[] = "bencownia/papaj_bp_planter.wav"

public plugin_init()
{
	register_plugin(PLUGIN, VERSION, AUTHOR)
}

public bomb_planted(planter)
{
	new players[32], num

	// Play sound for CT team
	get_players(players, num, "ae", "CT")
	for (new i = 0; i < num; i++)
	{
		client_cmd(players[i], "spk %s", sound_ct)
	}

	// Play sound for T team
	get_players(players, num, "ae", "TERRORIST")
	for (new i = 0; i < num; i++)
	{
		if (players[i] == planter)
		{
			client_cmd(players[i], "spk %s", sound_planter)
		}
		else
		{
			client_cmd(players[i], "spk %s", sound_tt)
		}
	}
}

public plugin_precache()
{
	precache_sound(sound_ct)
	precache_sound(sound_tt)
	precache_sound(sound_planter)
}