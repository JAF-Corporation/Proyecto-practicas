<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
%>

<%@ page import="com.svalero.choom.dao.Database" %>
<%@ page import="com.svalero.choom.domain.User" %>
<%@ page import="com.svalero.choom.dao.BookingDao" %>
<%@ page import="com.svalero.choom.domain.Booking" %>
<%@ page import="java.util.Optional" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.svalero.choom.dao.UserDao" %>
<%@ page import="com.svalero.choom.domain.Room" %>

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
    <title>Pago</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/css/bootstrap.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap-responsive.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/js/bootstrap.js"></script>

</head>
<body>
<script type="text/javascript">
    $(document).ready(function() {
        $("form").on("submit", function(event) {
            event.preventDefault();
            var formValue = $(this).serialize();
            $.post("pay", formValue, function(data) {
                $("#result").html(data);
            });
        });
    });
</script>

<%
    int bookingID = Integer.parseInt(request.getParameter("bookingID"));
%>

<div style="margin: 50px; justify-content: center" class="container">
    <h2>Booking process</h2>

    <form method="post" action="pay">
        <div class="mb-2">
            <label for="checkinDate" class="form-label">Property Name</label>
            <input name="checkinDate" type="text" class="form-control w-25" id="checkinDate">
        </div>
        <div class="mb-2">
            <label for="checkinDate" class="form-label">Card Number</label>
            <input name="cardNumber" type="text" class="form-control w-25" id="cardNumber">
        </div>
        <div class="mb-2">
            <label for="checkoutDate" class="form-label">Date Expiry</label>
            <input name="checkoutDate" type="date" class="form-control w-25" id="checkoutDate">
        </div>
        <div style="margin-top: 10px;" class="mb-2">
            <label for="noomRoom" class="form-label">CVV</label>
            <input class="text" id="noomRoom" name="numRoom"type="text">
        </div>
        <div style="margin-top: 30px;" class="btn.group">
            <input type="hidden" name="bookingID" value="<%= bookingID %>">
            <button type="submit" class="btn btn-primary"><strong>Confirm payment</strong></button>
        </div>
    </form>
    <div id="result"></div>
</div>
</body>
</html>