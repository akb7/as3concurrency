/*******************************************************************************************************************************************
 * This is an automatically generated class. Please do not modify it since your changes may be lost in the following circumstances:
 *     - Members will be added to this class whenever an embedded worker is added.
 *     - Members in this class will be renamed when a worker is renamed or moved to a different package.
 *     - Members in this class will be removed when a worker is deleted.
 *******************************************************************************************************************************************/

package 
{
    
    import flash.utils.ByteArray;
    
    public class Workers
    {
        
        [Embed(source="../workerswfs/ResidentCommand1.swf", mimeType="application/octet-stream")]
        private static var ResidentCommand1_ByteClass:Class;
        
        [Embed(source="../workerswfs/HighLoadCommand.swf", mimeType="application/octet-stream")]
        private static var HighLoadCommand_ByteClass:Class;
        
        [Embed(source="../workerswfs/ResidentCommand2.swf", mimeType="application/octet-stream")]
        private static var ResidentCommand2_ByteClass:Class;
        
        [Embed(source="../workerswfs/HighLoadCallableCommand.swf", mimeType="application/octet-stream")]
        private static var HighLoadCallableCommand_ByteClass:Class;
        
        [Embed(source="../workerswfs/ThrowErrorCommand.swf", mimeType="application/octet-stream")]
        private static var ThrowErrorCommand_ByteClass:Class;
        
        [Embed(source="../workerswfs/ThrowErrorCallableCommand.swf", mimeType="application/octet-stream")]
        private static var ThrowErrorCallableCommand_ByteClass:Class;
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        public static function get ResidentCommand1():ByteArray
        {
            return new ResidentCommand1_ByteClass();
        }
        
        
        
        
        
        public static function get HighLoadCommand():ByteArray
        {
            return new HighLoadCommand_ByteClass();
        }
        
        public static function get ResidentCommand2():ByteArray
        {
            return new ResidentCommand2_ByteClass();
        }
        
        public static function get HighLoadCallableCommand():ByteArray
        {
            return new HighLoadCallableCommand_ByteClass();
        }
        
        public static function get ThrowErrorCommand():ByteArray
        {
            return new ThrowErrorCommand_ByteClass();
        }
        
        public static function get ThrowErrorCallableCommand():ByteArray
        {
            return new ThrowErrorCallableCommand_ByteClass();
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
}
