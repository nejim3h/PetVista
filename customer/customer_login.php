<div class="box"><!-- box Starts -->

<div class="box-header"><!-- box-header Starts -->

<center>

<h1>Login</h1>

</center>

</div><!-- box-header Ends -->

<form action="checkout.php" method="post"><!--form Starts -->

<center><!-- center Starts -->

<div class="form-group" style="width: 40%;"><!-- form-group Starts -->

<label>Email</label>

<input type="text" class="form-control" name="c_email" required >

</div><!-- form-group Ends -->

<div class="form-group" style="width: 40%;"><!-- form-group Starts -->

<label>Password</label>

<input type="password" class="form-control" name="c_pass" required >

<h4>

<center>

<a href="customer_register.php" >

<h4>Register Here</h4>

</a>


</center><!-- center Ends -->

</h4>

</div><!-- form-group Ends -->

</center><!-- center Ends -->

<div class="text-center"><!-- text-center Starts -->

<button name="login" value="Login" class="btn btn-primary" style="background-color: #1DB954;">

<i class="fa fa-sign-in"></i> Log in

</button>

</div><!-- text-center Ends -->

</form><!--form Ends -->

</div><!-- box Ends -->


</div><!-- box Ends -->

<?php

if(isset($_POST['login'])){

$customer_email = $_POST['c_email'];

$customer_pass = $_POST['c_pass'];

$select_customer = "select * from customers where customer_email='$customer_email' AND customer_pass='$customer_pass'";

$run_customer = mysqli_query($con,$select_customer);

$get_ip = getRealUserIp();

$check_customer = mysqli_num_rows($run_customer);

$select_cart = "select * from cart where ip_add='$get_ip'";

$run_cart = mysqli_query($con,$select_cart);

$check_cart = mysqli_num_rows($run_cart);

if($check_customer==0){

echo "<script>alert('password or email is wrong')</script>";

exit();

}

if($check_customer==1 AND $check_cart==0){

$_SESSION['customer_email']=$customer_email;

echo "<script>alert('You are Logged In')</script>";

echo "<script>window.open('customer/my_account.php?my_orders','_self')</script>";

}
else {

$_SESSION['customer_email']=$customer_email;

echo "<script>alert('You are Logged In')</script>";

echo "<script>window.open('checkout.php','_self')</script>";

} 


}

?>