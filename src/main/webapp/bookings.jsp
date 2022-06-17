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
    <title>Bookings</title>
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
    ArrayList<Booking> bookings = new ArrayList<>();
    if (currentUser.getRole().equals("user")) {
        bookings = bookingDao.findByUserID(currentUser.getUserID());
    }
    else {
        bookings = bookingDao.findAll();
    }
    RoomDao roomDao = new RoomDao(database.getConnection());
    HotelDao hotelDao = new HotelDao(database.getConnection());
%>

<div class="container">
    <%
        if(currentUser.getRole().equals("user")) {
    %>
    <h2 class="text-center" style="margin: 50px">MY BOOKINGS</h2>
    <%
        } else {
    %>
    <h2 class="text-center" style="margin: 50px">ALL BOOKINGS</h2>
    <%
        }
    %>

    <div style="justify-content: center;" class="container">
        <%
            for(int i = 0; i < bookings.size(); i++) {

                Room room = roomDao.findById(bookings.get(i).getRoomID()).get();
                Hotel hotel = hotelDao.findByHotelID(room.getHotelID()).get();

        %>
        <div class="card" style="width: auto;  margin: 20px">
            <img src="img/hotels/<%= hotel.getName()%>.jpg" class="card-img-top justify-content-center text-center" alt="..." style="width: 20%">
            <div class="card-body text-center">
                <table class="table">
                    <thead>
                    <tr>
                        <th scope="col">Checkin</th>
                        <th scope="col">Checkout</th>
                        <th scope="col">Rooms</th>
                        <th scope="col">Payment Method</th>
                        <th scope="col">State</th>
                    </tr>
                    </thead>
                    <tbody>

                    <tr>
                        <td><%= bookings.get(i).getCheckinDate() %></td>
                        <td><%= bookings.get(i).getCheckoutDate() %></td>
                        <td><%= bookings.get(i).getNumRoom()%></td>
                        <td><%= bookings.get(i).getPaymentMethod()%></td>
                        <%
                            if (bookings.get(i).getState().equals("Pendiente")) {
                        %>
                        <td>PENDIENTE</td>
                        <%
                            } else {
                        %>
                        <td>PAGADO</td
                        <%
                            }
                        %>

                        <%
                            if(currentUser.getRole().equals("user") && bookings.get(i).getState().equals("Pendiente")) {
                        %>
                        <td><a href="card-payment.jsp?bookingID=<%= bookings.get(i).getBookingID() %>" class="w-100 btn btn-primary btn-lg" style="text-decoration:none; color:white">Pay</a></td>
                        <%
                        } else if (currentUser.getRole().equals("admin")) {
                        %>
                        <td><a href="#" class="w-100 btn btn-warning btn-lg" style="text-decoration:none; color:white">Modify</a></td>
                        <%
                            }
                        %>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <%
            }
        %>
    </div>
    <button type="button" onclick="window.location.href='index.jsp'" class="btn btn-secondary">Back</button>



</div>
</body>
</html>