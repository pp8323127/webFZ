package eg.zcrpt.telnet;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.net.Socket;

public class CommandClient extends Thread {

	/**
	 * @param args
	 */
	Socket socket;
    BufferedReaderr in; 
    BufferedReaderr stdin;
    PrintStream out;
	 
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

	   
    public CommandClient(Socket s) throws Exception {
        socket = s;
        in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
        out = new PrintStream(socket.getOutputStream());
        stdin = new BufferedReader(new InputStreamReader(System.in));
    }
 
    public void run() {
	      try {
	        System.out.println("Accept from : " + socket.getInetAddress());
	         while (true) {
	             String path = in.readLine();        // read path from server
	             System.out.print(socket.getInetAddress()+" $ "+path+">");
	             String cmd = stdin.readLine();        // read command from console
	             out.println(cmd);                    // send command to server
	             while (true) {                        // read output of command from server
	                 String line = in.readLine();
	                 if (line.equals(Telnet.endMsg))
	                     break;
	                 System.out.println(line);
	             }
	        }
	      } catch (Exception e) { e.printStackTrace(); }
	    }
	}
}
