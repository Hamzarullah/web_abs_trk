
package com.inkombizz.finance.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.model.VendorDebitNoteDetailTemp;
import com.inkombizz.finance.dao.VendorDebitNoteDAO;
import com.inkombizz.finance.model.VendorDebitNote;
import com.inkombizz.finance.model.VendorDebitNoteDetail;
import com.inkombizz.finance.model.VendorDebitNoteField;
import com.inkombizz.finance.model.VendorDebitNoteTemp;
import java.util.Date;
import java.util.List;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

public class VendorDebitNoteBLL {
    
    public static final String MODULECODE = "004_FIN_VENDOR_DEBIT_NOTE";
    public static final String MODULECODE_ACC_SPV = "004_FIN_VENDOR_DEBIT_NOTE_ACC_SUPERVISOR";
    
    private VendorDebitNoteDAO vendorDebitNoteDAO;
    
    public VendorDebitNoteBLL(HBMSession hbmSession){
        this.vendorDebitNoteDAO = new VendorDebitNoteDAO(hbmSession);
    }
    
    public ListPaging<VendorDebitNoteTemp> findData(Paging paging,String code,String vendorCode,String vendorName, Date firstDate, Date lastDate) throws Exception {
        try {
                     
            paging.setRecords(vendorDebitNoteDAO.countData(code,vendorCode,vendorName, firstDate, lastDate));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<VendorDebitNoteTemp> listVendorDebitNoteTemp = vendorDebitNoteDAO.findData(code,vendorCode,vendorName,paging.getFromRow(), paging.getToRow(),firstDate, lastDate);
            
            ListPaging<VendorDebitNoteTemp> listPaging = new ListPaging<VendorDebitNoteTemp>();
            
            listPaging.setList(listVendorDebitNoteTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<VendorDebitNoteDetailTemp> findDataDetail(String headerCode) throws Exception {
        try {
         
            List<VendorDebitNoteDetailTemp> listVendorDebitNoteDetailTemp = vendorDebitNoteDAO.findDataDetail(headerCode);
            
            return listVendorDebitNoteDetailTemp;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
       
    //check code dah ada di DB?
    public boolean isExist(String headerCode) throws Exception{
        try{            
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(VendorDebitNote.class)
                            .add(Restrictions.eq(VendorDebitNoteField.CODE, headerCode));
             
            if(vendorDebitNoteDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public void save(VendorDebitNote vendorDebitNote, List<VendorDebitNoteDetail> listVendorDebitNoteDetail) throws Exception {
        try {
            vendorDebitNoteDAO.save(vendorDebitNote, listVendorDebitNoteDetail, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(VendorDebitNote vendorDebitNote, List<VendorDebitNoteDetail> listDetail) throws Exception{
        try {
            vendorDebitNoteDAO.update(vendorDebitNote, listDetail, MODULECODE);
        }catch (Exception e) {
            throw e;
        }
    }
    public void updateAccSpv(VendorDebitNote vendorDebitNote, List<VendorDebitNoteDetail> listDetail) throws Exception{
        try {
            vendorDebitNoteDAO.updateAccSpv(vendorDebitNote, listDetail, MODULECODE);
        }catch (Exception e) {
            throw e;
        }
    }
    
    
    
    public void delete(String code) throws Exception{
        try{
            vendorDebitNoteDAO.delete(code, MODULECODE);
        }catch(Exception ex){
            throw ex;
        }
    }
    public ListPaging<VendorDebitNoteTemp> findDataAccSpv(Paging paging, String code, String vendorCode, String vendorName, Date firstDate, Date lastDate, String status) {
        try {
                     
            paging.setRecords(vendorDebitNoteDAO.countDataAccSpv(code,vendorCode,vendorName, firstDate, lastDate,status));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<VendorDebitNoteTemp> listVendorDebitNoteTemp = vendorDebitNoteDAO.findDataAccSpv(code,vendorCode,vendorName,paging.getFromRow(), paging.getToRow(), firstDate, lastDate,status);
            
            ListPaging<VendorDebitNoteTemp> listPaging = new ListPaging<VendorDebitNoteTemp>();
            
            listPaging.setList(listVendorDebitNoteTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
}
