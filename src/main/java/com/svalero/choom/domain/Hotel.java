package com.svalero.choom.domain;

public class Hotel {
    private int hotelID;
    private String name;
    private String address;
    private String city;
    private float rating;

    public Hotel() {
    }

    public Hotel(int hotelID, String name, String address, String city, float rating) {
        this.hotelID = hotelID;
        this.name = name;
        this.address = address;
        this.city = city;
        this.rating = rating;
    }

    public int getHotelID() {
        return hotelID;
    }

    public void setHotelID(int hotelID) {
        this.hotelID = hotelID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public float getRating() {
        return rating;
    }

    public void setRating(float rating) {
        this.rating = rating;
    }
}
