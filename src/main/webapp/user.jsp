<%@ page import="com.svalero.choom.domain.User" %>
<%@ page import="java.io.PrintWriter" %>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>

<%
  User currentUser = (User) session.getAttribute("currentUser");
  if (currentUser == null) {
    response.sendRedirect("index.jsp");
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
        <h1> Usuario </h1>
        <h2>Zona de usuario</h2>
        <form>
          <div class="mb-2">
            <label for="username" class="form-label">Username</label>
            <input name="username" type="text" class="form-control w-25" id="username" value="<% if (currentUser != null) out.print(currentUser.getUsername()); %>">
          </div>
          <div class="mb-2">
            <label for="password" class="form-label">Password</label>
            <input name="password" type="password" class="form-control w-25" id="password" value="<% if (currentUser != null) out.print(currentUser.getPassword()); %>">
          </div>
          <div class="mb-2">
            <label for="personalName" class="form-label">First name and last name</label>
            <input name="personalName" type="text" class="form-control w-25" id="personalName" value="<% if (currentUser != null) out.print(currentUser.getPersonalName()); %>">
          </div>
          <div class="mb-2">
            <label for="email" class="form-label">User email</label>
            <input name="email" type="email" class="form-control w-25" id="email" value="<% if (currentUser != null) out.print(currentUser.getEmail()); %>">
          </div>
          <div class="mb-2">
            <label for="address" class="form-label">User address</label>
            <input name="address" type="text" class="form-control w-25" id="address" value="<% if (currentUser != null) out.print(currentUser.getAddress()); %>">
          </div>
          <div class="mb-2">
            <label for="telephone" class="form-label">User telephone</label>
            <input name="telephone" type="text" class="form-control w-25" id="telephone" value="<% if (currentUser != null) out.print(currentUser.getTelephone()); %>">
          </div>
          <input type="hidden" name="userID" value="<% if (currentUser != null) out.print(currentUser.getUserID()); %>">
          <input type="hidden" name="role" value="<% if (currentUser != null) out.print(currentUser.getRole()); %>">
          <button type="submit" class="btn btn-primary">Modify</button>
        </form>
        <div id="result"></div>
      </div>

  </body>
</html>
