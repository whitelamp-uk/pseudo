
/* Copyright 2019 Whitelamp  http://www.whitelamp.com/ */

import {Generic} from './generic.js';

export class Pseudo extends Generic {

    async authAuto ( ) {
        var response;
        this.log ('Authenticating automatically');
        this.screenLockRefreshInhibit = 1;
        try {
            response = await super.authenticate (
                this.qs(document,'#gui-email').value
               ,null
               ,'pseudo-server'
               ,'\\Pseudo\\Server'
            );
            this.authCheck (response);
        }
        catch (e) {
            console.log (e.message);
        }
        try {
            response = await super.authenticate (
                this.qs(document,'#gui-email').value
               ,null
               ,'pseudo-auth'
               ,'\\Pseudo\\Auth'
            );
            this.authCheck (response);
        }
        catch (e) {
            console.log (e.message);
        }
        this.screenLockRefreshInhibit = null;
    }

    async authenticate (eml,pwd,pkg,cls) {
        this.loginTried = 1;
        try {
        var request = {
                "email" : eml
               ,"method" : {
                    "vendor" : "whitelamp-pesudo"
                   ,"package" : pkg
                   ,"class" : cls
                   ,"method" : "authenticate"
                   ,"arguments" : [
                    ]
                }
            }
            if (pwd) {
                request.password = pwd;
            }
            if ('key' in this) {
                request.key = this.key;
            }
        }
        catch (e) {
            console.log (e.message);
        }
        try {
        var response = await this.request (request);
        }
        catch (e) {
            if ('currentUser' in this) {
                console.log ('authenticate(): clearing current user details');
                this.currentUser = {};
                this.data.currentUser = {};
            }
            throw new Error (e.message);
        }
        return response;
    }

    async authProvider (evt) {
        var email, pwd, response;
        evt.preventDefault ();
        try {
            pwd         = evt.currentTarget.form.password.value;
            if (pwd.length==0) {
                this.log ('No password given');
                return;
            }
            evt.currentTarget.form.password.value  = '';
            email       = evt.currentTarget.form.email.value;
            response    = await this.authenticate (
                evt.currentTarget.form.email.value
               ,pwd
               ,'pseudo-server'
               ,'\\Pseudo\\Server'
            );
            this.authCheck (response);
        }
        catch (e) {
            console.log (e.message);
        }
    }

    async authPseudo (evt) {
        var email, pwd, response;
        evt.preventDefault ();
        try {
            pwd         = evt.currentTarget.form.password.value;
            if (pwd.length==0) {
                this.log ('No password given');
                return;
            }
            evt.currentTarget.form.password.value  = '';
            email       = evt.currentTarget.form.email.value;
            response    = await this.authenticate (
                evt.currentTarget.form.email.value
               ,pwd
               ,'pseudo-auth'
               ,'\\Pseudo\\Auth'
            );
            this.authCheck (response);
        }
        catch (e) {
            console.log (e.message);
        }
    }

    async authForget ( ) {
        await this.screenRender ('home');
        super.authForget ();
    }

    async authOk ( ) {
        super.authOk ();
        // Now get business configuration data
        await this.configRequest ();
        // Render a screen by URL (only when page loads)
        if (this.urlScreen) {
            await this.templateFetch (this.urlScreen);
            await this.screenRender (this.urlScreen);
            this.urlScreen = null;
            return;
        }
        // Render a default screen
        if (!this.currentScreen) {
            await this.templateFetch ('home');
            await this.screenRender ('home');
        }
    }

    constructor (config) {
        super (config);
    }

    async init ( ) {
        var keys, i, unlock, userScope;
        this.log ('API='+this.cfg.url);
        this.reset                  = null;
        this.templates              = {};
        if (this.cfg.diagnostic.data) {
            this.templateFetch ('data');
        }
        this.templateFetch ('lock');
        this.templateFetch ('splash');
        this.templateFetch ('place');
        await this.templateFetch ('login');
        this.currentScreen          = null;
        this.currentTemplates       = {};
        this.currentInserts         = [];
        this.parametersClear ();
        this.dataRefresh ();
        this.globalLoad ();
        this.access.innerHTML       = this.templates.login ();
        unlock                      = this.qs (document,'#gui-unlock');
        unlock.addEventListener ('click',this.authProvider.bind(this));
        // Define user scope
        userScope                   = this.userScope ();
        this.authAutoPermit         =  0;
        if (this.urlUser.length>0) {
            // Passed in URL so allow instant login
            this.authAutoPermit     =  1;
            userScope.value         = this.urlUser;
        }
        this.saveScopeSet (userScope.value);
        userScope.addEventListener ('keyup',this.saveScopeListen.bind(this));
        userScope.addEventListener ('change',this.saveScopeListen.bind(this));
        if ((typeof this.authAuto)=='function') {
            // Multiple window mode is defined by existence of this.authAuto()
            this.screenLocker       = window.setInterval (this.screenLockRefresh.bind(this),2000);
            this.windowLogger       = window.setInterval (this.windowLog.bind(this),900);
            this.windowLog ();
        }
        keys                        = Object.keys (this.urlParameters);
        for (i=0;i<keys.length;i++) {
            this.parameterWrite (keys[i],this.urlParameters[keys[i]]);
        }
    }

    async report (evt) {
        var args, err, form, file, i, link, report, target, title, type;
        form        = this.qs (this.restricted,'form[data-report]');
        target      = this.qs (this.restricted,'#'+evt.currentTarget.dataset.target);
        title       = evt.currentTarget.dataset.title;
        file        = title.replace(/[^a-zA-Z ]/g,'').replace(/ /g,'-');
        args        = [];
        type        = 'xml';
        if (evt.currentTarget.dataset.download=='csv') {
            type    = 'csv';
        }
        for (i=0;form.elements[i];i++) {
            args.push (form.elements[i].value);
        }
        try {
            report  = await this.reportRequest (args);
        }
        catch (e) {
            err     = this.errorSplit (e.message);
            if (err.hpapiCode=='400') {
                this.splash (2,'Invalid input(s)','Error','OK');
            }
            else {
                this.splash (2,e.message,'Error','OK');
            }
            return false;
        }
        if (type=='csv') {
            link = this.downloadLink (
                'Here is your download'
               ,file+'.csv'
               ,'text/csv'
               ,this.objectToCsv (report)
            );
            target.appendChild (link);
            return true;
        }
        link = this.downloadLink (
            'Here is your download'
           ,file+'.xml'
           ,'text/xml'
           ,this.objectToMsExcel2003Xml (report,title)
        );
        target.appendChild (link);
        return true;
    }

}

