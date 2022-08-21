package com.microlearn.controller;

import com.microlearn.model.CustomerModel;
import com.microlearn.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class CustomerController {

    @Autowired
    CustomerService custService;

    @GetMapping("/getCustomer")
    public List<CustomerModel> getCustomer()
    {
        return custService.retrieveAllCustomers();
    }

    @GetMapping("/getCustomer/{id}")
    public CustomerModel getCustomer(@PathVariable String id)
    {
        return custService.retrieveCustomerById(id);
    }

    @PostMapping("/getCustomer")
    public CustomerModel createCustomer(@RequestBody CustomerModel customer)
    {
        return custService.createNewCustomer(customer);
    }

}
