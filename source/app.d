module main;

import std.stdio;
import std.file;
import std.string;

import GameList;
import GameDB;

int main(string[] args)
{
	GameList g = new GameList("./games");
	g.Print();

	g.GetGames()[0].Start();

	//Test if user is valid
	GameDB db = new GameDB();
	string username="test", password="pwd";
	if(db.isPasswordValid(username, password)){
		writeln("Connected !");
	}


	//link user saves
	g.GetGames()[0].LinkSaves(username);
	g.GetGames()[0].UnlinkSaves();
	return 0;
}
