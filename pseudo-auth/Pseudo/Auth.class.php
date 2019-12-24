<?php

/* Copyright 2019 Whitelamp http://www.whitelamp.com/ */

/* This class sits on the pseudo server and receives requests from the client analyst */

namespace Pseudo;

class Auth {

    public $hpapi;

    public function __construct (\Hpapi\Hpapi $hpapi) {
        $this->hpapi = $hpapi;
    }

    public function __destruct ( ) {
    }

    public function passwordReset ($answer,$code,$newPassword) {
        // Reset password after verifying secret answer to question
        // See \Bab\Agent::passwordReset()
        return false;
    }

    public function secretQuestion ($phoneEnd) {
        // Get a question to provide the secret answer
        // Constrained by knowing something about user phone number
        // See \Bab\Agent::secretQuestion()
        return false;
    }

    public function token ( ) {
        // Set and return a token for this user
        // This is not the hpapi authentication token - this one will be handed to the data provider for use
        // This function also acts as the hpapi authentication function
/*
    Find $this->userId in `pseudo_user`
    Set a token with an expiry based on a configured token duration (short)
    Return the token
*/
        return false;
    }

    public function verify ( ) {
        // Send a verification code to $this->userId
        // See \Bab\Agent::verify()
        return false;
    }

}

