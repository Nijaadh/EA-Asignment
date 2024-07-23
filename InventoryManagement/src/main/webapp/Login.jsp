<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>INVENTORY</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f7f7f7;
        }
        .login-container {
            background: white;
            padding: 2rem;
            border-radius: 0.5rem;
            box-shadow: 0 0 1rem rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .login-container img {
            max-width: 100px;
            margin-bottom: 1rem;
        }
        .login-container h2 {
            margin-bottom: 1rem;
            font-weight: 400;
            color: #007bff;
        }
        .form-group input {
            padding: 0.75rem 1.25rem;
        }
        .form-check-label {
            margin-left: 0.5rem;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <img src="${pageContext.request.contextPath}/images/inLogo.jpg" width="100px" height="100px" alt="Logo">
        <h2>Log in to Inventory Management</h2>
        <form action="LoginController" method="post">
        
        
        
    <div class="form-group">
        <input type="text" class="form-control" id="username" name="username" placeholder="User Name" required>
    </div>
    <div class="form-group">
        <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
    </div>
    <!-- <div class="form-group form-check">
        <input type="checkbox" class="form-check-input" id="rememberMe">
        <label class="form-check-label" for="rememberMe">Remember me</label>
    </div>-->
    <button type="submit" class="btn btn-primary btn-block">Log In</button>
    <!-- <a href="#" class="d-block mt-3">Forgot User Name or Password?</a>
    <a href="#" class="d-block">Create an account</a> -->
</form>

    </div>
</body>
</html>
