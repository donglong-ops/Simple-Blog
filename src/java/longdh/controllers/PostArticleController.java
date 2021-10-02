/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longdh.controllers;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import longdh.articles.ArticlesCreateError;
import longdh.articles.ArticlesDAO;
import longdh.articles.ArticlesDTO;
import longdh.users.UsersDTO;
import longdh.utils.Util;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileItemFactory;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;

/**
 *
 * @author Dong Long
 */
@WebServlet(name = "PostArticleController", urlPatterns = {"/PostArticleController"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 5 * 5)
public class PostArticleController extends HttpServlet {

    private final String CREATE_ERROR = "postArticle.jsp";
    private final String CREATE_SUCCESS = "waitingPage";
    private final String LOST_SESSION_PAGE = "try";

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
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("utf-8");
        String url = CREATE_ERROR;

        HttpSession session = request.getSession();
        UsersDTO userDto = (UsersDTO) session.getAttribute("USER");
        if (userDto == null || userDto.getRole().equals("Admin")) {
            url = LOST_SESSION_PAGE;
            response.sendRedirect(url);
            return;
        }

        ArticlesCreateError errors = new ArticlesCreateError();
        boolean fourdErr = false;
        try {
            boolean isMutilpart = ServletFileUpload.isMultipartContent(request);
            if (isMutilpart) {
                FileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);

                List<FileItem> items = upload.parseRequest(new ServletRequestContext(request));
                Map<String, String> parameters = new HashMap<>();
                FileItem fileItem = null;
                for (FileItem item : items) {
                    if (item.isFormField()) {
                        parameters.put(item.getFieldName(), item.getString());
                    }
                    if (item.getFieldName().equals("fileImage")) {
                        fileItem = item;
                    }
                }
                String txtTitle = new String(parameters.get("txtTitle").getBytes("iso-8859-1"), "UTF-8");
                String txtDiscription = new String(parameters.get("txtDiscription").getBytes("iso-8859-1"), "UTF-8");
                String imageLink = null;
                try {
                    String uploadPath = request.getServletContext().getRealPath("/") + "img" + File.separator;
                    String fileName = Util.randomFileName(15);
                    String extension = Util.getFileExtension(fileItem.getName());
                    File fileUpload = new File(uploadPath + fileName + extension);
                    fileItem.write(fileUpload);
                    imageLink = "img/" + fileName + extension;
                } catch (Exception ex) {
                    errors.setImageError("Failed to upload image!");
                }
                if (fileItem.getName() == null || fileItem.getName().trim().length() < 2) {
                    fourdErr = true;
                    errors.setImageError("Select image!");
                }

                if (txtTitle.trim().length() < 2 || txtTitle.trim().length() > 70) {
                    fourdErr = true;
                    errors.setTitleError("Article title required from 2 to 70 characters");
                }

                if (txtDiscription.trim().length() < 2) {
                    fourdErr = true;
                    errors.setDescriptionError("Content required from 2 characters");
                }

                if (fourdErr) {
                    ArticlesDTO dto = new ArticlesDTO();
                    dto.setTitle(txtTitle);
                    dto.setDescription(txtDiscription);
                    request.setAttribute("DTO", dto);
                    request.setAttribute("CREATEERROR", errors);
                    url = CREATE_ERROR;
                    request.getRequestDispatcher(url).forward(request, response);
                } else {
                    ArticlesDAO dao = new ArticlesDAO();
                    ArticlesDTO dto = new ArticlesDTO();
                    dto.setTitle(txtTitle);
                    dto.setDescription(txtDiscription);
                    dto.setImage(imageLink);
                    dto.setEmail(userDto.getEmail());

                    boolean result = dao.insertArticle(dto);
                    if (result) {
                        url = CREATE_SUCCESS;
                    }
                    response.sendRedirect(url);
                }
            }
        } catch (FileUploadException ex) {
            log("Error CreateArticle File Upload: " + ex.getMessage());
        } catch (SQLException ex) {
            log("Error CreateArticle SQL: " + ex.getMessage());
        } catch (NamingException ex) {
            log("Error CreateArticle Naming: " + ex.getMessage());
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
