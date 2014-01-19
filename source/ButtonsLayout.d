import std.conv;
import std.stdio;

import dsfml.graphics;
import AGSEvent;

class ButtonsLayout : Drawable,Transformable {
	mixin NormalTransformable;

	this(int nButtons, in string sText) {

		m_nButtons = nButtons;

		if(m_texActive is null)
		{
			m_texActive = new Texture;
			m_texActive.loadFromFile("res/ButtonActive.png");
			m_sprActive = new Sprite(m_texActive);
		}
		if(m_texInactive is null)
		{
			m_texInactive = new Texture;
			m_texInactive.loadFromFile("res/ButtonInactive.png");
			m_sprInactive = new Sprite(m_texInactive);
		}
		if(m_texBG is null)
		{
			m_texBG = new Texture;
			m_texBG.loadFromFile("res/ButtonBG.png");
			m_sprBG = new Sprite(m_texBG);
		}
		if(m_font is null)
		{
			m_font = new Font;
			m_font.loadFromFile("res/default.ttf");
		}

		m_txt = new Text(to!dstring(sText), m_font, 32);
		m_txt.setColor(Color(255,255,255));
		m_txt.origin(Vector2f(m_txt.getLocalBounds().width/2., m_txt.getLocalBounds().height/2.));
		m_txt.position(Vector2f(65,46));

		origin(Vector2f(65,51));

		
	}

	override void draw(RenderTarget renderTarget, RenderStates renderStates)// const
	{
		renderStates.transform *= getTransform();

		renderTarget.draw(m_sprBG, renderStates);

		Sprite spr;

		spr = (m_nButtons&AGSEvent.AGSEvent.ButA) ? m_sprActive : m_sprInactive;
		spr.position(Vector2f(0,10));
		renderTarget.draw(spr, renderStates);

		spr = (m_nButtons&AGSEvent.AGSEvent.ButB) ? m_sprActive : m_sprInactive;
		spr.position(Vector2f(40,0));
		renderTarget.draw(spr, renderStates);

		spr = (m_nButtons&AGSEvent.AGSEvent.ButC) ? m_sprActive : m_sprInactive;
		spr.position(Vector2f(80,5));
		renderTarget.draw(spr, renderStates);

		spr = (m_nButtons&AGSEvent.AGSEvent.ButD) ? m_sprActive : m_sprInactive;
		spr.position(Vector2f(0,52));
		renderTarget.draw(spr, renderStates);

		spr = (m_nButtons&AGSEvent.AGSEvent.ButE) ? m_sprActive : m_sprInactive;
		spr.position(Vector2f(40,42));
		renderTarget.draw(spr, renderStates);

		spr = (m_nButtons&AGSEvent.AGSEvent.ButF) ? m_sprActive : m_sprInactive;
		spr.position(Vector2f(80,47));
		renderTarget.draw(spr, renderStates);

		renderTarget.draw(m_txt, renderStates);

	}





private:
	static Texture m_texActive;
	static Sprite m_sprActive;
	static Texture m_texInactive;
	static Sprite m_sprInactive;
	static Texture m_texBG;
	static Sprite m_sprBG;

	static Font m_font;
	Text m_txt;

	int m_nButtons;
}