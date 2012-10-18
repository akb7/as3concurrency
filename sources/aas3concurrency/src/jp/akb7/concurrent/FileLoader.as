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
    import flash.net.registerClassAlias;
    import flash.system.Worker;
    
    public class FileLoader extends CommandTask
    {
        {
            registerClassAlias("jp.akb7.concurrent.Fault", jp.akb7.concurrent.Fault);
        }
        
        private var _path:String;
        
        public function FileLoader() {
            super(InternalAIRWorkers.FileLoaderCommand);
        }
        
        public function load(path:String, timeout:Number=-1):Object {
            _path=path;
            var result:Object=getResult(timeout);
            return result;
        }
        
        public function loadAsync(path:String):void {
            _path=path;
            getResultAsync();
        }
        
        protected override function doCreateWorker():Worker {
            var result:Worker=super.doCreateWorker();
            result.setSharedProperty("jp.akb7.concurrent.FileLoaderCommand.path", _path);
            return result;
        }
    }
}