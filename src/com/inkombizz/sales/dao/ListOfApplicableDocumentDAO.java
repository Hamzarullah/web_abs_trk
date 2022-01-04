
package com.inkombizz.sales.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumActivity;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionType;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.sales.model.ListOfApplicableDocument;
import com.inkombizz.sales.model.ListOfApplicableDocumentDetail;
import com.inkombizz.sales.model.ListOfApplicableDocumentDetailField;
import com.inkombizz.system.dao.TransactionLogDAO;
//import com.oreilly.servlet.MultipartRequest;
//import com.oreilly.servlet.MultipartRequest;
//import java.io.IOException;
//import java.io.PrintWriter;
import java.math.BigInteger;
import java.util.Date;
import java.util.List;
//import javax.servlet.ServletException;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.Transformers;


public class ListOfApplicableDocumentDAO {
    private HBMSession hbmSession;
    
    public ListOfApplicableDocumentDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(ListOfApplicableDocument listApplicableDocument) {
        try {
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "CALL usp_list_of_applicable_document_list(:prmFlag,:prmCode,:prmSalesOrderCode,:prmCustomerCode,:prmCustomerName,"
                        + ":prmRefNo,:prmRemark,:prmFirstDate,:prmLastDate,0,0)")
                .setParameter("prmFlag", "COUNT")
                .setParameter("prmCode", "%"+listApplicableDocument.getCode()+"%")
                .setParameter("prmSalesOrderCode","%"+listApplicableDocument.getSalesOrderCode()+"%")
                .setParameter("prmCustomerCode","%"+listApplicableDocument.getSalesOrderCustomerCode() +"%")
                .setParameter("prmCustomerName","%"+listApplicableDocument.getSalesOrderCustomerName()+"%")
                .setParameter("prmRefNo", "%"+listApplicableDocument.getRefNo()+"%")
                .setParameter("prmRemark", "%"+listApplicableDocument.getRemark()+"%")
                .setParameter("prmFirstDate", listApplicableDocument.getTransactionFirstDate())
                .setParameter("prmLastDate", listApplicableDocument.getTransactionLastDate())
                .uniqueResult();
            return temp.intValue();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<ListOfApplicableDocument> findData(ListOfApplicableDocument listApplicableDocument, int from, int to) {
        try {
            
            List<ListOfApplicableDocument> list = (List<ListOfApplicableDocument>)hbmSession.hSession.createSQLQuery(
                    "CALL usp_list_of_applicable_document_list(:prmFlag,:prmCode,:prmSalesOrderCode,:prmCustomerCode,:prmCustomerName,"
                        + ":prmRefNo,:prmRemark,:prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitTo)")                       
                .addScalar("code", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("salesOrderCode", Hibernate.STRING)      
                .addScalar("SalesOrderCustomerCode", Hibernate.STRING)
                .addScalar("salesOrderCustomerName", Hibernate.STRING)
                .addScalar("salesOrderSalesPersonCode", Hibernate.STRING)    
                .addScalar("salesOrderSalesPersonName", Hibernate.STRING)    
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("preparedBy", Hibernate.STRING)
                .addScalar("approvedBy", Hibernate.STRING)
                .setParameter("prmFlag", "LISTS")
                .setParameter("prmCode", "%"+listApplicableDocument.getCode()+"%")
                .setParameter("prmSalesOrderCode","%"+listApplicableDocument.getSalesOrderCode()+"%")
                .setParameter("prmCustomerCode","%"+listApplicableDocument.getSalesOrderCustomerCode()+"%")
                .setParameter("prmCustomerName","%"+listApplicableDocument.getSalesOrderCustomerName()+"%")
                .setParameter("prmRefNo", "%"+listApplicableDocument.getRefNo()+"%")
                .setParameter("prmRemark", "%"+listApplicableDocument.getRemark()+"%")
                .setParameter("prmFirstDate", listApplicableDocument.getTransactionFirstDate())
                .setParameter("prmLastDate", listApplicableDocument.getTransactionLastDate())
                .setParameter("prmLimitFrom", from)
                .setParameter("prmLimitTo", to)
                .setResultTransformer(Transformers.aliasToBean(ListOfApplicableDocument.class))
                .list(); 
                 
                return list;
        } catch (HibernateException e) {
            throw e;
        }
    }

    
    public List<ListOfApplicableDocumentDetail> findDataDetail(String headerCode) {
        try {
            
            List<ListOfApplicableDocumentDetail> list = (List<ListOfApplicableDocumentDetail>)hbmSession.hSession.createSQLQuery(
                "SELECT "+
                "   sal_list_of_applicable_document_detail.NameOfDocument, "+
                "   sal_list_of_applicable_document_detail.DocumentNo, "+
                "   sal_list_of_applicable_document_detail.VersionEdition "+
//                "   sal_list_of_applicable_document_detail.DocumentPath "+
                "FROM sal_list_of_applicable_document_detail "+
                "WHERE sal_list_of_applicable_document_detail.HeaderCode=:prmHeaderCode "+
                "ORDER BY sal_list_of_applicable_document_detail.Code ASC;")                       
                .addScalar("nameOfDocument", Hibernate.STRING)
                .addScalar("documentNo", Hibernate.STRING)
                .addScalar("versionEdition", Hibernate.STRING)
//                .addScalar("documentPath", Hibernate.STRING)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(ListOfApplicableDocumentDetail.class))
                .list(); 

            return list;
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
        
    private String createCode(ListOfApplicableDocument listApplicableDocument){
        try{
            String acronim = listApplicableDocument.getBranch().getCode() +"/"+EnumTransactionType.ENUM_TransactionType.LAD.toString()+"/"+AutoNumber.formatingDate(listApplicableDocument.getTransactionDate(), true, true, false);;
                        
            DetachedCriteria dc = DetachedCriteria.forClass(ListOfApplicableDocument.class)
                    .setProjection(Projections.max("code"))
                    .add(Restrictions.like("code",acronim + "%" ));

            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            List list = criteria.list();

           String oldID = "";
            if (list != null) {
                if (list.size() > 0) {
                    if (list.get(0) != null) {
                        oldID = list.get(0).toString();
                    }
                }
            }
            return AutoNumber.generate(acronim, oldID, AutoNumber.DEFAULT_TRANSACTION_LENGTH_4);
        }
        catch(HibernateException e){
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void save(ListOfApplicableDocument listApplicableDocument,
            List<ListOfApplicableDocumentDetail> listListOfApplicableDocumentDetail, String moduleCode) throws Exception {
        try {
            
            String headerCode=createCode(listApplicableDocument);
            
            hbmSession.hSession.beginTransaction();
            
            listApplicableDocument.setCode(headerCode);
            listApplicableDocument.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            listApplicableDocument.setCreatedDate(new Date());
            
            hbmSession.hSession.save(listApplicableDocument);
            
            
//            if (!processDetail(EnumTransactionAction.ENUM_TransactionAction.INSERT,listApplicableDocument,listListOfApplicableDocumentDetail)) {
//                hbmSession.hTransaction.rollback();
//            }
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    listApplicableDocument.getCode(),""));
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
  
    public void update(ListOfApplicableDocument listApplicableDocument,
            List<ListOfApplicableDocumentDetail> listListOfApplicableDocumentDetail,String moduleCode) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
            
            listApplicableDocument.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            listApplicableDocument.setUpdatedDate(new Date());
                        
            hbmSession.hSession.update(listApplicableDocument);
            
            if (!processDetail(EnumTransactionAction.ENUM_TransactionAction.UPDATE,listApplicableDocument,listListOfApplicableDocumentDetail)) {
                hbmSession.hTransaction.rollback();
            }
                        
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    listApplicableDocument.getCode(),""));
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
    
    public void delete(ListOfApplicableDocument listApplicableDocument, String moduleCode){
        try{
            hbmSession.hSession.beginTransaction();
            
            if (!processDetail(EnumTransactionAction.ENUM_TransactionAction.DELETE,listApplicableDocument,null)) {
                hbmSession.hTransaction.rollback();
            }
            
            hbmSession.hSession.createQuery("DELETE FROM ListApplicableDocument "
                    + " WHERE code  = :prmCode")
                    .setParameter("prmCode", listApplicableDocument.getCode())
                    .executeUpdate();
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.DELETE), 
                                                                    listApplicableDocument.getCode(), EnumActivity.toString(EnumActivity.ENUM_Activity.DELETE)));
            
            hbmSession.hTransaction.commit();
            
            
        }catch(HibernateException e){
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
        finally{
            hbmSession.hSession.clear();
            hbmSession.hSession.close();
        }
    }
       
    private boolean processDetail(EnumTransactionAction.ENUM_TransactionAction enumActivity, ListOfApplicableDocument listApplicableDocument,
            List<ListOfApplicableDocumentDetail> listListOfApplicableDocumentDetail){
        try{
            
            hbmSession.hSession.createQuery("DELETE FROM "+ListOfApplicableDocumentDetailField.BEAN_NAME+" WHERE "+ListOfApplicableDocumentDetailField.HEADERCODE+" = :prmCode")
                        .setParameter("prmCode", listApplicableDocument.getCode())    
                        .executeUpdate();
            
            
            if(!enumActivity.equals(EnumTransactionAction.ENUM_TransactionAction.DELETE)){
                int i = 1;
                for(ListOfApplicableDocumentDetail listApplicableDocumentItemDetail : listListOfApplicableDocumentDetail){

                    String detailCode = listApplicableDocument.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    listApplicableDocumentItemDetail.setCode(detailCode);
                    listApplicableDocumentItemDetail.setHeaderCode(listApplicableDocument.getCode());

                    listApplicableDocumentItemDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    listApplicableDocumentItemDetail.setCreatedDate(new Date());

                    hbmSession.hSession.save(listApplicableDocumentItemDetail);

                    i++;
                }
            }
            
            return Boolean.TRUE;
        }catch(HibernateException e){
            e.printStackTrace();
            return Boolean.FALSE;
        }
    }
    
//    public void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        response.setContentType("text/html");
//        PrintWriter out = response.getWriter(); 
//
//        MultipartRequest m = new MultipartRequest(request, "D:\\Project\\Java\\web_abs_trk\\Doc");
//        out.print("successfully uploaded");
//    }
}

    

