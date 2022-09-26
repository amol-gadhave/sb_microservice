package com.microlearn.controller;

import com.fasterxml.jackson.databind.ser.BeanPropertyFilter;
import com.fasterxml.jackson.databind.ser.FilterProvider;
import com.fasterxml.jackson.databind.ser.impl.SimpleBeanPropertyFilter;
import com.fasterxml.jackson.databind.ser.impl.SimpleFilterProvider;
import com.microlearn.model.CustomerModel;
import com.microlearn.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.json.MappingJacksonValue;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
public class CustomerController {

    @Autowired
    CustomerService custService;

    @GetMapping("/getCustomer")
    public List<CustomerModel> getCustomer()
    {
        List<CustomerModel> customerList = custService.retrieveAllCustomers();
        MappingJacksonValue mappedValue=new MappingJacksonValue(customerList);
        SimpleBeanPropertyFilter filter= SimpleBeanPropertyFilter.filterOutAllExcept("customerId","firstName","lastName");
        FilterProvider fProvider=new SimpleFilterProvider().addFilter("CustomerFilter", filter);
        mappedValue.setFilters(fProvider);
        return customerList;
    }

    @GetMapping("/getCustomer/{id}")
    public ResponseEntity<CustomerModel> getCustomer(@PathVariable String id)
    {
        CustomerModel customer= custService.retrieveCustomerById(id);
        if(customer==null){
            throw new CustomerNotFoundException("Customer id "+id+"not found");
        }
        return ResponseEntity.ok().body(customer);
    }

    @PostMapping("/getCustomer")
    public ResponseEntity<CustomerModel> createCustomer(@RequestBody CustomerModel customer)
    {
        CustomerModel customerResponse=custService.createNewCustomer(customer);
        MappingJacksonValue mappedValue = new MappingJacksonValue(customerResponse);
        SimpleBeanPropertyFilter filter= SimpleBeanPropertyFilter.filterOutAllExcept("customerId","firstName","lastName");
        FilterProvider fProvider=new SimpleFilterProvider().addFilter("CustomerFilter", filter);
        mappedValue.setFilters(fProvider);
        return ResponseEntity.status(HttpStatus.CREATED).body(customerResponse);
    }

    @PostMapping("/getCustomer/param")
    public CustomerModel createCustomer(@RequestParam Map<String,String> requestParams)
    {
        return custService.createNewCustomer(new CustomerModel(null, requestParams.get("fname"), requestParams.get("lname"),null,null));
    }

    @PostMapping("/getCustomer/param2")
    public CustomerModel createCustomer(@RequestParam(value="fname", required = true) String fname, @RequestParam(value="lname", required = false) String lname )
    {
        return custService.createNewCustomer(new CustomerModel(null,fname, lname,null,null));
    }

}
