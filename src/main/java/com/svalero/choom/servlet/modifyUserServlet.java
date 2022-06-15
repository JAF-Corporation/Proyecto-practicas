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

@WebServlet("/modifyUser")
public class modifyUserServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();

        User currentUser = (User) req.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            resp.sendRedirect("roleDenied.jsp");
        }

        Integer userID = Integer.parseInt(req.getParameter("userId"));
        String personalName = req.getParameter("personalName");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String address = req.getParameter("address");
        String telephone = req.getParameter("telephone");
        User user = new User(personalName,username,password,email,address,telephone);

        Database database = new Database();
        UserDao userDao = new UserDao(database.getConnection());

        try {
            userDao.modify(userID,user);
            out.println("<div class='alert alert-success' role='alert'>\n" +
                    "  <h4 class='alert-heading'>Modification success</h4>\n" +
                    "  <p>The user was modificated successfully</p>\n" +
                    "  <hr>\n" +
                    "  <p class='mb-0'><a href='/choom/index.jsp'>Go to menu</a></p>\n" +
                    "</div>");
        } catch (SQLException sqlee) {
            out.println("<div class='alert alert-danger' role='alert'>ERROR:Can not connect to database</div>");
            sqlee.printStackTrace();
        }
    }
}
