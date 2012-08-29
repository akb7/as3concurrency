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
CONFIG::SHAREDMEMORY{
    import flash.concurrent.Condition;
    import flash.concurrent.Mutex;
}
    import flash.events.Event;
    import flash.utils.ByteArray;
    
    [Event(name="result", type="jp.akb7.concurrent.events.CommandEvent")]
    public class CommandTask extends Task {
        
        private var _callable:ByteArray;
        
        private var _thread:Task;
        

CONFIG::SHAREDMEMORY{
        public function CommandTask(runnable:ByteArray, name:String=null, sharedMemory:ByteArray=null, condition:Condition=null, mutex:Mutex=null ){
            super(runnable, name, sharedMemory, condition, mutex);
        }
}
        
        public function CommandTask(runnable:ByteArray, name:String=null){
            super(runnable, name);
        }
        
        public final function getResult(timeout:Number=-1):Object {
            start();
            var result:Object=_inchannel.receive(true);
            
            if(result is Fault) {
                var f:Fault=result as Fault;
                var error:Error=new Error(f.message, f.errrorID);
                error.name=f.name;
                terminate();
                throw error;
            }
            return result;
        }
        
        public final function getResultAsync():void {
            start();
            _inchannel.addEventListener(Event.CHANNEL_MESSAGE, inchannel_channelMessageHandler);
        }
        
        private function inchannel_channelMessageHandler(e:Event):void {
            //メッセージチャンネルにメッセージがあるかどうか
            if(_inchannel.messageAvailable) {
                //メッセージチャンネルに受信
                var data:Object=_inchannel.receive();
                doParseReceiveMessage(data);
                terminate();
            }
        }
        
        protected override function doTerminateWorker():void {
            if(_worker != null) {
                _worker.setSharedProperty(OUT_CHANNEL, null);
                _inchannel.removeEventListener(Event.CHANNEL_MESSAGE, inchannel_channelMessageHandler);
                _inchannel=null;
            }
            super.doTerminateWorker();
        }
        
        protected final override function doPrepare():void {
            setupMessageChannel();
        }
    }
}


