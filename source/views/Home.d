import std.stdio;

import AGSEvent;
import View;
import dsfml.graphics;
import GameList;

class Home : View {
	this() {
		m_gl = new GameList("./games");
		m_games = m_gl.GetGames();
		m_nGameIndex = 0;

		m_font = new Font;
		m_font.loadFromFile("res/title.ttf");
		m_gamename = new Text("GG HF GL WP", m_font, 60);
		m_gamename.setColor(Color(0,0,0));
		m_gamename.position(Vector2f(70,20));
	}

	override void OnEvent(in AGSEvent e)
	{
		writeln("Event received: ",e);
		//if(e == AGSEvent.JoyUp)
		//{
		//	m_nGameIndex--;
		//	if(m_nGameIndex<0)
		//		m_nGameIndex=0;
		//}
	}

	override void Render(ref RenderWindow win)
	{
		win.draw(m_gamename);
	}

private:
	Font m_font;
	Text m_gamename;

	GameList m_gl;
	Game[] m_games;

	int m_nGameIndex;


}