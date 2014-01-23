import AGSEvent;
import dsfml.graphics;

interface View
{
	static immutable int viewwidth=800;
	static immutable int viewheight=600;

    void Render(ref RenderWindow win);

    void OnEvent(in AGSEvent e);
}
