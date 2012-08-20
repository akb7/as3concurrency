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
    import flash.system.MessageChannel;
    import flash.system.Worker;
    import flash.utils.ByteArray;
    
    import jp.akb7.concurrent.events.FutureEvent;
    
    [Event(name="result", type="jp.akb7.concurrent.events.FutureEvent")]
    public class FutureTask extends Task implements Future {
        public static const IN_CHANNEL:String="jp.akb7.concurrent.FutureTask.inchannel";
        
        private var _inchannel:MessageChannel;
        
        private var _callable:ByteArray;
        
        private var _thread:Task;
        
        private var _result:Object;
        
        private var _running:Boolean=false;
        
        private var _isDone:Boolean=false;
        
        public function FutureTask(runnable:ByteArray, name:String=null, condition:Condition=null, mutex:Mutex=null, sharedMemory:ByteArray=null) {
            super(runnable, name, condition, mutex, sharedMemory);
        }
        
        public final function getResult(timeout:Number=-1):Object {
            //ワーカー開始
            doPrepare();
            var result:Object=_inchannel.receive(true);
            
            if(result is Fault) {
                var f:Fault=result as Fault;
                var error:Error=new Error(f.message, f.errrorID);
                error.name=f.name;
                terminate();
                throw error;
            }
            _running=false;
            _isDone=true;
            return result;
        }
        
        public final function getResultAsync():void {
            //ワーカー開始
            doPrepare();
            _inchannel.addEventListener(Event.CHANNEL_MESSAGE, inchannel_channelMessageHandler);
            _inchannel.receive();
        }
        
        public function isDone():Boolean {
            return _isDone;
        }
        
        protected final function doPrepare():void {
            _running=true;
            
            //子ワーカー作成
            start();
            
            //メッセージチャンネル作成
            //メインワーカーに対するメッセージチャンネル作成
            _inchannel=_worker.createMessageChannel(Worker.current);
            
            //共有プロパティに設定
            _worker.setSharedProperty(IN_CHANNEL, _inchannel);
        }
        
        protected override function doTerminateWorker():void {
            if(_worker != null) {
                _worker.setSharedProperty(IN_CHANNEL, null);
                _inchannel.removeEventListener(Event.CHANNEL_MESSAGE, inchannel_channelMessageHandler);
                _inchannel=null;
                _running=false;
            }
            super.doTerminateWorker();
        }
        
        private function inchannel_channelMessageHandler(e:Event):void {
            //メッセージチャンネルにメッセージがあるかどうか
            if(_inchannel.messageAvailable) {
                //メッセージチャンネルに受信
                _isDone=true;
                
                var data:Object=_inchannel.receive();
                var event:FutureEvent;
                
                if(data is Fault) {
                    event=new FutureEvent(FutureEvent.FAULT);
                } else {
                    event=new FutureEvent(FutureEvent.RESULT);
                }
                event.data=data;
                dispatchEvent(event);
                
                terminate();
            }
        }
    }
}

