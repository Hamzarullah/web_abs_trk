
package com.inkombizz.finance.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.model.VendorCreditNoteDetailTemp;
import com.inkombizz.finance.dao.VendorCreditNoteDAO;
import com.inkombizz.finance.model.VendorCreditNote;
import com.inkombizz.finance.model.VendorCreditNoteDetail;
import com.inkombizz.finance.model.VendorCreditNoteField;
import com.inkombizz.finance.model.VendorCreditNoteTemp;
import java.util.Date;
import java.util.List;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

public class VendorCreditNoteBLL {
    
    public static final String MODULECODE = "004_FIN_VENDOR_CREDIT_NOTE";
    public static final String MODULECODE_ACC_SPV = "004_FIN_VENDOR_CREDIT_NOTE_ACC_SUPERVISOR";
    
    private VendorCreditNoteDAO vendorCreditNoteDAO;
    
    public VendorCreditNoteBLL(HBMSession hbmSession){
        this.vendorCreditNoteDAO = new VendorCreditNoteDAO(hbmSession);
    }
    
    public ListPaging<VendorCreditNoteTemp> findData(Paging paging,String code,String vendorCode,String vendorName, Date firstDate, Date lastDate) throws Exception {
        try {
                     
            paging.setRecords(vendorCreditNoteDAO.countData(code,vendorCode,vendorName, firstDate, lastDate));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<VendorCreditNoteTemp> listVendorCreditNoteTemp = vendorCreditNoteDAO.findData(code,vendorCode,vendorName,paging.getFromRow(), paging.getToRow(),firstDate, lastDate);
            
            ListPaging<VendorCreditNoteTemp> listPaging = new ListPaging<VendorCreditNoteTemp>();
            
            listPaging.setList(listVendorCreditNoteTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    public ListPaging<VendorCreditNoteTemp> findDataAccSpv(Paging paging,String code,String vendorCode,String vendorName, Date firstDate, Date lastDate, String status) throws Exception {
        try {
                     
            paging.setRecords(vendorCreditNoteDAO.countDataAccSpv(code,vendorCode,vendorName,status, firstDate, lastDate));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<VendorCreditNoteTemp> listVendorCreditNoteTemp = vendorCreditNoteDAO.findDataAccSpv(code,vendorCode,vendorName, firstDate, lastDate, status, paging.getFromRow(), paging.getToRow());
            
            ListPaging<VendorCreditNoteTemp> listPaging = new ListPaging<VendorCreditNoteTemp>();
            
            listPaging.setList(listVendorCreditNoteTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<VendorCreditNoteDetailTemp> findDataDetail(String headerCode) throws Exception {
        try {
         
            List<VendorCreditNoteDetailTemp> listVendorCreditNoteDetailTemp = vendorCreditNoteDAO.findDataDetail(headerCode);
            
            return listVendorCreditNoteDetailTemp;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
       
    //check code dah ada di DB?
    public boolean isExist(String headerCode) throws Exception{
        try{            
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(VendorCreditNote.class)
                            .add(Restrictions.eq(VendorCreditNoteField.CODE, headerCode));
             
            if(vendorCreditNoteDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public void save(VendorCreditNote vendorCreditNote, List<VendorCreditNoteDetail> listVendorCreditNoteDetail) throws Exception {
        try {
            vendorCreditNoteDAO.save(vendorCreditNote, listVendorCreditNoteDetail, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(VendorCreditNote vendorCreditNote, List<VendorCreditNoteDetail> listDetail) throws Exception{
        try {
            vendorCreditNoteDAO.update(vendorCreditNote, listDetail, MODULECODE);
        }catch (Exception e) {
            throw e;
        }
    }
    
    
    public void updateAccSpv(VendorCreditNote vendorCreditNote, List<VendorCreditNoteDetail> listDetail) throws Exception{
        try {
            vendorCreditNoteDAO.updateAccSpv(vendorCreditNote, listDetail, MODULECODE_ACC_SPV);
        }catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception{
        try{
            vendorCreditNoteDAO.delete(code, MODULECODE);
        }catch(Exception ex){
            throw ex;
        }
    }

}
