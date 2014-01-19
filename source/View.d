import Event;

interface View
{
    void Render();

    void OnEvent(in Event e);
}
