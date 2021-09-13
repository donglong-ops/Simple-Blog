<%-- 
    Document   : gallery
    Created on : Sep 13, 2021, 12:47:56 PM
    Author     : Dong Long
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>City Blog Theme - Gallery Page</title>
        <meta name="keywords" content="city blog, gallery theme, free templates, website templates, CSS, HTML" />
        <meta name="description" content="City Blog Gallery Theme is a free website template provided by tooplate.com" />
        <link href="css/tooplate_style.css" rel="stylesheet" type="text/css" />

        <!--////// CHOOSE ONE OF THE 3 PIROBOX STYLES  \\\\\\\-->
        <link href="css_pirobox/white/style.css" media="screen" title="shadow" rel="stylesheet" type="text/css" />
        <!--<link href="css_pirobox/white/style.css" media="screen" title="white" rel="stylesheet" type="text/css" />
        <link href="css_pirobox/black/style.css" media="screen" title="black" rel="stylesheet" type="text/css" />-->
        <!--////// END  \\\\\\\-->

        <!--////// INCLUDE THE JS AND PIROBOX OPTION IN YOUR HEADER  \\\\\\\-->
        <script type="text/javascript" src="js/jquery.min.js"></script>
        <script type="text/javascript" src="js/piroBox.1_2.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                $().piroBox({
                    my_speed: 600, //animation speed
                    bg_alpha: 0.5, //background opacity
                    radius: 4, //caption rounded corner
                    scrollImage: false, // true == image follows the page, false == image remains in the same open position
                    pirobox_next: 'piro_next', // Nav buttons -> piro_next == inside piroBox , piro_next_out == outside piroBox
                    pirobox_prev: 'piro_prev', // Nav buttons -> piro_prev == inside piroBox , piro_prev_out == outside piroBox
                    close_all: '.piro_close', // add class .piro_overlay(with comma)if you want overlay click close piroBox
                    slideShow: 'slideshow', // just delete slideshow between '' if you don't want it.
                    slideSpeed: 4 //slideshow duration in seconds(3 to 6 Recommended)
                });
            });
        </script>
    </head>
    <body>
        <div id="tooplate_header_wrapper">
            <div id="tooplate_header">

                <div id="tooplate_menu">
                    <ul>
                        <li><a href="homePage.jsp">Home</a></li>
                        <li><a href="about.jsp">About Us</a></li>
                        <li><a href="gallery.jsp">Gallery</a></li>
                        <li><a href="#">Contact</a></li>
                    </ul>    	
                </div> <!-- end of tooplate_menu -->

                <div id="site_title"><h1><a rel="nofollow" href="http://www.tooplate.com">Free Website Templates</a></h1></div>

            </div> <!-- end of header -->
        </div> <!-- end of header wrapper -->
        <div id="tooplate_main_wrapper">
            <div id="tooplate_top"></div>

            <div id="tooplate_main">
                <div id="tooplate_content_wrapper">
                    <div id="tc_top"></div>

                    <div id="tooplate_content">
                        <h1>Gallery</h1>
                        <p>Credit goes to <a href="http://www.pirolab.it" target="_blank"> Diego Valobra</a> for piroxbox. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec tempus rutrum tellus at varius. Ut sit amet arcu elit, in posuere arcu. Phasellus in sapien vel felis imperdiet ullamcorper.</p>

                        <div class="cleaner h40"></div>

                        <div id="gallery">
                            <div class="gallery_box">
                                <a href="./images/gallery/image_01_b.jpg" class="pirobox gallery_img image_wrapper" title="Project 1"><img src="images/gallery/image_01.jpg" alt="Image 01" /></a>
                                <div class="right">
                                    <h5>Project 1</h5>
                                    <p><em>Cras sed sem sapien. Proin fermentum porta ligula, ac hendrerit lorem accumsan eu. Nam sodales orci at tortor tristique tincidunt.</em></p>		
                                    <p>Quisque sed mauris velit, a congue lorem. Aliquam quis mi sed libero dapibus iaculis a et mi. Egestas diam quis dapibus. Quisque sed mauris velit, a congue lorem. </p>
                                    <a href="#" class="more float_r">Visit site</a>
                                </div>
                                <div class="cleaner"></div>
                            </div>

                            <div class="gallery_box">
                                <a href="./images/gallery/image_02_b.jpg" class="pirobox gallery_img image_wrapper" title="Project 2"><img src="images/gallery/image_02.jpg" alt="Image 02" /></a>
                                <div class="right">
                                    <h5>Project 2</h5>
                                    <p><em>Cras id tortor nisl. Nullam ante diam, interdum sit amet. Velit justo sodales lectus, ac porta nunc eros vitae.  Morbi nec velit magna.</em></p>
                                    <p>Maecenas eros ipsum, tincidunt vitae ultricies id, blandit quis nulla. Fusce sem nulla, rutrum ac suscipit eget, commodo vitae est. In at orci arcu.</p>
                                    <a href="#" class="more float_r">Visit site</a>
                                </div>
                                <div class="cleaner"></div>
                            </div>

                            <div class="gallery_box last_gallery_box">
                                <a href="./images/gallery/image_03_b.jpg" class="pirobox gallery_img image_wrapper" title="Project 3"><img src="images/gallery/image_03.jpg" alt="Image 03" /></a>
                                <div class="right">
                                    <h5>Project 3</h5>
                                    <p><em>Nam vel mauris eu lacus vehicula rhoncus nec nec tellus. Sed felis tellus, interdum eget tincidunt nec, aliquam vel ligula.Nam vel mauris eu lacus.</em></p>
                                    <p>Sodales nec, mollis lobortis sapien. Vestibulum pharetra tortor vitae velit pretium rhoncus integer consectetur enim eget. Pellentesque et semper nisi.</p>
                                    <a href="#" class="more float_r">Visit site</a>
                                </div>

                                <div class="cleaner"></div>
                            </div>

                        </div> <!-- end of gallery -->
                    </div>

                    <div id="tc_bottom"></div>
                </div> <!-- end of content wrapper -->

                <div id="tooplate_sidebar_wrapper">
                    <div id="tooplate_sidebar_top"></div>

                    <div id="tooplate_sidebar">

                        <div class="ads_250x250">
                            <a href="#"><img src="./images/tooplate_ads.jpg" alt="banner" /></a>
                        </div>

                        <div class="sb_box">
                            <h3>Categories</h3>
                            <ul class="tooplate_list">
                                <li><a href="#">Aenean lacinia nunc id</a></li>
                                <li><a href="#">Cras sed neque et eros</a></li>
                                <li><a href="#">Donec eget massa eget</a></li>
                                <li><a href="#">Etiam eu velit sapien</a></li>
                                <li><a href="#">Integer hendrerit nisi</a></li>
                                <li><a href="#">Maecenas sit odio ut</a></li>
                            </ul>
                        </div>

                        <div class="sb_box">
                            <h3>Recent comments</h3>
                            <div class="recent_comment_box">
                                <a href="#">Praesent malesuada turpis</a>
                                <p>Duis mi elit, aliquet id euismod egestas, venenatis sit amet lectus.</p>
                            </div>

                            <div class="recent_comment_box">
                                <a href="#">Nullam consequat mauris </a>
                                <p>Etiam porttitor metus ac est mattis luctus. Integer tortor. Validate <a href="http://validator.w3.org/check?uri=referer" rel="nofollow"><strong>XHTML</strong></a> and <a href="http://jigsaw.w3.org/css-validator/check/referer" rel="nofollow"><strong>CSS</strong></a>.</p>
                            </div>

                            <a href="#" class="more float_r">Read more</a>
                            <div class="cleaner"></div>
                        </div>

                        <div class="cleaner"></div>
                    </div>

                    <div id="tooplate_sidebar_bottom"></div>
                </div> <!-- end of sidebar wrapper -->

                <div class="cleaner"></div>
            </div>

            <div id="tooplate_bottom"></div>
        </div> <!-- end of main wrapper -->

        <div id="tooplate_footer">
            Copyright © 2048 <a href="#">Dong Long - Ops</a>
        </div> <!-- end of tooplate_footer -->
    </body>
</html>
