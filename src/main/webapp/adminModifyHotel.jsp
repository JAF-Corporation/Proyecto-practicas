<%@ page import="com.svalero.choom.domain.User" %>
<%@ page import="com.svalero.choom.dao.Database" %>
<%@ page import="com.svalero.choom.domain.Hotel" %>
<%@ page import="com.svalero.choom.dao.HotelDao" %>
<%@ page import="java.util.Optional" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>

<%
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect("roleDenied.jsp");
    }

    int hotelID = Integer.parseInt(request.getParameter("hotelID"));
    Hotel hotel = null;

    Database database = new Database();
    HotelDao hotelDao = new HotelDao(database.getConnection());

    try {
        Optional<Hotel> optionalHotel = hotelDao.findByHotelID(hotelID);
        hotel = optionalHotel.get();
    } catch(SQLException sqle) {
        out.print("ERROR: Can not connect to database");
        sqle.printStackTrace();
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
                $.post("modifyHotel", formValue, function(data) {
                    $("#result").html(data);
                });
            });
        });
    </script>
    <div class="container">
        <h1> CHOOM </h1>
        <h2>Modify Hotel</h2>
        <form>
            <div class="mb-2">
                <label for="name" class="form-label">New name</label>
                <input name="name" type="text" class="form-control w-25" id="name" value="<% hotel.getName(); %>">
            </div>
            <div class="mb-2">
                <label for="address" class="form-label">New address</label>
                <input name="address" type="text" class="form-control w-25" id="address" value="<% hotel.getAddress(); %>">
            </div>
            <div class="mb-2">
                <label for="city" class="form-label">New city</label>
                <input name="city" type="text" class="form-control w-25" id="city" value="<% hotel.getCity(); %>">
            </div>
            <div class="mb-2">
                <label for="address" class="form-label">Address</label>
                <input name="address" type="text" class="form-control w-25" id="address" value="<% hotel.getAddress(); %>">
            </div>
            <div class="mb-2">
                <label for="rating" class="form-label">Rating</label>
                <input name="rating" type="text" class="form-control w-25" id="rating" value="<% hotel.getRating(); %>">
            </div>
            <div class="mb-2">
                <label for="hotelCategoryID" class="form-label">Category</label>
                <input name="hotelCategoryID" type="text" class="form-control w-25" id="hotelCategoryID" value="<% hotel.getHotelCategoryID(); %>">
            </div>
            <input type="hidden" name="hotelID" value="<% hotel.getHotelID(); %>">
            <button type="submit" class="btn btn-primary">Send</button>
        </form>
        <div id="result"></div>
    </div>
    </body>
</html>
