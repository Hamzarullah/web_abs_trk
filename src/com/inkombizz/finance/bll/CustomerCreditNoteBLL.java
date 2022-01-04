
package com.inkombizz.finance.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.dao.CustomerCreditNoteDAO;
import com.inkombizz.finance.model.CustomerCreditNote;
import com.inkombizz.finance.model.CustomerCreditNoteDetail;
import com.inkombizz.finance.model.CustomerCreditNoteDetailTemp;
import com.inkombizz.finance.model.CustomerCreditNoteField;
import com.inkombizz.finance.model.CustomerCreditNoteTemp;
import java.util.Date;
import java.util.List;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

public class CustomerCreditNoteBLL {
    
    public static final String MODULECODE = "004_FIN_CUSTOMER_CREDIT_NOTE";
    public static final String MODULECODE_ACC_SPV = "004_FIN_CUSTOMER_CREDIT_NOTE_ACC_SPV";
    
    private CustomerCreditNoteDAO customerCreditNoteDAO;
    
    public CustomerCreditNoteBLL(HBMSession hbmSession){
        this.customerCreditNoteDAO = new CustomerCreditNoteDAO(hbmSession);
    }
    
    public ListPaging<CustomerCreditNoteTemp> findData(Paging paging,String code,String customerCode,String customerName, Date firstDate, Date lastDate) throws Exception {
        try {
                     
            paging.setRecords(customerCreditNoteDAO.countData(code,customerCode,customerName, firstDate, lastDate));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CustomerCreditNoteTemp> listCustomerCreditNoteTemp = customerCreditNoteDAO.findData(code,customerCode,customerName,paging.getFromRow(), paging.getToRow(), firstDate, lastDate);
            
            ListPaging<CustomerCreditNoteTemp> listPaging = new ListPaging<CustomerCreditNoteTemp>();
            
            listPaging.setList(listCustomerCreditNoteTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
      public ListPaging<CustomerCreditNoteTemp> findDataAccSpv(Paging paging,String code,String customerCode,String customerName, Date firstDate, Date lastDate, String status) throws Exception {
        try {
                     
            paging.setRecords(customerCreditNoteDAO.countDataAccSpv(code,customerCode,customerName, firstDate, lastDate,status));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<CustomerCreditNoteTemp> listCustomerCreditNoteTemp = customerCreditNoteDAO.findDataAccSpv(code,customerCode,customerName,paging.getFromRow(), paging.getToRow(), firstDate, lastDate,status);
            
            ListPaging<CustomerCreditNoteTemp> listPaging = new ListPaging<CustomerCreditNoteTemp>();
            
            listPaging.setList(listCustomerCreditNoteTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public List<CustomerCreditNoteDetailTemp> findDataDetail(String headerCode) throws Exception {
        try {
            
            List<CustomerCreditNoteDetailTemp> listCustomerCreditNoteDetailTemp = customerCreditNoteDAO.findDataDetail(headerCode);
            
            return listCustomerCreditNoteDetailTemp;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }

    public boolean isExist(String headerCode) throws Exception{
        try{            
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(CustomerCreditNote.class)
                            .add(Restrictions.eq(CustomerCreditNoteField.CODE, headerCode));
             
            if(customerCreditNoteDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public void save(CustomerCreditNote customerCreditNote, List<CustomerCreditNoteDetail> listCustomerCreditNoteDetail) throws Exception {
        try {
            customerCreditNoteDAO.save(customerCreditNote, listCustomerCreditNoteDetail, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(CustomerCreditNote customerCreditNote, List<CustomerCreditNoteDetail> listDetail) throws Exception{
        try{
            customerCreditNoteDAO.update(customerCreditNote, listDetail, MODULECODE);
        }catch(Exception e){
            throw e;
        }
    }
    
    public void delete(String code) throws Exception{
        try{
            customerCreditNoteDAO.delete(code, MODULECODE);
        }catch(Exception e){
            throw e;
        }
    }

    public CustomerCreditNoteDAO getCustomerCreditNoteDAO() {
        return customerCreditNoteDAO;
    }

    public void setCustomerCreditNoteDAO(CustomerCreditNoteDAO customerCreditNoteDAO) {
        this.customerCreditNoteDAO = customerCreditNoteDAO;
    }
    
}
