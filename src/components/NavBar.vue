<template>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
	  <a class="navbar-brand" href="#">MD Clinic Systems</a>
	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  </button>

	  <div class="collapse navbar-collapse" id="navbarSupportedContent">
	    <ul class="navbar-nav mr-auto">
	      <li class="nav-item dropdown">
	        <a class="nav-link dropdown-toggle" href="#" id="employeesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	          Employees
	        </a>
	        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
	          <a class="dropdown-item" href="#" data-toggle="modal" data-target="#new-employee-modal">Add</a>
	          <!-- <a class="dropdown-item" href="#">Edit/Delete</a> -->
	        </div>
	      </li>
	      <li class="nav-item dropdown">
	        <a class="nav-link dropdown-toggle" href="#" id="employeesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	          Clients
	        </a>
	        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
	          <a class="dropdown-item" href="#" data-toggle="modal" data-target="#new-client-modal">Add</a>
	          <a class="dropdown-item" href="#" data-toggle="modal" data-target="#client-measurement-modal">Weight Mesaurements</a>
	          <!-- <a class="dropdown-item" href="#">Edit/Delete</a> -->
	        </div>
	      </li>
	    </ul>
	  </div>
	</nav>
</template>