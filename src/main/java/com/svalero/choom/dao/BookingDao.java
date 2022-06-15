package com.svalero.choom.dao;

import com.svalero.choom.domain.Booking;
import com.svalero.choom.exception.BookingAlreadyExistException;

import java.sql.*;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Optional;

public class BookingDao {

    private Connection connection;

    public BookingDao(Connection connection) {
        this.connection = connection;
    }

    public void add(Booking booking, int userID, int roomID) throws SQLException, BookingAlreadyExistException {
        if (existBooking(booking.getBookingID())){
            throw new BookingAlreadyExistException();
        }

        String sql = "INSERT INTO BOOKING (in_date, out_date, room_number, pay_state, pay_method, id_user, id_room) VALUES (?, ?, ?, ?, ?, ?, ?)";

        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setDate(1, java.sql.Date.valueOf(booking.getCheckinDate()));
        statement.setDate(2, java.sql.Date.valueOf(booking.getCheckoutDate()));
        statement.setInt(3, booking.getNumRoom());
        statement.setString(4, "Pendiente");
        statement.setString(5, booking.getPaymentMethod());
        statement.setInt(6, userID);
        statement.setInt(7, roomID);
        statement.executeUpdate();
    }

    private boolean existBooking(int bookingID) throws SQLException {
        Optional<Booking> booking = findById(bookingID);
        return booking.isPresent();
    }

    public ArrayList<Booking> findAll() throws SQLException {
        String sql = "SELECT * FROM BOOKING ORDER BY in_date";
        ArrayList<Booking> bookings = new ArrayList<>();

        PreparedStatement statement = connection.prepareStatement(sql);
        ResultSet resultSet = statement.executeQuery();

        while(resultSet.next()) {
            Booking booking = fromResultSet(resultSet);
            bookings.add(booking);
        }

        return bookings;
    }

    public ArrayList<Booking> findByUserID(int idUser) throws SQLException {
        String sql = "SELECT * FROM BOOKING WHERE id_user = ?";
        ArrayList<Booking> bookings = new ArrayList<>();

        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, idUser);
        ResultSet resultSet = statement.executeQuery();

        while(resultSet.next()) {
            Booking booking = fromResultSet(resultSet);
            bookings.add(booking);
        }

        return bookings;
    }

    public Optional<Booking> findById(int id) throws SQLException {
        String sql = "SELECT * FROM BOOKING WHERE id_booking = ?";
        Booking booking = null;

        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, id);
        ResultSet resultSet = statement.executeQuery();

        if(resultSet.next()) {
            booking = fromResultSet(resultSet);
        }

        return Optional.ofNullable(booking);
    }


    public void modify(int id, LocalDate checkinDate, LocalDate checkoutDate, int roomNumber, String state, String paymentMethod) throws SQLException {
        String sql = "UPDATE BOOKING SET in_date = ?, out_date = ?, room_number = ?, pay_state = ?, pay_method = ? WHERE id_booking = ?";
        BookingDao boockingDao = new BookingDao(connection);

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


    private Booking fromResultSet(ResultSet resultSet) throws SQLException{
        Booking booking = new Booking();

        booking.setBookingID(resultSet.getInt("id_booking"));
        booking.setCheckinDate(new java.util.Date(resultSet.getDate("in_date").getTime()).toInstant().atZone(ZoneId.systemDefault()).toLocalDate());
        booking.setCheckoutDate(new java.util.Date(resultSet.getDate("out_date").getTime()).toInstant().atZone(ZoneId.systemDefault()).toLocalDate());
        booking.setNumRoom(resultSet.getInt("room_number"));
        booking.setState(resultSet.getString("pay_state"));
        booking.setPaymentMethod(resultSet.getString("pay_method"));
        booking.setUserID(resultSet.getInt("id_user"));
        booking.setRoomID(resultSet.getInt("id_room"));

        return booking;
    }
}
