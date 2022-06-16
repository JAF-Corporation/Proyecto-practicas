package com.svalero.choom.util;

import com.svalero.choom.domain.Room;

import java.util.ArrayList;

public class Utils {

    public static float getBigPrice(ArrayList<Room> rooms) {
        float value = rooms.get(0).getPrice();

        for (int i = 0; i < rooms.size(); i++) {
            if (rooms.get(i).getPrice() > value) {
                value = rooms.get(i).getPrice();
            }
        }

        return value;
    }

    public static String getSmallPrice(ArrayList<Room> rooms) {
        if (rooms.size() == 0)
            return "Agotado";

        float value = rooms.get(0).getPrice();

        for (int i = 0; i < rooms.size(); i++) {
            if (rooms.get(i).getPrice() < value) {
                value = rooms.get(i).getPrice();
            }
        }

        return "From " + String.valueOf(value) + " \u20AC";
    }
}
