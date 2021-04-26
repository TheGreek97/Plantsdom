<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script  src="https://code.jquery.com/jquery-3.6.0.min.js"
  integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
  crossorigin="anonymous"></script>
  
<link rel="stylesheet" href="src/css/app.css">
<link rel="stylesheet" href="src/css/home.css">

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js" integrity="sha384-LtrjvnR4Twt/qOuYxE721u19sVFLVSA4hf/rRt6PrZTmiPltdZcI7q7PXQBYTKyf" crossorigin="anonymous"></script>
<title>Plantsdom - Home</title>
</head>
<body>

<nav class="navbar navbar-expand-md navbar-dark bg-dark">
    <div class="navbar-collapse collapse w-100 order-1 order-md-0 dual-collapse2">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="/plantsdom">Home</a>
            </li>
        </ul>
    </div>
    <div class="mx-auto order-0">
        <a class="navbar-brand mx-auto text-uppercase logo" href="/plantsdom">Plantsdom</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target=".dual-collapse2">
            <span class="navbar-toggler-icon"></span>
        </button>
    </div>
    <div class="navbar-collapse collapse w-100 order-3 dual-collapse2">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item">
                <a class="nav-link" href="/plantsdom/operations.jsp">Private area</a>
            </li>
        </ul>
    </div>
</nav>
<div class="row mt-3">
	<div class="col-12">
		<div class="container carousel-container-rounded"> 
			<div id="carouselSlides" class="carousel slide" data-ride="carousel">
				<div class="carousel-inner img-container">
				    <div class="carousel-item active image">
						<div class="over-image-text"> An enormous variety of plants</div>
				      	<img class="d-block w-100" src="src/pictures/slideshow2.jpeg" alt="Plants image 1">
				    </div>
				    <div class="carousel-item image">
				    	<div class="over-image-text"> The most robust trees</div>
				      	<img class="d-block w-100" src="src/pictures/slideshow3.jpeg" alt="Trees">
				    </div>
				    <div class="carousel-item image">
				    	<div class="over-image-text"> The most beautiful and rare flowers</div>
				      	<img class="d-block w-100" src="src/pictures/slideshow4.jpg" alt="Flowers">
				    </div>
				    <div class="carousel-item image">
				    	<div class="over-image-text"> For privates and retailers</div>
				      	<img class="d-block w-100" src="src/pictures/slideshow1.jpeg" alt="Plants image 2">
				   	</div>
			 	</div>
			</div>
		</div>
	</div>
</div>
<div class="d-flex justify-content-center mt-3">
	<span class="logo large"> Discover our services</span>
</div>
<div class="row mt-4">
	<div class="col-md-4 col-12 text-center banner px-3">
		<div class="card m-auto">
			<div class="card-header"></div>
	  		<div class="card-body px-4">
	  			<h5 class="card-title">Get the beauty</h5>
		    	<p class="card-text">Buy Plants for your house, your garden or your greenhouse!</p>
		    	<img class="card-img-top img-fluid" src="src/pictures/flowers.jpg" alt="Card image cap">
		  	</div>
	  	</div>
	</div>
	<div class="col-md-4 col-12 text-center banner px-3">
		<div class="card m-auto">
			<div class="card-header"></div>
	  		<div class="card-body px-4">
		    	<h5 class="card-title">Save the planet</h5>
		    	<p class="card-text">Buy Trees and make the world green!</p>
		    	<img class="card-img-top img-fluid" src="src/pictures/ecology.jpg" alt="Card image cap">
		  	</div>
	  	</div>
	</div>
	<div class="col-md-4 col-12 text-center banner px-3">
		<div class="card m-auto">
			<div class="card-header"></div>
	  		<div class="card-body px-4">
	  		<h5 class="card-title">Make business</h5>
		    	<p class="card-text">Are you a retailer? Contact us for more information</p>
		    	<img class="card-img-top img-fluid" src="src/pictures/tall-trees.jpg" alt="Card image cap">
		  	</div>
	  	</div>
	</div>
</div>
</body>
</html>