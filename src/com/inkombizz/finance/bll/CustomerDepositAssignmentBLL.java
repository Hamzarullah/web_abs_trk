/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.dao.CustomerDepositAssignmentDAO;
//import com.inkombizz.finance.model.BankReceivedDeposit;
import com.inkombizz.finance.model.CustomerDepositAssignmentTemp;
import java.util.Date;
import java.util.List;

/**
 *
 * @author egie
 */
public class CustomerDepositAssignmentBLL {
    
    public final String MODULECODE = "004_FIN_CUSTOMER_DEPOSIT_ASSIGNMENT";
    
    private CustomerDepositAssignmentDAO customerDepositAssignmentDAO;
    
    public CustomerDepositAssignmentBLL(HBMSession hbmSession) {
        this.customerDepositAssignmentDAO = new CustomerDepositAssignmentDAO(hbmSession);
    }
    
    public ListPaging<CustomerDepositAssignmentTemp> findData(Paging paging,Date firstDate,Date lastDate,String code, String depositNo, String remark, String refNo) throws Exception {
        try {
            
            paging.setRecords(customerDepositAssignmentDAO.countData(firstDate,lastDate,code, depositNo, remark, refNo));
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CustomerDepositAssignmentTemp> listCustomerDepositAssignmentTemp = customerDepositAssignmentDAO.findData(firstDate,lastDate,code,depositNo,remark,refNo,paging.getFromRow(), paging.getToRow());
            
            ListPaging<CustomerDepositAssignmentTemp> listPaging = new ListPaging<CustomerDepositAssignmentTemp>();
            
            listPaging.setList(listCustomerDepositAssignmentTemp);
            listPaging.setPaging(paging);
            
            return listPaging;
            
        }
        catch(Exception ex) {
            throw ex;
        }
    }      
    
    public CustomerDepositAssignmentTemp get(String depositNo) throws Exception {
        try {
            return customerDepositAssignmentDAO.get(depositNo);
        }
        catch (Exception ex) {
            throw ex;
        }
    }
    
    public void save(CustomerDepositAssignmentTemp customerDepositAssignment) throws Exception {
        try {
            customerDepositAssignmentDAO.save(customerDepositAssignment, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
}
