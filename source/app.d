module main;

import std.stdio;
import std.file;
import std.string;

import GameList;
import GameDB;
import Gui;

int main(string[] args)
{

	//Test if user is valid
	/*GameDB db = new GameDB();
	string username="toto", password="titi";
	if(db.addUser(username, password)){
		writeln("User successfully created !");
	}
	if(db.isPasswordValid(username, password)){
		writeln("Connected !");
	}
	if(db.removeUser(username)){
		writeln("User removed successfully !");
	}*/

    Gui gui = new Gui;
    gui.RenderLoop();

	return 0;
}
