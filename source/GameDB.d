
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
        auto s = conn.exec("SELECT password FROM userlist WHERE username='"~username~"';");

        return(password==s[0][0].as!PGtext);

    }

    bool addUser(string username, string password){

        try{
            // Text query result
            conn.exec("INSERT INTO userlist(username, password) VALUES ('"~username~"', '"~password~"');");
        }
        catch(Exception e) {
            return false;
        }

        return true;
    }

    bool removeUser(string username){
        try{
            // Text query result
            conn.exec("DELETE FROM userlist WHERE username='"~username~"';");
        }
        catch(Exception e) {
            return false;
        }

        return true;
    }
        
private:
    Connection conn;
}
