package com.svalero.choom.domain;

public class User {
    private int userID;
    private String personalName;
    private String role;
    private String username;
    private String password;
    private String email;
    private String address;
    private String telephone;

    public User(String personalName, String username, String password, String email, String address, String telephone) {
        this.userID = userID;
        this.personalName = personalName;
        this.role = role;
        this.username = username;
        this.password = password;
        this.email = email;
        this.address = address;
        this.telephone = telephone;
    }

    public User() {
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getPersonalName() {
        return personalName;
    }

    public void setPersonalName(String personalName) {
        this.personalName = personalName;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }
}
