/*
    Made by : Hardik Kumar
    on behalf of DomainSquare+ for EXUN 2015
    Github: hardikk21
*/
// Includes
#include <a_samp>
#include <streamer>
#include <izcmd>
#include <gangzones>

// Teams
#define TEAM_RED 1
#define TEAM_BLUE 2
#define TEAM_GREEN 3
#define TEAM_ORANGE 4

// Colors
#define white 0xFFFFFFAA
#define red 0x8B0000AA
#define blue 0x4169FFAA
#define yellow 0xFFD700AA
#define blueviolet 0x8A2BE2AA
#define gray 0x808080AA
#define green 0x6AFF00AA
#define orange 0xEA9E23AA


new redcp, bluecp, greencp, orangecp;
new redzone, bluezone, greenzone, orangezone;

new Float:zones_points_0[] = {
	23.0, -93.0, 43.0, -73.0
};
new Float:zones_points_1[] = {
	54.0, 23.0, 74.0, 43.0
};
new Float:zones_points_2[] = {
	-198.0, 171.0, -178.0, 191.0
};
new Float:zones_points_3[] = {
	-243.0, 3.0, -223.0, 23.0
};
// gTeam ( Used For Check The Player's Team )
static gTeam[MAX_PLAYERS];

new flag; // The Flags
new GotsTheFlag = 999;
new NewPlayer[MAX_PLAYERS]; // Used For The Textdraw when someone spawns

// Forwards
forward SetPlayerColorFromTeam(playerid);
forward ChangeRound();
enum Info
{
	DroppedFlags,
};
new PlayerInfo[MAX_PLAYERS][Info];

enum Flag
{
	Float:flagX,
	Float:flagY,
	Float:flagZ,
};
new FlagInfo[Flag];

main()
{
	print("\n----------------------------------");
	print(" DomainSquare Capture the Flag");
	print("----------------------------------\n");
}
public OnGameModeInit()
{

	ShowPlayerMarkers(PLAYER_MARKERS_MODE_OFF);
	// Don't use these lines if it's a filterscript
	SetGameModeText("Capture The Flag D2S+");

	AddPlayerClass(128, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(129, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(130, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(159, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(200, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(162, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);

	UsePlayerPedAnims();
	DisableInteriorEnterExits();
	ShowPlayerMarkers(0);
	SetWorldTime(0);
	SendRconCommand("hostname Capture The Flag D2S+");
	SetTimer("ChangeRound",1000,false);
	redzone = GangZoneCreate(zones_points_0[0], zones_points_0[1], zones_points_0[2], zones_points_0[3], red);
	bluezone = GangZoneCreate(zones_points_1[0], zones_points_1[1], zones_points_1[2], zones_points_1[3], blue);
	greenzone = GangZoneCreate(zones_points_2[0], zones_points_2[1], zones_points_2[2], zones_points_2[3], green);
	orangezone = GangZoneCreate(zones_points_3[0], zones_points_3[1], zones_points_3[2], zones_points_3[3], orange);
	return 1;
}

public OnGameModeExit()
{
    FlagInfo[flagX] = 0.0;
	FlagInfo[flagY] = 0.0;
	FlagInfo[flagZ] = 0.0;
	return 1;
}
stock GetFileValue(string[])
{
	new val[128];
	val[0] = 0;
	if (strfind(string , ":", true) == -1) return val;
	new id = strfind(string, ":", true);
	strmid(val, string, id+2, strlen(string), 128);
	return val;
}
public OnPlayerEnterGangZone(playerid, zone)
{
	if(GotsTheFlag == playerid)
	{
	    new pName[MAX_PLAYER_NAME];
	    GetPlayerName(playerid, pName, MAX_PLAYER_NAME);
	    new string[MAX_PLAYER_NAME+50];
		if(gTeam[playerid] == TEAM_RED && zone == redzone)
		{
		    
		    DestroyPickup(flag);
	        SetTimer("ChangeRound",1000,false);
	        GivePlayerMoney(playerid,500);
	        SetPlayerScore(playerid,GetPlayerScore(playerid)+10);
	        format(string,sizeof(string)," [Flag-Update]: %s captured the flag",pName);
	        SendClientMessageToAll(blueviolet,string);
	        PlayerInfo[playerid][DroppedFlags]++;
	        SetPlayerColorFromTeam(playerid);
	        GotsTheFlag = 999;
			for(new i = 0;i<MAX_PLAYERS;i++)
			{
			    ForceClassSelection(i);
			    TogglePlayerControllable(i,0);
			    GameTextForPlayer(i,"~w~The Round is Changing...Please Wait",3000,4);
			}
		}
		else if(gTeam[playerid] == TEAM_BLUE && zone == bluezone)
		{
		    DestroyPickup(flag);
	        SetTimer("ChangeRound",1000,false);
	        GivePlayerMoney(playerid,500);
	        SetPlayerScore(playerid,GetPlayerScore(playerid)+10);
	        format(string,sizeof(string)," [Flag-Update]: %s captured the flag",pName);
	        SendClientMessageToAll(blueviolet,string);
	        PlayerInfo[playerid][DroppedFlags]++;
	        SetPlayerColorFromTeam(playerid);
	        GotsTheFlag = 999;
			for(new i = 0;i<MAX_PLAYERS;i++)
			{
			    ForceClassSelection(i);
			    TogglePlayerControllable(i,0);
			    GameTextForPlayer(i,"~w~The Round is Changing...Please Wait",3000,4);
			}
		}
		else if(gTeam[playerid] == TEAM_GREEN && zone == greenzone)
		{
		    DestroyPickup(flag);
	        SetTimer("ChangeRound",1000,false);
	        GivePlayerMoney(playerid,500);
	        SetPlayerScore(playerid,GetPlayerScore(playerid)+10);
	        format(string,sizeof(string)," [Flag-Update]: %s captured the flag",pName);
	        SendClientMessageToAll(blueviolet,string);
	        PlayerInfo[playerid][DroppedFlags]++;
	        SetPlayerColorFromTeam(playerid);
	        GotsTheFlag = 999;
			for(new i = 0;i<MAX_PLAYERS;i++)
			{
			    ForceClassSelection(i);
			    TogglePlayerControllable(i,0);
			    GameTextForPlayer(i,"~w~The Round is Changing...Please Wait",3000,4);
			}
		}
		else if(gTeam[playerid] == TEAM_ORANGE && zone == orangezone)
		{
		    DestroyPickup(flag);
	        SetTimer("ChangeRound",1000,false);
	        GivePlayerMoney(playerid,500);
	        SetPlayerScore(playerid,GetPlayerScore(playerid)+10);
	        format(string,sizeof(string)," [Flag-Update]: %s captured the flag",pName);
	        SendClientMessageToAll(blueviolet,string);
	        PlayerInfo[playerid][DroppedFlags]++;
	        SetPlayerColorFromTeam(playerid);
	        GotsTheFlag = 999;
			for(new i = 0;i<MAX_PLAYERS;i++)
			{
			    ForceClassSelection(i);
			    TogglePlayerControllable(i,0);
			    GameTextForPlayer(i,"~w~The Round is Changing...Please Wait",3000,4);
			}
		}
	}
}

public SetPlayerColorFromTeam(playerid)
{
	if(gTeam[playerid] == TEAM_RED)
	{
	    SetPlayerColor(playerid,red);
	}
	else if(gTeam[playerid] == TEAM_BLUE)
	{
	    SetPlayerColor(playerid,blue);
	}
	else if(gTeam[playerid] == TEAM_GREEN)
	{
	    SetPlayerColor(playerid,green);
	}
	else if(gTeam[playerid] == TEAM_ORANGE)
	{
	    SetPlayerColor(playerid,orange);
	}
	return 1;
}
public OnPlayerRequestClass(playerid, classid)
{
	PlayerPlaySound(playerid,1068,0.0,0.0,0.0);
	if(classid == 0)
	{
	    gTeam[playerid] = TEAM_RED;
	    GameTextForPlayer(playerid," ~r~Red~w~ Team",2500,6);
	}
	else if(classid == 1)
	{
	    gTeam[playerid] = TEAM_BLUE;
	    GameTextForPlayer(playerid," ~b~Blue~w~ Team",2500,6);
	}
	else if(classid == 2)
	{
	    gTeam[playerid] = TEAM_ORANGE;
	    GameTextForPlayer(playerid, " Orange Team",2500,6);
	}
	else if(classid == 3)
	{
	    gTeam[playerid] = TEAM_GREEN;
	    GameTextForPlayer(playerid, " ~g~Green Team", 2500, 6);
	}
	SetPlayerColor(playerid,gray);
	return 1;
}

public OnPlayerConnect(playerid)
{
    /*TextDrawShowForPlayer(playerid,RedTeamText);
    TextDrawShowForPlayer(playerid,BlueTeamText);
    TextDrawShowForPlayer(playerid,RedTeamScoreText);
    TextDrawShowForPlayer(playerid,BlueTeamScoreText);*/
	new string[248],pName[MAX_PLAYER_NAME];
	GetPlayerName(playerid,pName,sizeof(pName));
	PlayerInfo[playerid][DroppedFlags] = 0;
	format(string,sizeof(string)," Join: %s [ID:%d] has joined the server.",pName,playerid);
	SendClientMessageToAll(blueviolet,string);
	NewPlayer[playerid] = 1;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	new string[248],pName[MAX_PLAYER_NAME];
	GetPlayerName(playerid,pName,sizeof(pName));
	if(GotsTheFlag == playerid)
	{
	    GotsTheFlag = 999;
     	DestroyPickup(flag);
	    flag = CreatePickup(2914,22,-60.1534,20.4997,3.1094);

	}
	switch(reason)
    {
        case 0: format(string,sizeof(string)," Leaving: %s [ID:%d] has left the server ( Time Out ).",pName,playerid);
        case 1: format(string,sizeof(string)," Leaving: %s [ID:%d] has left the server ( Leaving ).",pName,playerid);
        case 2: format(string,sizeof(string)," Leaving: %s [ID:%d] has left the server ( Kicked / Banned ).",pName,playerid);
    }
    SendClientMessageToAll(blueviolet,string);
    /*TextDrawHideForPlayer(playerid,RedTeamText);
    TextDrawHideForPlayer(playerid,BlueTeamText);
    TextDrawHideForPlayer(playerid,RedTeamScoreText);
    TextDrawHideForPlayer(playerid,BlueTeamScoreText);*/
    NewPlayer[playerid] = 0;
	return 1;
}

public OnPlayerSpawn(playerid)
{
    PlayerPlaySound(playerid,1069,0.0,0.0,0.0);
    ClearAnimations(playerid);
    SetPlayerColorFromTeam(playerid);
    GangZoneShowForAll(redzone, red);
    GangZoneShowForAll(bluezone, blue);
    GangZoneShowForAll(greenzone, green);
    GangZoneShowForAll(orangezone, orange);
	if(gTeam[playerid] == TEAM_RED)
	{
	    	SetPlayerSkillLevel(playerid,WEAPONSKILL_DESERT_EAGLE,999);
	    	SetPlayerSkillLevel(playerid,WEAPONSKILL_MP5,999);
	    	SetPlayerPos(playerid,32.8712,-83.4041,0.8605);
	    	SetPlayerTeam(playerid,TEAM_RED); // Useful for Anti-TeamKill
	    	GivePlayerWeapon(playerid,3,1);
	    	GivePlayerWeapon(playerid,24,10000);
	    	GivePlayerWeapon(playerid,29,10000);
	    	redcp = CreateDynamicCP(28.4900,-85.8172,1.0717,2,-1,-1,playerid,50);
	}
	else if(gTeam[playerid] == TEAM_BLUE)
	{
	    	SetPlayerSkillLevel(playerid,WEAPONSKILL_DESERT_EAGLE,999);
	    	SetPlayerSkillLevel(playerid,WEAPONSKILL_MP5,999);
	    	SetPlayerPos(playerid,64.9643,35.7748,0.6094);
	    	SetPlayerTeam(playerid,TEAM_BLUE); // Useful for Anti-TeamKill
	    	GivePlayerWeapon(playerid,3,1);
	    	GivePlayerWeapon(playerid,24,10000);
	    	GivePlayerWeapon(playerid,29,10000);
	    	bluecp = CreateDynamicCP(62.0483,37.3572,0.6094,2,-1,-1,playerid,50);
	}
	else if(gTeam[playerid] == TEAM_ORANGE)
	{
	    	SetPlayerSkillLevel(playerid,WEAPONSKILL_DESERT_EAGLE,999);
	    	SetPlayerSkillLevel(playerid,WEAPONSKILL_MP5,999);
	    	SetPlayerPos(playerid,-233.7896,8.9296,3.0631);
	    	SetPlayerTeam(playerid,TEAM_BLUE); // Useful for Anti-TeamKill
	    	GivePlayerWeapon(playerid,3,1);
	    	GivePlayerWeapon(playerid,24,10000);
	    	GivePlayerWeapon(playerid,29,10000);
	    	orangecp = CreateDynamicCP(-234.5818,5.6825,3.0767,2,-1,-1,playerid,50);
	}
	else if(gTeam[playerid] == TEAM_GREEN)
	{
	    	SetPlayerSkillLevel(playerid,WEAPONSKILL_DESERT_EAGLE,999);
	    	SetPlayerSkillLevel(playerid,WEAPONSKILL_MP5,999);
	    	SetPlayerPos(playerid,-191.7142,181.8912,9.4601);
	    	SetPlayerTeam(playerid,TEAM_BLUE); // Useful for Anti-TeamKill
	    	GivePlayerWeapon(playerid,3,1);
	    	GivePlayerWeapon(playerid,24,10000);
	    	GivePlayerWeapon(playerid,29,10000);
	    	greencp = CreateDynamicCP(-186.2496,185.3858,10.0297,2,-1,-1,playerid,50);
	}
	return 1;
}
public OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	if((gTeam[playerid] == TEAM_RED && checkpointid == redcp) || (gTeam[playerid] == TEAM_BLUE && checkpointid == bluecp) || (gTeam[playerid] == TEAM_GREEN && checkpointid == greencp) || (gTeam[playerid] == TEAM_ORANGE && checkpointid == orangecp))
	{
		ShowPlayerDialog(playerid, 299, DIALOG_STYLE_LIST, "Weapon Shop", " 5 Grenades - $100\n Sawed Off Shotgun - $400\n AK47 - $600\n Sniper Rifle  - $800\n 10 Rocket Launchers - $1000", "Buy", "Cancel");
	}
}
public OnPlayerDeath(playerid, killerid, reason)
{
	ResetPlayerWeapons(playerid);
	SendDeathMessage(killerid,playerid,reason);
	new string[248],pName[MAX_PLAYER_NAME];
	GetPlayerName(playerid,pName,sizeof(pName));
	new Float:X,Float:Y,Float:Z;
	GetPlayerPos(playerid,X,Y,Z);
	if(GotsTheFlag == playerid)
	{
	    DestroyPickup(flag);
		flag = CreatePickup(2914,22,X,Y,Z);
		FlagInfo[flagX] = X;
		FlagInfo[flagY] = Y;
		FlagInfo[flagZ] = Z;
		SetPlayerColorFromTeam(playerid);
		format(string,sizeof(string)," [Flag Update]: %s dropped the Flag.",pName);
		SendClientMessageToAll(blueviolet, string);
		GotsTheFlag = 999;
	}
	GivePlayerWeapon(playerid,3,1);
	GivePlayerWeapon(playerid,24,10000);
 	GivePlayerWeapon(playerid,29,10000);
	SetPlayerScore(killerid,GetPlayerScore(killerid)+1);
	GivePlayerMoney(killerid,100);
	return 1;
}
public OnPlayerCommandText(playerid, cmdtext[])
{
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid==299)
	{
		if(!response)
		return 1;
		switch(listitem)
		{
		    case 0:
		    {
		        if(GetPlayerMoney(playerid) < 100)
		        {
		            return SendClientMessage(playerid, red, "You don't have enough money to buy this weapon.");
				}
				GivePlayerMoney(playerid, -100);
				GivePlayerWeapon(playerid, 16, 5);
				SendClientMessage(playerid, green, "You successfully bought a weapon.");
			}
			case 1:
		    {
		        if(GetPlayerMoney(playerid) < 400)
		        {
		            return SendClientMessage(playerid, red, "You don't have enough money to buy this weapon.");
				}
				GivePlayerMoney(playerid, -400);
				GivePlayerWeapon(playerid, 26, 999);
				SendClientMessage(playerid, green, "You successfully bought a weapon.");
			}
			case 2:
		    {
		        if(GetPlayerMoney(playerid) < 600)
		        {
		            return SendClientMessage(playerid, red, "You don't have enough money to buy this weapon.");
				}
				GivePlayerMoney(playerid, -600);
				GivePlayerWeapon(playerid, 30, 999);
				SendClientMessage(playerid, green, "You successfully bought a weapon.");
			}
			case 3:
		    {
		        if(GetPlayerMoney(playerid) < 800)
		        {
		            return SendClientMessage(playerid, red, "You don't have enough money to buy this weapon.");
				}
				GivePlayerMoney(playerid, -800);
				GivePlayerWeapon(playerid, 34, 999);
				SendClientMessage(playerid, green, "You successfully bought a weapon.");
			}
			case 4:
		    {
		        if(GetPlayerMoney(playerid) < 1000)
		        {
		            return SendClientMessage(playerid, red, "You don't have enough money to buy this weapon.");
				}
				GivePlayerMoney(playerid, -1000);
				GivePlayerWeapon(playerid, 35, 10);
				SendClientMessage(playerid, green, "You successfully bought a weapon.");
			}
		}
				
	}
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	if(gTeam[playerid] == TEAM_RED)
	{
	    if(NewPlayer[playerid] == 1)
	    {
	    	//TextDrawShowForPlayer(playerid,HelpText1[playerid]);SetTimerEx("Text1Off",10000,false,"d",playerid);
	    	NewPlayer[playerid] = 0;
	    	return 1;
		}
		else
		{
		    return 1;
		}
	}
	else if(gTeam[playerid] == TEAM_ORANGE)
	{
	    if(NewPlayer[playerid] == 1)
	    {
	        //TextDraw
			NewPlayer[playerid] = 0;
			return 1;
		}
		else
		{
		    return 1;
		}
	}
	else if(gTeam[playerid] == TEAM_GREEN)
	{
	    if(NewPlayer[playerid] == 1)
	    {
	        //TextDraw
			NewPlayer[playerid] = 0;
			return 1;
		}
		else
		{
		    return 1;
		}
	}
	else if(gTeam[playerid] == TEAM_BLUE)
	{
	    if(NewPlayer[playerid] == 1)
	    {
	    	//TextDrawShowForPlayer(playerid,HelpText2[playerid]);SetTimerEx("Text2Off",10000,false,"d",playerid);
	    	NewPlayer[playerid] = 0;
	    	return 1;
		}
		else
		{
		    return 1;
		}
	}
	return 1;
}
public OnPlayerPickUpPickup(playerid, pickupid)
{
	new string[248],pName[MAX_PLAYER_NAME];
	GetPlayerName(playerid,pName,sizeof(pName));
	if(pickupid == flag)
	{
	    if(gTeam[playerid] == TEAM_BLUE)
	    {
	        	DestroyPickup(flag);
	    		format(string,sizeof(string)," [Game-Engine]: %s has picked up the flag.",pName);
	    		SendClientMessageToAll(blueviolet,string);
	   	 		SendClientMessage(playerid,white," Drop The flag at your base.");
				GotsTheFlag = playerid;
				SetPlayerColor(playerid,yellow);
		}
		else if(gTeam[playerid] == TEAM_RED)
	    {
	        	DestroyPickup(flag);
	    		format(string,sizeof(string)," [Game-Engine]: %s has picked up the flag.",pName);
	    		SendClientMessageToAll(blueviolet,string);
	   	 		SendClientMessage(playerid,white," Drop The flag at your base.");
				GotsTheFlag = playerid;
				SetPlayerColor(playerid,yellow);
		}
		else if(gTeam[playerid] == TEAM_ORANGE)
	    {
	        	DestroyPickup(flag);
	    		format(string,sizeof(string)," [Game-Engine]: %s has picked up the flag.",pName);
	    		SendClientMessageToAll(blueviolet,string);
	   	 		SendClientMessage(playerid,white," Drop The flag at your base.");
				GotsTheFlag = playerid;
				SetPlayerColor(playerid,yellow);
		}
		else if(gTeam[playerid] == TEAM_GREEN)
	    {
	        	DestroyPickup(flag);
	    		format(string,sizeof(string)," [Game-Engine]: %s has picked up the flag.",pName);
	    		SendClientMessageToAll(blueviolet,string);
	   	 		SendClientMessage(playerid,white," Drop The flag at your base.");
				GotsTheFlag = playerid;
				SetPlayerColor(playerid,yellow);

		}
	}
	return 1;
}
public ChangeRound()
{
	    flag = CreatePickup(2914,22,-60.1534,20.4997,3.1094);// Flag 1
		FlagInfo[flagX] = -82.4229;
		FlagInfo[flagY] = -8.6836;
		FlagInfo[flagZ] = 2.1488;
		SendRconCommand("mapname CTF");
		for(new i = 0;i<MAX_PLAYERS;i++)
		{
			SetPlayerHealth(i,0.0);
		}
}
