import AGSEvent;
import dsfml.graphics;

interface View
{
    void Render(ref RenderWindow win);

    void OnEvent(in AGSEvent e);
}
