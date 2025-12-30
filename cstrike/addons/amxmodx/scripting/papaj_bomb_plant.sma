/*
 * Bomb Plant Sound Plugin
 * Plays a custom sound when the bomb is planted
 */

#include <amxmodx>
#include <amxmisc>

#define PLUGIN "Bomb Plant - Papaj"
#define VERSION "0.1"
#define AUTHOR "bordeux"

new const sound[] = "bencownia/papaj_bp.wav"

public plugin_init()
{
	register_plugin(PLUGIN, VERSION, AUTHOR)
}

public bomb_planted()
{
	client_cmd(0, "spk %s", sound)
}

public plugin_precache()
{
	precache_sound(sound)
}