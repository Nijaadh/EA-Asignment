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

import model.Item;
import util.DbConnection;

@WebServlet(name = "DispatchItemSearch", urlPatterns = {"/dispatchitemSearch"})
public class DispatchItemSearch extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public DispatchItemSearch() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String modelNo = request.getParameter("modelNo");
        
        System.out.println("serch model num is: "+modelNo);
        
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DbConnection.getConnection();
            String selectSql = "SELECT * FROM items WHERE modelNo = ?";
            preparedStatement = connection.prepareStatement(selectSql);
            preparedStatement.setString(1, modelNo);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                Item item = new Item();
                item.setId(resultSet.getInt("id"));
                item.setModelNo(resultSet.getString("modelNo"));
                item.setName(resultSet.getString("name"));
                item.setWeight(resultSet.getDouble("weight"));
                item.setDescription(resultSet.getString("description"));
                item.setQuantity(resultSet.getInt("quantity"));

                request.setAttribute("item", item);
                
                System.out.println(item.getName());
            } else {
                request.setAttribute("errorMessage", "Item not found.");
            }

            request.getRequestDispatcher("ItemDispatch.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while processing your request.");
            request.getRequestDispatcher("ItemDispatch.jsp").forward(request, response);
        } finally {
            DbConnection.closeConnection(connection);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
