/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longdh.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import longdh.users.UsersDAO;
import longdh.users.UsersDTO;

/**
 *
 * @author Dong Long
 */
@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {

    private static final String ERROR = "login.jsp";
    private static final String MEMBER = "homeAction";
    private static final String ADMIN = "manageArticleAction";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        UsersDAO dao = new UsersDAO();
        String email = request.getParameter("txtEmail");
        String password = request.getParameter("txtPassword");

        try {
            String encryPassword = org.apache.commons.codec.digest.DigestUtils.sha256Hex(password);
            UsersDTO dto = dao.checkLogin(email, encryPassword);
            if (dto == null) {
                url = ERROR;
                request.setAttribute("ERROR", "Email or password swrong");
                request.getRequestDispatcher(url).forward(request, response);
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("USER", dto);
                if (dto.getRole().equals("Admin")) {
                    url = ADMIN;
                } else if (dto.getRole().equals("Member")) {
                    url = MEMBER;
                }
                response.sendRedirect(url);
            }
        } catch (Exception e) {
            log("Error LoginController at: " + e.getMessage());
        } 
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
