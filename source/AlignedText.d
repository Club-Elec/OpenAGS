import std.conv;
import dsfml.graphics;

class AlignedText : Text 
{
	this(){
		super();
	}

	this(dstring text, const(Font) font, uint characterSize = 30){
		super(text, font, characterSize);
	}


	enum Alignment{
		left, right, center
	}

	@property
	{
		Alignment alignment(){
			return m_alignment;
		}
		void alignment(Alignment a){
			m_alignment = a;
		}
	}


	override void setString(dstring text)
	{
		super.setString(text);
		Align();
	}


private:
	void Align()
	{
		switch(m_alignment)
		{
			case Alignment.right:
				origin(Vector2f(getLocalBounds().width, to!int(getLocalBounds().height/2)));
				break;
			case Alignment.center: default:
				origin(Vector2f(to!int(getLocalBounds().width/2), to!int(getLocalBounds().height/2)));
				break;
			case Alignment.left:
				origin(Vector2f(0, to!int(getLocalBounds().height/2)));
				break;

		}
	}

	Alignment m_alignment=Alignment.center;

}