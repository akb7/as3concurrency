package jp.akb7.concurrent 
{
	import flash.utils.ByteArray;
	
	public class Workers
	{
		[Embed(source="./workers/URLLoaderCommand.swf", mimeType="application/octet-stream")]
		private static var URLLoaderCommand_ByteClass:Class;

		public static function get URLLoaderCommand():ByteArray
		{
			return new URLLoaderCommand_ByteClass();
		} 
	} 
} 