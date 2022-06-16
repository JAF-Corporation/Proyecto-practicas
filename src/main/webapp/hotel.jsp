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
        <div class="card mb-3">
            <img src="img/hotels/<%= hotel.getName() %>.jpg" class="card-img-top justify-content-center text-center" alt="..." style="width: 300px">
            <div class="card-body text-center">
                <h5 class="card-title"><<%= hotel.getName() %></h5>
                <h6 class="card-title"><<%= hotel.getAddress() + " - " + hotel.getCity() %></h6>
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
                        <td><button type="button" class="w-100 btn btn-primary btn-lg" style="margin-top: 10px"><a href="booking.jsp?id=<%=rooms.get(i).getRoomID()%>" style="text-decoration:none; color:white">Pay</button></td>
                    </tr>



                    </tbody>
                </table>
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