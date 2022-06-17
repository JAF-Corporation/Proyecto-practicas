<%@ page import="com.svalero.choom.domain.User" %>
<%@ page import="com.svalero.choom.dao.Database" %>
<%@ page import="com.svalero.choom.dao.UserDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>

<%
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
    }
%>

<html>
    <head>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    </head>
    <body>
    <div class="container">
        <h1> CHOOM </h1>
        <h2> User list </h2>
        <div class="accordion" id="accordionPanelsStayOpenExample">
            <% Database database = new Database();
                UserDao userDao = new UserDao(database.getConnection());
                try{
                    List<User> users = userDao.findAll();
                    for (User user : users) {
            %>
            <div class="accordion-item">
                <h2 class="accordion-header" id="panelsStayOpen-headingOne">
                    <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne">
                        <%= user.getUserID() + ". " + user.getUsername() +" / "+ user.getPersonalName() %>
                    </button>
                </h2>
            </div>
            <div id="panelsStayOpen-collapseOne" class="accordion-collapse collapse show" aria-labelledby="panelsStayOpen-headingOne">
                <div class="accordion-body">
                    <a href="detailUser.jsp?userID=<%= user.getUserID() %>" class="link-success">User info</a>
                    <a href="adminModifyUser.jsp?userID=<%= user.getUserID() %>" class="link-primary">Modify</a>
                    <a href="deleteUser?userID=<%= user.getUserID() %>" class="link-danger">Delete</a>
                </div>
            </div>
            <%
                }
            } catch (SQLException sqle) {
            %>
            <div class="alert alert-danger" role="alert">
                ERROR: Can not connect with database
            </div>
            <%
                }
            %>
        </div>
    </div>
    </body>
</html>
