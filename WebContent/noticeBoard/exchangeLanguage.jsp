<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<!-- Page Content -->
    <div class="container">
        <!-- Page Heading/Breadcrumbs -->
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">About
                    <small>site</small>
                </h1>
                <ol class="breadcrumb">
                    <li><a href="main.jsp">Home</a></li>
                    <li class="active">About</li>
                    <li class="active">Contact</li>
                </ol>
            </div>
        </div>
        <!-- /.row -->

		<div class="row">
            <div class="col-md-6">
                <img class="img-responsive" src="../images/intro_img.jpg" alt="">
            </div>
            <div class="col-md-6">
                <h2>Language Exchange</h2>
                <p>A method of language learning based on mutual language practicing by learning partners who speak different languages.</p>
                <p>Language exchange is a method of language learning based on mutual language practicing by learning partners who are speakers of different languages. Language exchange is sometimes called Tandem language learning.</p>
                <p>In modern contexts, "language exchange" most often refers to the mutual teaching of partners' first languages. Language exchanges are generally considered helpful for developing language proficiency, especially in speaking fluency and listening comprehension. Language exchanges that take place through writing or text chats also improve reading comprehension and writing ability. Given that language exchanges generally take place between native speakers of different languages, there is also the side benefit of improving cross-cultural communication.</p>
            </div>
        </div>
        <!-- /.row -->

        <!-- Content Row -->
        <div class="col-lg-12">
                <h2 class="page-header">Contact</h2>
        </div>
        <div class="row">
            <!-- Map Column -->
            <div class="col-md-8">
                <!-- Embedded Google Map -->
                <iframe width="100%" height="400px" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="https://www.google.com/maps/embed?pb=!1m14!1m12!1m3!1d3165.3834234340043!2d127.0311146071595!3d37.49887400600874!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!5e0!3m2!1sko!2skr!4v1461752869956"></iframe>
            </div>
            <!-- Contact Details Column -->
            <div class="col-md-4">
                <h3>Contact Details</h3>
                <p>
                   	 서울 강남구 테헤란로 7길 7 (역삼동 에스코빌딩 6층)<br>
                </p>
                <p><i class="fa fa-phone"></i> 
                    <abbr title="Phone">P</abbr>: (123) 456-7890</p>
                <p><i class="fa fa-envelope-o"></i> 
                    <abbr title="Email">E</abbr>: <a href="mailto:name@example.com">name@example.com</a>
                </p>
                <p><i class="fa fa-clock-o"></i> 
                    <abbr title="Hours">H</abbr>: Monday - Friday: 9:00 AM to 6:00 PM</p>
                <ul class="list-unstyled list-inline list-social-icons">
                    <li>
                        <a href="http://www.facebook.com"><i class="fa fa-facebook-square fa-2x"></i></a>
                    </li>
                    <li>
                        <a href="http://instagram.com"><i class="fa fa-linkedin-square fa-2x"></i></a>
                    </li>
                    <li>
                        <a href="http://www.twitter.com"><i class="fa fa-twitter-square fa-2x"></i></a>
                    </li>
                    <li>
                        <a href="http://www.google.co.kr"><i class="fa fa-google-plus-square fa-2x"></i></a>
                    </li>
                </ul>
            </div>
        </div>
        <!-- /.row -->
		
		<!-- Contact Form -->
        <!-- In order to set the email address and subject line for the contact form go to the bin/contact_me.php file. -->
        <div class="row">
            <div class="col-md-8">
                <h3>Send us a Message</h3>
                <form name="sentMessage" id="contactForm">
                    <div class="control-group form-group">
                        <div class="controls">
                            <label>Name:</label>
                            <input type="text" class="form-control" id="name" required data-validation-required-message="Please enter your name.">
                            <p class="help-block"></p>
                        </div>
                    </div>
                    <div class="control-group form-group">
                        <div class="controls">
                            <label>Email Address:</label>
                            <input type="email" class="form-control" id="email" required data-validation-required-message="Please enter your email address.">
                        </div>
                    </div>
                    <div class="control-group form-group">
                        <div class="controls">
                            <label>Message:</label>
                            <textarea rows="10" cols="100" class="form-control" id="message" required data-validation-required-message="Please enter your message" maxlength="999" style="resize:none"></textarea>
                        </div>
                    </div>
                    <div id="success"></div>
                    <!-- For success/fail messages -->
                    <button type="submit" class="btn btn-primary">Send Message</button>
                </form>
            </div>
        </div>
        <!-- /.row -->
	</div>

</body>
</html>