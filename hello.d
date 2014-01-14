module main;

import std.stdio;
import std.file;
import std.string;

import GameList;

int main(string[] args)
{
	GameList g = new GameList("./games");
	g.Print();

	g.GetGames()[0].Start();
	g.GetGames()[0].LinkSaves("toto");
	g.GetGames()[0].UnlinkSaves();
	return 0;
}
