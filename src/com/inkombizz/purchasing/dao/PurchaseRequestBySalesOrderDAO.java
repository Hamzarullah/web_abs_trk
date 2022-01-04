
package com.inkombizz.purchasing.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumApprovalStatus;
import com.inkombizz.common.enumeration.EnumClosingStatus;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.purchasing.model.PurchaseRequestBySalesOrder;
import com.inkombizz.purchasing.model.PurchaseRequestBySalesOrderDetail;
import com.inkombizz.purchasing.model.PurchaseRequestBySalesOrderDetailField;
import com.inkombizz.purchasing.model.PurchaseRequestBySalesOrderField;
import com.inkombizz.purchasing.model.PurchaseRequestBySalesOrder;
import com.inkombizz.system.dao.TransactionLogDAO;
import com.inkombizz.utils.DateUtils;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.Transformers;


public class PurchaseRequestBySalesOrderDAO {
    private HBMSession hbmSession;
    
    public PurchaseRequestBySalesOrderDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(PurchaseRequestBySalesOrder purchaseRequest){
        try{
//            String concat_qry="";
//            if(!active.equals("")){
//                concat_qry="AND mst_branch.ActiveStatus="+active+"";
//            }
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM pur_purchase_request_non_sales_order "
                + "INNER JOIN mst_branch ON mst_branch.Code = pur_purchase_request_non_sales_order.BranchCode "
//                + concat_qry
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<PurchaseRequestBySalesOrder> findData(PurchaseRequestBySalesOrder purchaseRequest,int from, int row) {
        try {  
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(purchaseRequest.getTransactionFirstDate());
            String dateLast = DATE_FORMAT.format(purchaseRequest.getTransactionLastDate());
            
            List<PurchaseRequestBySalesOrder> list = (List<PurchaseRequestBySalesOrder>)hbmSession.hSession.createSQLQuery(
                    "SELECT  "
                + "pur_purchase_request_non_sales_order.Code, "
                + "pur_purchase_request_non_sales_order.TransactionDate, "
                + "mst_branch.Code AS branchCode, "
                + "mst_branch.Name AS branchName, "
                + "pur_purchase_request_non_sales_order.RequestBy, "
                + "pur_purchase_request_non_sales_order.RefNo, "
                + "pur_purchase_request_non_sales_order.Remark "
                    + "FROM "
                + "pur_purchase_request_non_sales_order "
                + "INNER JOIN mst_branch ON mst_branch.Code = pur_purchase_request_non_sales_order.BranchCode "
                + "WHERE pur_purchase_request_non_sales_order.code LIKE '%"+purchaseRequest.getCode()+"%' "
                + "AND mst_branch.Code LIKE '%"+purchaseRequest.getBranchCode()+"%' "
                + "AND mst_branch.Name LIKE '%"+purchaseRequest.getBranchName()+"%' "
                + "AND DATE(pur_purchase_request_non_sales_order.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.DATE)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("requestBy", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(PurchaseRequestBySalesOrder.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<PurchaseRequestBySalesOrderDetail> findDataDetail(String code) {
        try {
            
            List<PurchaseRequestBySalesOrderDetail> list = (List<PurchaseRequestBySalesOrderDetail>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "pur_purchase_request_non_sales_order_detail.Code, "
                + "pur_purchase_request_non_sales_order_detail.HeaderCode, "
                + "mst_item_material.Code AS ItemCode, "
                + "mst_item_material.Name AS itemName, "
                + "pur_purchase_request_non_sales_order_detail.Quantity, "
                + "pur_purchase_request_non_sales_order_detail.Remark, "
                + "mst_unit_of_measure.Code AS unitOfMeasureCode, "
                + "mst_unit_of_measure.Name AS unitOfMeasureName "
                    + "FROM "
                + "pur_purchase_request_non_sales_order_detail "
                + "INNER JOIN mst_item_material ON mst_item_material.Code = pur_purchase_request_non_sales_order_detail.ItemCode "
                + "INNER JOIN mst_unit_of_measure ON mst_unit_of_measure.Code = mst_item_material.UnitOfMeasureCode "
                    + "WHERE "
                + "pur_purchase_request_non_sales_order_detail.HeaderCode = '"+code+"' "
            )
                                            
            .addScalar("code", Hibernate.STRING)
            .addScalar("headerCode", Hibernate.STRING)
            .addScalar("itemCode", Hibernate.STRING)
            .addScalar("itemName", Hibernate.STRING)
            .addScalar("unitOfMeasureCode", Hibernate.STRING)
            .addScalar("unitOfMeasureName", Hibernate.STRING)
            .addScalar("remark", Hibernate.STRING)
            .addScalar("quantity", Hibernate.BIG_DECIMAL)
            .setResultTransformer(Transformers.aliasToBean(PurchaseRequestBySalesOrderDetail.class))
            .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<PurchaseRequestBySalesOrder> findDataApproval(PurchaseRequestBySalesOrder purchaseRequestApproval,int from, int row) {
        try {  
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(purchaseRequestApproval.getTransactionFirstDate());
            String dateLast = DATE_FORMAT.format(purchaseRequestApproval.getTransactionLastDate());
            
            String concat_qry="";
            if(!purchaseRequestApproval.getApprovalStatus().equals("")){
                concat_qry="AND pur_purchase_request_non_sales_order.ApprovalStatus = '"+purchaseRequestApproval.getApprovalStatus()+"' ";
            }
            
            List<PurchaseRequestBySalesOrder> list = (List<PurchaseRequestBySalesOrder>)hbmSession.hSession.createSQLQuery(
                    "SELECT  "
                + "pur_purchase_request_non_sales_order.Code, "
                + "pur_purchase_request_non_sales_order.TransactionDate, "
                + "mst_branch.Code AS branchCode, "
                + "mst_branch.Name AS branchName, "
                + "pur_purchase_request_non_sales_order.RequestBy, "
                + "pur_purchase_request_non_sales_order.RefNo, "
                + "pur_purchase_request_non_sales_order.Remark "
                    + "FROM "
                + "pur_purchase_request_non_sales_order "
                + "INNER JOIN mst_branch ON mst_branch.Code = pur_purchase_request_non_sales_order.BranchCode "
                + "WHERE pur_purchase_request_non_sales_order.code LIKE '%"+purchaseRequestApproval.getCode()+"%' "
                + "AND pur_purchase_request_non_sales_order.RefNo LIKE '%"+purchaseRequestApproval.getRefNo()+"%' "
                + "AND pur_purchase_request_non_sales_order.Remark LIKE '%"+purchaseRequestApproval.getRemark()+"%' "
                + "AND DATE(pur_purchase_request_non_sales_order.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.DATE)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("requestBy", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(PurchaseRequestBySalesOrder.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    
    public List<PurchaseRequestBySalesOrder> findDataClosing(PurchaseRequestBySalesOrder purchaseRequestClosing,int from, int row) {
        try {  
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(purchaseRequestClosing.getTransactionFirstDate());
            String dateLast = DATE_FORMAT.format(purchaseRequestClosing.getTransactionLastDate());
            
            String concat_qry="";
            if(!purchaseRequestClosing.getClosingStatus().equals("")){
                concat_qry="AND pur_purchase_request_non_sales_order.ClosingStatus = '"+purchaseRequestClosing.getClosingStatus()+"' ";
            }
            
            List<PurchaseRequestBySalesOrder> list = (List<PurchaseRequestBySalesOrder>)hbmSession.hSession.createSQLQuery(
                    "SELECT  "
                + "pur_purchase_request_non_sales_order.Code, "
                + "pur_purchase_request_non_sales_order.TransactionDate, "
                + "mst_branch.Code AS branchCode, "
                + "mst_branch.Name AS branchName, "
                + "pur_purchase_request_non_sales_order.RequestBy, "
                + "pur_purchase_request_non_sales_order.RefNo, "
                + "pur_purchase_request_non_sales_order.Remark "
                    + "FROM "
                + "pur_purchase_request_non_sales_order "
                + "INNER JOIN mst_branch ON mst_branch.Code = pur_purchase_request_non_sales_order.BranchCode "
                + "WHERE pur_purchase_request_non_sales_order.code LIKE '%"+purchaseRequestClosing.getCode()+"%' "
                + "AND pur_purchase_request_non_sales_order.RefNo LIKE '%"+purchaseRequestClosing.getRefNo()+"%' "
                + "AND pur_purchase_request_non_sales_order.Remark LIKE '%"+purchaseRequestClosing.getRemark()+"%' "
                + "AND DATE(pur_purchase_request_non_sales_order.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                + concat_qry
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.DATE)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("requestBy", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(PurchaseRequestBySalesOrder.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
        
    public PurchaseRequestBySalesOrder get(String code) {
        try {
               return (PurchaseRequestBySalesOrder) hbmSession.hSession.get(PurchaseRequestBySalesOrder.class, code);
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public int countByCriteria(DetachedCriteria dc) {
        try {
            Criteria criteria = dc.getExecutableCriteria(this.hbmSession.hSession);
            criteria.setProjection(Projections.rowCount());
            if (criteria.list().size() == 0)
            	return 0;
            else
            	return ((Integer) criteria.list().get(0)).intValue();
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public String createCode(PurchaseRequestBySalesOrder purchaseRequestNonSo){   
        try{
            String acronim = purchaseRequestNonSo.getBranch().getCode()+ "/PRQ/"+AutoNumber.formatingDate(purchaseRequestNonSo.getTransactionDate(), true, true, false);;
            
            DetachedCriteria dc = DetachedCriteria.forClass(PurchaseRequestBySalesOrder.class)
                    .setProjection(Projections.max("code"))
                    .add(Restrictions.like("code",  acronim + "%" ));
            
            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            List list = criteria.list();
            
            String oldID = "";
            if(list != null){
                if (list.size() > 0)
                    if(list.get(0) != null)
                        oldID = list.get(0).toString();
            }
            return AutoNumber.generate(acronim, oldID, AutoNumber.DEFAULT_TRANSACTION_LENGTH_4);
        }        
        catch(HibernateException e){
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void save(PurchaseRequestBySalesOrder purchaseRequestNonSo,List<PurchaseRequestBySalesOrderDetail> listPurchaseRequestNonSoDetail,String moduleCode) throws Exception{
        try{
            hbmSession.hSession.beginTransaction();
            
            String headerCode = createCode(purchaseRequestNonSo);
            purchaseRequestNonSo.setCode(headerCode);
            
            purchaseRequestNonSo.setClosingStatus("OPEN");
            purchaseRequestNonSo.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            purchaseRequestNonSo.setCreatedDate(new Date()); 
            
            hbmSession.hSession.save(purchaseRequestNonSo);
            
            if(listPurchaseRequestNonSoDetail==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!");
            }

            int i = 1;
            for(PurchaseRequestBySalesOrderDetail purchaseRequestNonSoDetail : listPurchaseRequestNonSoDetail){
                                                            
                String detailCode = headerCode+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                purchaseRequestNonSoDetail.setCode(detailCode);
                purchaseRequestNonSoDetail.setHeaderCode(purchaseRequestNonSo.getCode());
                
                purchaseRequestNonSoDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                purchaseRequestNonSoDetail.setCreatedDate(new Date());
                
                hbmSession.hSession.save(purchaseRequestNonSoDetail);
                i++;
            }
            
            TransactionLogDAO transactionLogDAO=new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), purchaseRequestNonSo.getCode(),""));
            
            hbmSession.hTransaction.commit();
            
        }
        
        catch(HibernateException e){
            hbmSession.hTransaction.rollback();
           throw e;
        }
    }
    
    public void update(PurchaseRequestBySalesOrder purchaseRequestNonSo,List<PurchaseRequestBySalesOrderDetail> listPurchaseRequestNonSoDetail,String moduleCode) throws Exception {
        try {
            hbmSession.hSession.beginTransaction();
            
            hbmSession.hSession.createQuery("DELETE FROM " + PurchaseRequestBySalesOrderDetailField.BEAN_NAME + 
                                 " WHERE " + PurchaseRequestBySalesOrderDetailField.HEADERCODE + " = :prmHeaderCode")
                    .setParameter("prmHeaderCode", purchaseRequestNonSo.getCode())
                    .executeUpdate();
            
            purchaseRequestNonSo.setClosingStatus("OPEN");
            purchaseRequestNonSo.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            purchaseRequestNonSo.setUpdatedDate(new Date()); 
            
            hbmSession.hSession.update(purchaseRequestNonSo);
            
            if(listPurchaseRequestNonSoDetail==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!");
            }
            
            if(!updateDetail(purchaseRequestNonSo,listPurchaseRequestNonSoDetail)){
                hbmSession.hTransaction.rollback();
            }
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    purchaseRequestNonSo.getCode(), ""));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    private Boolean updateDetail(PurchaseRequestBySalesOrder purchaseRequestNonSo,List<PurchaseRequestBySalesOrderDetail> listPurchaseRequestNonSoDetail) throws Exception{
        try {
            
    
            int i = 1;
            for(PurchaseRequestBySalesOrderDetail purchaseRequestNonSalesOrderDetail : listPurchaseRequestNonSoDetail){
                purchaseRequestNonSalesOrderDetail.setHeaderCode(purchaseRequestNonSo.getCode());
                String detailCode = purchaseRequestNonSo.getCode() + "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                purchaseRequestNonSalesOrderDetail.setCode(detailCode);
                purchaseRequestNonSalesOrderDetail.setCreatedBy(purchaseRequestNonSo.getCreatedBy());
                purchaseRequestNonSalesOrderDetail.setCreatedDate(purchaseRequestNonSo.getCreatedDate());
                purchaseRequestNonSalesOrderDetail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                purchaseRequestNonSalesOrderDetail.setUpdatedDate(new Date());
                
                hbmSession.hSession.save(purchaseRequestNonSalesOrderDetail);
                
                i++;
            }
            
            return Boolean.TRUE;
            
        } catch (HibernateException e) {
            e.printStackTrace();
            return Boolean.FALSE;
        }
    }
    
    public void delete(String code, String moduleCode){
        try{
            hbmSession.hSession.beginTransaction();
                    
            hbmSession.hSession.createQuery("DELETE FROM "+PurchaseRequestBySalesOrderField.BEAN_NAME+" WHERE "+PurchaseRequestBySalesOrderField.CODE+" = :prmCode")
                    .setParameter("prmCode", code)    
                    .executeUpdate();
            
            hbmSession.hSession.createQuery("DELETE FROM " + PurchaseRequestBySalesOrderDetailField.BEAN_NAME + 
                                " WHERE " + PurchaseRequestBySalesOrderDetailField.HEADERCODE + " = :prmHeaderCode")
                    .setParameter("prmHeaderCode", code)
                    .executeUpdate();
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.DELETE), 
                                                                    code, ""));
            
            hbmSession.hTransaction.commit();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();
            
        }catch(HibernateException e){
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void approval(PurchaseRequestBySalesOrder purchaseRequestNonSalesOrderApproval, String MODULECODE) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
            
            PurchaseRequestBySalesOrder purchaseRequestNonSalesOrder=get(purchaseRequestNonSalesOrderApproval.getCode());
            
            if(purchaseRequestNonSalesOrderApproval.getApprovalStatus().equalsIgnoreCase(EnumApprovalStatus.toString(EnumApprovalStatus.ENUM_ApprovalStatus.APPROVED))){
                
                purchaseRequestNonSalesOrder.setApprovalRemark(purchaseRequestNonSalesOrderApproval.getApprovalRemark());
                
            }else{
                purchaseRequestNonSalesOrder.setApprovalReason(null);
                purchaseRequestNonSalesOrder.setApprovalRemark("");
            }
            
            purchaseRequestNonSalesOrder.setApprovalStatus(purchaseRequestNonSalesOrderApproval.getApprovalStatus());
            purchaseRequestNonSalesOrder.setApprovalBy(BaseSession.loadProgramSession().getUserName());
            purchaseRequestNonSalesOrder.setApprovalDate(new Date());
            purchaseRequestNonSalesOrder.setApprovalReason(purchaseRequestNonSalesOrderApproval.getApprovalReason());
                
            hbmSession.hSession.update(purchaseRequestNonSalesOrder);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(MODULECODE, 
                                                                    purchaseRequestNonSalesOrderApproval.getApprovalStatus() , 
                                                                    purchaseRequestNonSalesOrderApproval.getCode(),""));
            hbmSession.hTransaction.commit();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();           
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();
            throw e;
        }
    }
    
    public void closing(PurchaseRequestBySalesOrder purchaseRequestNonSalesOrderClosing, String MODULECODE) throws Exception {
        try {
            hbmSession.hSession.beginTransaction();
            
            PurchaseRequestBySalesOrder purchaseRequestNonSalesOrder=get(purchaseRequestNonSalesOrderClosing.getCode());
            
            String closingBy="";
            Date closingDate=DateUtils.newDate(1900, 1, 1);
            
            if(purchaseRequestNonSalesOrderClosing.getClosingStatus().equalsIgnoreCase(EnumClosingStatus.ENUM_ClosingStatus.CLOSED.toString())){
                closingBy=BaseSession.loadProgramSession().getUserName();
                closingDate=new Date();
            }
            
            purchaseRequestNonSalesOrder.setClosingBy(closingBy);
            purchaseRequestNonSalesOrder.setClosingDate(closingDate);
            purchaseRequestNonSalesOrder.setClosingStatus(purchaseRequestNonSalesOrderClosing.getClosingStatus());
            hbmSession.hSession.update(purchaseRequestNonSalesOrder);
           

            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(MODULECODE, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    purchaseRequestNonSalesOrderClosing.getCode(), "Closing Process: "+purchaseRequestNonSalesOrderClosing.getClosingStatus()));
                        
            hbmSession.hTransaction.commit(); 
            hbmSession.hSession.close();
        } catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
}
