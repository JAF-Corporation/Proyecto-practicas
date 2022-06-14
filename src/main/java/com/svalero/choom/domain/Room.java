package com.svalero.choom.domain;

public class Room {
    private int roomID;
    private String type;
    private float prive;
    private int totalRooms;

    public Room(int roomID, String type, float prive, int totalRooms) {
        this.roomID = roomID;
        this.type = type;
        this.prive = prive;
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

    public float getPrive() {
        return prive;
    }

    public void setPrive(float prive) {
        this.prive = prive;
    }

    public int getTotalRooms() {
        return totalRooms;
    }

    public void setTotalRooms(int totalRooms) {
        this.totalRooms = totalRooms;
    }

}
