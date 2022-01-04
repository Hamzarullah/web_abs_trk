
package com.inkombizz.finance.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.dao.GiroPaymentDAO;
import com.inkombizz.finance.model.GiroPayment;
import com.inkombizz.finance.model.GiroPaymentField;
import com.inkombizz.finance.model.GiroPaymentTemp;
import java.util.Date;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

public class GiroPaymentBLL {
    
    public static final String MODULECODE = "004_FIN_GIRO_PAYMENT";
    public static final String MODULECODE_REJECTED = "004_FIN_GIRO_PAYMENT_REJECTED";
    
    private GiroPaymentDAO giroPaymentDAO;
    
    public GiroPaymentBLL(HBMSession hbmSession){
        this.giroPaymentDAO = new GiroPaymentDAO(hbmSession);
    }
    
    public ListPaging<GiroPaymentTemp> findData(Paging paging,String code,String giroStatus,Date firstDate, Date lastDate) throws Exception {
        try {
                     
            paging.setRecords(giroPaymentDAO.countData(code,giroStatus,firstDate, lastDate));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<GiroPaymentTemp> listGiroPaymentTemp = giroPaymentDAO.findData(code,giroStatus,firstDate, lastDate,paging.getFromRow(), paging.getToRow());
            
            ListPaging<GiroPaymentTemp> listPaging = new ListPaging<GiroPaymentTemp>();
            
            listPaging.setList(listGiroPaymentTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
            
    public GiroPaymentTemp findData(String code) throws Exception {
        try {
            return (GiroPaymentTemp) giroPaymentDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public boolean isExist(String headerCode) throws Exception{
        try{            
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(GiroPayment.class)
                            .add(Restrictions.eq(GiroPaymentField.CODE, headerCode));
             
            if(giroPaymentDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public boolean isGiroNoAndBankCodeExist(String giroNo,String bankCode) throws Exception{
        try{            
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(GiroPayment.class)
                            .add(Restrictions.eq(GiroPaymentField.GIRONO, giroNo))
                            .add(Restrictions.eq(GiroPaymentField.BANKCODE, bankCode));
             
            if(giroPaymentDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public List<GiroPaymentTemp> isUsedByBankPayment (String code ) throws Exception{
        try{
            
            return giroPaymentDAO.isUsedByBankPayment(code);
        }
        catch(Exception ex){
            ex.printStackTrace();
            throw ex;
        }
    }
    
    public Boolean isRejected(String code) throws Exception{
        try {
            return giroPaymentDAO.isRejected(code);
        } catch (HibernateException e) {
            e.printStackTrace();
            return Boolean.FALSE;
        }
    }
    
    public void save(GiroPayment giroPayment) throws Exception {
        try {
            giroPaymentDAO.save(giroPayment,MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(GiroPayment giroPayment) throws Exception{
        giroPaymentDAO.update(giroPayment, MODULECODE);
    }
    
    public void rejected(GiroPayment giroPayment) throws Exception{
        giroPaymentDAO.rejected(giroPayment, MODULECODE);
    }
    
    public void delete(String code) throws Exception {
        try {
            giroPaymentDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
}
