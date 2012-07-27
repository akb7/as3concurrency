package jp.akb7.concurrent 
{
	import flash.net.URLRequest;
	import flash.net.registerClassAlias;
	import flash.system.Worker;
	import flash.utils.ByteArray;

	public class URLLoader extends FutureTask
	{	
		private var _req:URLRequest;
		
		{
			registerClassAlias("flash.net.URLRequest",flash.net.URLRequest);
		}
		
		public function URLLoader(){
			super(Workers.URLLoaderCommand);
		}
		
		public function load(req:URLRequest,timeout:Number=-1):Object{
			_req = req;
 			var result:Object = getResult(timeout);
			return result;
		}
		
		public function loadAsync(req:URLRequest):void{
			_req = req;
			getResultAsync();
		}
		
		protected override function doCreateWorker(runnable:ByteArray):Worker
		{
			var result:Worker = super.doCreateWorker(runnable);
			result.setSharedProperty("jp.akb7.concurrent.URLLoader.request",_req);
			return result;
		}
	}
}