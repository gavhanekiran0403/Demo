<%@page import="java.sql.*"%>
<%@ include file="DBConnection.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page</title>
<style type="text/css">
    body {
        font-family: Arial, sans-serif;
        background-color: white;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
        padding: 0;
    }

    .form-container {
        background: white;
        padding: 30px;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        width: 100%;
        max-width: 300px;
    }

    h2 {
        text-align: center;
        margin-bottom: 20px;
        color: black;
    }

    form label {
        display: block;
        margin-bottom: 8px;
        font-weight: bold;
        color: #555;
    }

    form input {
        width: 100%;
        padding: 10px;
        margin-bottom: 15px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 14px;
    }

    form button {
        width: 100%;
        padding: 10px;
        background-color: #4CAF50;
        color: white;
        border: none;
        font-size: 16px;
        border-radius: 4px;
    }

    form button:hover {
        background-color: #45a049;
    }

    .error-message {
        color: red;
        font-family: italic;
        font-size: 14px;
        text-align: center;
    }

    .link-container {
        text-align: center;
        margin-top: 10px;
    }

    .link-container a {
        text-decoration: none;
        color: green;
        font-size: 15px;
    }

    .link-container a:hover {
        text-decoration: underline;
    }

</style>
</head>
<body>
    <div class="form-container">
        <h2>Login</h2>

        <form action="login.jsp" method="post">
            
            <label>Email :</label>
            <input type="email" name="email" placeholder="Enter your email" required>

            <label>Password:</label>
            <input type="password" name="password" placeholder="Enter your password" required>
			
			<div class="error-message">
                <% 
                String errorMessage = (String) session.getAttribute("errorMessage");
                	if(errorMessage != null){
                		System.out.println(errorMessage);
                		out.println("<h3>"+errorMessage+"</h3>");
                		session.removeAttribute("errorMessage");
                	}
                %>
            </div>
            
            <button type="submit">Login</button>

        </form>

        <div class="link-container">
            Don't have an account? <a href="registration.jsp">Register here</a>
        </div>
        
        <%
        	String email = request.getParameter("email");
        	String password = request.getParameter("password");
        	
        	if (email != null && password != null) {
        		Connection connection = null;
            	PreparedStatement psmt = null;
    			
    			try{
    				connection = getConnection();
    				String query = "SELECT * FROM USER WHERE email=? AND password=?";
    				psmt = connection.prepareStatement(query);
    				psmt.setString(1, email);
    				psmt.setString(2, password);
    				ResultSet resultSet = psmt.executeQuery();
    				
    				if(resultSet.next()){
    					String name = resultSet.getString("user_name");
    					session.setAttribute("name", name);
    					response.sendRedirect("success.jsp");
    				}else {
    					session.setAttribute("errorMessage", "Invalid username or password!");
    					response.sendRedirect("login.jsp");
                    }	
    			}catch(SQLException e){
    				e.printStackTrace();
    			}finally{
    				if(connection != null){
    					connection.close();
    				}
    				
    				if(psmt != null){
    					psmt.close();
    				}
    			}
        	}
        	
        %>

    </div>
</body>
</html>




