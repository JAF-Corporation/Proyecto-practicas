package com.svalero.choom.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import static com.svalero.choom.util.Constants.*;

public class Database {
    private Connection connection;

    public Connection getConnection() {
        try {
            Class.forName(ORACLE_DRIVER);
            connection = DriverManager.getConnection(ORACLE_URL, USERNAME, PASSWORD);
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }

        return connection;
    }

    public void close() {
        try {
            connection.close();
        } catch (SQLException sqle) {
            System.out.println("No se ha podido conectar con el servidor de base de datos. Comprueba que los datos son correctos y que el servidor se ha iniciado");
            sqle.printStackTrace();
        }
    }
}
