package com.svalero.choom.exception;

public class BookingAlreadyExistException extends Exception {

    public BookingAlreadyExistException() {
        super("Booking already exist");
    }
}
