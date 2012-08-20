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
    import flash.events.EventDispatcher;
    import flash.net.registerClassAlias;
    import flash.system.MessageChannel;
    import flash.system.Worker;
    import flash.system.WorkerDomain;
    import flash.system.WorkerState;
    import flash.utils.ByteArray;
    
    import jp.akb7.concurrent.events.FutureEvent;
    
    public class Task extends EventDispatcher {
        
        public static const IN_CHANNEL:String="jp.akb7.concurrent.FutureTask.inchannel";
        
        public static const OUT_CHANNEL:String="jp.akb7.concurrent.FutureTask.outchannel";
        
        public static const NAME:String="jp.akb7.concurrent.Task.name";
        
        public static const RUNNABLE:String="jp.akb7.concurrent.Task.runnable";
        
        public static const CONDITION:String="jp.akb7.concurrent.Task.condition";
        
        public static const MUTEX:String="jp.akb7.concurrent.Task.mutex";
        
        public static const SHAREDMEMORY:String="jp.akb7.concurrent.Task.sharedMemory";
        
        {
            registerClassAlias("jp.akb7.concurrent.Fault", jp.akb7.concurrent.Fault);
        }
        
        protected var _worker:Worker;
        
        protected var _inchannel:MessageChannel;
        
        protected var _outchannel:MessageChannel;
        
        private var _mutex:Mutex;
        
        private var _condition:Condition;
        
        private var _name:String;
        
        private var _sharedMemory:ByteArray;
        
        private var _runnable:ByteArray;
        
        public function get isRunning():Boolean
        {
            return _worker != null && _worker.state == WorkerState.RUNNING;
        }
        
        public function get workerStatus():String
        {
            return _worker==null ? null:_worker.state;
        }
        
        public function Task(runnable:ByteArray, name:String=null, condition:Condition=null, mutex:Mutex=null, sharedMemory:ByteArray=null) {
            this._name=name;
            this._condition=condition;
            this._mutex=mutex;
            this._sharedMemory=sharedMemory;
            this._runnable=runnable;
        }
        
        public final function start():void {
            if( _worker == null ){
                _worker=doCreateWorker(_runnable);
                doPrepare();
                _worker.start();
            }
        }
        
        public final function terminate():void {
            if(_worker != null) {
                doTerminateWorker();
            }
        }
        
        protected function doPrepare():void {
            
        }
        
        protected function doTerminateWorker():void {
            _worker.terminate();
            _worker=null;
        }
        
        protected function doCreateWorker(runnable:ByteArray):Worker {
            var result:Worker=WorkerDomain.current.createWorker(runnable);
            
            if(_sharedMemory != null) {
                result.setSharedProperty(SHAREDMEMORY, _sharedMemory);
            }
            
            if(_mutex != null) {
                result.setSharedProperty(MUTEX, _mutex);
            }
            
            if(_condition != null) {
                result.setSharedProperty(CONDITION, _condition);
            }
            
            if(_name != null) {
                result.setSharedProperty(NAME, _name);
            }
            
            return result;
        }
        
        protected final function doParseReciveMessage(data:Object):void {
            var event:FutureEvent;
            
            if(data is Fault) {
                event=new FutureEvent(FutureEvent.FAULT);
            } else {
                event=new FutureEvent(FutureEvent.RESULT);
            }
            event.data=data;
            dispatchEvent(event);
        }
        
        protected final function setupMessageChannel():void{
            //メッセージチャンネル作成
            _inchannel=_worker.createMessageChannel(Worker.current);
            _outchannel = Worker.current.createMessageChannel(_worker);
            
            //共有プロパティに設定
            _worker.setSharedProperty(OUT_CHANNEL, _inchannel);
            _worker.setSharedProperty(IN_CHANNEL, _outchannel);
        }
    }
}


