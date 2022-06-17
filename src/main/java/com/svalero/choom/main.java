package com.svalero.choom;

import com.svalero.choom.dao.BookingDao;
import com.svalero.choom.dao.Database;
import com.svalero.choom.domain.Booking;

import java.sql.SQLException;
import java.util.ArrayList;

public class main {
    public static void main(String[] args) throws SQLException {

        Database database = new Database();
        BookingDao bookingDao = new BookingDao(database.getConnection());
        ArrayList<Booking> bookings = bookingDao.findByUserID(2);

        for(Booking booking : bookings) {
            System.out.println(booking.getBookingID());
            System.out.println(booking.getRoomID());
            System.out.println(booking.getCheckinDate());
            System.out.println(booking.getCheckoutDate());
            System.out.println(booking.getNumRoom());
            System.out.println(booking.getState());
            System.out.println(booking.getPaymentMethod());
        }
    }
}
