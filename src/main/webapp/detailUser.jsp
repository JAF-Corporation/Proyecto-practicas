<%@ page import="com.svalero.choom.domain.User" %>
<%@ page import="com.svalero.choom.dao.Database" %>
<%@ page import="com.svalero.choom.dao.UserDao" %>
<%@ page import="java.util.Optional" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>

<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    </head>
    <body>
    <%
        int userID = Integer.parseInt(request.getParameter("userID"));
        Database database = new Database();
        UserDao userDao = new UserDao(database.getConnection());
        User user = null;
        try {
            Optional<User> optionalUser = userDao.findById(userID);
            user = optionalUser.get();
    %>

    <div class="container">
        <h1> CHOOM </h1>
        <h2> User detail</h2>
        <ul class="list-group">
            <li class="list-group-item">User ID: <%= user.getUserID() %></li>
            <li class="list-group-item">Username: <%= user.getUsername() %></li>
            <li class="list-group-item">Password: <%= user.getPassword() %></li>
            <li class="list-group-item">Address: <%= user.getAddress() %></li>
            <li class="list-group-item">Telephone: <%= user.getTelephone() %></li>
            <li class="list-group-item">Email: <%= user.getEmail() %></li>
        </ul>
    </div>
    <%
    }catch (SQLException sqle) {
    %>
    <div class='alert alert-danger' role='alert'>ERROR: Can not connect with database</div>
    <%
            sqle.printStackTrace();
        }
    %>

    </body>
</html>
