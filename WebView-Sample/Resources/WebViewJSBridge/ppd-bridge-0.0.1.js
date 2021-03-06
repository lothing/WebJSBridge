(function() {
    var initialize = false;
    var configData;
    var configIsValid = false;
    var readyCallback = function () {
        var callback = readyCallback._que.shift();
        while (callback) {
            if (typeof callback === 'function') callback();
            callback = readyCallback._que.shift();
        }
    };
    var ppd = window.ppd = {
        initCallback: initCallback,
        registerHandler: registerHandler,
        config: config,
        ready: ready,
    };

    readyCallback._que = []; // manage ready callback event

    function registBridge(){
        var iframe = document.getElementById("initIframe");
        if(iframe) {
            initCallback();
            return true;
        }
        iframe = document.createElement('iframe');
        iframe.id = "initIframe";
        iframe.style.display = 'none';
        iframe.src = 'ppdapi://init/';
        document.documentElement.appendChild(iframe);
        return false;
    }

    // wait for bridge object injected
    function prepare(callback){
        if (window.WebViewJavascriptBridge) {
            callback();
        } else {
            document.addEventListener('WebViewJavascriptBridgeReady',
            function() {
                callback();
            }, false);
        }
    }
 
    function call(id) { execute(id, ''); }
 
    function call(id, data) { execute(id, data); }

    //无通用回调
    function execute(method, data){
        if(!isValid()) return;
        window.WebViewJavascriptBridge.callHandler(method, data);
    }

    //配置化完成后，执行Ready设置的回调(如果ready没有执行过)
    function config(data){
        configData = data;
        registBridge();
    }

    // 调用底层方法，在底层完成config状态检测，执行回调(如果config没有执行过)
    function ready(callback){
        if (initialize) callback();
        else readyCallback._que.push(callback);
    }

    function initCallback(){
        prepare(function(){
            WebViewJavascriptBridge.debug = configData.debug;
            initialize = true;
            configIsValid = true;
            readyCallback();
            /*
            execute('config', configData, function(result){
                if(result.code == 1) {
                    configIsValid = true;
                    readyCallback();
                }
            });*/
            //set as a default js message handler
            window.WebViewJavascriptBridge.init(function(message, responseCallback) {
            });
        });
    }

    // check the valid invoke status, when any api method invoked
    function isValid(){
        var ret = true;
        if(!initialize) ret = false;
        if(!configIsValid) ret = false;

        if(!ret) {
            alert("bridge module hasn't been initialized.");
            return ret;
        }
        var domain = window.location.host;
        if(domain.indexOf("ymatou.com") == -1) {
            //alert("对不起，你没有调用权限，请联系管理员.");
            //return false;
        }
        return ret;
    }

    // 注册方法，让Native层调用
    function registerHandler(handlerName, handler) {
        window.WebViewJavascriptBridge.registerHandler(handlerName, handler);
    }
})();
