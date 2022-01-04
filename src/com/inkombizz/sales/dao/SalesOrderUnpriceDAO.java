
package com.inkombizz.sales.dao;

import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.model.CustomerSalesOrder;
import com.inkombizz.sales.model.CustomerSalesOrderAdditionalFee;
import com.inkombizz.sales.model.CustomerSalesOrderItemDeliveryDate;
import com.inkombizz.sales.model.CustomerSalesOrderItemDetail;
import com.inkombizz.sales.model.CustomerSalesOrderPaymentTerm;
import com.inkombizz.sales.model.CustomerSalesOrderSalesQuotation;
import java.math.BigInteger;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.transform.Transformers;


public class SalesOrderUnpriceDAO {
    private HBMSession hbmSession;
    
    public SalesOrderUnpriceDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(CustomerSalesOrder salesOrderUnprice) {
        try {
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "CALL usp_sales_order_by_customer_purchase_order_list(:prmFlag,:prmCode,:prmCustomerCode,:prmCustomerName,"
                        + ":prmRefNo,:prmRemark,:prmApprovalStatus,:prmClosingStatus,:prmFirstDate,:prmLastDate,0,0)")
                .setParameter("prmFlag", "COUNT")
                .setParameter("prmCode", "%"+salesOrderUnprice.getCode()+"%")
                .setParameter("prmCustomerCode","%"+salesOrderUnprice.getCustomerCode() +"%")
                .setParameter("prmCustomerName","%"+salesOrderUnprice.getCustomerName()+"%")
                .setParameter("prmRefNo", "%"+salesOrderUnprice.getRefNo()+"%")
                .setParameter("prmRemark", "%"+salesOrderUnprice.getRemark()+"%")
                .setParameter("prmFirstDate", salesOrderUnprice.getTransactionFirstDate())
                .setParameter("prmLastDate", salesOrderUnprice.getTransactionLastDate())
                .uniqueResult();
            return temp.intValue();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<CustomerSalesOrder> findData(CustomerSalesOrder salesOrderUnprice, int from, int to) {
        try {
            
            List<CustomerSalesOrder> list = (List<CustomerSalesOrder>)hbmSession.hSession.createSQLQuery(
                    "CALL usp_sales_order_by_customer_purchase_order_list(:prmFlag,:prmCode,:prmCustomerCode,:prmCustomerName,"
                        + ":prmRefNo,:prmRemark,:prmApprovalStatus,:prmClosingStatus,:prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitTo)")                       
                .addScalar("code", Hibernate.STRING)
                .addScalar("custSONo", Hibernate.STRING)
                .addScalar("revision", Hibernate.STRING)
                .addScalar("revisionRemark", Hibernate.STRING)
                .addScalar("refCUSTSOCode", Hibernate.STRING) 
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("customerCode", Hibernate.STRING)
                .addScalar("customerName", Hibernate.STRING)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("currencyName", Hibernate.STRING)
                .addScalar("endUserCode", Hibernate.STRING)
                .addScalar("endUserName", Hibernate.STRING)                                  
                .addScalar("salesPersonCode", Hibernate.STRING)    
                .addScalar("salesPersonName", Hibernate.STRING)    
                .addScalar("projectCode", Hibernate.STRING)     
                .addScalar("projectName", Hibernate.STRING)     
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)
                .addScalar("discountPercent", Hibernate.BIG_DECIMAL)
                .addScalar("discountAmount", Hibernate.BIG_DECIMAL)
                .addScalar("taxBaseAmount", Hibernate.BIG_DECIMAL)
                .addScalar("vatPercent", Hibernate.BIG_DECIMAL)
                .addScalar("vatAmount", Hibernate.BIG_DECIMAL)
                .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                .addScalar("approvalStatus", Hibernate.STRING)
                .addScalar("approvalBy", Hibernate.STRING)
                .addScalar("approvalDate", Hibernate.TIMESTAMP)
                .addScalar("approvalRemark", Hibernate.STRING)
                .addScalar("approvalReasonCode", Hibernate.STRING)
                .addScalar("approvalReasonName", Hibernate.STRING)
                .addScalar("closingStatus", Hibernate.STRING)
                .addScalar("closingBy", Hibernate.STRING)
                .addScalar("closingDate", Hibernate.TIMESTAMP)
                    
                .setParameter("prmFlag", "LISTS")
                .setParameter("prmCode", "%"+salesOrderUnprice.getCode()+"%")
                .setParameter("prmCustomerCode","%"+salesOrderUnprice.getCustomerCode() +"%")
                .setParameter("prmCustomerName","%"+salesOrderUnprice.getCustomerName()+"%")
                .setParameter("prmRefNo", "%"+salesOrderUnprice.getRefNo()+"%")
                .setParameter("prmRemark", "%"+salesOrderUnprice.getRemark()+"%")
                .setParameter("prmFirstDate", salesOrderUnprice.getTransactionFirstDate())
                .setParameter("prmLastDate", salesOrderUnprice.getTransactionLastDate())
                .setParameter("prmLimitFrom", from)
                .setParameter("prmLimitTo", to)
                .setResultTransformer(Transformers.aliasToBean(CustomerSalesOrder.class))
                .list(); 
                 
                return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerSalesOrderSalesQuotation> findDataSalesQuotation(String headerCode) {
        try {
            
            List<CustomerSalesOrderSalesQuotation> list = (List<CustomerSalesOrderSalesQuotation>)hbmSession.hSession.createSQLQuery(
                "SELECT " 
                + "sal_customer_sales_order_jn_sales_quotation.SalesQuotationCode AS SalesQuotationCode, "
                + "sal_sales_quotation.TransactionDate AS SalesQuotationTransactionDate, "
                + "mst_customer.Code AS salesQuotationCustomerCode, "
                + "mst_customer.Name AS salesQuotationCustomerName, "
                + "sal_sales_quotation.EndUserCode AS salesQuotationEndUserCode, "
                + "endUser.Name AS salesQuotationEndUserName, "
                + "sal_sales_quotation.subject AS salesQuotationSubject, "
                + "sal_sales_quotation.RFQNo AS salesQuotationRfqNo, "
                + "sal_sales_quotation.ProjectCode AS salesQuotationProject, "
                + "sal_sales_quotation.Attn AS salesQuotationAttn, "
                + "sal_sales_quotation.RefNo AS salesQuotationRefNo, "
                + "sal_sales_quotation.Remark AS salesQuotationRemark "
                    + "FROM sal_customer_sales_order_jn_sales_quotation "
                + "INNER JOIN "
                    + "sal_sales_quotation ON sal_sales_quotation.Code = sal_customer_sales_order_jn_sales_quotation.SalesQuotationCode "
                + "INNER JOIN "
                    + "mst_customer ON mst_customer.Code = sal_sales_quotation.CustomerCode "
                + "INNER JOIN "
                    + "mst_customer endUser ON sal_sales_quotation.EndUserCode = endUser.Code "
                + "WHERE sal_customer_sales_order_jn_sales_quotation.HeaderCode=:prmHeaderCode"
            )
                        
                .addScalar("salesQuotationCode", Hibernate.STRING)
                .addScalar("SalesQuotationTransactionDate", Hibernate.TIMESTAMP)
                .addScalar("salesQuotationCustomerCode", Hibernate.STRING)
                .addScalar("salesQuotationCustomerName", Hibernate.STRING)
                .addScalar("salesQuotationRfqNo", Hibernate.STRING)
                .addScalar("salesQuotationProject", Hibernate.STRING)
                .addScalar("salesQuotationAttn", Hibernate.STRING)
                .addScalar("salesQuotationRefNo", Hibernate.STRING)
                .addScalar("salesQuotationRemark", Hibernate.STRING)
                .addScalar("salesQuotationRemark", Hibernate.STRING)
                .addScalar("salesQuotationEndUserCode", Hibernate.STRING)
                .addScalar("salesQuotationEndUserName", Hibernate.STRING)
                .addScalar("salesQuotationSubject", Hibernate.STRING)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(CustomerSalesOrderSalesQuotation.class))
                .list(); 
                 
            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerSalesOrderItemDetail> findDataItemDetail(String headerCode) {
        try {
            
            List<CustomerSalesOrderItemDetail> list = (List<CustomerSalesOrderItemDetail>)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "	sal_customer_sales_order_item_detail.SalesQuotationCode, " +
                "	sal_customer_sales_order_item_detail.CustomerPurchaseOrderSortNo, " +
                "	sal_sales_quotation_detail.ValveTag, " +
                "	sal_sales_quotation_detail.DataSheet, " +
                "       sal_sales_quotation_detail.bodyConstruction, "+        
                "	sal_sales_quotation_detail.Description, " +
                "	sal_sales_quotation_detail.TypeDesign, " +
                "	sal_sales_quotation_detail.Size, " +
                "	sal_sales_quotation_detail.Rating, " +
                "	sal_sales_quotation_detail.EndCon, " +
                "	sal_sales_quotation_detail.Body, " +
                "	sal_sales_quotation_detail.Ball, " +
                "	sal_sales_quotation_detail.Seat, " +
                "	sal_sales_quotation_detail.Stem, " +
                "	sal_sales_quotation_detail.seatInsert, " +
                "	sal_sales_quotation_detail.Seal, " +
                "	sal_sales_quotation_detail.Bolting, " +
                "	sal_sales_quotation_detail.SeatDesign, " +
                "	sal_sales_quotation_detail.Oper, " +
                "       sal_sales_quotation_detail.bore, " +
                "       sal_sales_quotation_detail.disc, " +
                "       sal_sales_quotation_detail.plates,"+
                "       sal_sales_quotation_detail.shaft, "+
                "       sal_sales_quotation_detail.spring, "+
                "       sal_sales_quotation_detail.armPin, "+
                "       sal_sales_quotation_detail.backseat, "+
                "	sal_sales_quotation_detail.Note, " +
                "	sal_sales_quotation_detail.Quantity, " +
                "	sal_sales_quotation_detail.UnitPrice, " +
                "	ROUND(sal_customer_sales_order_item_detail.Quantity * sal_sales_quotation_detail.UnitPrice) AS TotalAmount " +
                "FROM sal_customer_sales_order_item_detail " +
                "INNER JOIN sal_customer_sales_order ON sal_customer_sales_order_item_detail.HeaderCode=sal_customer_sales_order.Code " +
                "INNER JOIN sal_sales_quotation_detail ON " +
                "sal_customer_sales_order_item_detail.SalesQuotationCode=sal_sales_quotation_detail.HeaderCode " +
                "WHERE sal_customer_sales_order.Code=:prmHeaderCode " +
                "GROUP BY sal_customer_sales_order_item_detail.CustomerPurchaseOrderSortNo ")

                .addScalar("salesQuotationCode", Hibernate.STRING)
                .addScalar("customerPurchaseOrderSortNo", Hibernate.BIG_DECIMAL)
                .addScalar("valveTag", Hibernate.STRING)
                .addScalar("dataSheet", Hibernate.STRING)
                .addScalar("description", Hibernate.STRING)
                .addScalar("typeDesign", Hibernate.STRING)
                .addScalar("size", Hibernate.STRING)
                .addScalar("rating", Hibernate.STRING)
                .addScalar("endCon", Hibernate.STRING)
                .addScalar("body", Hibernate.STRING)
                .addScalar("ball", Hibernate.STRING)
                .addScalar("seat", Hibernate.STRING)
                .addScalar("stem", Hibernate.STRING)
                .addScalar("seatInsert", Hibernate.STRING)
                .addScalar("seal", Hibernate.STRING)
                .addScalar("bolting", Hibernate.STRING)
                .addScalar("seatDesign", Hibernate.STRING)
                .addScalar("oper", Hibernate.STRING)
                .addScalar("bodyConstruction", Hibernate.STRING)
                .addScalar("bore", Hibernate.STRING)
                .addScalar("disc", Hibernate.STRING)
                .addScalar("plates", Hibernate.STRING)
                .addScalar("shaft", Hibernate.STRING)
                .addScalar("armPin", Hibernate.STRING)
                .addScalar("spring", Hibernate.STRING)
                .addScalar("backseat", Hibernate.STRING)      
                .addScalar("note", Hibernate.STRING)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("unitPrice", Hibernate.BIG_DECIMAL)
                .addScalar("totalAmount", Hibernate.BIG_DECIMAL)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(CustomerSalesOrderItemDetail.class))
                .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerSalesOrderAdditionalFee> findDataAdditionalFee(String headerCode) {
        try {
            
            List<CustomerSalesOrderAdditionalFee> list = (List<CustomerSalesOrderAdditionalFee>)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "	sal_customer_sales_order_additional_fee.Remark, " +
                "	sal_customer_sales_order_additional_fee.Quantity, " +
                "	sal_customer_sales_order_additional_fee.UnitCode AS unitOfMeasureCode, " +
                "	sal_customer_sales_order_additional_fee.Price, " +
                "	sal_customer_sales_order_additional_fee.Total " +
                "FROM sal_customer_sales_order_additional_fee " +
                "WHERE sal_customer_sales_order_additional_fee.HeaderCode=:prmHeaderCode")

                .addScalar("remark", Hibernate.STRING)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("unitOfMeasureCode", Hibernate.STRING)
                .addScalar("price", Hibernate.BIG_DECIMAL)
                .addScalar("total", Hibernate.BIG_DECIMAL)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(CustomerSalesOrderAdditionalFee.class))
                .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerSalesOrderPaymentTerm> findDataPaymentTerm(String headerCode) {
        try {
            
            List<CustomerSalesOrderPaymentTerm> list = (List<CustomerSalesOrderPaymentTerm>)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "	sal_customer_sales_order_payment_term.SortNo, " +
                "	sal_customer_sales_order_payment_term.PaymentTermCode, " +
                        "mst_payment_term.Name AS paymentTermName, " +
                "	sal_customer_sales_order_payment_term.Percentage, " +
                "	sal_customer_sales_order_payment_term.Remark " +
                "FROM sal_customer_sales_order_payment_term " +
                "INNER JOIN mst_payment_term ON sal_customer_sales_order_payment_term.PaymentTermCode=mst_payment_term.Code " +
                "WHERE sal_customer_sales_order_payment_term.HeaderCode=:prmHeaderCode")

                .addScalar("sortNo", Hibernate.BIG_DECIMAL)
                .addScalar("paymentTermCode", Hibernate.STRING)
                .addScalar("paymentTermName", Hibernate.STRING)
                .addScalar("percentage", Hibernate.BIG_DECIMAL)
                .addScalar("remark", Hibernate.STRING)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(CustomerSalesOrderPaymentTerm.class))
                .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerSalesOrderItemDeliveryDate> findDataItemDeliveryDate(String headerCode) {
        try {
            
            List<CustomerSalesOrderItemDeliveryDate> list = (List<CustomerSalesOrderItemDeliveryDate>)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "	sal_customer_sales_order_item_delivery_date.ItemCode, " +
                "	sal_customer_sales_order_item_delivery_date.Quantity, " +
                "	sal_customer_sales_order_item_delivery_date.DeliveryDate, " +
                "	sal_customer_sales_order_item_delivery_date.SalesQuotationCode " +
                "FROM sal_customer_sales_order_item_delivery_date " +
                "WHERE sal_customer_sales_order_item_delivery_date.HeaderCode=:prmHeaderCode")

                .addScalar("itemCode", Hibernate.STRING)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("deliveryDate", Hibernate.DATE)
                .addScalar("salesQuotationCode", Hibernate.STRING)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(CustomerSalesOrderItemDeliveryDate.class))
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
    
    public CustomerSalesOrder get(String code) {
        try {
               return (CustomerSalesOrder) hbmSession.hSession.get(CustomerSalesOrder.class, code);
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public CustomerSalesOrder totalAdditionalFeeAmount(String headerCode){
       try {   
            CustomerSalesOrder salesOrderUnprice = (CustomerSalesOrder)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "	sal_customer_sales_order_by_purchase_order.TotalTransactionAmount, " +
                "	sal_customer_sales_order_by_purchase_order.DiscountPercent, " +
                "	sal_customer_sales_order_by_purchase_order.DiscountAmount, " +
                "	fn_getAdditionalFee(sal_customer_sales_order_by_purchase_order.Code,'SODPOC') AS totalAdditionalFeeAmount, " +
                "	sal_customer_sales_order_by_purchase_order.TaxBaseAmount, " +
                "	sal_customer_sales_order_by_purchase_order.Vatpercent, " +
                "	sal_customer_sales_order_by_purchase_order.Vatamount, " +
                "	sal_customer_sales_order_by_purchase_order.GrandTotalAmount " +
                "FROM sal_customer_sales_order_by_purchase_order " +
                "WHERE sal_customer_sales_order_by_purchase_order.Code=:prmHeaderCode")
                    
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)
                .addScalar("discountPercent", Hibernate.BIG_DECIMAL)
                .addScalar("discountAmount", Hibernate.BIG_DECIMAL)
                .addScalar("totalAdditionalFeeAmount", Hibernate.BIG_DECIMAL)
                .addScalar("taxBaseAmount", Hibernate.BIG_DECIMAL)
                .addScalar("vatPercent", Hibernate.BIG_DECIMAL)
                .addScalar("vatAmount", Hibernate.BIG_DECIMAL)
                .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(CustomerSalesOrder.class))
                .uniqueResult(); 
                 
                return salesOrderUnprice;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
}

    

