

import std.file;
import std.string;
import std.conv;
import INIReader;

class Game
{
public:
	this(string sDirectory)
	{
		if(!exists(sDirectory))throw new Exception("Directory "~sDirectory~" does not exists");
		if(!exists(sDirectory~"/start.sh"))throw new Exception("File "~sDirectory~"/start.sh does not exists");
		if(!exists(sDirectory~"/game.ini"))throw new Exception("File "~sDirectory~"/game.ini does not exists");
		if(!exists(sDirectory~"/description.txt"))throw new Exception("File "~sDirectory~"/description.txt does not exists");


		INIReader ini = new INIReader(sDirectory~"/game.ini");
		m_sName = ini.Get("game", "name");
		m_bSavesEnabled = to!bool(ini.Get("game", "savesenabled"));
		if(m_bSavesEnabled)
		{
			if(!exists(sDirectory~"/linksave.sh"))throw new Exception("File "~sDirectory~"/linksave.sh does not exists");
		}

		m_sGameType = ini.Get("game", "gametype");
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

	string GetName()
	{
		return m_sName;
	}
	string GetGameType()
	{
		return m_sGameType;
	}
	string GetDescription()
	{
		return "";
	}


private:
	string m_sDirectory;

	string m_sName;
	bool m_bSavesEnabled;
	string m_sGameType;
}
