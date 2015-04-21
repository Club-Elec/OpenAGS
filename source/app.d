module main;

import gtk.Main;
import gtk.Widget;
import gdk.Event;
import gtk.Builder;
import gtk.CssProvider;
import gtk.StyleContext;
import gio.Vfs;
import gdk.Display;

import std.stdio;
import std.file;
import std.string;
import std.conv : to;

import GameList;
import AgsEvent;
import inireader;

int main(string[] args)
{
	Main.init(args);

	auto gameList = new GameList("games");
	size_t gameIndex = 0;
	writeln(gameList.games.length);

	//Override default CSS
	auto css = new CssProvider;
	css.loadFromFile(Vfs.getDefault.getFileForPath("res/app.css"));
	StyleContext.addProviderForScreen(Display.getDefault.getDefaultScreen, css, 10);

	//Build windows with glade template
	auto b = new Builder("res/ui.glade");
	auto win = (cast(Widget)b.getObject("win"));

	//Loading bindings
	AGSEvent[int] bindings;
	INIReader bindingsini = new INIReader("./bindings.ini");
    foreach(player ; ["Player1","Player2"])
    {
        bindings[bindingsini.Get!int(player, "up")] = AGSEvent.JoyUp;
        bindings[bindingsini.Get!int(player, "down")] = AGSEvent.JoyDown;
        bindings[bindingsini.Get!int(player, "left")] = AGSEvent.JoyLeft;
        bindings[bindingsini.Get!int(player, "right")] = AGSEvent.JoyRight;
        bindings[bindingsini.Get!int(player, "A")] = AGSEvent.ButA;
        bindings[bindingsini.Get!int(player, "B")] = AGSEvent.ButB;
        bindings[bindingsini.Get!int(player, "C")] = AGSEvent.ButC;
        bindings[bindingsini.Get!int(player, "D")] = AGSEvent.ButD;
        bindings[bindingsini.Get!int(player, "E")] = AGSEvent.ButE;
        bindings[bindingsini.Get!int(player, "F")] = AGSEvent.ButF;
    }
    bindings[bindingsini.Get!int("Common", "start")] = AGSEvent.ButStart;
    bindings[bindingsini.Get!int("Common", "stop")] = AGSEvent.ButStop;

    //Update game info (titles, description)
    void UpdateGameInfo(){
    	import gtk.Label;
    	auto game = gameList.games[gameIndex];
    	(cast(Label)b.getObject("game")).setText(game.GetName);
    	(cast(Label)b.getObject("gamePrev")).setText(
    		gameIndex>0? gameList.games[gameIndex-1].GetName : ""
    	);
    	(cast(Label)b.getObject("gameNext")).setText(
    		gameIndex<gameList.games.length-1? gameList.games[gameIndex+1].GetName : ""
    	);
    	(cast(Label)b.getObject("gameDesc")).setText(
    		"Type: "~game.GetGameType~"\n"~
    		"Joueurs: "~game.GetPlayers~"\n"~
    		game.GetDescription
    	);
    }
	UpdateGameInfo();

    //Handle key press
	win.addOnKeyPress(delegate(Event e, Widget w){
		if(e.getEventType == EventType.KEY_PRESS){
			ushort key;
			e.getKeycode(key);
			writeln("Key pressed: ", key);
			if(key in bindings){
				switch(bindings[key]){
					case AGSEvent.JoyUp:
						if(gameIndex>0)gameIndex--;
						UpdateGameInfo();
						break;
					case AGSEvent.JoyDown:
						if(gameIndex<gameList.games.length-1)gameIndex++;
						UpdateGameInfo();
						break;
					case AGSEvent.ButStart:
						gameList.games[gameIndex].Start();
						break;
					default:
						break;
				}
			}

		}
		return true;
	});



	win.showAll();
	Main.run();
	return 0;
}
