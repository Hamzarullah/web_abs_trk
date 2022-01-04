
package com.inkombizz.finance.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.dao.CustomerDebitNoteDAO;
import com.inkombizz.finance.model.CustomerDebitNote;
import com.inkombizz.finance.model.CustomerDebitNoteDetail;
import com.inkombizz.finance.model.CustomerDebitNoteDetailTemp;
import com.inkombizz.finance.model.CustomerDebitNoteField;
import com.inkombizz.finance.model.CustomerDebitNoteTemp;
import java.util.Date;
import java.util.List;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

public class CustomerDebitNoteBLL {
    
    public static final String MODULECODE = "004_FIN_CUSTOMER_DEBIT_NOTE";
    public static final String MODULECODE_ACC_SPV = "004_FIN_CUSTOMER_DEBIT_NOTE_ACC_SPV";
    private CustomerDebitNoteDAO customerDebitNoteDAO;
    
    public CustomerDebitNoteBLL(HBMSession hbmSession){
        this.customerDebitNoteDAO = new CustomerDebitNoteDAO(hbmSession);
    }
    
    public ListPaging<CustomerDebitNoteTemp> findData(Paging paging,String code,String customerCode,String customerName, Date firstDate, Date lastDate) throws Exception {
        try {
                     
            paging.setRecords(customerDebitNoteDAO.countData(code,customerCode,customerName, firstDate, lastDate));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CustomerDebitNoteTemp> listCustomerDebitNoteTemp = customerDebitNoteDAO.findData(code,customerCode,customerName,paging.getFromRow(), paging.getToRow(), firstDate, lastDate);
            
            ListPaging<CustomerDebitNoteTemp> listPaging = new ListPaging<CustomerDebitNoteTemp>();
            
            listPaging.setList(listCustomerDebitNoteTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<CustomerDebitNoteDetailTemp> findDataDetail(String headerCode) throws Exception {
        try {
            
            List<CustomerDebitNoteDetailTemp> listCustomerDebitNoteDetailTemp = customerDebitNoteDAO.findDataDetail(headerCode);
            
            return listCustomerDebitNoteDetailTemp;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }

    public boolean isExist(String headerCode) throws Exception{
        try{            
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(CustomerDebitNote.class)
                            .add(Restrictions.eq(CustomerDebitNoteField.CODE, headerCode));
             
            if(customerDebitNoteDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public void save(CustomerDebitNote customerDebitNote, List<CustomerDebitNoteDetail> listCustomerDebitNoteDetail) throws Exception {
        try {
            customerDebitNoteDAO.save(customerDebitNote, listCustomerDebitNoteDetail, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(CustomerDebitNote customerDebitNote, List<CustomerDebitNoteDetail> listDetail) throws Exception{
        try{
            customerDebitNoteDAO.update(customerDebitNote, listDetail, MODULECODE);
        }catch(Exception e){
            throw e;
        }
    }
    
    public void delete(String code) throws Exception{
        try{
            customerDebitNoteDAO.delete(code, MODULECODE);
        }catch(Exception e){
            throw e;
        }
    }

    public ListPaging<CustomerDebitNoteTemp> findDataAccSpv(Paging paging, String code, String customerCode, String customerName, Date firstDate, Date lastDate, String status) {
        try {
                     
            paging.setRecords(customerDebitNoteDAO.countDataAccSpv(code,customerCode,customerName, firstDate, lastDate,status));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CustomerDebitNoteTemp> listCustomerDebitNoteTemp = customerDebitNoteDAO.findDataAccSpv(code,customerCode,customerName,paging.getFromRow(), paging.getToRow(), firstDate, lastDate,status);
            
            ListPaging<CustomerDebitNoteTemp> listPaging = new ListPaging<CustomerDebitNoteTemp>();
            
            listPaging.setList(listCustomerDebitNoteTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
}
