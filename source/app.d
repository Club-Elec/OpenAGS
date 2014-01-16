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

	//g.GetGames()[0].Start();

	//Test if user is valid
	GameDB db = new GameDB();
	string username="toto", password="titi";
	if(db.addUser(username, password)){
		writeln("User successfully created !");
	}
	if(db.isPasswordValid(username, password)){
		writeln("Connected !");
	}
	if(db.removeUser(username)){
		writeln("User removed successfully !");
	}


	//link user saves
	g.GetGames()[0].LinkSaves(username);
	g.GetGames()[0].UnlinkSaves();
	return 0;
}
