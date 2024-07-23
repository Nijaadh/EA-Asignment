package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DbConnection;

@WebServlet(name = "DispatchController", urlPatterns = {"/dispatchcontroller"})
public class DispatchController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public DispatchController() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int itemId = Integer.parseInt(request.getParameter("id"));
        int dispatchQuantity = Integer.parseInt(request.getParameter("quantityToDispatch"));

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = DbConnection.getConnection();
            // Fetch the current quantity
            String selectSql = "SELECT quantity FROM items WHERE id = ?";
            preparedStatement = connection.prepareStatement(selectSql);
            preparedStatement.setInt(1, itemId);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                int currentQuantity = resultSet.getInt("quantity");

                if (dispatchQuantity > currentQuantity) {
                    // If dispatch quantity is more than available, show an error message
                    request.setAttribute("errorMessage", "Dispatch quantity exceeds available quantity.");
                    request.getRequestDispatcher("ItemDispatch.jsp").forward(request, response);
                } else {
                    // Update the quantity in the database
                    String updateSql = "UPDATE items SET quantity = quantity - ? WHERE id = ?";
                    preparedStatement = connection.prepareStatement(updateSql);
                    preparedStatement.setInt(1, dispatchQuantity);
                    preparedStatement.setInt(2, itemId);
                    preparedStatement.executeUpdate();

                    // Redirect to the dashboard
                    response.sendRedirect("Dashboard.jsp");
                }
            } else {
                // Item not found, show an error message
                request.setAttribute("errorMessage", "Item not found.");
                request.getRequestDispatcher("ItemDispatch.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            // Show a generic error message
            request.setAttribute("errorMessage", "An error occurred while processing your request.");
            request.getRequestDispatcher("ItemDispatch.jsp").forward(request, response);
        } finally {
            DbConnection.closeConnection(connection);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
