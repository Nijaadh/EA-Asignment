package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Item;
import util.DbConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ItemListController", urlPatterns = {"/itemlist"})
public class ItemListController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ItemListController() {
        super();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        List<Item> itemList = new ArrayList<>();

        try {
            connection = DbConnection.getConnection();
            String sql = "SELECT id, modelNo, name, quantity FROM items";
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Item item = new Item();
                item.setId(resultSet.getInt("id"));
                item.setModelNo(resultSet.getString("modelNo"));
                item.setName(resultSet.getString("name"));
                item.setQuantity(resultSet.getInt("quantity"));
                itemList.add(item);
            }

            request.setAttribute("itemList", itemList);
            request.getRequestDispatcher("ItemList.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DbConnection.closeConnection(connection);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        response.sendRedirect("ItemList.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        response.sendRedirect("ItemList.jsp");
    }
}
