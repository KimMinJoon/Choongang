<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/modern-business.css" rel="stylesheet">
<link href="../font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	/* 에이작스로 두에서 뷰를 받아서 뿌려버림 개 편리하고 좋음 */
</script>

</head>
<body>
	
	
    <!-- Header Carousel -->
    <header id="myCarousel" class="carousel slide">
        <!-- Indicators -->
        <ol class="carousel-indicators">
            <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
            <li data-target="#myCarousel" data-slide-to="1"></li>
            <li data-target="#myCarousel" data-slide-to="2"></li>
        </ol>

        <!-- Wrapper for slides -->
        <div class="carousel-inner">
            <div class="item active">
                <div class="fill" style="background-image:url('../images/le_img1.jpg');"></div>
                <div class="carousel-caption">
                </div>
            </div>
            <div class="item">
                <div class="fill" style="background-image:url('../images/le_img2.jpg');"></div>
                <div class="carousel-caption">
                </div>
            </div>
            <div class="item">
                <div class="fill" style="background-image:url('../images/le_img3.jpg');"></div>
                <div class="carousel-caption">
                </div>
            </div>
        </div>

        <!-- Controls -->
        <a class="left carousel-control" href="#myCarousel" data-slide="prev">
            <span class="icon-prev"></span>
        </a>
        <a class="right carousel-control" href="#myCarousel" data-slide="next">
            <span class="icon-next"></span>
        </a>
    </header>
    

    <div id="homemeetlist_new"> </div>
	
	<div class="container">
	<table>
		<tr>
			<td> <div id="homemeetlist_reco" class="table"> </div> </td>
			<td> <div id="homemeetlist_read" class="table"> </div> </td>
		</tr>
	</table>
   </div>

	
	<script src="../js/jquery.js"></script>
	<script src="../js/bootstrap.min.js"></script>
	<script>
	$(function() {
		var sendData = 'pageNum=${pageNum}'; 
		$.post('${pageContext.request.contextPath}/meetBoard/homemeetlist_new.chk',sendData,function(data){
			$('#homemeetlist_new').html(data);
		});
	});
	
	 $(function() {
		var sendData = 'pageNum=${pageNum}'; 
		$.post('${pageContext.request.contextPath}/meetBoard/homemeetlist_reco.chk',sendData,function(data){
			$('#homemeetlist_reco').html(data);
		});
	});
	
	$(function() {
		var sendData = 'pageNum=${pageNum}'; 
		$.post('${pageContext.request.contextPath}/meetBoard/homemeetlist_read.chk',sendData,function(data){
			$('#homemeetlist_read').html(data);
		});
	});
		$('.carousel').carousel({
			interval: 5000 //changes the speed
		})
	</script>
	
</body>
</html>