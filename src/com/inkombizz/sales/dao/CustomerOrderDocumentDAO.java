package com.inkombizz.sales.dao;

import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.model.CustomerOrderDocument;
import com.inkombizz.sales.model.CustomerOrderDocumentDetail;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.List;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.transform.Transformers;

public class CustomerOrderDocumentDAO {

    private HBMSession hbmSession;
    
    public CustomerOrderDocumentDAO(HBMSession session) {
        this.hbmSession = session;
    }

    public int countData(CustomerOrderDocument customerOrderDocument) {
        try {
            
             SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(customerOrderDocument.getTransactionFirstDate());
            String dateLast = DATE_FORMAT.format(customerOrderDocument.getTransactionLastDate());
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "CALL usp_customer_order_document_search_list(:prmFlag,:prmDocumentType,:prmCode,:prmCustomerCode,:prmCustomerName,"
                        + ":prmFirstDate,:prmLastDate,0,0)"
            )
                .setParameter("prmFlag", "COUNT")
                .setParameter("prmDocumentType",customerOrderDocument.getDocumentType())
                .setParameter("prmCode", "%"+customerOrderDocument.getDocumentCode()+"%")
                .setParameter("prmCustomerCode", "%"+customerOrderDocument.getCustomerCode()+"%")
                .setParameter("prmCustomerName", "%"+customerOrderDocument.getCustomerName()+"%")
                .setParameter("prmFirstDate", dateFirst)
                .setParameter("prmLastDate", dateLast)
                .uniqueResult();
            return temp.intValue();
            
        } catch (HibernateException e) {
            e.printStackTrace();
            throw e;
        }
    }

    public List<CustomerOrderDocument> findData(CustomerOrderDocument customerOrderDocument, int from, int to) {
        try {
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(customerOrderDocument.getTransactionFirstDate());
            String dateLast = DATE_FORMAT.format(customerOrderDocument.getTransactionLastDate());
            
            List<CustomerOrderDocument> list = hbmSession.hSession.createSQLQuery(

            "CALL usp_customer_order_document_search_list(:prmFlag,:prmDocumentType,:prmCode,:prmCustomerCode,:prmCustomerName,"
                        + ":prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitUpTo)")
                    .addScalar("documentCode", Hibernate.STRING)
                    .addScalar("branchCode", Hibernate.STRING)
                    .addScalar("transactionDate", Hibernate.TIMESTAMP)
                    .addScalar("customerCode", Hibernate.STRING)
                    .addScalar("customerName", Hibernate.STRING)
                    .setParameter("prmFlag", "LISTS")
                    .setParameter("prmDocumentType",customerOrderDocument.getDocumentType())
                    .setParameter("prmCode", "%"+customerOrderDocument.getDocumentCode()+"%")
                    .setParameter("prmCustomerCode", "%"+customerOrderDocument.getCustomerCode()+"%")
                    .setParameter("prmCustomerName", "%"+customerOrderDocument.getCustomerName()+"%")
                    .setParameter("prmFirstDate", dateFirst)
                    .setParameter("prmLastDate", dateLast)
                    .setParameter("prmLimitFrom", from)
                    .setParameter("prmLimitUpTo", to)
                    .setResultTransformer(Transformers.aliasToBean(CustomerOrderDocument.class))
                    .list();
            return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerOrderDocumentDetail> findDataDetail(CustomerOrderDocument customerOrderDocument) {
        try {
                        
            List<CustomerOrderDocumentDetail> list = hbmSession.hSession.createSQLQuery(

            "CALL usp_customer_order_document_detail_list(:prmDocumentType,:prmHeaderCode)")
                    .addScalar("sortNo", Hibernate.BIG_DECIMAL)
                    .addScalar("itemFinishGoodsCode", Hibernate.STRING)
                    .addScalar("itemSizeCode", Hibernate.STRING)
                    .addScalar("itemRatingCode", Hibernate.STRING)
                    .addScalar("itemTypeDesignCode", Hibernate.STRING)
                    .addScalar("itemEndConCode", Hibernate.STRING)
                    .addScalar("itemBodyCode", Hibernate.STRING)
                    .addScalar("itemBallCode", Hibernate.STRING)
                    .addScalar("itemSeatCode", Hibernate.STRING)
                    .addScalar("itemStemCode", Hibernate.STRING)
                    .addScalar("itemSeatInsertCode", Hibernate.STRING)
                    .addScalar("itemSealCode", Hibernate.STRING)
                    .addScalar("itemBoltCode", Hibernate.STRING)
                    .addScalar("itemSeatDesignCode", Hibernate.STRING)
                    .addScalar("itemOperatorCode", Hibernate.STRING)
                    .addScalar("quantity", Hibernate.BIG_DECIMAL)
                    .setParameter("prmDocumentType",customerOrderDocument.getDocumentType())
                    .setParameter("prmHeaderCode",customerOrderDocument.getDocumentCode())
                    .setResultTransformer(Transformers.aliasToBean(CustomerOrderDocumentDetail.class))
                    .list();
            return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
        
}
