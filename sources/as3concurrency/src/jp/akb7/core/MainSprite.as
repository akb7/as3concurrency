package jp.akb7.core
{
	import flash.display.Sprite;
	import flash.events.Event;

	public class MainSprite extends Sprite 
	{
		private var _frameCount:int;
		
		public function MainSprite()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,on_addedToStageHandler);
		}
		
		private function on_addedToStageHandler(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,on_addedToStageHandler);
			this.addEventListener(Event.ENTER_FRAME,on_enterFrameHandler);
		}
		
		private function on_enterFrameHandler(event:Event):void
		{
			_frameCount++;
			if( _frameCount == 1 ){
				if( "init" in this ){
					var initfunc:Function = this["init"] as Function;
					if( initfunc != null ){
						initfunc.apply(this);
					}
				}
			} else if( _frameCount == 2 ){
				if( "prepare" in this ){
					var preparefunc:Function = this["prepare"] as Function;
					if( preparefunc != null ){
						preparefunc.apply(this);
					}
				}
			} else if( _frameCount == 3){
				this.removeEventListener(Event.ENTER_FRAME,on_enterFrameHandler);
				if( "main" in this ){
					var mainfunc:Function = this["main"] as Function;
					if( mainfunc != null ){
						mainfunc.apply(this);
					}
				}
			}
		}
	}
}