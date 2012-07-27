package 
{
	import jp.akb7.concurrent.Callable;
	import jp.akb7.concurrent.Command;

	public class HighLoadCallableCommand extends Command implements Callable
	{
	    public function call():Object{
			trace("HighLoadCallableCommand.run() - start");
	        for (var i:int = 0; i < 1000; i++) 
	        {
	            var s:String = ""+i;
	        }
			trace("HighLoadCallableCommand.run() - end : " + s);
			
			return s;
		}
	}
}