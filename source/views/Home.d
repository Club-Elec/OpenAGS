import std.stdio;
import std.conv;

import AGSEvent;
import View;
import dsfml.graphics;
import GameList;
import ButtonsLayout;

class Home : View {
	this() {
		m_gl = new GameList("./games");
		m_games = m_gl.GetGames();
		m_nGameIndex = 0;

		m_font = new Font;
		m_font.loadFromFile("res/title.ttf");
		m_gamename = new Text(to!dstring(m_games[m_nGameIndex].GetName()), m_font, 60);
		m_gamename.setColor(Color(0,0,0));
		m_gamename.position(Vector2f(70,20));

		m_blPlay = new ButtonsLayout(
			AGSEvent.AGSEvent.ButA
			, "Jouer");
		m_blPlay.position(Vector2f(800/2,600-100));
	}

	override void OnEvent(in AGSEvent e)
	{
		if(e == AGSEvent.AGSEvent.JoyUp)
		{
			if(m_nGameIndex>0)
				m_nGameIndex--;

			m_gamename.setString(to!dstring(m_games[m_nGameIndex].GetName()));
		}
		else if(e == AGSEvent.AGSEvent.JoyDown)
		{
			if(m_nGameIndex+1<m_games.length)
				m_nGameIndex++;

			m_gamename.setString(to!dstring(m_games[m_nGameIndex].GetName()));
		}
		else if(e == AGSEvent.AGSEvent.ButA)
		{
			m_games[m_nGameIndex].Start();
		}
	}

	override void Render(ref RenderWindow win)
	{
		win.draw(m_gamename);
		win.draw(m_blPlay);

	}

private:
	Font m_font;
	Text m_gamename;
	ButtonsLayout m_blPlay;

	GameList m_gl;
	Game[] m_games;

	size_t m_nGameIndex;


}