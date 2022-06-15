<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
%>

<%@ page import="com.svalero.choom.domain.User" %>
<%@ page import="com.svalero.choom.domain.Booking" %>
<%@ page import="java.util.Optional" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.svalero.choom.domain.Room" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.svalero.choom.dao.*" %>
<%@ page import="com.svalero.choom.domain.Hotel" %>

<%
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
    }
%>


<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <title>Reservas</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/css/bootstrap.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap-responsive.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/js/bootstrap.js"></script>

</head>
<body>

<%
    Database database = new Database();
    BookingDao bookingDao = new BookingDao(database.getConnection());
    ArrayList<Booking> bookings = bookingDao.findByUserID(currentUser.getUserID());
    RoomDao roomDao = new RoomDao(database.getConnection());
    HotelDao hotelDao = new HotelDao(database.getConnection());
%>

<div class="container">
    <%
        if(currentUser.getRole().equals("user")) {
    %>
    <h2>My Bookings</h2>
    <%
        } else {
    %>
        <h2>All Bookings</h2>
    <%
        }
    %>

    <div style="justify-content: center" class="container">
        <%
            for(int i = 0; i < bookings.size(); i++) {
        %>
        <div class="card" style="width: 18rem;">
            <img src="..." class="card-img-top" alt="...">
            <div class="card-body">
                <h5 class="card-title"><%= bookings.get(i).getCheckinDate() %></h5>
                <h5 class="card-title"><%= bookings.get(i).getCheckoutDate() %></h5>
                <p class="card-text"><%= bookings.get(i).getNumRoom() %></p>
                <p class="card-text"><%= bookings.get(i).getPaymentMethod() %></p>
                <%
                    if(bookings.get(i).getState().equals("Pendiente")) {
                %>
                <a href="#" class="btn btn-primary" target="_blank"><strong>Pay</strong></a>
                <%
                    }
                %>
            </div>
        </div>
        <%
            }
        %>
    </div>


</div>
</body>
</html>