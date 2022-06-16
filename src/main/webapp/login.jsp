<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.88.1">
    <title>Singin</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/5.1/examples/sign-in/">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    <meta name="theme-color" content="#7952b3">


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
    </style>


    <link href="css/login.css" rel="stylesheet">
  </head>
  <body class="text-center">

    <main class="form-signin">
        <form style="margin: 20px" method="post" action="login">
            <img src="img/logo/logo.png" alt="..." style="width: 150px; margin: 30px">
            <div class="card mb-3" style="width: 300px">
                <img src="img/hotels/Concordia.jpg" class="card-img-top" alt="...">
                <div class="card-body text-center">
                    <h5 class="card-title" style="margin-top: 20px">LOG IN</h5>
                    <div class="form-floating">
                        <input type="text" name="username" class="form-control" id="floatingInput" placeholder="Username">
                        <label for="floatingInput">Username</label>
                    </div>
                    <div class="form-floating">
                        <input type="password" name="password" class="form-control" id="floatingPassword" placeholder="Password">
                        <label for="floatingPassword">Password</label>
                    </div>
                    <button class="w-100 btn btn-lg btn-primary" type="submit">Log in</button>
                    <button type="button" class="w-100 btn btn-primary btn-lg" style="margin-top: 10px"><a href="/choom/register.jsp" style="text-decoration:none; color:white">Sign in</button>
                </div>
            </div>
        </form>
        <div id="result"></div>
    </main>

  </body>
</html>
