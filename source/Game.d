

import std.stdio;
import std.file;
import std.string;
import std.conv;
import std.process;
import inireader;

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
		m_sName = ini.Get!string("game", "name");
		m_bSavesEnabled = to!bool(ini.Get!string("game", "savesenabled"));
		if(m_bSavesEnabled)
		{ 
			if(!exists(m_sDirectory~"/linksaves.sh"))throw new Exception("File "~m_sDirectory~"/linksaves.sh does not exists");
		}

		m_sDescription = readText(m_sDirectory~"/description.txt");

		m_sGameType = ini.Get!string("game", "gametype");

		m_sPlayers = ini.Get!string("game", "players");
	}

	void Start()
	{
		writeln("Starting ",m_sName);
		executeShell("cd "~m_sDirectory~" && "~"./start.sh");
	}

	/**
	@brief Create symlinks to use the account's saves
	**/
	void LinkSaves(in string sAccount)
	{
		executeShell(m_sDirectory~"/linksaves.sh "~sAccount);
	}

	/**
	@brief Deletes the link to the account saves
	**/
	void UnlinkSaves()
	{
		executeShell(m_sDirectory~"/linksaves.sh public");
	}

	string GetName()const
	{
		return m_sName;
	}
	string GetGameType()const
	{
		return m_sGameType;
	}
	string GetDescription() const
	{
		return m_sDescription;
	}
	string GetPlayers() const
	{
		return m_sPlayers;
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
	string m_sDescription;
	string m_sPlayers;
	bool m_bSavesEnabled;
	string m_sGameType;
}
