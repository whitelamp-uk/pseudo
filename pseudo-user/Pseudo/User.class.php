<?php

/* Copyright 2019 Whitelamp http://www.whitelamp.com/ */

namespace Pseudo;

class User {

    public $hpapi;

    public function __construct (\Hpapi\Hpapi $hpapi) {
        $this->hpapi = $hpapi;
    }

    public function __destruct ( ) {
    }

}

