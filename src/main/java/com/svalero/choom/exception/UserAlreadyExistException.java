package com.svalero.choom.exception;

public class UserAlreadyExistException extends Exception {

    public UserAlreadyExistException() {
        super("User already exists");
    }
}
