<?php

/* Copyright 2019 Whitelamp http://www.whitelamp.com/ */

/* This example class sits on the organisation server and receives requests from the client analyst */
/* It makes client requests via CLI/cURL to pseudo server class \Pseudo\Admin */


namespace Pseudo;

class Server {

    public $hpapi;

    public function __construct (\Hpapi\Hpapi $hpapi) {
        $this->hpapi    = $hpapi;
        $this->userId   = $this->hpapi->userId;
    }

    public function __destruct ( ) {
    }

    public function egGetPersons ($token,$filter) {
        // Get data from a local table
        // Pass any hashed values to Pseudo API and substitute values
        // Return the results
        // This method should be restricted to appropriate user group(s)
        return false;
    }

    public function rehash ($db,$table,$column) {
        // Analyse column, calculate $distribution, request Pseudo API to add hashes
        // to correct distribution
        // This method should be restricted to administrators or automated jobs
        return false;
    }

}

