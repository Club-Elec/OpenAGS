import Game;
import std.stdio;
import std.file;

class GameList
{
public:
	this(string sGamesDir)
	{
		foreach(ref DirEntry dir ; dirEntries(sGamesDir, SpanMode.shallow))
		{
			if(dir.isDir())
			{
				try
				{
					m_games ~= new Game(dir);
				}
				catch(Exception e)
				{
					writeln("/!\\ Warning: Ignoring folder "~dir.name~" because: ",e);
				}

			}
		}

		m_games.sort;
	}

	ref Game[] GetGames()
	{
		return m_games;
	}

	void Print()
	{
		foreach(ref Game g ; m_games)
			writeln("Game: "~g.GetName());
	}

private:
	Game[] m_games;


}
