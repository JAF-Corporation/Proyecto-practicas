package com.svalero.choom.exception;

public class RoomAlreadyExistException extends Exception {

    public RoomAlreadyExistException() {
        super("Hotel already exists.");
    }
}
