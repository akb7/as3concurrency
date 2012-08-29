package jp.akb7.concurrent.errors
{
	import flash.errors.IllegalOperationError;

	public class WorkerError extends IllegalOperationError
	{
		public function WorkerError(message:String,id:int=0){
			super(message,id);
		}
	}
}