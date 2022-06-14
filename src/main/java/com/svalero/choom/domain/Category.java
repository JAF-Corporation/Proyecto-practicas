package com.svalero.choom.domain;

public class Category {
    private int categoryID;
    private int stars;

    public Category(int categoryID, int stars) {
        this.categoryID = categoryID;
        this.stars = stars;
    }

    public Category() {
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public int getStars() {
        return stars;
    }

    public void setStars(int stars) {
        this.stars = stars;
    }
}
