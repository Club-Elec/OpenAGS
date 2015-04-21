import Game;
import std.stdio;
import std.file;
import std.algorithm;

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
					games ~= new Game(dir);
				}
				catch(Exception e)
				{
					writeln("/!\\ Warning: Ignoring folder "~dir.name~" because: ",e);
				}

			}
		}

		sort(games);
	}

	Game[] games;

	void Print()
	{
		foreach(ref Game g ; games)
			writeln("Game: "~g.GetName());
	}

private:
	


}
