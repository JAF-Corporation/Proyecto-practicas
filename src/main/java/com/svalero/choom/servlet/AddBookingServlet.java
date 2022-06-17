package com.svalero.choom.servlet;

import com.svalero.choom.dao.BookingDao;
import com.svalero.choom.dao.Database;
import com.svalero.choom.domain.Booking;
import com.svalero.choom.domain.User;
import com.svalero.choom.exception.BookingAlreadyExistException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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

        HttpSession session = req.getSession(true);
        User currentUser = (User) session.getAttribute("currentUser");

        LocalDate checkinDate = LocalDate.parse(req.getParameter("checkinDate"));
        LocalDate checkoutDate = LocalDate.parse(req.getParameter("checkoutDate"));
        String paymentMethod = req.getParameter("paymentMethod");
        int numRoom = Integer.parseInt(req.getParameter("numRoom"));
        int roomID = Integer.parseInt(req.getParameter("roomID"));
        int userID = currentUser.getUserID();
        
        Booking booking = new Booking(checkinDate,checkoutDate,numRoom,paymentMethod);

        Database database = new Database();
        BookingDao bookingDao = new BookingDao(database.getConnection());

        try{
            bookingDao.add(booking, userID, roomID);
            out.println("<div class='alert alert-success' role='alert'>\n" +
                    "  <h4 class='alert-heading'>Success booking</h4>\n" +
                    "  <p>The booking was made succesfully</p>\n" +
                    "  <hr>\n" +
                    "  <p class='mb-0'><a href='/choom/index.jsp'>Go to menu</a></p>\n" +
                    "  </div>");
        }catch (SQLException sqlee) {
            out.println("<div class='alert alert-danger' role='alert'>ERROR: Can not connect to database</div>");
            sqlee.printStackTrace();
        }catch (BookingAlreadyExistException baee) {
            out.println("<div class='alert alert-danger' role='alert'>ERROR: This booking already exists</div>");
            baee.printStackTrace();
        }

    }
}
