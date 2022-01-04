package com.inkombizz.system.bll;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.system.model.TransactionLogTemp;
import com.inkombizz.system.dao.TransactionLogDAO;
import com.inkombizz.system.model.TransactionLog;
import com.inkombizz.system.model.TransactionLogField;
import java.util.Date;
import org.hibernate.criterion.Restrictions;

public class TransactionLogBLL {
    
    public static final String MODULECODE = "008_SYS_TRANSACTION_LOG";
    private TransactionLogDAO transactionLogDAO;

    public TransactionLogBLL(HBMSession hbmSession) {
        this.transactionLogDAO = new TransactionLogDAO(hbmSession);
    }
     public ListPaging<TransactionLogTemp> findData(Paging paging,String transactionCode,String actionType,String moduleCode,String userCode,Date firstDate,Date lastDate) throws Exception{
        try{

            paging.setRecords(transactionLogDAO.countData(transactionCode,actionType,moduleCode,userCode,firstDate,lastDate));
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<TransactionLogTemp> listTransactionLogTemp = transactionLogDAO.findData(transactionCode,actionType,moduleCode,userCode,firstDate,lastDate,paging.getFromRow(), paging.getToRow());
            
            ListPaging<TransactionLogTemp> listPaging = new ListPaging<TransactionLogTemp>();
            listPaging.setList(listTransactionLogTemp);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
	
    public ListPaging<TransactionLog> get(Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(TransactionLog.class);
            
            criteria = paging.addOrderCriteria(criteria);

            paging.setRecords(transactionLogDAO.countByCriteria(criteria));

            // Reset count Projection
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);

            // Calculate total Pages
            paging.setTotal( (int) Math.ceil((double) paging.getRecords()  / (double) paging.getRows()) );

            List<TransactionLog> listTransactionLog = transactionLogDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());

            ListPaging<TransactionLog> listPaging = new ListPaging<TransactionLog>();

            listPaging.setList(listTransactionLog);
            listPaging.setPaging(paging);

                return listPaging;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<TransactionLog> search(Paging paging, String code, String moduleCode, 
                                             String transactionCode, String userCode) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(TransactionLog.class)
                    .add(Restrictions.like(TransactionLogField.CODE, code + "%" ))
                    .add(Restrictions.like(TransactionLogField.MODULECODE, moduleCode + "%" ))
                    .add(Restrictions.like(TransactionLogField.TRANSACTIONCODE, transactionCode + "%" ))
                    .add(Restrictions.like(TransactionLogField.USERCODE, userCode + "%" ));
                        
            criteria = paging.addOrderCriteria(criteria);
            
            paging.setRecords(transactionLogDAO.countByCriteria(criteria));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<TransactionLog> listTransactionLog = transactionLogDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());
            
            ListPaging<TransactionLog> listPaging = new ListPaging<TransactionLog>();
            
            listPaging.setList(listTransactionLog);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }

    public List<TransactionLog> getList() throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(TransactionLog.class);
            List<TransactionLog> listTransactionLog = transactionLogDAO.findByCriteria(criteria);
            return listTransactionLog;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public TransactionLog get(String code) throws Exception {
        try {
            return (TransactionLog) transactionLogDAO.get(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
   
    public void delete(String code) throws Exception {
        try {
            transactionLogDAO.delete(code);
        }
        catch (Exception e) {
            throw e;
        }
    }	
    
}