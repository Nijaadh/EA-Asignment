<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Item" %>

<%
    HttpSession validSession = request.getSession(false);
    if (validSession == null || validSession.getAttribute("username") == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
    String username = (String) validSession.getAttribute("username");
    
    List<Item> itemList = (List<Item>) request.getAttribute("itemList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventory List</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body, html {
            height: 100%;
            margin: 0;
            display: flex;
            font-family: 'Arial', sans-serif;
        }
        .sidebar {
            height: 100%;
            width: 200px;
            background-color: #343a40; /* Dark background color */
            padding-top: 20px;
            color: #ffffff; /* Light text color */
            position: fixed;
            overflow-y: auto; /* Enable scrolling for sidebar if content exceeds height */
        }
        .sidebar-logo {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 10px;
        }
        .nav-item {
            padding: 10px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .nav-item:hover {
            background-color: #495057; /* Darker background color on hover */
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            background-color: #343a40; /* Dark background color */
            color: #ffffff; /* Light text color */
            /*width: calc(100% - 200px); /* Adjusted width to exclude sidebar */
            width:87vw;
            margin-left: 200px; /* Offset to align with sidebar */
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* Shadow for header */
            z-index: 1; /* Ensure header stays above other content */
        }
        .header h2 {
            margin: 0;
            font-size: 1.5rem; /* Larger font size */
        }
        .welcome-message {
        	margin-left: auto;
        	margin-right: 50px;
            text-align: center;
            margin-top: 50px;
            animation: fadeIn 2s;
        }
        
        .main-content {
        	 /*background-color:green;*/
        	 margin-left: 200px;
        	 width:88vw;
        	
        }
        
        .form-container{
        	 /*background-color:blue;*/
        	 width:35vw;
        	 margin-left: auto;
        	margin-right: auto;
        	margin-top: 3em;
        	 
        }
        
        .table-container{
         	width:55vw;
        	 margin-left: auto;
        	margin-right: auto;
        	margin-top: 3em;
        }
        
        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }
        /* Mobile-first responsive design */
        @media (max-width: 768px) {
            .sidebar {
                width: 100%; /* Full width on smaller screens */
                height: auto; /* Allow height to adjust as per content */
                position: static; /* Static position for mobile */
            }
            .header {
                width: 100%; /* Full width header on smaller screens */
                margin-left: 0; /* No offset for header */
            }
        }
    </style>
    <script>
        function searchItems() {
            var input, filter, table, tr, td, i, txtValue;
            input = document.getElementById("search-input");
            filter = input.value.toUpperCase();
            table = document.getElementById("item-table");
            tr = table.getElementsByTagName("tr");
            
            for (i = 1; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[1]; // Model No column
                if (td) {
                    txtValue = td.textContent || td.innerText;
                    if (txtValue.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }       
            }
        }
    </script>
</head>
<body>
    <div class="sidebar">
        <div class="sidebar-logo">
            <img src="${pageContext.request.contextPath}/images/inLogo.jpg" width="75px" height="75px" alt="Logo">
        </div>
        <div class="nav-item"><a href="Dashboard.jsp" class="text-white">Dashboard</a></div>
        <div class="nav-item"><a href="AddItem.jsp" class="text-white">Add Item</a></div>
        <div class="nav-item"><a href="ItemListController" class="text-white">List Item</a></div>
        <div class="nav-item"><a href="Search.jsp" class="text-white">Search Item</a></div>
        <div class="nav-item"><a href="ItemDispatch.jsp" class="text-white">Dispatch Item</a></div>
    </div>
    <div>
        <div class="header">
            <h2>Inventory Management</h2>
            <div>
                <span><%= username %></span>
                <button type="submit" class="btn btn-danger btn-sm">Logout</button>
            </div>
        </div>
        
        <div class="main-content">
            <div class="table-container">
                <h3>Item List</h3>
                <div class="mb-3">
                    <div class="input-group">
                        <input type="text" id="search-input" class="form-control" placeholder="Search items by model number...">
                        <div class="input-group-append">
                            <button class="btn btn-primary" type="button" onclick="searchItems()">Search</button>
                        </div>
                    </div>
                </div>
                <table id="item-table" class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Model No</th>
                            <th>Name</th>
                            <th>Quantity</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (itemList != null) {
                                for (Item item : itemList) {
                        %>
                        <tr>
                            <td><%= item.getId() %></td>
                            <td><%= item.getModelNo() %></td>
                            <td><%= item.getName() %></td>
                            <td><%= item.getQuantity() %></td>
                            <td>
                                <form action="ViewController" method="get" style="display:inline;">
                                    <input type="hidden" name="id" value="<%= item.getId() %>">
                                    <button type="submit" class="btn btn-info btn-sm">View</button>
                                </form>
                                <form action="UpdateController" method="get" style="display:inline;">
                                    <input type="hidden" name="id" value="<%= item.getId() %>">
                                    <button type="submit" class="btn btn-warning btn-sm">Update</button>
                                </form>
                                <form action="DeleteController" method="get" style="display:inline;">
                                    <input type="hidden" name="id" value="<%= item.getId() %>">
                                    <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                </form>
                            </td>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
