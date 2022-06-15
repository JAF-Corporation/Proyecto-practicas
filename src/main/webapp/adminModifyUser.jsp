<%@ page import="com.svalero.choom.domain.User" %>
<%@ page import="com.svalero.choom.dao.Database" %>
<%@ page import="com.svalero.choom.dao.UserDao" %>
<%@ page import="java.util.Optional" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
  User currentUser = (User) session.getAttribute("currentUser");
  if (currentUser == null) {
    response.sendRedirect("roleDenied.jsp");
  }



  int userID = Integer.parseInt(request.getParameter("userID"));
  User user = null;

  Database database = new Database();
  UserDao userDao = new UserDao(database.getConnection());

  try {
    Optional<User> optionalUser = userDao.findById(userID);
    user = optionalUser.get();
  } catch(SQLException sqle) {
    out.print("ERROR: Can not connect with database");
    sqle.printStackTrace();
  }
%>

<html>
  <head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  </head>
  <body>
    <script type="text/javascript">
      $(document).ready(function() {
        $("form").on("submit", function(event) {
          event.preventDefault();
          var formValue = $(this).serialize();
          $.post("modifyUser", formValue, function(data) {
            $("#result").html(data);
          });
        });
      });
    </script>

    <div class="container">
      <h1> CHOOM </h1>
      <h2>Modify User</h2>
      <form>
        <div class="mb-2">
          <label for="username" class="form-label">New username</label>
          <input name="username" type="text" class="form-control w-25" id="username" value="<% user.getUsername(); %>">
        </div>
        <div class="mb-2">
          <label for="password" class="form-label">New password</label>
          <input name="password" type="password" class="form-control w-25" id="password" value="<% user.getPassword(); %>">
        </div>
        <div class="mb-2">
          <label for="personalName" class="form-label">Personal name</label>
          <input name="personalName" type="text" class="form-control w-25" id="personalName" value="<% user.getPersonalName(); %>">
        </div>
        <div class="mb-2">
          <label for="address" class="form-label">Address</label>
          <input name="address" type="text" class="form-control w-25" id="address" value="<% user.getAddress(); %>">
        </div>
        <div class="mb-2">
          <label for="telephone" class="form-label">Telephone</label>
          <input name="telephone" type="text" class="form-control w-25" id="telephone" value="<% user.getTelephone(); %>">
        </div>
        <div class="mb-2">
          <label for="email" class="form-label">Email</label>
          <input name="email" type="email" class="form-control w-25" id="email" value="<% user.getEmail(); %>">
        </div>
        <input type="hidden" name="idUser" value="<% user.getUserID(); %>">
        <input type="hidden" name="role" value="<% user.getRole(); %>">
        <button type="submit" class="btn btn-primary">Send</button>
      </form>
      <div id="result"></div>
    </div>
  </body>
</html>
