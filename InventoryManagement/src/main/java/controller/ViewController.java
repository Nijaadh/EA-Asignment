package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.DbConnection;
import model.Item;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Servlet implementation class ViewController
 */
@WebServlet(name = "ViewController", urlPatterns = {"/viewcontroller"})
public class ViewController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ViewController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String itemId = request.getParameter("id");

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DbConnection.getConnection();
            String sql = "SELECT * FROM items WHERE id = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, Integer.parseInt(itemId));
            resultSet = preparedStatement.executeQuery();

            Item item = null;
            if (resultSet.next()) {
                item = new Item();
                item.setId(resultSet.getInt("id"));
                item.setModelNo(resultSet.getString("modelNo"));
                item.setName(resultSet.getString("name"));
                item.setWeight(resultSet.getDouble("weight"));
                item.setDescription(resultSet.getString("description"));
                item.setQuantity(resultSet.getInt("quantity"));
            }

            request.setAttribute("item", item);
            request.getRequestDispatcher("ViewItemJsp.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DbConnection.closeConnection(connection);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
