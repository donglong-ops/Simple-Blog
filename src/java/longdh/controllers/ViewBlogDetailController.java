/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longdh.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import longdh.daos.ArticlesDAO;
import longdh.daos.CommentsDAO;
import longdh.dtos.ArticlesDTO;
import longdh.dtos.CommentsDTO;

/**
 *
 * @author Dong Long
 */
@WebServlet(name = "ViewBlogDetailController", urlPatterns = {"/ViewBlogDetailController"})
public class ViewBlogDetailController extends HttpServlet {

    private final String ERROR_PAGE = "errorPage.jsp";
    private final String SUCCESS_PAGE = "blogDetailPage.jsp";

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
        PrintWriter out = response.getWriter();

        String url = ERROR_PAGE;
        String blogID = request.getParameter("txtPostID");
        HttpSession session = request.getSession();
        CommentsDAO commentDAO = new CommentsDAO();
        ArticlesDAO dao = new ArticlesDAO();
        try {
            if (blogID != null) {
                ArticlesDTO dto = dao.getBlogByID(Integer.parseInt(blogID));
                request.setAttribute("DTO", dto);
                System.out.println("data nè: " + dto.getTitle());

                List<CommentsDTO> listComment = commentDAO.getAllCommentsByPostID(Integer.parseInt(blogID));
//               CommentsDTO commentDTO = commentDAO.get(blogID);
                request.setAttribute("COMMENT", listComment);
//                request.setAttribute("COMMENT_DTO", commentDTO);
                List<ArticlesDTO> list = dao.getAllArticles(); // chua phan trang
                if (list != null) {
                    session.setAttribute("LIST", list);
                }
                url = SUCCESS_PAGE;
            }
        } catch (Exception ex) {
            log("Error ViewDetailBlog SQL: " + ex.getMessage());
            ex.printStackTrace();
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
            out.close();
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
