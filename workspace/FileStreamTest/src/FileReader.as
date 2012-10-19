package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.registerClassAlias;
	import flash.system.MessageChannel;
	import flash.system.System;
	import flash.system.Worker;
	import flash.utils.ByteArray;

	public class FileReader extends Sprite
	{
		public function FileReader()
		{
			var path:String = Worker.current.getSharedProperty("path") as String;
			var channel:MessageChannel = Worker.current.getSharedProperty("channel") as MessageChannel;
			
			
			var fs:FileStream = new FileStream();
			fs.open(new File(path),FileMode.READ);
			
			var ba:ByteArray = new ByteArray();
			fs.readBytes(ba,0,fs.bytesAvailable);
			fs.close();
			
			
			channel.send(ba);
			
			//System.exit(1);
			
			
			//fs.addEventListener(Event.OPEN,fs_openHandler);
		}
	}
}