BEGIN
    INSERT INTO HOTEL (hotel_name, hotel_address, hotel_city, hotel_rating, id_category) VALUES ('El Gran Duque', 'Calle Javier Lo Peta 12 50112', 'Zaragoza', 9.7, 304);
    INSERT INTO HOTEL (hotel_name, hotel_address, hotel_city, hotel_rating, id_category) VALUES ('Riu Palace', 'Calle Rey del Git 25 50002', 'Zaragoza', 9.5, 304);
    INSERT INTO HOTEL (hotel_name, hotel_address, hotel_city, hotel_rating, id_category) VALUES ('Costa Calma', 'Calle Tomcat 777 07007', 'Palma de Mallorca', 9.0, 303);
    INSERT INTO HOTEL (hotel_name, hotel_address, hotel_city, hotel_rating, id_category) VALUES ('Gran Plaza', 'C/ Lucario 51 50180', 'Zaragoza', 8.5, 303);
    INSERT INTO HOTEL (hotel_name, hotel_address, hotel_city, hotel_rating, id_category) VALUES ('La Cumbre', 'C/ De las Rosas 34 50002', 'Zaragoza', 9.7, 303);
    INSERT INTO HOTEL (hotel_name, hotel_address, hotel_city, hotel_rating, id_category) VALUES ('Mirablau', 'Av/ De las Luces 51 28056', 'Madrid', 9.1, 301);
    INSERT INTO HOTEL (hotel_name, hotel_address, hotel_city, hotel_rating, id_category) VALUES ('Concordia', 'Plaza de la Congregacion 08017', 'Barcelona', 8.6, 304);
    INSERT INTO HOTEL (hotel_name, hotel_address, hotel_city, hotel_rating, id_category) VALUES ('Vista Nueva', 'Camino de San Juan 48011', 'Bizkaia', 9.8, 304);
    INSERT INTO HOTEL (hotel_name, hotel_address, hotel_city, hotel_rating, id_category) VALUES ('Horizonte', 'Camino de Valldemossa 51 41025', 'Sevilla', 9.9, 302);
    INSERT INTO HOTEL (hotel_name, hotel_address, hotel_city, hotel_rating, id_category) VALUES ('Global Blue', 'Plaza las Palmas 12 35006', 'Islas Canarias', 7.7, 301);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error y no se han podido almacenar los datos');
    ROLLBACK;
END;

BEGIN
    INSERT INTO ROOM (room_type, room_price, total_rooms, id_hotel) VALUES ('Suite', 290, 10, 143);
    INSERT INTO ROOM (room_type, room_price, total_rooms, id_hotel) VALUES ('Suite', 340, 20, 143);
    INSERT INTO ROOM (room_type, room_price, total_rooms, id_hotel) VALUES ('Individual', 140, 100, 143);
    INSERT INTO ROOM (room_type, room_price, total_rooms, id_hotel) VALUES ('Doble', 170, 150, 143);
    INSERT INTO ROOM (room_type, room_price, total_rooms, id_hotel) VALUES ('Individual', 40, 300, 144);
    INSERT INTO ROOM (room_type, room_price, total_rooms, id_hotel) VALUES ('Doble', 70, 350, 144);
    INSERT INTO ROOM (room_type, room_price, total_rooms, id_hotel) VALUES ('Suite Junior', 390, 10, 145);
    INSERT INTO ROOM (room_type, room_price, total_rooms, id_hotel) VALUES ('Suite', 440, 20, 145);
    INSERT INTO ROOM (room_type, room_price, total_rooms, id_hotel) VALUES ('Gran Suite', 540, 20, 145);
    INSERT INTO ROOM (room_type, room_price, total_rooms, id_hotel) VALUES ('Doble', 240, 50, 145);
    INSERT INTO ROOM (room_type, room_price, total_rooms, id_hotel) VALUES ('Individual', 110, 100, 146);
    INSERT INTO ROOM (room_type, room_price, total_rooms, id_hotel) VALUES ('Doble', 140, 450, 146);
    INSERT INTO ROOM (room_type, room_price, total_rooms, id_hotel) VALUES ('Individual', 100, 100, 147);
    INSERT INTO ROOM (room_type, room_price, total_rooms, id_hotel) VALUES ('Doble', 130, 450, 147);
    INSERT INTO ROOM (room_type, room_price, total_rooms, id_hotel) VALUES ('Individual', 130, 10, 148);
    INSERT INTO ROOM (room_type, room_price, total_rooms, id_hotel) VALUES ('Doble', 170, 50, 148);
    INSERT INTO ROOM (room_type, room_price, total_rooms, id_hotel) VALUES ('Suite', 220, 10, 149);
    INSERT INTO ROOM (room_type, room_price, total_rooms, id_hotel) VALUES ('Gran Suite', 340, 2, 149);
    INSERT INTO ROOM (room_type, room_price, total_rooms, id_hotel) VALUES ('Doble', 170, 50, 149);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error y no se han podido almacenar los datos');
    ROLLBACK;
END;

BEGIN
    INSERT INTO CATEGORY (category_stars) VALUES (1);
    INSERT INTO CATEGORY (category_stars) VALUES (2);
    INSERT INTO CATEGORY (category_stars) VALUES (3);
    INSERT INTO CATEGORY (category_stars) VALUES (4);
    INSERT INTO CATEGORY (category_stars) VALUES (5);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error y no se han podido almacenar los datos');
    ROLLBACK;
END;

    --INSERT USERS
BEGIN
    INSERT INTO USERS (username,password,email,personal_name,user_address,user_tlp,user_role) VALUES ('maria', '1234', 'maria@choom.com', 'Maria', 'Calle Luna', '86994839', 'user');
    INSERT INTO USERS (username,password,email,personal_name,user_address,user_tlp,user_role) VALUES ('nando', '1234', '@admin', 'Fernando', 'Calle Sol', '86994838', 'admin');
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error y no se han podido almacenar los datos');
    ROLLBACK;
END;
