<%@ page import="com.svalero.choom.domain.User" %>
<%@ page import="com.svalero.choom.dao.Database" %>
<%@ page import="com.svalero.choom.domain.Booking" %>
<%@ page import="com.svalero.choom.dao.BookingDao" %>
<%@ page import="java.util.Optional" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>

<%
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect("roleDenied.jsp");
    }

    int bookingID = Integer.parseInt(request.getParameter("bookingID"));
    Booking booking = null;

    Database database = new Database();
    BookingDao bookingDao = new BookingDao(database.getConnection());

    try {
        Optional<Booking> optionalBooking = bookingDao.findById(bookingID);
        booking = optionalBooking.get();
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
            $.post("modifyBooking", formValue, function(data) {
                $("#result").html(data);
            });
        });
    });
</script>
<div class="container">
    <h1> CHOOM </h1>
    <h2>Modify Booking</h2>
    <form>
        <div class="mb-2">
            <label for="checkin" class="form-label">New Checking</label>
            <input name="checkin" type="date" class="form-control w-25" id="checkin" value="<%= booking.getCheckinDate() %>">
        </div>
        <div class="mb-2">
            <label for="checkout" class="form-label">New Checkout</label>
            <input name="checkout" type="date" class="form-control w-25" id="checkout" value="<%= booking.getCheckoutDate() %>">
        </div>
        <div style="margin-top: 10px;" class="mb-2">
            <label for="numRoom" class="form-label">Total rooms</label>
            <input class="quantity" id="numRoom" min="0" name="numRoom" value="<%= booking.getNumRoom()%>" type="number">
        </div>
        <div class="btn-group">
            <select class="btn btn-primary dropdown-toggle" name="state" id="state" >
                <option value="pendiente">Pending</option>
                <option value="pagado">Payd</option>
            </select>
        </div>
        <div class="btn-group">
            <select class="btn btn-primary dropdown-toggle" name="paymentMethod" id="paymentMethod" >
                <option value="mastercard">Master Card</option>
                <option value="creditcard">Credit Card</option>
                <option value="debitcard">Debit Card</option>
                <option value="paypal">PayPal</option>
            </select>
        </div>
        <input type="hidden" name="bookingID" value="<%= booking.getBookingID() %>">
        <button type="submit" class="btn btn-primary">Send</button>
    </form>
    <div id="result"></div>
</div>
</body>
</html>