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
				m_games ~= new Game(dir);
			}
		}
	}

	void Print()
	{
		foreach(ref Game g ; m_games)
			writeln("Game: "~g.GetName());
	}

private:
	Game[] m_games;


}
