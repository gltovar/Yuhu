package server;

/**
 * ...
 * @author 
 */
class Room
{
	public var id:Int;
	public var clientMap:Map<Int, Client>;
	
	public function new( p_id:Int ) 
	{
		id = p_id;
		clientMap = new Map<Int, Client>();
	}
	
	public function addClientToRoom( p_client:Client ):Void
	{
		clientMap[ p_client.id ] = p_client;
		sendMessageToAllClients("client: " + p_client.id + " as joined the room", p_client);
	}
	
	// null omit sender send it to sender
	private function sendMessageToAllClients( p_message:String, p_omitSender:Client = null ):Void
	{
		for ( l_client in clientMap )
		{
			if ( l_client != p_omitSender )
			{
				sendMessageToClient( l_client, p_message );
			}
		}
	}
	
	private function sendMessageToClient( p_client:Client, p_message:String ):Void
	{
		p_client.socket.output.writeString( p_message );
		p_client.socket.output.flush();
	}
	
	// new client joins
	
	// room closes
	
	// game start
	
}