package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import util.LoginValidation;

@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		
		
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        LoginValidation loginValidation = new LoginValidation();
        
        boolean isValidUser = loginValidation.authenticateUser(username, password);
        
        if (isValidUser) {
            request.getSession().setAttribute("username", username);
            response.sendRedirect("Dashboard.jsp");
        } else {
            request.setAttribute("errorMessage", "Invalid username or password");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
    }



	public LoginController() {
        super();

    }

	 @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//doGet(request, response);
		 processRequest(request, response);
	}
	
	@Override
    public String getServletInfo() {
        return "Login Controller Servlet";
    }

}
