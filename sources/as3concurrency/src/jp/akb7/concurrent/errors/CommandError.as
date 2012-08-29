package jp.akb7.concurrent.errors
{
	import flash.errors.IllegalOperationError;

	public class CommandError extends IllegalOperationError
	{
		public function CommandError(message:String,id:int=0){
			super(message,id);
		}
	}
}