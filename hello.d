module main;

import std.stdio;
import std.file;
import std.string;

import GameList;

int main(string[] args)
{
	GameList g = new GameList("./games");
	g.Print();
	return 0;
}
