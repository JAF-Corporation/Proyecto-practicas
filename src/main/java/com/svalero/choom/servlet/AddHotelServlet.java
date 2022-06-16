package com.svalero.choom.servlet;

import com.svalero.choom.dao.Database;
import com.svalero.choom.dao.HotelDao;
import com.svalero.choom.domain.Hotel;
import com.svalero.choom.domain.User;
import com.svalero.choom.exception.HotelAlreadyExistsException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet("/addHotel")
public class AddHotelServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();

        User currentUser = (User) req.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            resp.sendRedirect("roleDenied.jsp");
        }

        String name = req.getParameter("name");
        String address = req.getParameter("address");
        String city = req.getParameter("city");
        Float rating = Float.parseFloat(req.getParameter("rating"));
        Integer hotelCategoryID = Integer.parseInt(req.getParameter("hotelCategoryID"));
        Hotel hotel = new Hotel(name,address,city,rating,hotelCategoryID);

        Database database = new Database();
        HotelDao hotelDao = new HotelDao(database.getConnection());

        try {
            hotelDao.addHotel(hotel);
            out.println("<div class='alert alert-success' role='alert'>\n" +
                    "  <h4 class='alert-heading'>REGISTERED HOTEL</h4>\n" +
                    "  <p>The hotel was registered correctly.</p>\n" +
                    "  <hr>\n" +
                    "  <p class='mb-0'><a href='/choom/index.jsp'>Go to menu</a></p>\n" +
                    "</div>");
        } catch (SQLException sqle) {
            out.println("<div class='alert alert-danger' role='alert'>ERROR: Can not connect to database</div>");
            sqle.printStackTrace();
        } catch (HotelAlreadyExistsException haee) {
            out.println("<div class='alert alert-danger' role='alert'>ERROR: Hotel already exists</div>");
            haee.printStackTrace();
        }
    }
}
