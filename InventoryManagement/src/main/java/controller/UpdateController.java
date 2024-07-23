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

@WebServlet(name = "UpdateController", urlPatterns = {"/updatecontroller"})
public class UpdateController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public UpdateController() {
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
                
                System.out.println(item.getModelNo());
                System.out.println(item.getName());
                System.out.println(item.getWeight());
                System.out.println(item.getDescription());
                System.out.println(item.getQuantity());
                
            }

            request.setAttribute("item", item);
            request.getRequestDispatcher("Update.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DbConnection.closeConnection(connection);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String modelNo = request.getParameter("modelNo");
        String name = request.getParameter("name");
        double weight = Double.parseDouble(request.getParameter("weight"));
        String description = request.getParameter("description");
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = DbConnection.getConnection();
            String sql = "UPDATE items SET modelNo = ?, name = ?, weight = ?, description = ?, quantity = ? WHERE id = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, modelNo);
            preparedStatement.setString(2, name);
            preparedStatement.setDouble(3, weight);
            preparedStatement.setString(4, description);
            preparedStatement.setInt(5, quantity);
            preparedStatement.setInt(6, id);
            preparedStatement.executeUpdate();

            response.sendRedirect("ItemListController");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DbConnection.closeConnection(connection);
        }
    }
}
