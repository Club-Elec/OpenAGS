import std.stdio;
import std.file;
import std.string;
import std.regex;
import std.stream;


class INIReader
{
public:
	this(string sPath)
	{
		m_sPath = sPath;
		Parse();
	}

	string GetPath(){return m_sPath;}

	string Get(string sHeader, string sName)
	{
		return m_Data[sHeader][sName];
	}

	void Print()
	{
		foreach(string section, entries ; m_Data)
		{
			writeln("[",section,"]");

			foreach(string name, string value ; entries)
			{
				writeln("\t",name,"=",value);
			}
		}
	}

private:
	static rgxEntry = regex(r"^(?=[^;^#])([\s]*)(.+)=(.*)$");
	static rgxHeader = regex(r"^\[(.+)\]$");
	void Parse()
	{
		Stream file = new BufferedFile(m_sPath);


		string sCurrentHeader = "";
		while(!file.eof())
		{
			string sLine = file.readLine().idup;

			auto results = match(sLine, rgxEntry);
			if(results)
			{//Entry
				string sName = results.captures[2];
				string sValue = results.captures[3];

				m_Data[sCurrentHeader][sName] = sValue;
				continue;
			}

			results = match(sLine, rgxHeader);
			if(results)
			{//Header
				string sName = results.captures[1];
				sCurrentHeader = sName;
				continue;
			}
		}

		file.close();
	}

	string m_sPath;
	string[string][string] m_Data;
}
