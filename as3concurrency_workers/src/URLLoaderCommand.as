package 
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.net.registerClassAlias;
	import flash.system.Worker;
	import flash.utils.ByteArray;
	
	import jp.akb7.concurrent.AsyncCallable;
	import jp.akb7.concurrent.Command;
	
	public class URLLoaderCommand extends Command implements AsyncCallable
	{	
		{
			registerClassAlias("flash.net.URLRequest",flash.net.URLRequest);
		}
		
		public function URLLoaderCommand(){
			super();   
		}
				  
		public function callAsync():void{
			
			var req:URLRequest = Worker.current.getSharedProperty("jp.akb7.concurrent.URLLoader.request") as URLRequest;
			if( req == null ){
				return;
			}
			var urlstream:URLStream = new URLStream();
			urlstream.addEventListener(Event.COMPLETE,urlstream_completeHandler);
			urlstream.addEventListener(SecurityErrorEvent.SECURITY_ERROR,urlstream_errorHandler);
			urlstream.addEventListener(IOErrorEvent.IO_ERROR,urlstream_errorHandler);
			urlstream.load(req);
		}
		
		protected function urlstream_completeHandler(event:Event):void
		{
			var ba:ByteArray = new ByteArray();
			var urlstream:URLStream = event.target as URLStream;
			urlstream.readBytes(ba,0,urlstream.bytesAvailable);
			setResult(ba);
		}
		
		protected function urlstream_errorHandler(event:Event):void
		{
			setResult(null);
		}
	}
}