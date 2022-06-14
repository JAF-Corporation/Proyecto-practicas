package com.svalero.choom.dao;

import com.svalero.choom.domain.Hotel;
import com.svalero.choom.exception.HotelAlreadyExistsException;

import javax.xml.transform.Result;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Optional;

public class HotelDao {

    private Connection connection;

    public HotelDao(Connection connection) {
        this.connection = connection;
    }

    //AÑADIR

    public void addHotel(Hotel hotel) throws SQLException, HotelAlreadyExistsException {
        if (existHotel(hotel.getHotelID())){
            throw new HotelAlreadyExistsException();
        }

        connection.setAutoCommit(false);

        String sql = "INSERT INTO HOTEL (hotel_name, hotel_address, hotel_city, hotel_rating) VALUES (?,?,?,?)";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1,hotel.getName());
        statement.setString(2,hotel.getAddress());
        statement.setString(3,hotel.getCity());
        statement.setFloat(4,hotel.getRating());

        connection.commit();
        connection.setAutoCommit(true);
    }

    public boolean existHotel(int hotelID) throws SQLException{
        Optional<Hotel> hotel = findByHotelID(hotelID);
        return hotel.isPresent();
    }

    //BUSCAR POR ID

    public Optional<Hotel> findByHotelID(int hotelID) throws SQLException{
        Hotel hotel = null;

        String sql = "SELECT * FROM HOTEL WHERE id_hotel = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1,hotelID);
        ResultSet resultSet = statement.executeQuery();

        if (resultSet.next()) {
            hotel = new Hotel();
            hotel.setHotelID(resultSet.getInt("id_hotel"));
            hotel.setName(resultSet.getString("hotel_name"));
            hotel.setAddress(resultSet.getString("hotel_address"));
            hotel.setCity(resultSet.getString("hotel_city"));
            hotel.setRating(resultSet.getFloat("hotel_rating"));
        }

        return Optional.ofNullable(hotel);
    }

    // ELIMINAR POR ID

    public boolean deleteHotelByID(int hotelID) throws SQLException{
        connection.setAutoCommit(false);

        String sql = "DELELTE FROM HOTEL WHERE id_hotel = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1,hotelID);
        int rows = statement.executeUpdate();

        connection.commit();
        connection.setAutoCommit(true);

        return rows == 1;
    }

    // BUSQUEDA DE HOTELES POR NOMBRE O POR CIUDAD

    public ArrayList<Hotel> findAllHotelsByText(String searchText) throws SQLException{
        ArrayList<Hotel> hotels = new ArrayList<>();

        String sql = "SELECT * FROM HOTEL WHERE INSTR(hotel_name,?) != 0 OR INSTR(hotel_city,?) != 0 ORDER BY id_hotel";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1,searchText);
        statement.setString(2,searchText);
        ResultSet resultSet = statement.executeQuery();
        while (resultSet.next()){
            Hotel hotel = fromResultSet(resultSet);
        }
        return hotels;
    }

    public ArrayList<Hotel> findAllHotels() throws SQLException{
        ArrayList<Hotel> hotels = new ArrayList<>();

        String sql = "SELECT * FROM HOTEL ORDER BY hotel_name";
        PreparedStatement statement = connection.prepareStatement(sql);
        ResultSet resultSet = statement.executeQuery();

        while (resultSet.next()){
            Hotel hotel = fromResultSet(resultSet);
            hotels.add(hotel);
        }
        return hotels;
    }

    //MODIFICAR HOTEL POR ID

    public boolean modifyHotelByID(Hotel hotel, int hotelID) throws SQLException {
        connection.setAutoCommit(false);

        String sql = "UPDATE HOTEL SET hotel_name = ?, hotel_address = ?, hotel_city = ?, hotel_rating = ?, id_category = ? WHERE hotel_id = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, hotel.getName());
        statement.setString(2,hotel.getAddress());
        statement.setString(3,hotel.getCity());
        statement.setFloat(4,hotel.getRating());
        statement.setInt(5,hotel.getHotelCategoryID());
        statement.setInt(6,hotel.getHotelID());
        int rows = statement.executeUpdate();

        connection.commit();
        connection.setAutoCommit(true);

        return rows == 1;
    }

    public Hotel fromResultSet(ResultSet resultSet) throws SQLException{
        Hotel hotel = new Hotel();
        hotel.setHotelID(resultSet.getInt("id_hotel"));
        hotel.setName(resultSet.getString("hotel_name"));
        hotel.setAddress(resultSet.getString("hotel_address"));
        hotel.setCity(resultSet.getString("hotel_city"));
        hotel.setRating(resultSet.getFloat("hotel_rating"));
        hotel.setHotelCategoryID(resultSet.getInt("id_category"));
        return hotel;
    }

    // BUSCAR TODOS LOS HOTELES

    public ArrayList<Hotel> searchAllHotel() throws SQLException{
        ArrayList<Hotel> hotels = new ArrayList<>();

        String sql = "SELECT * FROM HOTEL ORDER BY id_hotel";
        PreparedStatement statement = connection.prepareStatement(sql);
        ResultSet resultSet = statement.executeQuery();

        while (resultSet.next()){
            Hotel hotel = fromResultSet(resultSet);
        }
        return hotels;

    }
}

