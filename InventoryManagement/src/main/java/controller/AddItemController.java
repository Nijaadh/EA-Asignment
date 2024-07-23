package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.DbConnection;
import util.LoginValidation;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet(name = "AddItemController", urlPatterns = {"/additem"})
public class AddItemController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public AddItemController() {
        super();

    }


protected void processRequest(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		
	 	Connection connection = null;
	 	PreparedStatement preparedStatement = null;	
	
	
        String modelNo = request.getParameter("modelNo");
        String name = request.getParameter("name");
        String weight = request.getParameter("weight");
        String discription = request.getParameter("description");
        String quatity = request.getParameter("quantity");
        
        
        
        
        try {
            connection = DbConnection.getConnection();
            String sql = "INSERT INTO items (modelNo, name, weight, description, quantity) VALUES (?, ?, ?, ?, ?)";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, modelNo);
            preparedStatement.setString(2, name);
            preparedStatement.setDouble(3, Double.parseDouble(weight));
            preparedStatement.setString(4, discription);
            preparedStatement.setInt(5, Integer.parseInt(quatity));

            int rowsAffected = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);
            
            response.sendRedirect("AddItem.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        	DbConnection.closeConnection(connection);
        }
        
        
        
        
     
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		processRequest(request, response);
	}

}
