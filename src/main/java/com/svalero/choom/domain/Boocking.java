package com.svalero.choom.domain;

import java.time.LocalDate;

public class Boocking {
    private int bookingID;
    private LocalDate checkinDate;
    private LocalDate chekoutDate;
    private int numRoom;
    private String state;
    private String paymentMethod;

    public Boocking(int bookingID, LocalDate checkinDate, LocalDate chekoutDate, int numRoom, String state, String paymentMethod) {
        this.bookingID = bookingID;
        this.checkinDate = checkinDate;
        this.chekoutDate = chekoutDate;
        this.numRoom = numRoom;
        this.state = state;
        this.paymentMethod = paymentMethod;
    }

    public Boocking() {
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

    public LocalDate getChekoutDate() {
        return chekoutDate;
    }

    public void setChekoutDate(LocalDate chekoutDate) {
        this.chekoutDate = chekoutDate;
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
