package com.microlearn.service;

import com.microlearn.model.CustomerModel;
import com.microlearn.repository.StoreCustomerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CustomerService {

    @Autowired
    StoreCustomerRepository storeRepository;

    public List<CustomerModel> retrieveAllCustomers()
    {
        return storeRepository.getAllCustomers();
    }

    public CustomerModel  retrieveCustomerById(String id)
    {
        return storeRepository.getCustomerById(id);
    }

    public CustomerModel createNewCustomer(CustomerModel model)
    {
        return storeRepository.addNewCustomer(model);
    }

}
