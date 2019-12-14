
/* Copyright 2018 Burden and Burden  http://www.burdenandburden.co.uk/ */

// Import
import {AdminCfg} from './class/admin-cfg.js';
import {AdminEnforcer} from './class/admin-enforcer.js';

// Executive
function execute ( ) {
    try {
        new AdminEnforcer (new AdminCfg()) .init ();
    }
    catch (e) {
        document.getElementById('gui-access').innerHTML = 'Failed to initialise application: '+e.message;
    }
}
if (window.document.readyState=='interactive' || window.document.readyState=='complete') {
    execute ();
}
else {
    window.document.addEventListener ('DOMContentLoaded',execute);
}
