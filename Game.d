

import std.file;
import std.string;
import INIReader;

class Game
{
public:
	this(string sDirectory)
	{
		if(!exists(sDirectory))throw new Exception("Directory "~sDirectory~" does not exists");
		if(!exists(sDirectory~"/start.sh"))throw new Exception("File "~sDirectory~"/start.sh does not exists");
		if(!exists(sDirectory~"/game.ini"))throw new Exception("File "~sDirectory~"/start.sh does not exists");


		INIReader ini = new INIReader(sDirectory~"/game.ini");
		m_sName = init.Get("game", "name");
		m_bSavesEnabled = to!bool(init.Get("game", "savesenabled"));
		if(m_bSavesEnabled)
		{
			if(!exists(sDirectory~"/linksave.sh"))throw new Exception("File "~sDirectory~"/linksave.sh does not exists")
		}

		m_sGameType = init.Get("game", "gametype");
		m_sStartCmd = init.Get("game", "startcmd");
	}

	void Start()
	{

	}

	void LinkSaves(in string account)
	{

	}
	void UnlinkSaves()
	{

	}


private:
	string m_sDirectory;

	string m_sName;

}
