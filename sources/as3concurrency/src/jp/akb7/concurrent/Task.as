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

    import flash.concurrent.Condition;
    import flash.concurrent.Mutex;
    import flash.events.EventDispatcher;
    import flash.net.registerClassAlias;
    import flash.system.MessageChannel;
    import flash.system.Worker;
    import flash.system.WorkerDomain;
    import flash.system.WorkerState;
    import flash.utils.ByteArray;
    
    import jp.akb7.concurrent.events.CommandEvent;
    
    [Event(name="result", type="jp.akb7.concurrent.events.CommandEvent")]
    [Event(name="fault", type="jp.akb7.concurrent.events.CommandEvent")]
    public class Task extends EventDispatcher {
        
        {
            registerClassAlias("jp.akb7.concurrent.Fault", jp.akb7.concurrent.Fault);
        }
        
        protected var _worker:Worker;
        
        protected var _inchannel:MessageChannel;
        
        protected var _outchannel:MessageChannel;
        
        private var _name:String;

        private var _mutex:Mutex;
        
        private var _condition:Condition;
        
        private var _sharedMemory:ByteArray;
        
        private var _workerByteArray:ByteArray;
        
        public function get isRunning():Boolean
        {
            return _worker != null && _worker.state == WorkerState.RUNNING;
        }
        
        public function get workerStatus():String
        {
            return _worker==null ? null:_worker.state;
        }


        public function Task(workerByteArray:ByteArray, name:String=null, sharedMemory:ByteArray=null, condition:Condition=null, mutex:Mutex=null) {
            this._workerByteArray=workerByteArray;
            this._name=name;
            this._condition=condition;
            this._mutex=mutex;
            this._sharedMemory=sharedMemory;
            if (this._sharedMemory != null ){
                _sharedMemory.shareable = true;
            }
        }
    
        public final function start():void {
            if( _worker == null ){
                _worker=doCreateWorker();
                doPrepare();
                _worker.start();
            }
        }
        
        public function terminate():void {
            if(_worker != null) {
                doTerminateWorker();
            }
        }
        
        protected function doPrepare():void {
            
        }
        
        protected function doTerminateWorker():void {
            _worker.setSharedProperty(TaskConsts.OUT_CHANNEL, null);
            _worker.setSharedProperty(TaskConsts.IN_CHANNEL, null);
            _worker.terminate();
            _inchannel = null;
            _outchannel = null;
            _worker=null;
        }
        
        protected function doCreateWorker():Worker {
            var result:Worker=WorkerDomain.current.createWorker(_workerByteArray);

            if(_sharedMemory != null) {
                result.setSharedProperty(TaskConsts.SHAREDMEMORY, _sharedMemory);
            }
            
            if(_mutex != null) {
                result.setSharedProperty(TaskConsts.MUTEX, _mutex);
            }
            
            if(_condition != null) {
                result.setSharedProperty(TaskConsts.CONDITION, _condition);
            }

            if(_name != null) {
                result.setSharedProperty(TaskConsts.NAME, _name);
            }
            
            return result;
        }
        
        protected final function doParseReceiveMessage(data:Object):void {
            var event:CommandEvent;
            
            if(data is Fault) {
                event=new CommandEvent(CommandEvent.FAULT);
            } else {
                event=new CommandEvent(CommandEvent.RESULT);
            }
            event.data=data;
            dispatchEvent(event);
        }
        
        protected final function setupMessageChannel():void{
            //メッセージチャンネル作成
            _inchannel=_worker.createMessageChannel(Worker.current);
            _outchannel = Worker.current.createMessageChannel(_worker);

            //共有プロパティに設定
            _worker.setSharedProperty(TaskConsts.OUT_CHANNEL, _inchannel);
            _worker.setSharedProperty(TaskConsts.IN_CHANNEL, _outchannel);
        }
    }
}


