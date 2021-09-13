/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longdh.controllers;

import java.io.IOException;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import longdh.daos.ArticlesDAO;
import longdh.dtos.UsersDTO;

/**
 *
 * @author Cyrus
 */
public class LikesController extends HttpServlet {

    private static final String SUCCESS = "SocialNetworkController";
    private static final String ERROR = "error.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String txtPostID = request.getParameter("txtPostID");
          
            int postID = Integer.parseInt(txtPostID);
     
            UsersDTO user = ((UsersDTO) request.getSession().getAttribute("USER"));
            String email = user.getEmail();
            ArticlesDAO dao = new ArticlesDAO();
            if (dao.checkBoxLikeAndDisLike(postID, email)) {
                dao.removeEmotion(postID, email);
                
            } else {
                dao.insertEmotion(postID, email);
            }
            request.setAttribute("postID", postID);
            url = SUCCESS;

        } catch (SQLException | NamingException e) {
            log("Error LikesController at: " + e.getMessage());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
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
