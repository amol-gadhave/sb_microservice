package com.microlearn.repository;

import com.microlearn.model.CustomerModel;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository
public class StoreCustomerRepository {
    public static List<CustomerModel> customerList=new ArrayList<>();

    public List<CustomerModel> getAllCustomers()
    {
      return customerList;
    }
    public CustomerModel addNewCustomer(CustomerModel newCustomer)
    {
      int maxCustomerId=0;
      if(customerList.size()!=0){
          maxCustomerId=  customerList.stream().map(customer -> Integer.parseInt(customer.getCustomerId())).max(Integer::compare).orElse(0);
      }
      CustomerModel customer= new CustomerModel(String.valueOf(maxCustomerId+1),newCustomer.getFirstName(),newCustomer.getLastName(),newCustomer.getEmailId(),newCustomer.getMobileNumber());
      customerList.add(customer);
      return customer;
    }

    public CustomerModel getCustomerById(String customerId)
    {
         return customerList.stream().filter(customer -> customer.getCustomerId().equalsIgnoreCase(customerId)).findAny().orElse(null);
    }
}
