package
{
    import flash.filesystem.File;
    import flash.utils.ByteArray;
    
    import jp.akb7.concurrent.FileLoader;
    import jp.akb7.core.MainSprite;
    
    public class FileLoaderTest1 extends MainSprite
    {
        public function main():void
        {
            try {
				var fileLoader:FileLoader = new FileLoader();
				var path:String = File.applicationDirectory.resolvePath("tests.txt").nativePath;
                var text:ByteArray=fileLoader.load(path) as ByteArray;
                trace(text.readUTFBytes(text.bytesAvailable));
            } catch(e:Error) {
                trace(e); 
            }
        }
    }
}