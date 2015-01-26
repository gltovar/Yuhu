package server;
import sys.net.Socket;

/**
 * ...
 * @author 
 */
class Client
{
	public var id:Int;
	public var socket:Socket;
	
	public function new( p_id:Int, p_socket:Socket ) 
	{
		id = p_id;
		socket = p_socket;
	}
	
}