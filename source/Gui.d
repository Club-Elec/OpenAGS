import std.stdio;
import std.conv;
import core.thread;

import dsfml.window;
import dsfml.graphics;
import View;
import Home;
import INIReader;
import AGSEvent;

class Gui {
	this() {
	    win = new RenderWindow(VideoMode(1024,768),"Hello DSFML!",Window.Style.None);
	    win.setVerticalSyncEnabled(true);

        Texture m_texBackground = new Texture;
	    m_texBackground.loadFromFile("res/background.jpg");
	    m_sprBackground = new Sprite(m_texBackground);
	    //m_sprBackground.setScale(Vector2f(10,10));
	    //m_sprBackground.textureRect(IntRect(0, 0,700,500));

	    //Create Views
	    m_viewHome = new Home;

        //Set m_currView as home screen
        m_currView = m_viewHome;

        INIReader ini = new INIReader("./bindings.ini");
        foreach(player ; ["Player1","Player2"])
        {
	        m_bindings[to!int(ini.Get(player, "up"))] = AGSEvent.AGSEvent.JoyUp;
	        m_bindings[to!int(ini.Get(player, "down"))] = AGSEvent.AGSEvent.JoyDown;
	        m_bindings[to!int(ini.Get(player, "left"))] = AGSEvent.AGSEvent.JoyLeft;
	        m_bindings[to!int(ini.Get(player, "right"))] = AGSEvent.AGSEvent.JoyRight;
	        m_bindings[to!int(ini.Get(player, "A"))] = AGSEvent.AGSEvent.ButA;
	        m_bindings[to!int(ini.Get(player, "B"))] = AGSEvent.AGSEvent.ButB;
	        m_bindings[to!int(ini.Get(player, "C"))] = AGSEvent.AGSEvent.ButC;
	        m_bindings[to!int(ini.Get(player, "D"))] = AGSEvent.AGSEvent.ButD;
	        m_bindings[to!int(ini.Get(player, "E"))] = AGSEvent.AGSEvent.ButE;
	        m_bindings[to!int(ini.Get(player, "F"))] = AGSEvent.AGSEvent.ButF;
        }
        m_bindings[to!int(ini.Get("Common", "start"))] = AGSEvent.AGSEvent.ButStart;
        m_bindings[to!int(ini.Get("Common", "stop"))] = AGSEvent.AGSEvent.ButStop;

	}





	void RenderLoop()
	{
	    while(true)
        {
            Event ev;
            while(win.pollEvent(ev))
            {
                if(ev.type == ev.EventType.KeyPressed)
                {
                	if(ev.key.code in m_bindings)
                    	m_currView.OnEvent(m_bindings[ev.key.code]);
                }
            }

            win.clear();

            //Render background
            win.draw(m_sprBackground);

            m_currView.Render(win);

            win.display();

            Thread.sleep(dur!("msecs")(15));
        }
	}

private:
	RenderWindow win;
	Sprite m_sprBackground;

	View m_currView;
	Home m_viewHome;

	AGSEvent[int] m_bindings;

}
