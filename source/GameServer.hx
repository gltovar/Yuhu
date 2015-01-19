package ;
import haxe.io.BytesInput;
import neko.Lib;
import sys.net.Socket;

import neko.net.ThreadServer;
import haxe.io.Bytes;

/**
 * ...
 * @author Samuel Bouchet
 */
typedef Client = {
  var id : Int;
}

typedef Message = {
  var str : String;
}

class GameServer extends ThreadServer<Client, Message>
{
	function new() { super(); }
	
	static var clientNumber:Int = 0;
	
	// create a Client
	override function clientConnected( s : Socket ) : Client
	{
		var num = clientNumber++;
		Lib.println("client " + num + " is " + s.peer());
		s.output.writeString("Roger");
		s.output.flush();
		return { id: num };
	}

	override function clientDisconnected( c : Client )
	{
		Lib.println("client " + Std.string(c.id) + " disconnected");
	}

	override function readClientMessage(c:Client, buf:Bytes, pos:Int, len:Int)
	{
		var bytesIn:BytesInput = new BytesInput(buf, pos, len);
		
		// got a full message, return it
		var x:Int = bytesIn.readInt16();
		var y:Int = bytesIn.readInt16();
		var txtlen:Int = bytesIn.readInt8();
		var txt:String = bytesIn.readString(txtlen);
		
		//Lib.println(buf.getString(pos, cpos-pos));
		
		//var end:Int = bytesIn.readByte();
		return {msg: {str: txt + " : "+x+", "+y+", "+txt+":"+txtlen}, bytes: len};
	}

	override function clientMessage( c : Client, msg : Message )
	{
		Lib.println(c.id + " sent "+msg.str.length+" bytes  (" + msg.str+")");
	}

	static function main() {
		
		var server = new GameServer();
		trace("Starting server...");
		server.run("localhost", 2000);
		
	}
	
}