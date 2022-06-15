package com.svalero.choom.servlet;

import com.svalero.choom.dao.BookingDao;
import com.svalero.choom.dao.Database;
import com.svalero.choom.domain.Booking;
import com.svalero.choom.exception.BookingAlreadyExistException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDate;

@WebServlet("/booking")
public class AddBookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();

        //TODO CONTROL DE USUARIOS

        Integer bookingID = Integer.parseInt(req.getParameter("bookingID"));
        LocalDate checkinDate = LocalDate.parse(req.getParameter("checkinDate"));
        LocalDate checkoutDate = LocalDate.parse(req.getParameter("checkoutDate"));
        Integer numRoom = Integer.parseInt(req.getParameter("numRoom"));
        String state = req.getParameter("state");
        String paymentMethod = req.getParameter("paymentMehtod");
        Booking booking = new Booking(bookingID,checkinDate,checkoutDate,numRoom,state,paymentMethod);

        Database database = new Database();
        BookingDao bookingDao = new BookingDao(database.getConnection());

        try{
            bookingDao.add(booking);
            out.println("<div class='alert alert-success' role='alert'>\n" +
                    "  <h4 class='alert-heading'>Success booking</h4>\n" +
                    "  <p>The booking was made succesfully</p>\n" +
                    "  <hr>\n" +
                    "  <p class='mb-0'><a href='/academia-servlet/index.jsp'>Go to menu</a></p>\n" +
                    "  </div>");
        }catch (SQLException sqlee) {
            out.println("<div class='alert alert-danger' role='alert'>ERROR: Can not connect with database</div>");
            sqlee.printStackTrace();
        }catch (BookingAlreadyExistException baee) {
            out.println("<div class='alert alert-danger' role='alert'>ERROR: This booking already exists</div>");
            baee.printStackTrace();
        }

    }
}
