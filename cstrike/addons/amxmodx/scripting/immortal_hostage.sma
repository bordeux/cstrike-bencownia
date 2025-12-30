/*
 * Immortal Hostage Plugin
 * Makes hostages invulnerable to damage by intercepting and blocking damage events
 */

#include <amxmodx>
#include <amxmisc>
#include <hamsandwich>

#define PLUGIN "Immortal Hostage"
#define VERSION "1.0"
#define AUTHOR "Sn!ff3r"

public plugin_init() {
	register_plugin(PLUGIN, VERSION, AUTHOR)
	RegisterHam(Ham_TakeDamage, "hostage_entity", "Ham_Damage")
}

public Ham_Damage()
{
	return HAM_SUPERCEDE
}