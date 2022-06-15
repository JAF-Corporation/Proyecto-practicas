       <!doctype html>

<%@ page import="com.svalero.choom.dao.Database" %>
<%@ page import="com.svalero.choom.dao.HotelDao" %>
<%@ page import="com.svalero.choom.dao.CategoryDao" %>
<%@ page import="com.svalero.choom.domain.Hotel" %>
<%@ page import="com.svalero.choom.dao.RoomDao" %>
<%@ page import="com.svalero.choom.domain.Room" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.choom.util.Utils" %>

       <html lang="en">
         <head>
           <meta charset="utf-8">
           <meta name="viewport" content="width=device-width, initial-scale=1">
           <meta name="description" content="">
           <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
           <meta name="generator" content="Hugo 0.98.0">
           <title>Dashboard Template · Bootstrap v5.2</title>

       <link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/dashboard/">
       <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

       <meta name="theme-color" content="#7952b3">


       <link href="/docs/5.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">

           <!-- Favicons -->
       <link rel="apple-touch-icon" href="/docs/5.2/assets/img/favicons/apple-touch-icon.png" sizes="180x180">
       <link rel="icon" href="/docs/5.2/assets/img/favicons/favicon-32x32.png" sizes="32x32" type="image/png">
       <link rel="icon" href="/docs/5.2/assets/img/favicons/favicon-16x16.png" sizes="16x16" type="image/png">
       <link rel="manifest" href="/docs/5.2/assets/img/favicons/manifest.json">
       <link rel="mask-icon" href="/docs/5.2/assets/img/favicons/safari-pinned-tab.svg" color="#712cf9">
       <link rel="icon" href="/docs/5.2/assets/img/favicons/favicon.ico">
       <meta name="theme-color" content="#712cf9">


           <style>
             .bd-placeholder-img {
               font-size: 1.125rem;
               text-anchor: middle;
               -webkit-user-select: none;
               -moz-user-select: none;
               user-select: none;
             }

             @media (min-width: 768px) {
               .bd-placeholder-img-lg {
                 font-size: 3.5rem;
               }
             }

             .b-example-divider {
               height: 3rem;
               background-color: rgba(0, 0, 0, .1);
               border: solid rgba(0, 0, 0, .15);
               border-width: 1px 0;
               box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15);
             }

             .b-example-vr {
               flex-shrink: 0;
               width: 1.5rem;
               height: 100vh;
             }

             .bi {
               vertical-align: -.125em;
               fill: currentColor;
             }

             .nav-scroller {
               position: relative;
               z-index: 2;
               height: 2.75rem;
               overflow-y: hidden;
             }

             .nav-scroller .nav {
               display: flex;
               flex-wrap: nowrap;
               padding-bottom: 1rem;
               margin-top: -1px;
               overflow-x: auto;
               text-align: center;
               white-space: nowrap;
               -webkit-overflow-scrolling: touch;
             }
           </style>


           <!-- Custom styles for this template -->
           <link href="css/dashboard.css" rel="stylesheet">
         </head>
    <body>

       <header class="navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-0 shadow">
         <a class="navbar-brand col-md-3 col-lg-2 me-0 px-3 fs-6" href="#">CHOOM</a>
         <button class="navbar-toggler position-absolute d-md-none collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#sidebarMenu" aria-controls="sidebarMenu" aria-expanded="false" aria-label="Toggle navigation">
           <span class="navbar-toggler-icon"></span>
         </button>
         <input class="form-control form-control-dark w-100 rounded-0 border-0" type="text" placeholder="Search" aria-label="Search">
         <div style="display: flex;" class="navbar-nav">
           <div class="nav-item text-nowrap">
             <a class="nav-link px-3" href="login.jsp">Log in</a>
           </div>
           <div class="nav-item text-nowrap">
             <a class="nav-link px-3" href="#">Log out</a>
           </div>
         </div>
       </header>

       <div class="container-fluid">
         <div class="row">
           <nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
             <div class="position-sticky pt-3">
               <ul class="nav flex-column">
                 <li class="nav-item">
                   <a class="nav-link active" aria-current="page" href="#">
                     <span data-feather="home" class="align-text-bottom"></span>
                     View Hotels
                   </a>
                 </li>
                 <li class="nav-item">
                   <a class="nav-link" href="#">
                     <span data-feather="file" class="align-text-bottom"></span>
                     View bookings
                   </a>
                 </li>
                 <li class="nav-item">
                   <a class="nav-link" href="#">
                     <span data-feather="shopping-cart" class="align-text-bottom"></span>
                     View profile
                   </a>
                 </li>
               </ul>
             </div>
           </nav>
         </div>
       </div>

       <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
         <div style="margin: 10px; justify-content: center;" class="container">
                 <h2 style="margin: 10px; justify-content: center;">HOTELS</h2>
                 <ul class="list-group">
                     <%
                         Database database = new Database();
                         HotelDao hotelDao = new HotelDao(database.getConnection());
                         CategoryDao categoryDao = new CategoryDao(database.getConnection());
                         //RoomDao roomDao = new RoomDao(database.getConnection());

                         try {
                             List<Hotel> hotels = hotelDao.findAllHotels();
                             for (Hotel hotel : hotels) {
                     %>
                                 <div class="card mb-3" style="max-width: 540px;">
                                   <div class="row g-0">
                                     <div class="col-md-4">
                                       <img src="img/hotels/<%= hotel.getName() %>.jpg" class="img-fluid rounded-start" alt="...">
                                     </div>
                                     <div class="col-md-8">
                                       <div class="card-body">
                                         <h5 class="card-title"><%= hotel.getName() %></h5>
                                         <p class="card-text"><%= hotel.getAddress() %></p>
                                         <p class="card-text"><%= hotel.getCity() %></p>
                                         <p class="card-text">
                                         <div style="display: flex; justify-content:left;">
                                         <%
                                         for(int i = 0; i < categoryDao.findStarsById(hotel.getHotelCategoryID()); i++) {
                                         %>
                                            <img style="width: 4%; height: 4%;" src="img/icons/black-star.png"></p>
                                         <%
                                          }
                                          %>
                                         </div>
                                         <h6 style="display: flex; justify-content:right;" class="card-title"><%= hotel.getRating() %>/10</h6>
                                       </div>
                                     </div>
                                   </div>
                                   <a href="hotel.jsp?id=<%= hotel.getHotelID() %>" class="btn btn-primary" target="_blank"><strong>View more</strong></a>
                                 </div>
                     <%
                             }
                        } catch (SQLException sqle) {
                            sqle.printStackTrace();
                     %>
                             <div class="alert alert-danger" role="alert">Error conectando con la base de datos</div>
                     <%
                        }
                     %>
                 </ul>
         </div>
       </main>

       <script src="/docs/5.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
       <script src="https://cdn.jsdelivr.net/npm/feather-icons@4.28.0/dist/feather.min.js" integrity="sha384-uO3SXW5IuS1ZpFPKugNNWqTZRRglnUJK6UAZ/gxOX80nxEkN9NcGZTftn6RzhGWE" crossorigin="anonymous"></script><script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js" integrity="sha384-zNy6FEbO50N+Cg5wap8IKA4M/ZnLJgzc6w2NqACZaK0u0FXfOWRRJOnQtpZun8ha" crossorigin="anonymous"></script><script src="dashboard.js"></script>
    </body>
</html>