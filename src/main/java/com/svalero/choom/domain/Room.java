package com.svalero.choom.domain;

public class Room {
    private int roomID;
    private String type;
    private float price;
    private int totalRooms;

    public Room(int roomID, String type, float price, int totalRooms) {
        this.roomID = roomID;
        this.type = type;
        this.price = price;
        this.totalRooms = totalRooms;
    }

    public Room() {
    }

    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getTotalRooms() {
        return totalRooms;
    }

    public void setTotalRooms(int totalRooms) {
        this.totalRooms = totalRooms;
    }

}
