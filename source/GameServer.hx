package ;
import haxe.io.BytesInput;
import neko.Lib;
import sys.net.Socket;

import neko.net.ThreadServer;
import haxe.io.Bytes;

import server.Client;
import server.Room;

/**
 * following this from: http://ludumdare.com/compo/2014/12/14/a-72h-mmo-game-from-theme-to-reality/
 * @author Samuel Bouchet (original)
 * 
 * Will be modifying it moving forward
 */

typedef Message = {
	var str : String;
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
	
	
	static var clientMap:Map<Int, Client>;
	static var roomMap:Map<Client,Room>;
	static var lobby:Room;
	static var clientNumber:Int = 0;
	static var roomNumber:Int = 0;
	
	static var server:GameServer;
	
	// create a Client
	override function clientConnected( s : Socket ) : Client
	{
		var client:Client = new Client( getNewClientId(), s );
		clientMap[client.id] = client;
		
		addClientToLobby(client);
		
		
		Lib.println("client " + client.id + " is " + s.peer());
		
		return client;
	}
	
	static function getNewClientId():Int
	{
		return ++clientNumber;
	}
	
	static function getNewRoomId():Int
	{
		return ++roomNumber;
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
		return { msg: { str: txt + " : " + x + ", " + y + ", " + txt + ":" + txtlen }, bytes: len };
		
	}

	override function clientMessage( c : Client, msg : Message )
	{
		Lib.println(c.id + " sent "+msg.str.length+" bytes  (" + msg.str+")");
	}
	
	
	private function addClientToLobby( c:Client ):Void
	{
		lobby.addClientToRoom( c );
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
		
		clientMap = new Map<Int, Client>();
		roomMap = new Map<Client,Room>();
		lobby = new Room( getNewRoomId() );
		lobby.id = -1;
		
		server = new GameServer();
		trace("Starting server...");
		server.run("localhost", 2000);
		
	}
	
}