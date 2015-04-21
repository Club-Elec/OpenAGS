module inireader;

import std.stdio;
import std.file;
import std.regex;
import std.stream;
import std.conv;

public import std.string;

/**
	INI config file reader
*/
class INIReader
{
public:
	this(in string sPath, string[string][string] defValues=null)
	{
		m_sPath = sPath;

		if(defValues !is null)
			m_Data = defValues.dup;

		if(m_sPath!="")
			Parse();
	}

	@property{
		string path(){return m_sPath;}
	}

	/**
		Gets the value of the field
		Throws: if the value could not be retrieved
		Returns: "" if not found
	*/
	T Get(T)(string sHeader, string sName)
	{
		if(sHeader in m_Data && sName in m_Data[sHeader])
			return to!(T)(m_Data[sHeader][sName]);
		else
			throw new Exception("Value not found: "~sHeader~"."~sName);
	}

	void Set(T)(string sHeader, string sName, T value){
		m_Data[sHeader][sName] = to!string(value);
	}

	/**
		Prints the configuration entries, useful for debugging purposes
	*/
	override string toString()
	{
		string sRet;
		foreach(string section, entries ; m_Data)
		{
			sRet ~= "["~section~"]\n";

			foreach(string name, string value ; entries)
			{
				sRet ~= "\t"~name~"="~value~"\n";
			}
		}
		return sRet;
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
