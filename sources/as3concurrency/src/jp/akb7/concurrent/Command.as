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
    import flash.errors.IllegalOperationError;
    import flash.system.MessageChannel;
    import flash.system.MessageChannelState;
    import flash.system.Worker;
    
    public class Command extends WorkerSprite {
                
        public override function run():void {
            if(this is AsyncCallable) {
                doCallAsync();
            } else if(this is Callable) {
                doCall();
            } else {
				throw new IllegalOperationError("This class must implements the Callable or AsyncCallable");
			}
        }
		
        protected final function setResult(result:Object):void {
            if(_outchannel != null && _outchannel.state == MessageChannelState.OPEN) {
                _outchannel.send(result);
            }
        }
        
        protected final function doCall():void {
            _outchannel=getOutChannel();
            _inchannel=getInChannel();
			const result:Object=(this as Callable).call();
            setResult(result);
            _outchannel=null;
			_inchannel=null;
        }
        
        protected final function doCallAsync():void {
            _outchannel=getOutChannel();
            _inchannel=getInChannel();
            (this as AsyncCallable).callAsync();
        }
        
        protected final function getOutChannel():MessageChannel {
            var channel:MessageChannel = Worker.current.getSharedProperty(Task.OUT_CHANNEL);
            
            return channel;
        }
        protected final function getInChannel():MessageChannel {
            var channel:MessageChannel = Worker.current.getSharedProperty(Task.IN_CHANNEL);
            
            return channel;
        }
    }
}


