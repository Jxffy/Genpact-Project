<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <link rel="stylesheet" href="form.css">
  <link rel="stylesheet" type="text/css" href="https://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css">
  <link rel="stylesheet" type="text/css" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.2.0/css/datepicker.min.css">
  <link rel="stylesheet" type="text/css" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-switch/1.8/css/bootstrap-switch.css">
  <link rel="stylesheet" type="text/css" href="https://davidstutz.github.io/bootstrap-multiselect/css/bootstrap-multiselect.css">
  
  <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
  <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.0/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.2.0/js/bootstrap-datepicker.min.js"></script>
  <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-switch/1.8/js/bootstrap-switch.min.js"></script>
  <script type="text/javascript" src="https://davidstutz.github.io/bootstrap-multiselect/js/bootstrap-multiselect.js"></script>
</head>
<body>
  <div class="container">
    <div class="panel panel-primary dialog-panel">
      <div class="panel-heading">
        <h5>Customer-Application</h5>
      </div>
      <div class="panel-body">
        <form class="form-horizontal" role="form" id="myform" action="storecustomer" method="post">
          <div class="form-group">
            <label class="control-label col-md-2 col-md-offset-2" for="id_accommodation">Type of Account</label>
            <div class="col-md-2">
              <select class="form-control" id="id_accommodation" name="type">
                <option>Saving</option>
                <option>Current</option>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="control-label col-md-2 col-md-offset-2" for="id_title">Name</label>
            <div class="col-md-8">
              <div class="col-md-2">
                <div class="form-group internal">
                  <select class="form-control" id="id_title">
                    <option>Mr</option>
                    <option>Ms</option>
                    <option>Mrs</option>
                    <option>Miss</option>
                    <option>Dr</option>
                  </select>
                </div>
              </div>
              <div class="col-md-3 indent-small">
                <div class="form-group internal">
                  <input class="form-control" id="id_first_name" name="first_name" type="text" placeholder="First Name">
                </div>
              </div>
              <div class="col-md-3 indent-small">
                <div class="form-group internal">
                  <input class="form-control" id="id_last_name" name="last_name" type="text" placeholder="Last Name">
                </div>
              </div>
            </div>
          </div>
          <div class="form-group">
            <label class="control-label col-md-2 col-md-offset-2" for="id_adults">Age</label>
            <div class="col-md-8">
              <div class="col-md-2">
                <div class="form-group internal">
                  <input class="form-control col-md-8" id="id_age" name="age" type="number" placeholder="18+ years">
                </div>
              </div>
            </div>
          </div>
          <div class="form-group">
            <label class="control-label col-md-2 col-md-offset-2" for="id_email">Contact</label>
            <div class="col-md-6">
              <div class="form-group">
                <div class="col-md-11">
                  <input class="form-control" id="id_email" name="email" type="text" placeholder="E-mail">
                </div>
              </div>
              <div class="form-group internal">
                <div class="col-md-11">
                  <input class="form-control" id="id_phone" name="phone" type="text" placeholder="Phone: (xxx) - xxx xxxx">
                </div>
              </div>
            </div>
          </div>
          <div class="form-group">
            <label class="control-label col-md-2 col-md-offset-2" for="id_dob">Date of Birth</label>
            <div class="col-md-8">
              <div class="col-md-3">
                <div class="form-group internal input-group">
                  <input class="form-control Date" id="id_dob" name="dob" placeholder="YYYY-MM--DD">
                  <span class="input-group-addon">
                    <i class="glyphicon glyphicon-calendar"></i>
                  </span>
                </div>
              </div>
            </div>
          </div>
          <div class="form-group">
            <label class="control-label col-md-2 col-md-offset-2" for="Address">Address</label>
            <div class="col-md-8">
              <div class="col-md-3">
                <div class="form-group internal">
                  <input class="form-control" type="text" id="Address" name="address">
                </div>
              </div>
            </div>
          </div>
          <!-- Initial Amount Section -->
          <div class="form-group">
            <label class="control-label col-md-2 col-md-offset-2" for="initial_amount">Initial Amount</label>
            <div class="col-md-8">
              <div class="col-md-3">
                <div class="form-group internal">
                  <input class="form-control" name="initial" id="initial_amount" type="number" placeholder="Enter amount" min="1000" oninput="validateInitialAmount()">
                  <small class="text-danger" id="amount_error" style="display:none;">Amount should be 1000 or more</small>
                </div>
              </div>
            </div>
          </div>
          <div class="form-group">
            <label class="control-label col-md-2 col-md-offset-2" for="id_proof">ID proof</label>
            <div class="col-md-6">
                <input type="text" class="form-control" id="id_proof" name="proof">
            </div>
          </div>
          <div class="form-group">
            <div class="col-md-offset-4 col-md-3" style="margin-top: 25px;">
              <button class="btn btn-lg btn-primary" type="submit">Create Account</button>
            </div>
            <div class="col-md-3">
              <a href="admin.html"><button class="btn btn-lg btn-danger" style="float:right; margin-top: 25px;" type="button">Cancel</button></a>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
  <script src="index.js"></script>
  <script>
    function validateInitialAmount() {
      var initialAmount = document.getElementById('initial_amount').value;
      if (initialAmount < 1000) {
        document.getElementById('amount_error').style.display = 'block';
      } else {
        document.getElementById('amount_error').style.display = 'none';
      }
    }
  </script>
</body>
</html>
