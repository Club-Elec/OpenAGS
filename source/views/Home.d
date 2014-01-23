import std.stdio;
import std.conv;

import AGSEvent;
import View;
import dsfml.graphics;
import GameList;
import AlignedText;
import ButtonsLayout;

class Home : View {
	this() {
		m_gl = new GameList("./games");
		m_games = m_gl.GetGames();
		m_nGameIndex = 0;

		m_fontTitle = new Font;
		m_fontTitle.loadFromFile("res/title.ttf");
		m_fontText = new Font;
		m_fontText.loadFromFile("res/default.ttf");
		m_texArrow = new Texture;
		m_texArrow.loadFromFile("res/ArrowActive.png");

		m_sprArrow[0] = new Sprite(m_texArrow);
		m_sprArrow[0].origin(Vector2f(20,10));
		m_sprArrow[0].position(Vector2f(viewwidth-50,55));
		m_sprArrow[1] = new Sprite(m_texArrow);
		m_sprArrow[1].origin(Vector2f(20,10));
		m_sprArrow[1].rotation(180);
		m_sprArrow[1].position(Vector2f(viewwidth-50,80));

		m_gamename[0] = new AlignedText(" ", m_fontTitle, 30);
		m_gamename[0].setColor(Color(64,64,64));
		m_gamename[0].alignment(AlignedText.AlignedText.Alignment.right);
		m_gamename[0].position(Vector2f(viewwidth-50,25));
		m_gamename[1] = new AlignedText(" ", m_fontTitle, 45);
		m_gamename[1].setColor(Color(0,0,0));
		m_gamename[1].alignment(AlignedText.AlignedText.Alignment.center);
		m_gamename[1].position(Vector2f(viewwidth/2,60));
		m_gamename[2] = new AlignedText(" ", m_fontTitle, 30);
		m_gamename[2].setColor(Color(64,64,64));
		m_gamename[2].alignment(AlignedText.AlignedText.Alignment.right);
		m_gamename[2].position(Vector2f(viewwidth-50,105));

		UpdateGameNames();


		m_blPlay = new ButtonsLayout(AGSEvent.AGSEvent.ButA, "Jouer");
		m_blPlay.position(Vector2f(800/2,600-100));
	}

	override void OnEvent(in AGSEvent e)
	{
		if(e == AGSEvent.AGSEvent.JoyUp)
		{
			if(m_nGameIndex>0)
				m_nGameIndex--;
			UpdateGameNames();
		}
		else if(e == AGSEvent.AGSEvent.JoyDown)
		{
			if(m_nGameIndex+1<m_games.length)
				m_nGameIndex++;
			UpdateGameNames();
		}
		else if(e == AGSEvent.AGSEvent.ButA)
		{
			m_games[m_nGameIndex].Start();
		}
	}

	override void Render(ref RenderWindow win)
	{
		foreach(ref gamename ; m_gamename)
			win.draw(gamename);
		
		if(m_nGameIndex>0)
			win.draw(m_sprArrow[0]);
		if(m_nGameIndex<m_games.length-1)
			win.draw(m_sprArrow[1]);

		win.draw(m_blPlay);

	}

private:
	void UpdateGameNames()
	{
		if(m_nGameIndex>=1)
			m_gamename[0].setString(to!dstring(m_games[m_nGameIndex-1].GetName()));
		else
			m_gamename[0].setString(" ");

		m_gamename[1].setString(to!dstring(m_games[m_nGameIndex].GetName()));

		if(m_nGameIndex<=m_games.length-2)
			m_gamename[2].setString(to!dstring(m_games[m_nGameIndex+1].GetName()));
		else
			m_gamename[2].setString(" ");
	}

	Font m_fontTitle, m_fontText;
	AlignedText m_gamename[3];
	ButtonsLayout m_blPlay;
	Texture m_texArrow;
	Sprite m_sprArrow[2];

	GameList m_gl;
	Game[] m_games;

	size_t m_nGameIndex;


}