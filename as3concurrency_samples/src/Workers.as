package    
{
	import flash.utils.ByteArray;
	
	public class Workers
	{
		[Embed(source="../bin-debug/HighLoadCallableCommand.swf", mimeType="application/octet-stream")]
		private static var HighLoadCallableCommand_ByteClass:Class;
		
		[Embed(source="../bin-debug/HighLoadCommand.swf", mimeType="application/octet-stream")]
		private static var HighLoadCommand_ByteClass:Class;
		
		public static function get HighLoadCallableCommand():ByteArray
		{
			return new HighLoadCallableCommand_ByteClass();
		}
		
		public static function get HighLoadCommand():ByteArray
		{
			return new HighLoadCommand_ByteClass();
		}
	} 
}