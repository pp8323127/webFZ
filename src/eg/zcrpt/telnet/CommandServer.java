package eg.zcrpt.telnet;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.net.Socket;

public class CommandServer extends Thread {

	/**
	 * @param args
	 */
	Socket socket;
    BufferedReader in;
    PrintStream out;
    Command command;
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

	    
	 
    public CommandServer(Socket s) throws Exception {
        socket = s;
        in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
        out = new PrintStream(socket.getOutputStream());
        command = new Command();
    }
 
	public void run() {
	      try {
	         while (true) {
	             out.println(command.getPath());     // set path to client
	            out.flush();
	             String cmd = in.readLine();            // read command from client
	             System.out.println(socket.getInetAddress()+" $ "+cmd);
	             String rzMsg = command.exec(cmd);    // execute command
	             out.print(rzMsg);
	            out.println(Telnet.endMsg);            // ¿é¥Xµ²§ô°T®§
	            out.flush();
	        }
	      } catch (Exception e) { e.printStackTrace(); }
	    }
	}
}
