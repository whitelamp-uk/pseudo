<?php

/* Copyright 2019 Whitelamp http://www.whitelamp.com/ */

/* This class sits on the pseudo server and receives requests from organisation server */

namespace Pseudo;

class Admin {

    public $hpapi;

    public function __construct (\Hpapi\Hpapi $hpapi) {
        $this->hpapi    = $hpapi;
        $this->userId   = $this->hpapi->userId;
    }

    public function __destruct ( ) {
    }

    public function rehash ($providerUuid,$db,$table,$column,$distribution) {
        // Generate the right number of hashes per value to stymie statistical value guessing
/*
    Check REMOTE_ADDR for  provider UUID
    Use $distribution which looks like {"Mr":48,"Mrs":27,"Ms":12,"Miss":9,"Mx":2,"Prof":1,"Rev":1}
    to add more UUIDs to `pseudo_value` thus equalising chance of any one UUID from this column
*/
        return false;
    }

    public function update ($remoteAddrPattern,$name) {
        if (!preg_match('<'.$remoteAddrPattern.'>',$_SERVER['REMOTE_ADDR'])) {
            throw new \Exception (PSEUDO_P_UPDATE_REMADDR);
            return false;
        }
/*
    Update `user`.`remote_addr_pattern`, `pseudo_provider`.`name` for $this->userId
*/
        return false;
    }

    public function values ($userToken,$db,$table,$column,$hashArray) {
        // Get some values represented by hashes for a column owned by this provider
        // Using a temporary token provided by the user
/*
    Get owner UUID using `owner`.`user_id`=$this->userId
    Get user UUID using `user`.`token`=$userToken
    Check `access` using user UUID, owner UUID, $db,$table,$column
    Throw error if access not found
    Return value array from `value` using owner UUID, $db,$table,$column,$hashArray
    preserving array order as per $hashArray
*/
        return false;
    }

}

