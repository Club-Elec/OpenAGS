
import dpq2.all;
import std.stdio: writeln;

class GameDB 
{
public:
    this()
    {
        conn = new Connection();
        conn.connString = "host=localhost port=5432 dbname=openags user=postgres password=postgres";
        conn.connect();
    }

    bool isPasswordValid(string username, string password){

        // Text query result
        auto s = conn.exec("SELECT password FROM userlist WHERE username='"~username~"'");

        writeln("[DBG] pwd : "~s[0][0].as!PGtext~"vs"~password);
        return(password==s[0][0].as!PGtext);

    }
        
private:
    Connection conn;
}
