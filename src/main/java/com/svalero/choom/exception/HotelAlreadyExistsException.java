package com.svalero.choom.exception;

public class HotelAlreadyExistsException extends Exception {

    public HotelAlreadyExistsException() {
        super("Hotel already exists.");
    }
}
