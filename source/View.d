import AGSEvent;
import dsfml.graphics;

interface View
{
	static immutable int viewwidth=1024;
	static immutable int viewheight=768;

    void Render(ref RenderWindow win);

    void OnEvent(in AGSEvent e);
}
