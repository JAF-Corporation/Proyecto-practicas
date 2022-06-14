package com.svalero.choom.dao;

import com.svalero.choom.domain.Boocking;

import java.sql.*;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Optional;

public class BoockingDao {

    private Connection connection;

    public BoockingDao(Connection connection) {
        this.connection = connection;
    }

    public void add(Boocking boocking) throws SQLException {
        String sql = "INSERT INTO BOOKING (in_date, out_date, room_number, pay_state, pay_method) VALUES (?, ?, ?, ?, ?)";
        BoockingDao boockingDao = new BoockingDao(connection);

        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setDate(1, java.sql.Date.valueOf(boocking.getCheckinDate()));
        statement.setDate(2, java.sql.Date.valueOf(boocking.getCheckoutDate()));
        statement.setInt(3, boocking.getNumRoom());
        statement.setString(4, boocking.getState());
        statement.setString(5, boocking.getPaymentMethod());
        statement.executeUpdate();
    }

    public ArrayList<Boocking> findAll() throws SQLException {
        String sql = "SELECT * FROM BOOKING ORDER BY in_date";
        ArrayList<Boocking> bookings = new ArrayList<>();

        PreparedStatement statement = connection.prepareStatement(sql);
        ResultSet resultSet = statement.executeQuery();

        while(resultSet.next()) {
            Boocking booking = fromResultSet(resultSet);
            bookings.add(booking);
        }

        return bookings;
    }

    public ArrayList<Boocking> findByUserID(int idUser) throws SQLException {
        String sql = "SELECT * FROM BOOKING WHERE id_user = ?";
        ArrayList<Boocking> bookings = new ArrayList<>();

        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, idUser);
        ResultSet resultSet = statement.executeQuery();

        while(resultSet.next()) {
            Boocking booking = fromResultSet(resultSet);
            bookings.add(booking);
        }

        return bookings;
    }

    public Optional<Boocking> findById(int id) throws SQLException {
        String sql = "SELECT * FROM BOOKING WHERE id_booking = ?";
        Boocking boocking = null;

        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, id);
        ResultSet resultSet = statement.executeQuery();

        if(resultSet.next()) {
            boocking = fromResultSet(resultSet);
        }

        return Optional.ofNullable(boocking);
    }

    public void modify(int id, LocalDate checkinDate, LocalDate checkoutDate, int roomNumber, String state, String paymentMethod) throws SQLException {
        String sql = "UPDATE BOOKING SET in_date = ?, out_date = ?, room_number = ?, pay_state = ?, pay_method = ? WHERE id_booking = ?";
        BoockingDao boockingDao = new BoockingDao(connection);

        PreparedStatement statement = connection.prepareStatement(sql);

        statement.setDate(1, java.sql.Date.valueOf(checkinDate));
        statement.setDate(2, java.sql.Date.valueOf(checkoutDate));
        statement.setInt(3, roomNumber);
        statement.setString(4, state);
        statement.setString(5, paymentMethod);
        statement.setInt(6, id);
        statement.executeUpdate();
    }

    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM BOOKING WHERE id_booking = ?";

        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, id);
        int row = statement.executeUpdate();

        return row == 1;
    }


    private Boocking fromResultSet(ResultSet resultSet) {
        Boocking boocking = new Boocking();

        boocking.setId(resultSet.getInt("id_booking"));
        boocking.setCheckinDate(new java.util.Date(resultSet.getDate("in_date").getTime()).toInstant().atZone(ZoneId.systemDefault()).toLocalDate());
        boocking.setCheckinOut(new java.util.Date(resultSet.getDate("out_date").getTime()).toInstant().atZone(ZoneId.systemDefault()).toLocalDate());
        boocking.setRoomNumber(resultSet.getInt("room_number"));
        boocking.setState(resultSet.getString("pay_state"));
        boocking.setPaymentMethod(resultSet.getString("pay_method"));

        return boocking;
    }
}
