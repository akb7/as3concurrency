package
{
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import flash.utils.ByteArray;
    
    import data.UserInfo;
    
    import jp.akb7.concurrent.ResidentCommand;
    
    [SWF(width="0", height="0", frameRate="1")]
    public class ResidentCommandWithShareMemory3 extends ResidentCommand
    {
        public function ResidentCommandWithShareMemory3()
        {
            super();
            trace("ResidentCommandWithShareMemory:Strat,"+stage.frameRate);
        }
        
        public function getUserList(value:int):Array{
            trace("ResidentCommandWithShareMemory3:getUserList,start");

			var result:Array = [];
			
			for (var i:int = 0; i < value; i++) 
			{
				var user:UserInfo = new UserInfo();
				user.uid = i;
				user.name = "Name"+i;
				result.push(user);
			}
			
			return result;

			trace("ResidentCommandWithShareMemory3:getUserList,end");
        }
    }
}