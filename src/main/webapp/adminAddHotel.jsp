<%@ page import="com.svalero.choom.domain.User" %>
<%@ page import="com.svalero.choom.domain.Hotel" %>
<%@ page import="com.svalero.choom.dao.Database" %>
<%@ page import="com.svalero.choom.dao.HotelDao" %>
<%@ page import="java.util.Optional" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect("roleDenied.jsp");
    }

%>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<script type="text/javascript">
    $(document).ready(function() {
        $("form").on("submit", function(event) {
            event.preventDefault();
            var formValue = $(this).serialize();
            $.post("addHotel", formValue, function(data) {
                $("#result").html(data);
            });
        });
    });
</script>
<div class="container">
    <h1> CHOOM </h1>
    <h2>New Hotel</h2>
    <form>
        <div class="mb-2">
            <label for="name" class="form-label">Name</label>
            <input name="name" type="text" class="form-control w-25" id="name" value="">
        </div>
        <div class="mb-2">
            <label for="address" class="form-label">Address</label>
            <input name="address" type="text" class="form-control w-25" id="address" value="">
        </div>
        <div class="mb-2">
            <label for="city" class="form-label">City</label>
            <input name="city" type="text" class="form-control w-25" id="city" value="">
        </div>
        <div class="mb-2">
            <label for="rating" class="form-label">Rating</label>
            <input name="rating" type="text" class="form-control w-25" id="rating" value="">
        </div>
        <div class="mb-2">
            <label for="hotelCategoryID" class="form-label">Rating</label>
            <input name="hotelCategoryID" type="text" class="form-control w-25" id="hotelCategoryID" value="">
        </div>
        <button type="submit" class="btn btn-primary">Send</button>
    </form>
    <div id="result"></div>
</div>
</body>
</html>
