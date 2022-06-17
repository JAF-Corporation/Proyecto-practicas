package com.svalero.choom.dao;

import com.svalero.choom.domain.Category;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CategoryDao {

    private Connection connection;

    public CategoryDao(Connection connection) {
        this.connection = connection;
    }

    public int findStarsById(int id) throws SQLException {
        String sql = "SELECT category_stars FROM CATEGORY WHERE id_category = ?";
        Category category = null;

        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, id);
        ResultSet resultSet = statement.executeQuery();

        if(resultSet.next()) {
            category = fromResultSet(resultSet);
        }

        return category.getStars();
    }

    private Category fromResultSet(ResultSet resultSet) throws SQLException {
        Category category = new Category();

        category.setStars(resultSet.getInt("category_stars"));

        return category;
    }

}
