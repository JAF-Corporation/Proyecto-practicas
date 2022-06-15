package com.svalero.choom.dao;

import com.svalero.choom.domain.User;
import com.svalero.choom.exception.UserAlreadyExistException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Optional;

public class UserDao {

    private Connection connection;

    public UserDao(Connection connection) {
        this.connection = connection;
    }

    public Optional<User> login(String username, String password) throws SQLException {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        User user = null;

        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, username);
        statement.setString(2, password);
        ResultSet resultSet = statement.executeQuery();
        if (resultSet.next()) {
            user = fromResultSet(resultSet);
        }

        return Optional.ofNullable(user);
    }

    public void add(User user) throws SQLException, UserAlreadyExistException {
        if (existUser(user.getUserID())){
            throw new UserAlreadyExistException();
        }

        String sql = "INSERT INTO USERS (username, password, email, personal_name, user_address, user_tlp, user_role) VALUES (?, ?, ?, ?, ?, ?, ?)";

        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, user.getUsername());
        statement.setString(2, user.getPassword());
        statement.setString(3, user.getEmail());
        statement.setString(4, user.getPersonalName());
        statement.setString(5, user.getAddress());
        statement.setString(6, user.getTelephone());
        statement.setString(7, "user");

        statement.executeUpdate();

        statement.close();
    }

    private boolean existUser(int userID) throws SQLException {
        Optional<User> user = findById(userID);
        return user.isPresent();
    }

    // Devuelve la lista de usuarios
    public ArrayList<User> findAll() throws SQLException {
        String sql = "SELECT * FROM users ORDER BY id_user";
        PreparedStatement st = connection.prepareStatement(sql);
        ResultSet res = st.executeQuery();
        ArrayList<User> users = new ArrayList<>();
        if(res.next()){
            User user = new User();

            user.setUserID(res.getInt("id_user"));
            user.setUsername(res.getString("username"));
            user.setPassword(res.getString("password"));
            user.setEmail(res.getString("email"));
            user.setPersonalName(res.getString("personal_name"));
            user.setAddress(res.getString("user_address"));
            user.setTelephone(res.getString("user_tlp"));
            user.setRole(res.getString("user_role"));

            users.add(user);
        }
        st.close();
        return users;
    }

    // Devuelve los detalles de los usuarios

    private Optional<User> getUser(Integer id) throws SQLException{
        String sql = "SELECT * FROM users WHERE id_user = ?";
        User user = null;

        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1,id);
        ResultSet res = st.executeQuery();
        while(res.next()){
            user = new User();

            user.setUserID(res.getInt("id_user"));
            user.setUsername(res.getString("username"));
            user.setPassword(res.getString("password"));
            user.setEmail(res.getString("email"));
            user.setPersonalName(res.getString("personal_name"));
            user.setAddress(res.getString("user_address"));
            user.setTelephone(res.getString("user_tlp"));
            user.setRole(res.getString("user_role"));
        }
        st.close();
        return Optional.ofNullable(user);
    }

    public Optional<User> findById(int id) throws SQLException {
        String sql = "SELECT * FROM users WHERE id_user = ?";
        User user = null;

        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, id);
        ResultSet resultSet = statement.executeQuery();
        if (resultSet.next()) {
            user = fromResultSet(resultSet);
        }

        return Optional.ofNullable(user);
    }

    public User fromResultSet(ResultSet resultSet) throws SQLException {
        User user = new User();
        user.setUserID(resultSet.getInt("id_user"));
        user.setUsername(resultSet.getString("username"));
        user.setPassword(resultSet.getString("password"));
        user.setEmail(resultSet.getString("email"));
        user.setPersonalName(resultSet.getString("personal_name"));
        user.setAddress(resultSet.getString("user_address"));
        user.setTelephone(resultSet.getString("user_tlp"));
        user.setRole(resultSet.getString("user_role"));

        return user;
    }

    public boolean modify(int userId, User user) throws SQLException {
        String sql = "UPDATE users SET username = ?, password = ?, email = ?, personal_name = ?, user_address = ?, user_tlp = ?, user_role = ? WHERE id_user = ?";

        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, user.getUsername());
        statement.setString(2, user.getPassword());
        statement.setString(3, user.getEmail());
        statement.setString(4, user.getPersonalName());
        statement.setString(5, user.getAddress());
        statement.setString(6, user.getTelephone());
        statement.setString(7, "user");
        statement.setInt(8, userId);
        int rows = statement.executeUpdate();
        return rows == 1;
    }
}
