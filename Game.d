

import std.stdio;
import std.file;
import std.string;
import std.conv;
import std.process;
import INIReader;

class Game
{
public:
	this(in string sDirectory)
	{
		m_sDirectory = sDirectory;

		if(!exists(m_sDirectory))throw new Exception("Directory "~m_sDirectory~" does not exists");
		if(!exists(m_sDirectory~"/start.sh"))throw new Exception("File "~m_sDirectory~"/start.sh does not exists");
		if(!exists(m_sDirectory~"/game.ini"))throw new Exception("File "~m_sDirectory~"/game.ini does not exists");
		if(!exists(m_sDirectory~"/description.txt"))throw new Exception("File "~m_sDirectory~"/description.txt does not exists");


		INIReader ini = new INIReader(m_sDirectory~"/game.ini");
		m_sName = ini.Get("game", "name");
		m_bSavesEnabled = to!bool(ini.Get("game", "savesenabled"));
		if(m_bSavesEnabled)
		{
			if(!exists(m_sDirectory~"/linksaves.sh"))throw new Exception("File "~m_sDirectory~"/linksaves.sh does not exists");
		}

		m_sGameType = ini.Get("game", "gametype");
	}

	void Start()
	{
		system(m_sDirectory~"/start.sh");
	}

	/**
	@brief Create symlinks to use the account's saves
	**/
	void LinkSaves(in string sAccount)
	{
		system(m_sDirectory~"/linksaves.sh link "~sAccount);
	}

	/**
	@brief Deletes the link to the account saves
	**/
	void UnlinkSaves()
	{
		system(m_sDirectory~"/linksaves.sh unlink");
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

	/**
	@brief Compare the game names
	**/
	override int opCmp(Object o)
	{
		Game g = cast(Game) o;
		if(this.m_sName>g.m_sName)return 1;
		else if(this.m_sName<g.m_sName)return -1;
		return 0;
	}


private:
	string m_sDirectory;

	string m_sName;
	bool m_bSavesEnabled;
	string m_sGameType;
}
