package com.svalero.choom.domain;

import java.time.LocalDate;

public class Booking {
    private int bookingID;
    private LocalDate checkinDate;
    private LocalDate checkoutDate;
    private int numRoom;
    private String state;
    private String paymentMethod;

    public Booking(int bookingID, LocalDate checkinDate, LocalDate checkoutDate, int numRoom, String state, String paymentMethod) {
        this.bookingID = bookingID;
        this.checkinDate = checkinDate;
        this.checkoutDate = checkoutDate;
        this.numRoom = numRoom;
        this.state = state;
        this.paymentMethod = paymentMethod;
    }

    public Booking() {
    }

    public int getBookingID() {
        return bookingID;
    }

    public void setBookingID(int bookingID) {
        this.bookingID = bookingID;
    }

    public LocalDate getCheckinDate() {
        return checkinDate;
    }

    public void setCheckinDate(LocalDate checkinDate) {
        this.checkinDate = checkinDate;
    }

    public LocalDate getCheckoutDate() {
        return checkoutDate;
    }

    public void setCheckoutDate(LocalDate checkoutDate) {
        this.checkoutDate = checkoutDate;
    }

    public int getNumRoom() {
        return numRoom;
    }

    public void setNumRoom(int numRoom) {
        this.numRoom = numRoom;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }
}
