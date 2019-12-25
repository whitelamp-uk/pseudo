
/* Copyright 2018 Burden and Burden  http://www.burdenandburden.co.uk/ */

import {Pseudo} from './pseudo.js';

export class PseudoEnforcer extends Pseudo {

    actors (templateName) {
        var defns;
        this.editModeReset ();
        switch (templateName) {
            case 'demo':
                defns = [
                    { id: 'demo-button', event: 'click', function: this.demoPing }
                ];
                break;
            default:
                return;
        }
        this.actorsListen (defns);
    }

    async loaders (evt,templateName) {
        switch (templateName) {
            case 'demo':
                this.demoPostLoad ();
                return true;
            default:
                return null;
        }
    }

    navigators ( ) {
        return {
            blocks : {
            },
            crumbs : {
            }
        }
    }

    navigatorsSelector ( ) {
        return 'a.navigator,button.navigator,.nugget.navigator';
    }

    preloaders (templateName) {
        switch (templateName) {
            case 'demo':
                return [this.demoPreLoad];
            default:
                return [];
        }
    }

    unstickers ( ) {
        return {
        }
    }

}

