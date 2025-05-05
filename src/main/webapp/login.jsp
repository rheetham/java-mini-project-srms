<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login</title>
        <link rel="stylesheet" href="css/style.css">
    
    <style>
        body { font-family: Arial, sans-serif; margin: 50px; }
        h2 {
        	margin-bottom: 30px;
        }
        .login-form { width: 400px; margin: 200px auto; padding: 30px; display: flex; flex-direction: column; align-items: center; justify-content: center;
    border-radius: 8px; 
    box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);}
    	form {
    		display: flex;
    		flex-direction: column;
    		align-items: center;
    		justify-items: center;
    	}
        .form-group { margin-bottom: 15px; }
        input[type="text"], input[type="password"] {
            width: 210px; padding: 8px; box-sizing: border-box;
        }
        button { margin-top: 20px; padding: 10px 17px; border-radius: 5px; background: blue; color: white; border: none; }
    </style>
</head>
<body>
    <div class="login-form">
        <h2>Admin Login</h2>
        <form action="LoginServlet" method="get">
            <div class="form-group">
                <label>Username:</label>
                <input type="text" name="username" required>
            </div>
            <div class="form-group">
                <label>Password:</label>
                <input type="password" name="password" required>
            </div>
            <button type="submit">Login</button>
        </form>
    </div>
</body>
</html>