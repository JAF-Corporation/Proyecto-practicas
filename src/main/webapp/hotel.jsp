<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="com.svalero.choom.domain.User"
%>
<%@ page import="com.svalero.choom.dao.Database" %>
<%@ page import="com.svalero.choom.dao.HotelDao" %>
<%@ page import="com.svalero.choom.domain.Hotel" %>
<%@ page import="com.svalero.choom.dao.RoomDao" %>
<%@ page import="com.svalero.choom.domain.Room" %>
<%@ page import="com.svalero.choom.domain.User" %>
<%@ page import="java.util.Optional" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.ArrayList" %>

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
    <%
        String hotelId = request.getParameter("id");
        Database database = new Database();
        HotelDao hotelDao = new HotelDao(database.getConnection());
        Hotel hotel = null;
        RoomDao roomDao = new RoomDao(database.getConnection());
        ArrayList<Room> rooms = roomDao.findByHotelID(Integer.parseInt(hotelId));
        try {
            Optional<Hotel> optionalEstablishment = hotelDao.findByHotelID(Integer.parseInt(hotelId));
            hotel = optionalEstablishment.get();

    %>
    <div style="justify-content: center" class="container">
        <div class="card" style="width: 18rem;">
            <img src="img/hotels/<%= hotel.getName() %>.jpg" class="card-img-top" alt="...">
            <div class="card-body">
                <h5 class="card-title"><%= hotel.getName() %></h5>
                <p class="card-text"><%= hotel.getAddress() %></p>
                <p class="card-text"><%= hotel.getCity() %></p>
            </div>
            <ul style="display: flex;" class="list-group list-group-flush">

                <div style="display: flex; justify-content: space-between;">
                <li class="list-group-item"><strong>TYPE</strong></li>
                <li class="list-group-item">AVAILABLE ROOMS</li>
                <li class="list-group-item">PRICE</li>
                </div>

                <%
                    for(int i=0; i < rooms.size(); i++) {
                %>

                <div style="display: flex; justify-content: space-between;">
                   <li class="list-group-item"><strong><%= rooms.get(i).getType() %></strong></li>
                <li class="list-group-item"><%= rooms.get(i).getTotalRooms() %></li>
                <li class="list-group-item"><%= rooms.get(i).getPrice() %>&euro;</li>
                </div>

                <%
                    }
                %>
            </ul>
            <div class="card-body">
                <a href="#" class="btn btn-primary">Booking</a>
            </div>
        </div>
    </div>
    <%
        } catch (SQLException sqle) {
    %>
        <div class='alert alert-danger' role='alert'>Se ha producido al cargar los datos del libro</div>
    <%
        }
    %>
</body>
</html>