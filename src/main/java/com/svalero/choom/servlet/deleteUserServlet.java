package com.svalero.choom.servlet;

import com.svalero.choom.dao.Database;
import com.svalero.choom.dao.UserDao;
import com.svalero.choom.domain.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet("/deleteUser")
public class deleteUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();

        out.println("<head><link href='https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css' rel='stylesheet' integrity='sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3' crossorigin='anonymous'></head>");

        User currentUser = (User) req.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            resp.sendRedirect("roleDenied.jsp");
        }

        Integer userID = Integer.parseInt(req.getParameter("userID"));

        Database database = new Database();
        UserDao userDao = new UserDao(database.getConnection());

        try{
            userDao.delete(userID);
            out.println("<div class='alert alert-success' role='alert'>\n" +
                    "  <h4 class='alert-heading'>USER DELETED</h4>\n" +
                    "  <p>User was deleted successfully</p>\n" +
                    "  <hr>\n" +
                    "  <p class='mb-0'><a href='/choom/index.jsp'>Go to menu</a></p>\n" +
                    "</div>");
        }catch (SQLException sqle) {
            out.println("<div class='alert alert-danger' role='alert'>ERROR: Can not connect to database</div>");
            sqle.printStackTrace();
        }
    }
}
