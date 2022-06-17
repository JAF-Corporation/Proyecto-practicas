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
        String hotelID = request.getParameter("hotelID");
        Database database = new Database();
        HotelDao hotelDao = new HotelDao(database.getConnection());
        Hotel hotel = null;
        RoomDao roomDao = new RoomDao(database.getConnection());
        ArrayList<Room> rooms = roomDao.findByHotelID(Integer.parseInt(hotelID));
        try {
            Optional<Hotel> optionalEstablishment = hotelDao.findByHotelID(Integer.parseInt(hotelID));
            hotel = optionalEstablishment.get();

    %>
    <div style="justify-content: center" class="container">
        <div class="card mb-3" style="margin: 50px">
            <div class="card-body" style="display: flex">
                <img src="img/hotels/<%= hotel.getName() %>.jpg" class="card-img-top justify-content-center text-center" alt="..." style="width: 300px">
                <h6 class="card-title"><<%= hotel.getAddress() + " - " + hotel.getCity() %></h6>
                <h5 class="card-title"><<%= hotel.getName() %></h5>
            </div>
            <div class="card-body text-center">
                <table class="table">
                    <thead>
                    <tr>
                        <th scope="col"></th>
                        <th scope="col">Type</th>
                        <th scope="col">Available rooms</th>
                        <th scope="col">Price</th>
                    </tr>
                    </thead>
                    <tbody>

                    <%
                        for(int i=0; i < rooms.size(); i++) {
                    %>

                    <tr>
                        <th scope="row"></th>
                        <td><%= rooms.get(i).getType() %></td>
                        <td><%= rooms.get(i).getTotalRooms() %></td>
                        <td><%= rooms.get(i).getPrice()%>&euro;</td>
                        <td><a href="booking.jsp?id=<%=rooms.get(i).getRoomID()%>" class="w-100 btn btn-primary btn-lg" style="text-decoration:none; color:white">Booking</a></td>
                    </tr>

                    <%
                        }
                    %>


                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <%
        } catch (SQLException sqle) {
    %>
        <div class='alert alert-danger' role='alert'>ERROR: Can not connect to database</div>
    <%
        }
    %>
</body>
</html>