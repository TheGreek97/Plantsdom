<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script  src="https://code.jquery.com/jquery-3.6.0.min.js"
  integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
  crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
<link rel="stylesheet" href="src/css/app.css">
<link href="https://unpkg.com/bootstrap-table@1.18.3/dist/bootstrap-table.min.css" rel="stylesheet">

<script src="https://unpkg.com/bootstrap-table@1.18.3/dist/bootstrap-table.min.js"></script>

<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js" integrity="sha384-LtrjvnR4Twt/qOuYxE721u19sVFLVSA4hf/rRt6PrZTmiPltdZcI7q7PXQBYTKyf" crossorigin="anonymous"></script>
<title>Plantsdom - Operations</title>
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
                <a class="nav-link" href="/plantsdom/operations.jsp"> Private area</a>
            </li>
        </ul>
    </div>
</nav>
<div class="row">
	<div class="col-2 sidebar">
		<div class="m-3"><span class="logo large">Operations - Private area</span></div>
		<div class="list-group" id="list-tab" role="tablist">
		  <a class="list-group-item list-group-item-action active" id="list-1-list" data-toggle="list" href="#list-1" role="tab" aria-controls="1">Insert a new supply</a>
		  <a class="list-group-item list-group-item-action" id="list-2-list" data-toggle="list" href="#list-2" role="tab" aria-controls="2">Register a new sale</a>
		  <a class="list-group-item list-group-item-action" id="list-3-list" data-toggle="list" href="#list-3" role="tab" aria-controls="3">Plants available list</a>
		  <a class="list-group-item list-group-item-action" id="list-4-list" data-toggle="list" href="#list-4" role="tab" aria-controls="4">Customer purchase list</a>
		  <a class="list-group-item list-group-item-action" id="list-5-list" data-toggle="list" href="#list-5" role="tab" aria-controls="5">Most sold plants list</a>
		</div>
	</div>
	<div class="col-10 p-3">
		<div class="tab-content" id="nav-tabContent">
		
		  <!-- TAB 1 -->
	      <div class="tab-pane fade show active" id="list-1" role="tabpanel" aria-labelledby="list-1-list">
      		<span class="section-title logo"> Insert a new supply (purchase from a supplier)</span>
      		<form action="insert_supply" class="mt-3 p-5" method="post" id="form_op_1">
      		   <div class="form-row">
      			 <div class="form-group col-md-6">
				    <label for="formGroupExampleInput">Supplier code</label>
				    <input type="number" class="form-control" id="supplierCode" name="supplierCode" required placeholder="Enter number" value="12132">
				  </div>
				  <div class="form-group col-md-6">
				    <label for="formGroupExampleInput">Purchase date</label>
				    <input type="date" class="form-control" id="purchaseDate" name="purchaseDate" required placeholder="Enter date" value="1997-09-01">
				  </div>
				  <div class="form-group col-md-6">
				    <label for="formGroupExampleInput">Arrival date (estimated)</label>
				    <input type="date" class="form-control" id="arrivalDate" name="arrivalDate" required placeholder="Enter date" value="1997-10-03">
				  </div>
			   </div>
			   <span>Plants purchased:</span>
			    <table class="table" id="add_table_1" data-unique-id="table_id" data-toggle="table" data-toolbar="#toolbar">
				  	<thead>
					    <tr>
					      <th scope="col" class="tcol-1" data-field="remove_btn"></th>
					      <th scope="col" class="tcol-2" data-field="id">Plant ID</th>
					      <th scope="col" class="tcol-3" data-field="color">Color</th>
					      <th scope="col" class="tcol-3" data-field="paid">Cost per unit</th>
					      <th scope="col" class="tcol-3" data-field="quantity">Quantity</th>
					    </tr>
					</thead>
				</table>
				<div class="form-row">
					<div class="form-group col-md-3">
					    <input type="number" class="form-control" min="1" id="add_plantID" placeholder="Enter plant ID">
					  </div>
					  <div class="form-group col-md-3">
					    <div class="input-group">
						  <input type="text" class="form-control" id="add_color" maxlength="10" placeholder="Enter color (optional)">
						</div>
					 </div>
					  <div class="form-group col-md-3">
				   
				    <div class="input-group mb-3">
					  <input type="number" class="form-control" id="add_paid" min="0" step="0.01" placeholder="Enter price" aria-label="Amount paid (Per piece)" aria-describedby="euro-symbol">
					  <div class="input-group-append">
					    <span class="input-group-text" id="euro-symbol">&euro;</span>
					  </div>
					</div>
				 </div>
					 <div class="form-group col-md-3">
					    <input type="number" class="form-control"  min="1" id="add_quantity" placeholder="Enter quantity">
					 </div>
					 <div class="col text-center mt-1">
				   		<button type="button" class="btn btn-secondary" onclick="addPlant(1)">+ Add plant</button>
			   	   	</div>
				 </div>
			   <div class="form-row mt-3">
			   	  <div class="col text-right">
			   		<button type="submit" class="btn btn-success">Save purchase</button>
			   	   </div>
			   </div>
			   <input type="hidden" name="plants_purchased" id="plants_purchased_1">
			   <input type="hidden" name="operation" value="1">
      		</form>
      		<%= request.getAttribute("previousResult")%>
      		<%= response.getStatus() %>
	      </div>
	      
	      <!-- TAB 2 -->
	      <div class="tab-pane fade" id="list-2" role="tabpanel" aria-labelledby="list-2-list">
	      	<span class="section-title logo"> Register a new sale to a customer</span>
	      	<form action="insert_sale" class="mt-3 p-5" method="post" id="form_op_2">
      		   <div class="form-row">
      			<div class="form-group col-md-6">
				    <label for="formGroupExampleInput">Customer identification number</label>
				    <input type="text" class="form-control" id="customerCode" name="customerCode" value="FM1A5SQ0ESBAKS4" required placeholder="Enter VAT or Tax Id. Number">
				  </div>
			   </div>
			   <span>Plants purchased:</span>
			    <table class="table" id="add_table_2" data-unique-id="table_id" data-toggle="table" data-toolbar="#toolbar">
				  	<thead>
					    <tr>
					      <th scope="col" class="tcol-1" data-field="remove_btn"></th>
					      <th scope="col" class="tcol-2" data-field="id">Plant ID</th>
					      <th scope="col" class="tcol-6" data-field="color">Color</th>
					      <th scope="col" class="tcol-3" data-field="quantity">Quantity</th>
					    </tr>
					</thead>
				</table>
				<div class="form-row">
					<div class="form-group col-md-3">
					    <input type="number" class="form-control"  min="1" id="add_plantID_2" placeholder="Enter plant ID">
					  </div>
					  <div class="form-group col-md-6">
					    <div class="input-group">
						  <input type="text" class="form-control" id="add_color_2" maxlength="10" placeholder="Enter color (optional)">
						</div>
					 </div>
					 <div class="form-group col-md-3">
					    <input type="number" class="form-control"  min="1" id="add_quantity_2" placeholder="Enter quantity">
					 </div>
					 <div class="col text-center mt-1">
				   		<button type="button" class="btn btn-secondary" onclick="addPlant('2')">+ Add plant</button>
			   	   	</div>
				 </div>
			   <div class="form-row mt-3">
			   	  <div class="col text-right">
			   		<button type="submit" class="btn btn-success">Save sale for customer</button>
			   	   </div>
			   </div>
			   <input type="hidden" name="plants_purchased"  id="plants_purchased_2">
			   <input type="hidden" name="operation" value="2">
      		</form>  
	      </div>
	      
	      <!-- TAB 3 -->
	      <div class="tab-pane fade" id="list-3" role="tabpanel" aria-labelledby="list-3-list">
	      	<span class="section-title logo"> Show the list of plants available</span>
      		<form  onsubmit="getPlantsAvailable(); return false;" class="mt-3 p-5" method="get">
      		   <div class="form-inline">
	      		   <div class="form-group mx-3">
					    <label for="formGroupExampleInput">Show how many results?</label>
					    <input type="number" class="form-control ml-2" id="op3_limit" name="op3_limit" required placeholder="Enter number" min="1" max="500">
				   </div>
				   <button type="submit" class="btn btn-primary">Show List</button> 
				</div>
			    <input type="hidden" name="operation" value="3">
      		</form>
      		<table class="table overflow-x" id="results_table_3" data-unique-id="table_id" data-toggle="table" data-toolbar="#toolbar">
			  	<thead>
				    <tr>
				      <th scope="col" class="tcol-1" data-field="PLANT_ID">Plant ID</th>
				      <th scope="col" class="tcol-1" data-field="COMMON_NAME" data-toggle="tooltip" data-placement="top" title="Common name">Common Name</th>
				      <th scope="col" class="tcol-1" data-field="SCIENTIFIC_NAME" data-toggle="tooltip" data-placement="top" title="Scientific name">Scientific Name</th>
				      <th scope="col" class="tcol-1" data-field="PLANT_TYPE">Plant type</th>
				      <th scope="col" class="tcol-1" data-field="GARDEN" data-toggle="tooltip" data-placement="top" title="Garden or Apartment plant?">Garden/apartment</th>
				      <th scope="col" class="tcol-1" data-field="EXOTIC">Exotic</th>
				      <th scope="col" class="tcol-1" data-field="CURRENT_PRICE" data-toggle="tooltip" data-placement="top" title="Current Price">Price</th>
				      <th scope="col" class="tcol-1" data-field="IN_STOCK">In Stock</th>
				      <th scope="col" class="tcol-1" data-field="COLORS">Colors</th>
				      <th scope="col" class="tcol-3" data-field="OLD_PRICES">Old Prices</th>
				    </tr>
				</thead>
			</table>
	      </div>
	      
	      <!-- TAB 4 -->
	      <div class="tab-pane fade" id="list-4" role="tabpanel" aria-labelledby="list-4-list">
	      	<span class="section-title logo"> Show the list of purchases of a Customer</span>
      		<form onsubmit="getCustomerPurchases(); return false;" class="mt-3 p-5" method="post">
      		   <div class="form-inline">
      			 <div class="form-group mx-3">
				      <label for="formGroupExampleInput">Enter the customer's identifier (VAT or Tax Identification number):</label>
				      <input type="text" class="form-control ml-2" value="FM1A5SQ0ESBAKS4" id="customer_identifier_op4" required placeholder="Enter VAT or Tax Number"> 
			    </div>
			     <button type="submit" class="btn btn-success">Show</button>
			   </div>
			   <input type="hidden" name="operation" value="4">
      		</form>
      		<table class="table overflow-x" id="results_table_4" data-unique-id="table_id" data-toggle="table" data-toolbar="#toolbar">
			  	<thead>
				    <tr>
				      <th scope="col" class="tcol-11" data-field="PLANTS_PURCHASED">Plants Purchased</th>
				      <th scope="col" class="tcol-1" data-field="DATETIME" data-toggle="tooltip" data-placement="top" title="Date and time of purchase"> Date and time</th>
				    </tr>
				</thead>
			</table>
	      </div>
	      
	       <!-- TAB 5 -->
	      <div class="tab-pane fade" id="list-5" role="tabpanel" aria-labelledby="list-5-list">
	       	<span class="section-title logo"> Show the list of the most sold Plants</span>
      		<form onsubmit="getMostSold(); return false;" class="mt-3 p-5" method="get">
      		   <div class="form-inline text-center">
	      		   <div class="form-group mx-3">
					    <label for="formGroupExampleInput">Show how many results?</label>
					    <input type="number" class="form-control ml-2" id="op5_limit" name="op5_limit" required placeholder="Enter number" min="1" max="500">
				   </div>
				   <button type="submit" class="btn btn-primary">Show</button> 
				</div>
			    <input type="hidden" name="operation" value="5">
      		</form>
      		<table class="table overflow-x" id="results_table_5" data-unique-id="table_id" data-toggle="table" data-toolbar="#toolbar">
			  	<thead>
				    <tr>
				      <th scope="col" class="tcol-1" data-field="PLANT_ID">Plant ID</th>
				      <th scope="col" class="tcol-1" data-field="COMMON_NAME" data-toggle="tooltip" data-placement="top" title="Common name">Common Name</th>
				      <th scope="col" class="tcol-1" data-field="SCIENTIFIC_NAME" data-toggle="tooltip" data-placement="top" title="Scientific name">Scientific Name</th>
				      <th scope="col" class="tcol-1" data-field="PLANT_TYPE">Plant type</th>
				      <th scope="col" class="tcol-1" data-field="GARDEN" data-toggle="tooltip" data-placement="top" title="Garden or Apartment plant?">Garden/apartment</th>
				      <th scope="col" class="tcol-1" data-field="EXOTIC">Exotic</th>
				      <th scope="col" class="tcol-1" data-field="CURRENT_PRICE" data-toggle="tooltip" data-placement="top" title="Current Price">Price</th>
				      <th scope="col" class="tcol-1" data-field="IN_STOCK">In Stock</th>
				      <th scope="col" class="tcol-1" data-field="COLORS">Colors</th>
				      <th scope="col" class="tcol-3" data-field="OLD_PRICES">Old Prices</th>
				    </tr>
				</thead>
			</table>
	      </div>
		</div>
	</div>
</div>
<script>


var table_id_1 = 0
var $table_1 = $('#add_table_1')
var $plant_id_1 = $('#add_plantID')
var $paid = $('#add_paid')
var $color_1 = $('#add_color')
var $qty_1 = $('#add_quantity')

var table_id_2 = 0
var $table_2 = $('#add_table_2')
var $plant_id_2 = $('#add_plantID_2')
var $color_2 = $('#add_color_2')
var $qty_2 = $('#add_quantity_2')

$('#form_op_1').submit ( function () {
	console.log ($table_1.bootstrapTable('getData'))
	$('#plants_purchased_1').val(JSON.stringify($table_1.bootstrapTable('getData')))
})

$('#form_op_2').submit ( function () {
	console.log ($table_2.bootstrapTable('getData'))
	$('#plants_purchased_2').val(JSON.stringify($table_2.bootstrapTable('getData')))
})

function addPlant (tab) {	
	if (tab === 1) {
		$table_1.bootstrapTable ('insertRow', {
			index: table_id_1,
			row : {
				table_id : 		table_id_1,
				remove_btn : '<button type="button" class="btn btn-danger" onclick="removeRow('+ table_id_1 +', '+ tab +')">x</button>',
				id: 			$plant_id_1.val(),
				color : 		$color_1.val(),
				paid : 			$paid.val(),
				quantity:  		$qty_1.val()
			}
		})
		$plant_id_1.val(null)
		$color_1.val(null)
		$qty_1.val(null)
		$paid.val(null)
		table_id_1++
	} else {
		$table_2.bootstrapTable ('insertRow', {
			index: table_id_2,
			row : {
				table_id : 		table_id_2,
				remove_btn : '<button type="button" class="btn btn-danger" onclick="removeRow('+ table_id_2 +', '+ tab +')">x</button>',
				id: 			$plant_id_2.val(),
				color : 		$color_2.val(),
				quantity:  		$qty_2.val()
			}
		})
		$plant_id_2.val(null)
		$color_2.val(null)
		$qty_2.val(null)
		table_id_2++
	}

}

function removeRow (id, tab) {
	if (tab === 1) {
		$table_1.bootstrapTable('removeByUniqueId', id)	
	} else {
		$table_2.bootstrapTable('removeByUniqueId', id)
	}
}

//Op 3
function getPlantsAvailable () {
	$.ajax({
	  url: "show_available_plants",
	  type: "GET", //send it through get method
	  data: { 
	  	operation : '3', 
	  	timeout : 5000
	  },
	  success: function(response) {
		  let i 
		  let results_limit = $('#op3_limit').val() ?? 50
		  $table = $('#results_table_3')
		  $table.bootstrapTable('removeAll')
		  for (i=0; i < results_limit; i++) {
			  response[i]['PLANT_TYPE'] = response[i]['PLANT_TYPE'] == 'g' ? 'Green' : 'Flowery'; 
			  response[i]['GARDEN'] = response[i]['GARDEN'] == 'G' ? 'Garden' : 'Apartment' ;
			  response[i]['EXOTIC'] = response[i]['EXOTIC'] == '1' ? 'Yes' : 'No' ;
			  response[i]['COLORS'] = getArrayString(response[i]['COLORS']);
			  response[i]['OLD_PRICES'] = createSubTable(response[i]['OLD_PRICES'], ["Price", "Start Date", "Ending Date"])
			  $table.bootstrapTable('append', response[i]) 
		  }
	  },
	  error: function(xhr) {
	    //Do Something to handle error
	  }
	});
}

// Op 4
function getCustomerPurchases() {
	let customer_id = $('#customer_identifier_op4').val()
	$.ajax({
	  url: "show_customer_purchases",
	  type: "GET", //send it through get method
	  data: { 
	  	operation : '4', 
	  	timeout : 5000,
	  	customer_id: customer_id
	  },
	  success: function(response) {
		  let i
		  $table = $('#results_table_4')
		  console.log(response) 
		  $table.bootstrapTable('removeAll')
		  for (i=0; i < response.length; i++) {
			  response[i]['PLANTS_PURCHASED'] = createSubTable(response[i]['PLANTS_PURCHASED'], ["Plant ID", "Common Name", "Quantity", "Color", "Paid"])
			  response[i]['DATETIME'] = response[i]['DATETIME']
			  $table.bootstrapTable('append', response[i]) 
		  }
	  },
	  error: function(xhr) {
	  }
	})
}

//Op 5
function getMostSold () {
	$.ajax({
	  url: "show_most_sold",
	  type: "GET", //send it through get method
	  data: { 
	  	operation : '5', 
	  	timeout : 5000
	  },
	  success: function(response) {
		  let i
		  let results_limit = $('#op5_limit').val() ?? 50
		  $table = $('#results_table_5')
		  $table.bootstrapTable('removeAll')
		  for (i=0; i < results_limit; i++) {
			  response[i]['PLANT_TYPE'] = response[i]['PLANT_TYPE'] == 'g' ? 'Green' : 'Flowery'; 
			  response[i]['GARDEN'] = response[i]['GARDEN'] == 'G' ? 'Garden' : 'Apartment' ;
			  response[i]['EXOTIC'] = response[i]['EXOTIC'] == '1' ? 'Yes' : 'No' ;
			  response[i]['COLORS'] = getArrayString(response[i]['COLORS']);
			  response[i]['OLD_PRICES'] = createSubTable(response[i]['OLD_PRICES'], ["Price", "Start Date", "Ending Date"])
			  $table.bootstrapTable('append', response[i]) 
		  }
	  },
	  error: function(xhr) {
	    //Do Something to handle error
	  }
	});
}

function createSubTable (object_array, col_names) {
	if (!object_array || object_array.length < 1 || object_array === "[]" || object_array === "{}") {
		return "-";
	}
	let res = '<table class="table overflow-x">' +
		'<thead><tr>'
	let i
	for (i= 0; i<col_names.length; i++) {
		res += "<th>"+ col_names[i] +"</th>"
	}
	res += '<tr></thead>'
	
	for (i=0; i<object_array.length; i++) {
		res += "<tr>"
		for (val in object_array[i]){
			res += "<td>" + object_array[i][val] +"</td>"
		}
		res += "</tr>"
	}
	res += '</table>'
	return res
}

function getArrayString (array) {
	if (!array || array.length < 1 || array==="{}") {
		return "-";
	}
	let res = ""
	for (let i=0; i<array.length; i++) {
		if(array[i]) {
			res +=	array[i]
			if (i !== array.length -1) {
				res += ", "
			}
		}
	}
	return res
}
</script>
</body>
</html>