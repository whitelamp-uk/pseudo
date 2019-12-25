
/* Copyright 2019 Whitelamp  http://www.whitelamp.com/ */

// Import
import {PseudoCfg} from './class/pseudo-cfg.js';
import {PseudoEnforcer} from './class/pseudo-enforcer.js';

// Executive
function execute ( ) {
    try {
        new PseudoEnforcer (new PseudoCfg()) .init ();
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
