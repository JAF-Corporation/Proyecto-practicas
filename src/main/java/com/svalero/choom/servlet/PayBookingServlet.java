package com.svalero.choom.servlet;

import com.svalero.choom.dao.BookingDao;
import com.svalero.choom.dao.Database;
import com.svalero.choom.domain.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet("/pay")
public class PayBookingServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();

        HttpSession session = req.getSession(true);
        User currentUser = (User) session.getAttribute("currentUser");

        int bookingID = Integer.parseInt(req.getParameter("bookingID"));

        Database database = new Database();
        BookingDao bookingDao = new BookingDao(database.getConnection());

        try{
            bookingDao.modifyState(bookingID);
            out.println("<div class='alert alert-success' role='alert'>\n" +
                    "  <h4 class='alert-heading'>Success pay</h4>\n" +
                    "  <p>The booking was payed</p>\n" +
                    "  <hr>\n" +
                    "  <p class='mb-0'><a href='/choom/bookings.jsp'>Go to my bookings</a></p>\n" +
                    "  </div>");
        }catch (SQLException sqlee) {
            out.println("<div class='alert alert-danger' role='alert'>ERROR: Can not connect to database</div>");
            sqlee.printStackTrace();
        }
    }
}
