package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.QRCodeUtil;

import java.io.IOException;
import java.util.Base64;

@WebServlet(name = "QRCodeServlet", urlPatterns = {"/qrcodeservlet"})
public class QRCodeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public QRCodeServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String modelNo = request.getParameter("modelNo");
        String name = request.getParameter("name");
        String weight = request.getParameter("weight");
        String description = request.getParameter("description");
        String quantity = request.getParameter("quantity");

        if (modelNo != null && !modelNo.isEmpty()) {
            try {
                byte[] qrCode = QRCodeUtil.generateQRCode(modelNo, 200, 200);
                String qrCodeBase64 = Base64.getEncoder().encodeToString(qrCode);

                request.setAttribute("modelNo", modelNo);
                request.setAttribute("name", name);
                request.setAttribute("weight", weight);
                request.setAttribute("description", description);
                request.setAttribute("quantity", quantity);
                request.setAttribute("qrCodeBase64", qrCodeBase64);

                request.getRequestDispatcher("AddItem.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "QR Code generation failed.");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Model number is required for QR code generation.");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

}
