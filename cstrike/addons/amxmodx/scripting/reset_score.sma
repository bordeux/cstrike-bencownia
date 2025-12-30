/*
   This plugin just restart the scores
*/

#include <amxmodx>
#include <amxmisc>
#include <cstrike>
#include <fun>

public plugin_init()
{
	register_plugin("Reset Score", "1.0", "bordeux")
	//You may type /resetscore or /rs
	register_clcmd("say /resetscore", "reset_score")
	register_clcmd("say /rs", "reset_score")
}

public reset_score(id)
{
	cs_set_user_deaths(id, 0)
	set_user_frags(id, 0)
	cs_set_user_deaths(id, 0)
	set_user_frags(id, 0)
	client_print(id, print_chat, "Statystyki wyczyszczone);
}
