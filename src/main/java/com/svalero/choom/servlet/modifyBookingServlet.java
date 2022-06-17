package com.svalero.choom.servlet;


import com.svalero.choom.dao.BookingDao;
import com.svalero.choom.dao.Database;
import com.svalero.choom.domain.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDate;

@WebServlet("/modifyBooking")
public class modifyBookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();

        User currentUser = (User) req.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            resp.sendRedirect("roleDenied.jsp");
        }

        int bookingID = Integer.parseInt(req.getParameter("bookingID"));
        LocalDate checkin = LocalDate.parse(req.getParameter("checkin"));
        LocalDate checkout = LocalDate.parse(req.getParameter("checkout"));
        int numRoom = Integer.parseInt(req.getParameter("numRoom"));
        String state = req.getParameter("state");
        String paymentMethod = req.getParameter("paymentMethod");

        out.println("<p>" + state + "</p>");
        Database database = new Database();
        BookingDao bookingDao = new BookingDao(database.getConnection());

        try {
            bookingDao.modify(bookingID, checkin, checkout, numRoom, state, paymentMethod);
            out.println("<div class='alert alert-success' role='alert'>\n" +
                    "  <h4 class='alert-heading'>Modification success</h4>\n" +
                    "  <p>The booking was modificated successfully</p>\n" +
                    "  <hr>\n" +
                    "  <p class='mb-0'><a href='/choom/index.jsp'>Go to menu</a></p>\n" +
                    "</div>");

        } catch (SQLException sqle) {
            out.println("<div class='alert alert-danger' role='alert'>ERROR:Can not connect to database</div>");
            sqle.printStackTrace();
        }
    }
}
