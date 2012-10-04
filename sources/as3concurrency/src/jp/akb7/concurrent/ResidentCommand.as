/*****************************************************
 *
 *  Copyright 2012 AKABANA.  All Rights Reserved.
 *
 *****************************************************
 *  The contents of this file are subject to the Mozilla Public License
 *  Version 1.1 (the "License"); you may not use this file except in
 *  compliance with the License. You may obtain a copy of the License at
 *  http://www.mozilla.org/MPL/
 *
 *  Software distributed under the License is distributed on an "AS IS"
 *  basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 *  License for the specific language governing rights and limitations
 *  under the License.
 *
 *
 *  The Initial Developer of the Original Code is AKABANA.
 *  Portions created by AKABANA are Copyright (C) 2012 AKABANA
 *  All Rights Reserved.
 *
 *****************************************************/
package jp.akb7.concurrent
{
    import flash.events.Event;
    
    public class ResidentCommand extends Command
    {
        public function ResidentCommand()
        {
            super();
        }
        
        public override final function run():void {
            _outchannel=getOutChannel();
            _inchannel=getInChannel();
            _inchannel.addEventListener(Event.CHANNEL_MESSAGE, inchannel_channelMessageHandler);
        }
		
		public final function terminate():void {
			if(_inchannel != null) {
				_inchannel.removeEventListener(Event.CHANNEL_MESSAGE, inchannel_channelMessageHandler);
			}
			_inchannel = null;
			_outchannel = null;
		}
        
		protected final function doInvoke(mesasges:Array):void{
            try{
                var funcName:String = mesasges.shift();
                var f:Function = this[funcName];
                var result:Object = f.apply(null,mesasges);
                setResult(result);
            } catch(e:Error){
                var fault:Fault=new Fault();
                fault.errrorID = e.errorID;
                fault.message = e.message;
                fault.name = e.name;
                setResult(fault);
            }
        }
		
		protected final function doInvokeAsync(mesasges:Array):void{
			try{
				var funcName:String = mesasges.shift();
				var f:Function = this[funcName];
				var result:* = f.apply(null,mesasges);
				if( result === undefined ){
					
				} else {
					setResult(result);
				}
			} catch(e:Error){
				var fault:Fault=new Fault();
				fault.errrorID = e.errorID;
				fault.message = e.message;
				fault.name = e.name;
				setResult(fault);
			}
		}
        
        protected final function inchannel_channelMessageHandler(event:Event):void
        {    
            if (_inchannel.messageAvailable)
            {
                var data:Object = _inchannel.receive();
                if( data is Array ){
                    var mesasges:Array = data as Array;
                    if( mesasges.length > 0 ){
                        var methodName:String = mesasges.shift();
                        if( ResidentConsts.INVOKE == methodName){
                            doInvoke(mesasges);
                            return;
                        } else if( ResidentConsts.INVOKE_ASYNC == methodName){
							doInvokeAsync(mesasges);
							return;
						}
                    }
                }
                
                var fault:Fault=new Fault();
                fault.message = "ResidentCommand Invoke Error";
                setResult(fault);
            }
        }
    }
}