package ;
import haxe.io.BytesInput;
import neko.Lib;
import sys.net.Socket;

import neko.net.ThreadServer;
import haxe.io.Bytes;

/**
 * following this from: http://ludumdare.com/compo/2014/12/14/a-72h-mmo-game-from-theme-to-reality/
 * @author Samuel Bouchet (original)
 * 
 * Will be modifying it moving forward
 */
typedef Client = {
  var id : Int;
}

typedef Message = {
  var str : String;
}

typedef Room = {
	var id:Int;
	var users:Array<Int>;
}

typedef Game = {
	var room:Int;
	var deck:Array<Card>;
}

typedef Card = {
	var color:Int;
	var number:Int;
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
	
	
	private function addClientToLobby( c:Client ):Void
	{
		
	}
	
	private function clientChatToLobby( c:Client ):Void
	{
		
	}
	
	private function clientCreateRoom( e:Client ):Void
	{
		
	}
	
	private function clientJoinRoom( e:Client ):Void
	{
		
	}
	
	private function clientHostStartGame( e:Client ):Void
	{
		
	}

	static function main() {
		
		var server = new GameServer();
		trace("Starting server...");
		server.run("localhost", 2000);
		
	}
	
}