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
package jp.akb7.concurrent {
    import flash.concurrent.Condition;
    import flash.concurrent.Mutex;
    import flash.events.Event;
    import flash.utils.ByteArray;
    
    [Event(name="result", type="jp.akb7.concurrent.events.FutureEvent")]
    public class FutureTask extends Task implements Future {
        
        private var _callable:ByteArray;
        
        private var _thread:Task;
        
        private var _result:Object;
        
        public function FutureTask(runnable:ByteArray, name:String=null, condition:Condition=null, mutex:Mutex=null, sharedMemory:ByteArray=null) {
            super(runnable, name, condition, mutex, sharedMemory);
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
                doParseReciveMessage(data);
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


