
import dsfml.window;
import dsfml.graphics;
//import View;

class Gui {
	this() {
	    win = new RenderWindow(VideoMode(800,600),"Hello DSFML!",Window.Style.None);
	    win.setVerticalSyncEnabled(true);

        Texture m_texBackground = new Texture;
	    m_texBackground.loadFromFile("res/background.jpg");
	    m_sprBackground = new Sprite(m_texBackground);
	    //m_sprBackground.setScale(Vector2f(10,10));
	    //m_sprBackground.textureRect(IntRect(0, 0,700,500));

        //Set m_currView as home screen
	}





	void RenderLoop()
	{
	    while(true)
        {
//            Event event;
//            while(win.pollEvent(event))
//            {
//                if(event.type == event.EventType.Closed)
//                {
//                    //do nothing
//                }
//            }

            win.clear();

            //Render background
            win.draw(m_sprBackground);

            //m_currView.Render();

            win.display();


        }
	}

private:
	RenderWindow win;
	Sprite m_sprBackground;
	View m_currView;

}
