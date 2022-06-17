<%@ page import="com.svalero.choom.domain.User" %>
<%@ page import="com.svalero.choom.dao.Database" %>
<%@ page import="com.svalero.choom.dao.HotelDao" %>
<%@ page import="com.svalero.choom.domain.Hotel" %>
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
<title>List Hotels</title>

    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    </head>
<body>
<div class="container">
    <h1> CHOOM </h1>
    <h2> Hotel list </h2>
    <div class="accordion" id="accordionPanelsStayOpenExample">
        <% Database database = new Database();
            HotelDao hotelDao = new HotelDao(database.getConnection());
            try{
                List<Hotel> hotels = hotelDao.findAllHotels();
                for (Hotel hotel : hotels) {
        %>
        <div class="accordion-item">
            <h2 class="accordion-header" id="panelsStayOpen-headingOne">
                <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne">
                    <%= hotel.getHotelID() + ". " + hotel.getName() %>
                </button>
            </h2>
        </div>
        <div id="panelsStayOpen-collapseOne" class="accordion-collapse collapse show" aria-labelledby="panelsStayOpen-headingOne">
            <div class="accordion-body">
                <a href="hotel.jsp?hotelID=<%= hotel.getHotelID() %>" class="link-success">Hotel info</a>
                <a href="adminModifyHotel.jsp?hotelID=<%= hotel.getHotelID() %>" class="link-primary">Modify</a>
                <a href="deleteHotel?hotelID=<%= hotel.getHotelID() %>" class="link-danger">Delete</a>
            </div>
        </div>
        <%
            }
        } catch (SQLException sqle) {
        %>
        <div class="alert alert-danger" role="alert">
            ERROR: Can not connect to database
        </div>
        <%
            }
        %>
    </div>
    <button type="button" onclick="window.location.href='index.jsp'" class="btn btn-secondary">Back</button>

</div>
</body>
</html>
