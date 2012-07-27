package jp.akb7.concurrent
{
	public interface Future
	{
		//function cancel(mayInterruptIfRunning:Boolean):Boolean; 
		
		function getResult(timeout:Number=-1):Object; 
		function getResultAsync():void; 

		//function isCancelled():Boolean; 

		//function isDone():Boolean;
	}
}