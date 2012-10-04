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
    import flash.net.URLRequest;
    import flash.net.registerClassAlias;
    import flash.system.Worker;
    import flash.utils.ByteArray;
    
    public class URLLoader extends CommandTask {

        {
            registerClassAlias("flash.net.URLRequest", flash.net.URLRequest);
            registerClassAlias("jp.akb7.concurrent.Fault", jp.akb7.concurrent.Fault);
        }
        
        private var _req:URLRequest;
        
        public function URLLoader(bytearry:ByteArray=null) {
            if( bytearry == null ){
                bytearry = InternalWorkers.URLLoaderCommand;
            }
            super(bytearry);
        }
        
        public function load(req:URLRequest, timeout:Number=-1):Object {
            _req=req;
            var result:Object=getResult(timeout);
            return result;
        }
        
        public function loadAsync(req:URLRequest):void {
            _req=req;
            getResultAsync();
        }
        
        protected override function doCreateWorker():Worker {
            var result:Worker=super.doCreateWorker();
            result.setSharedProperty("jp.akb7.concurrent.URLLoaderCommand.request", _req);
            return result;
        }
    }
}


