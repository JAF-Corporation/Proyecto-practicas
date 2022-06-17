<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
%>

<%@ page import="com.svalero.choom.dao.Database" %>
<%@ page import="com.svalero.choom.domain.User" %>
<%@ page import="java.util.Optional" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.svalero.choom.dao.UserDao" %>

<%
    String textButton = "";
    String userId = request.getParameter("id_user");
    User user = null;
    if (userId != null) {
        textButton = "Modificar";
        Database db = new Database();
        UserDao userDao = new UserDao(db.getConnection());
        try {
            Optional<User> optionalUser = userDao.findById(Integer.parseInt(userId));
            user = optionalUser.get();
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
    } else {
        textButton = "Register";
    }
%>

<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <title>Alta usuario nuevo</title>

</head>
<body>
<script type="text/javascript">
    $(document).ready(function() {
        $("form").on("submit", function(event) {
            event.preventDefault();
            var formValue = $(this).serialize();
            $.post("register-servlet", formValue, function(data) {
                $("#result").html(data);
            });
        });
    });
</script>

<div class="container">
    <h2>Sign In</h2>
    <form>
        <div class="mb-2">
            <label for="username" class="form-label">Username</label>
            <input name="username" type="text" class="form-control w-25" id="username" value="<% if (user != null) out.print(user.getUsername()); %>">
        </div>
        <div class="mb-2">
            <label for="password" class="form-label">Password</label>
            <input name="password" type="password" class="form-control w-25" id="password" value="<% if (user != null) out.print(user.getPassword()); %>">
        </div>
        <div class="mb-2">
            <label for="email" class="form-label">Email</label>
            <input name="email" type="text" class="form-control w-25" id="email" value="<% if (user != null) out.print(user.getEmail()); %>">
        </div>
        <div class="mb-3">
            <label for="personal_name" class="form-label">Name</label>
            <input name="personal_name" type="text" class="form-control w-25" id="personal_name" value="<% if (user != null) out.print(user.getPersonalName()); %>">
        </div>
        <div class="mb-3">
            <label for="user_address" class="form-label">Address</label>
            <input name="user_address" type="text" class="form-control w-25" id="user_address" value="<% if (user != null) out.print(user.getAddress()); %>">
        </div>
        <div class="mb-3">
        <label for="user_tlp" class="form-label">Telephone</label>
        <input name="user_tlp" type="text" class="form-control w-25" id="user_tlp" value="<% if (user != null) out.print(user.getTelephone()); %>">
        </div>


        <input type="hidden" name="action" value="<% if (user != null) out.print("modify"); else out.print("register"); %>">
        <input type="hidden" name="userId" value="<% if (user != null) out.print(user.getUserID()); %>">
        <button type="submit" class="btn btn-primary"><%= textButton %></button>
        <button type="button" onclick="window.location.href='index.jsp'" class="btn btn-danger">Back</button>

    </form>
    <div id="result"></div>
</div>
</body>
</html>
