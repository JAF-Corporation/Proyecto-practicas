package com.svalero.choom.dao;

import com.svalero.choom.domain.Room;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Optional;

public class RoomDao {

    private Connection connection;

    public RoomDao(Connection connection) {
        this.connection = connection;
    }

    public void add(Room room) throws SQLException {
        String sql = "INSERT INTO ROOM (room_type, room_price, total_rooms) VALUES (?, ?, ?)";
        RoomDao roomDao = new RoomDao(connection);

        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, room.getType());
        statement.setFloat(2, room.getPrice());
        statement.setInt(3, room.getTotalRooms());
        statement.executeUpdate();
    }

    public ArrayList<Room> findAll() throws SQLException {
        String sql = "SELECT * FROM ROOM ORDER BY room_price";
        ArrayList<Room> rooms = new ArrayList<>();

        PreparedStatement statement = connection.prepareStatement(sql);
        ResultSet resultSet = statement.executeQuery();

        while(resultSet.next()) {
            Room room = fromResultSet(resultSet);
            rooms.add(room);
        }

        return rooms;
    }

    public Optional<Room> findById(int id) throws SQLException {
        String sql = "SELECT * FROM ROOM WHERE id_room = ?";
        Room room = null;

        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, id);
        ResultSet resultSet = statement.executeQuery();

        if(resultSet.next()) {
            room = fromResultSet(resultSet);
        }

        return Optional.ofNullable(room);
    }

    public void modify(int id, String type, float price, int totalRooms) throws SQLException {
        String sql = "UPDATE ROOM SET room_type = ?,  room_price = ?, total_rooms = ? WHERE id_room = ?";
        RoomDao roomDao = new RoomDao(connection);

        PreparedStatement statement = connection.prepareStatement(sql);

        statement.setString(1, type);
        statement.setFloat(2, price);
        statement.setInt(3, totalRooms);
        statement.setInt(4, id);
        statement.executeUpdate();
    }

    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM ROOM WHERE id_room = ?";

        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, id);
        int row = statement.executeUpdate();

        return row == 1;
    }


    private Room fromResultSet(ResultSet resultSet) {
        Room room = new Room();

        room.setId(resultSet.getInt("id_room"));
        room.setType(resultSet.getString("room_type"));
        room.setPrice(resultSet.getFloat("room_price"));
        room.setPrice(resultSet.getInt("total_rooms"));

        return room;
    }
}
