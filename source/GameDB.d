
import dpq2.all;
import std.stdio: writeln;

class GameDB 
{
public:
    this()
    {
        conn = new Connection();
        conn.connString = "host=localhost port=5432 dbname=postgres user=postgres password=******";
        conn.connect();
    }

    bool isPasswordValid(string user, string password){

        // Text query result
        auto s = conn.exec("SELECT password WHERE user="~user);
      
        return(password==s[0][0]);

    }
        
private:
    Connection conn;
}
