package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import openfl.events.Event;
import openfl.events.ProgressEvent;
import openfl.net.Socket;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	
	private var socket:Socket;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		initNetwork();
		
	}
	
	private function initNetwork():Void
	{
		socket = new Socket();
		socket.addEventListener(Event.CONNECT, onSocketConnect);
		socket.addEventListener(Event.CLOSE, onSocketClose);
		socket.addEventListener(ProgressEvent.SOCKET_DATA, onReceiveSocketData);
		
		socket.connect("localhost", 2000);
	}
	
	private function onSocketConnect( e:Event = null ):Void
	{
		trace("socket connected");
	}
	
	private function onSocketClose( e:Event = null ):Void
	{
		trace("socket disconnected");
	}
	
	private function onReceiveSocketData( e:ProgressEvent ):Void
	{
		var message:String = socket.readUTFBytes( socket.bytesAvailable );
		trace( "Received: " + message );
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}	
}