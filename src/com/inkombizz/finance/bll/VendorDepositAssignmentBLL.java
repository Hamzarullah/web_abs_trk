/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.dao.VendorDepositAssignmentDAO;
//import com.inkombizz.finance.model.BankReceivedDeposit;
import com.inkombizz.finance.model.VendorDepositAssignmentTemp;
import java.util.Date;
import java.util.List;

/**
 *
 * @author egie
 */
public class VendorDepositAssignmentBLL {
    
    public final String MODULECODE = "004_FIN_VENDOR_DEPOSIT_ASSIGNMENT";
    
    private VendorDepositAssignmentDAO vendorDepositAssignmentDAO;
    
    public VendorDepositAssignmentBLL(HBMSession hbmSession) {
        this.vendorDepositAssignmentDAO = new VendorDepositAssignmentDAO(hbmSession);
    }
    
    public ListPaging<VendorDepositAssignmentTemp> findData(Paging paging,Date firstDate,Date lastDate,String code, String depositNo, String remark, String refNo) throws Exception {
        try {
            
            paging.setRecords(vendorDepositAssignmentDAO.countData(firstDate,lastDate,code, depositNo, remark, refNo));
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<VendorDepositAssignmentTemp> listVendorDepositAssignmentTemp = vendorDepositAssignmentDAO.findData(firstDate,lastDate,code,depositNo,remark,refNo,paging.getFromRow(), paging.getToRow());
            
            ListPaging<VendorDepositAssignmentTemp> listPaging = new ListPaging<VendorDepositAssignmentTemp>();
            
            listPaging.setList(listVendorDepositAssignmentTemp);
            listPaging.setPaging(paging);
            
            return listPaging;
            
        }
        catch(Exception ex) {
            throw ex;
        }
    }      
    
    public VendorDepositAssignmentTemp get(String depositNo) throws Exception {
        try {
            return vendorDepositAssignmentDAO.get(depositNo);
        }
        catch (Exception ex) {
            throw ex;
        }
    }
    
    public void save(VendorDepositAssignmentTemp vendorDepositAssignment) throws Exception {
        try {
            vendorDepositAssignmentDAO.save(vendorDepositAssignment, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
}