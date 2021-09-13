/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longdh.controllers;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import javax.imageio.ImageIO;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import longdh.daos.ArticlesDAO;
import longdh.dtos.ArticleErrorObj;
import longdh.dtos.ArticlesDTO;
import longdh.dtos.UsersDTO;
import longdh.utils.SecureUUIDUtil;

/**
 *
 * @author Cyrus
 */
@WebServlet(name = "PostTheArticleController", urlPatterns = {"/PostTheArticleController"})
public class PostTheArticleController extends HttpServlet {

    private static final ArticleErrorObj errorObj = new ArticleErrorObj();
    private String email;

    private boolean validateTitle(final HttpServletRequest req) {
        boolean check = false;
        String title = req.getParameter("txtTitle");
        if (title == null || title.isEmpty()) {
            errorObj.setTitleError("Title can't be blank");
            req.setAttribute("ERROR", errorObj.getTitleError());

        } else {
            check = true;
        }
        return check;
    }

    private boolean validateDescription(final HttpServletRequest req) {
        boolean check = false;
        String description = req.getParameter("txtDescription");

        if (description == null || description.isEmpty()) {
            errorObj.setDescriptionError("You have to type your ideas");
            req.setAttribute("ERROR", errorObj.getDescriptionError());
        } else {
            check = true;
        }
        return check;
    }

    private String getImageDir(final HttpServletRequest req) throws IOException, ServletException {
        String imgDir = null;
        try {
            Part image = req.getPart("txtImage");
            if (image != null) {
                if (image.getSize() > 0) {
                    String fileType = image.getContentType();
                    String imageFileName = SecureUUIDUtil.getSecureUUID();
                    switch (fileType) {
                        case "image/png":
                            imgDir = saveImage(image, imageFileName, "png");
                            break;
                        case "image/jpg":
                            imgDir = saveImage(image, imageFileName, "jpg");
                            break;
                        case "image/jpeg":
                            imgDir = saveImage(image, imageFileName, "jpg");
                            break;
                        case "image/gif":
                            imgDir = saveImage(image, imageFileName, "gif");
                            break;
                        default:
                            errorObj.setImageError("You have to choose the image file (png/jpg/jpeg/gif)");
                            req.setAttribute("ERROR", errorObj.getImageError());
                    }
                }
            } else {
                errorObj.setImageError("You have to choose the image file (png/jpg/jpeg/gif)");
                req.setAttribute("ERROR", errorObj.getImageError());
            }
        } catch (IOException | ServletException e) {
            log("Error getImageDIr: " + e.getMessage());
        }

        return imgDir;
    }

    private ArticlesDTO createNewArticle(final HttpServletRequest req) {
        ArticlesDTO dto = new ArticlesDTO();
        dto.setTitle(req.getParameter("txtTitle"));
        dto.setDescription(req.getParameter("txtDescription"));
        dto.setEmail(email);
        try {
            String imgDir = getImageDir(req);
            dto.setImage(imgDir);
        } catch (IOException | ServletException e) {
            log("Error image: " + e.getMessage());
            errorObj.setImageError("Cannot upload image");
            req.setAttribute("ERROR", errorObj.getImageError());

        }
        return dto;
    }

    private boolean checkValidate(final HttpServletRequest req) throws IOException, ServletException {

        return validateTitle(req) && validateDescription(req);
    }

    private void callInsert(final HttpServletRequest req) throws SQLException, NamingException {
        ArticlesDAO dao = new ArticlesDAO();
        ArticlesDTO dto = createNewArticle(req);
        dao.insert(dto);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        UsersDTO dto = ((UsersDTO) request.getSession().getAttribute("USER"));
        email = dto.getEmail();
        try {
            if (checkValidate(request)) {
                callInsert(request);
            }
        } catch (Exception e) {
            e.printStackTrace();
            log("Error PostTheArticleController at: " + e.getMessage());
        } finally {
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }

    private String saveImage(Part imgFile, String fileName, String fileType) throws IOException {
        BufferedImage image = ImageIO.read(imgFile.getInputStream());
        if (image != null) {
            String fullPath = getServletContext().getRealPath("/img/");
            File imageDir = new File(fullPath + fileName + "." + fileType);
                imageDir.getParentFile().mkdirs();
                ImageIO.write(image, fileType, imageDir);
                return fileName + "." + fileType;
            } else {
                throw new IOException("Not " + fileType + " image");

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
