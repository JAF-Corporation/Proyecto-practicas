package com.svalero.choom.servlet;

import com.svalero.choom.dao.Database;
import com.svalero.choom.dao.HotelDao;
import com.svalero.choom.domain.Hotel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet("/search-hotel")
public class searchHotelServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();

        String searchText = req.getParameter("searchText");

        Database database = new Database();
        HotelDao hotelDao = new HotelDao(database.getConnection());

        try {
            ArrayList<Hotel> hotels = hotelDao.findAllHotelsByText(searchText);
            StringBuilder result = new StringBuilder("<ul class='list-group'>");

            for (Hotel hotel : hotels) {
                result.append("<li class='list-group-item'> Hotel name: ").append(hotel.getName()).append("</li>");
                result.append("<li class='list-group-item'> Address: ").append(hotel.getAddress()).append("</li>");
                result.append("<li class='list-group-item'> City: ").append(hotel.getCity()).append("</li>");
                result.append("<li class='list-group-item'> Rating: ").append(hotel.getRating()).append("</li>");
            }
            result.append("</ul>");
            out.println(result);
        } catch ( SQLException sqle) {
            out.println("<div class='alert alert-danger' role='alert'>ERROR: Can not connect to database</div>");
            sqle.printStackTrace();
        }

    }
}
