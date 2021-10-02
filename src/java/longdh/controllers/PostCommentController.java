/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longdh.controllers;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import longdh.articles.ArticlesDAO;
import longdh.comments.CommentsDAO;
import longdh.articles.ArticlesDTO;
import longdh.comments.CommentsDTO;
import longdh.users.UsersDTO;

/**
 *
 * @author Dong Long
 */
@WebServlet(name = "PostCommentController", urlPatterns = {"/PostCommentController"})
public class PostCommentController extends HttpServlet {

    private static final String SUCCESS_PAGE = "blogDetailPage.jsp";
    private static final String LOGIN_PAGE = "try";

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

        Timestamp now = new Timestamp(System.currentTimeMillis());
        HttpSession session = request.getSession();
        CommentsDAO commentDAO = new CommentsDAO();
        ArticlesDAO dao = new ArticlesDAO();
        String url;
        String content = request.getParameter("txtComment");
        int postID = Integer.parseInt(request.getParameter("txtPostID"));
        try {
            if (content == null || content.trim().length() <= 0) {
                url = SUCCESS_PAGE;
                ArticlesDTO dto = dao.getBlogByID(postID);
                request.setAttribute("DTO", dto);
                List<CommentsDTO> listComment = commentDAO.getAllCommentsByPostID(postID);
                request.setAttribute("COMMENT", listComment);
                request.getRequestDispatcher(url).forward(request, response);
            } else {
                CommentsDTO commentDTO = new CommentsDTO(postID, content, new Date(now.getTime()));
                if (session.getAttribute("USER") == null) {
                    url = LOGIN_PAGE;
                    response.sendRedirect(url);
                } else {
                    UsersDTO user = (UsersDTO) session.getAttribute("USER");
                    if (user.getRole().equals("Member")) {
                        ArticlesDTO dto = dao.getBlogByID(postID);
                        if (dto != null) {
                            request.setAttribute("DTO", dto);
                            commentDAO.createComment(commentDTO, user.getEmail());
                            List<CommentsDTO> listComment = commentDAO.getAllCommentsByPostID(postID);
                            request.setAttribute("COMMENT", listComment);
                        }
                        url = SUCCESS_PAGE;
                        request.getRequestDispatcher(url).forward(request, response);
                    } else {
                        url = LOGIN_PAGE;
                        response.sendRedirect(url);
                    }
                }
            }
        } catch (SQLException | NamingException e) {
            log("Error CommentController at: " + e.getMessage());
        } catch (ParseException ex) {
            log("ParseException CommentController at: " + ex.getMessage());
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
