package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.DbConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet(name = "DeleteController", urlPatterns = {"/deletecontroller"})
public class DeleteController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public DeleteController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String itemId = request.getParameter("id");

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = DbConnection.getConnection();
            String sql = "DELETE FROM items WHERE id = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, Integer.parseInt(itemId));
            preparedStatement.executeUpdate();

            response.sendRedirect("ItemListController");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DbConnection.closeConnection(connection);
        }
    }
}
