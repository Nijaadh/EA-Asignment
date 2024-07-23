<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    HttpSession validSession = request.getSession(false);
    if (validSession == null || validSession.getAttribute("username") == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
    String username = (String) validSession.getAttribute("username");

    String modelNo = request.getParameter("modelNo");
    String name = request.getParameter("name");
    String weight = request.getParameter("weight");
    String description = request.getParameter("description");
    String quantity = request.getParameter("quantity");
    String qrCodeBase64 = (String) request.getAttribute("qrCodeBase64");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventory Management</title>
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
    <div >
        <div class="header">
            <h2>Inventory Management</h2>
            <div>
                <span>${username}</span>
                <button type="submit" class="btn btn-danger btn-sm">Logout</button>
            </div>
        </div>
        <div class="main-content">
        <div class="form-container">
            <h3>Register New Item</h3>
            <form id="addItemForm" action="AddItemController" method="post">
                <div class="form-group">
                    <label for="modelNo">Model No</label>
                    <input type="text" class="form-control" id="modelNo" name="modelNo" value="<%= modelNo != null ? modelNo : "" %>" required>
                </div>
                <div class="form-group">
                    <label for="name">Name</label>
                    <input type="text" class="form-control" id="name" name="name" value="<%= name != null ? name : "" %>" required>
                </div>
                <div class="form-group">
                    <label for="weight">Weight</label>
                    <input type="text" class="form-control" id="weight" name="weight" value="<%= weight != null ? weight : "" %>" required>
                </div>
                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea class="form-control" id="description" name="description" rows="3" required><%= description != null ? description : "" %></textarea>
                </div>
                <div class="form-group">
                    <label for="quantity">Quantity</label>
                    <input type="number" class="form-control" id="quantity" name="quantity" value="<%= quantity != null ? quantity : "" %>" required>
                </div>
                <button type="button" class="btn btn-secondary" onclick="generateQRCode()">Generate QR Code</button>
                <button type="submit" class="btn btn-primary">Add</button>
                <button type="reset" class="btn btn-danger">Clear</button>
            </form>
            <div class="qr-code">
                <% if (qrCodeBase64 != null) { %>
                    <h4>Generated QR Code:</h4>
                                       <img src="data:image/png;base64,<%= qrCodeBase64 %>" alt="QR Code">
                <% } %>
            </div>
        </div>
        </div>
    </div>

    <script>
        function generateQRCode() {
            const form = document.getElementById('addItemForm');
            form.action = 'QRCodeServlet';
            form.method = 'post';
            form.submit();
        }
    </script>
</body>
</html>
