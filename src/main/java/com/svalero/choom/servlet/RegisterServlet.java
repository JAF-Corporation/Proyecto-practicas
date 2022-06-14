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

@WebServlet("/register-servlet")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String username = request.getParameter("username");
        String password = request.getParameter("password");       // input name="title" del formulario
        String email = request.getParameter("email");
        String personalName = request.getParameter("personal_name");
        String action = request.getParameter("action");
        String address = request.getParameter("user_address");
        String telephone = request.getParameter("user_tlp");
        String role = request.getParameter("user_role");
        Integer userId = Integer.valueOf(request.getParameter("id_user"));


        User user = new User(userId, username, password, email, personalName, address, telephone, role);

        Database database = new Database();
        UserDao userDao = new UserDao(database.getConnection());
        try {
            if (action.equals("register")) {
                userDao.add(user);
                out.println("<div class='alert alert-success' role='alert'>El usuario se ha registrado correctamente</div>");
            } else {
                userDao.modify(userId, user);
                out.println("<div class='alert alert-success' role='alert'>El usuario se ha modificado correctamente</div>");
            }
        } catch (SQLException sqle) {
            out.println("<div class='alert alert-danger' role='alert'>Se ha producido un error al registrar el articulo</div>");
            sqle.printStackTrace();
        }
    }
}