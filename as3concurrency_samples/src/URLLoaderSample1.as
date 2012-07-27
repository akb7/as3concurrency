package 
{
    import flash.display.Sprite;
    import flash.net.URLRequest;
    import flash.utils.ByteArray;
    
    import jp.akb7.concurrent.URLLoader;
	
    public class URLLoaderSample1 extends Sprite{
        public function URLLoaderSample1(){
			var req:URLRequest = new URLRequest("test.txt");
            try{
			    var text:ByteArray = new URLLoader().load(req) as ByteArray;
                trace(text.readUTFBytes(text.bytesAvailable));
            } catch(e:Error){
                trace(e);
            }
        }
    }
}  