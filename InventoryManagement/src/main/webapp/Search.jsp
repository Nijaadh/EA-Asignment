
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    HttpSession validSession = request.getSession(false);
    if (validSession == null || validSession.getAttribute("username") == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
    String username = (String) validSession.getAttribute("username");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dispatch Items</title>
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
    <div>
        <div class="header">
            <h2>Inventory Management</h2>
            <div>
                <span>${username}</span>
                <button type="submit" class="btn btn-danger btn-sm">Logout</button>
            </div>
        </div>
        <div class="main-content">
        <div class="form-container">
             <form id="searchForm" action="SearchController" method="get">
                <div class="mb-3">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="Search items..." id="searchModelNo" name="modelNo" required>
                        <div class="input-group-append">
                            <button class="btn btn-primary" type="submit">Search</button>
                        </div>
                    </div>
                </div>
            </form>

            <c:if test="${not empty item}">
            
            
            
                <div class="item-details" id="itemDetails">
                    <h3>Item Details</h3>
                    <p><strong>Model No:</strong> ${item.modelNo}</p>
                    <p><strong>Name:</strong> ${item.name}</p>
                    <p><strong>Weight:</strong> ${item.weight}</p>
                    <p><strong>Description:</strong> ${item.description}</p>
                    <p><strong>Available Quantity:</strong> ${item.quantity}</p>
                </div>
                
                
                <form action="DispatchController" method="post" onsubmit="return validateQuantity()">
                    
                    <a href="Dashboard.jsp" class="btn btn-secondary">Back</a>
                </form>
            </c:if>
        </div>
        </div>
    </div>

    <script>
        function validateQuantity() {
            const availableQuantity = parseInt(document.getElementById('availableQuantity').value);
            const enteredQuantity = parseInt(document.getElementById('quantityToDispatch').value);

            if (enteredQuantity > availableQuantity) {
                alert('Entered quantity exceeds available quantity!');
                return false;
            }
            return true;
        }
        
       
        function redirectToDispatch() {
            window.location.href = 'ItemDispatch.jsp';
        }
    </script>
    </script>
</body>
</html>
