
package com.inkombizz.sales.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.CommonConst;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumActivity;
import com.inkombizz.common.enumeration.EnumClosingStatus;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionType;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.sales.model.CustomerBlanketOrder;
import com.inkombizz.sales.model.CustomerBlanketOrderAdditionalFee;
import com.inkombizz.sales.model.CustomerBlanketOrderAdditionalFeeField;
import com.inkombizz.sales.model.CustomerBlanketOrderField;
import com.inkombizz.sales.model.CustomerBlanketOrderItemDeliveryDate;
import com.inkombizz.sales.model.CustomerBlanketOrderItemDeliveryDateField;
import com.inkombizz.sales.model.CustomerBlanketOrderItemDetail;
import com.inkombizz.sales.model.CustomerBlanketOrderItemDetailField;
import com.inkombizz.sales.model.CustomerBlanketOrderPaymentTerm;
import com.inkombizz.sales.model.CustomerBlanketOrderPaymentTermField;
import com.inkombizz.sales.model.CustomerBlanketOrderSalesQuotation;
import com.inkombizz.sales.model.CustomerBlanketOrderSalesQuotationField;
import com.inkombizz.sales.model.CustomerPurchaseOrder;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.Transformers;


public class CustomerBlanketOrderDAO {
    private HBMSession hbmSession;
    
    public CustomerBlanketOrderDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(CustomerBlanketOrder blanketOrder, String validStatus) {
        try {
            
            String closingStatus=blanketOrder.getClosingStatus().equalsIgnoreCase(EnumClosingStatus.toString(EnumClosingStatus.ENUM_ClosingStatus.ALL)) ? "%%" : "%"+blanketOrder.getClosingStatus() +"%";
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "CALL usp_customer_blanket_order_list(:prmFlag,:prmCode,:prmCustomerCode,:prmCustomerName,"
                        + ":prmRefNo,:prmRemark,:prmClosingStatus,:prmValidStatus,:prmFirstDate,:prmLastDate,0,0)")
                .setParameter("prmFlag", "COUNT")
                .setParameter("prmCode", "%"+blanketOrder.getCode()+"%")
                .setParameter("prmCustomerCode","%"+blanketOrder.getCustomerCode() +"%")
                .setParameter("prmCustomerName","%"+blanketOrder.getCustomerName()+"%")
                .setParameter("prmRefNo", "%"+blanketOrder.getRefNo()+"%")
                .setParameter("prmRemark", "%"+blanketOrder.getRemark()+"%")
                .setParameter("prmClosingStatus", closingStatus)
                .setParameter("prmValidStatus", validStatus)
                .setParameter("prmFirstDate", blanketOrder.getTransactionFirstDateBo())
                .setParameter("prmLastDate", blanketOrder.getTransactionLastDateBo())
                .uniqueResult();
            return temp.intValue();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<CustomerBlanketOrder> findData(CustomerBlanketOrder blanketOrder,String validStatus, int from, int to) {
        try {
            
            String closingStatus=blanketOrder.getClosingStatus().equalsIgnoreCase(EnumClosingStatus.toString(EnumClosingStatus.ENUM_ClosingStatus.ALL)) ? "%%" : "%"+blanketOrder.getClosingStatus() +"%";
            List<CustomerBlanketOrder> list = (List<CustomerBlanketOrder>)hbmSession.hSession.createSQLQuery(
                    "CALL usp_customer_blanket_order_list(:prmFlag,:prmCode,:prmCustomerCode,:prmCustomerName,"
                        + ":prmRefNo,:prmRemark,:prmClosingStatus,:prmValidStatus,:prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitTo)")                       
                .addScalar("code", Hibernate.STRING)
                .addScalar("custBONo", Hibernate.STRING)
                .addScalar("customerPurchaseOrderCode", Hibernate.STRING)
                .addScalar("revision", Hibernate.STRING)
                .addScalar("revisionRemark", Hibernate.STRING)
                .addScalar("refCUSTBOCode", Hibernate.STRING) 
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("customerPurchaseOrderCode", Hibernate.STRING)
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
                .addScalar("totalAdditionalFeeAmount", Hibernate.BIG_DECIMAL)
                .addScalar("taxBaseAmount", Hibernate.BIG_DECIMAL)
                .addScalar("vatPercent", Hibernate.BIG_DECIMAL)
                .addScalar("vatAmount", Hibernate.BIG_DECIMAL)
                .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                .addScalar("closingStatus", Hibernate.STRING)
                .addScalar("closingBy", Hibernate.STRING)
                .addScalar("closingDate", Hibernate.TIMESTAMP)
                    
                .setParameter("prmFlag", "LISTS")
                .setParameter("prmCode", "%"+blanketOrder.getCode()+"%")
                .setParameter("prmCustomerCode","%"+blanketOrder.getCustomerCode() +"%")
                .setParameter("prmCustomerName","%"+blanketOrder.getCustomerName()+"%")
                .setParameter("prmRefNo", "%"+blanketOrder.getRefNo()+"%")
                .setParameter("prmRemark", "%"+blanketOrder.getRemark()+"%")
                .setParameter("prmClosingStatus", closingStatus)
                .setParameter("prmValidStatus", validStatus)    
                .setParameter("prmFirstDate", blanketOrder.getTransactionFirstDateBo())
                .setParameter("prmLastDate", blanketOrder.getTransactionLastDateBo())
                .setParameter("prmLimitFrom", from)
                .setParameter("prmLimitTo", to)
                .setResultTransformer(Transformers.aliasToBean(CustomerBlanketOrder.class))
                .list(); 
                 
                return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public int countDataClosing(CustomerBlanketOrder blanketOrder) {
        try {
            
            String closingStatus=blanketOrder.getClosingStatus().equalsIgnoreCase(EnumClosingStatus.toString(EnumClosingStatus.ENUM_ClosingStatus.ALL)) ? "%%" : "%"+blanketOrder.getClosingStatus() +"%";
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "CALL usp_customer_blanket_order_list_closing(:prmFlag,:prmCode,:prmCustomerCode,:prmCustomerName,"
                        + ":prmRefNo,:prmRemark,:prmClosingStatus,:prmFirstDate,:prmLastDate,0,0)")
                .setParameter("prmFlag", "COUNT")
                .setParameter("prmCode", "%"+blanketOrder.getCode()+"%")
                .setParameter("prmCustomerCode","%"+blanketOrder.getCustomerCode() +"%")
                .setParameter("prmCustomerName","%"+blanketOrder.getCustomerName()+"%")
                .setParameter("prmRefNo", "%"+blanketOrder.getRefNo()+"%")
                .setParameter("prmRemark", "%"+blanketOrder.getRemark()+"%")
                .setParameter("prmClosingStatus", closingStatus)
                .setParameter("prmFirstDate", blanketOrder.getTransactionFirstDateBo())
                .setParameter("prmLastDate", blanketOrder.getTransactionLastDateBo())
                .uniqueResult();
            return temp.intValue();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<CustomerBlanketOrder> findDataClosing(CustomerBlanketOrder blanketOrder, int from, int to) {
        try {
            
            String closingStatus=blanketOrder.getClosingStatus().equalsIgnoreCase(EnumClosingStatus.toString(EnumClosingStatus.ENUM_ClosingStatus.ALL)) ? "%%" : "%"+blanketOrder.getClosingStatus() +"%";
            List<CustomerBlanketOrder> list = (List<CustomerBlanketOrder>)hbmSession.hSession.createSQLQuery(
                    "CALL usp_customer_blanket_order_list_closing(:prmFlag,:prmCode,:prmCustomerCode,:prmCustomerName,"
                        + ":prmRefNo,:prmRemark,:prmClosingStatus,:prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitTo)")                       
                .addScalar("code", Hibernate.STRING)
                .addScalar("custBONo", Hibernate.STRING)
                .addScalar("customerPurchaseOrderCode", Hibernate.STRING)
                .addScalar("revision", Hibernate.STRING)
                .addScalar("revisionRemark", Hibernate.STRING)
                .addScalar("refCUSTBOCode", Hibernate.STRING) 
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("customerPurchaseOrderCode", Hibernate.STRING)
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
                .addScalar("totalAdditionalFeeAmount", Hibernate.BIG_DECIMAL)
                .addScalar("taxBaseAmount", Hibernate.BIG_DECIMAL)
                .addScalar("vatPercent", Hibernate.BIG_DECIMAL)
                .addScalar("vatAmount", Hibernate.BIG_DECIMAL)
                .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                .addScalar("closingStatus", Hibernate.STRING)
                .addScalar("closingBy", Hibernate.STRING)
                .addScalar("closingDate", Hibernate.TIMESTAMP)
                    
                .setParameter("prmFlag", "LISTS")
                .setParameter("prmCode", "%"+blanketOrder.getCode()+"%")
                .setParameter("prmCustomerCode","%"+blanketOrder.getCustomerCode() +"%")
                .setParameter("prmCustomerName","%"+blanketOrder.getCustomerName()+"%")
                .setParameter("prmRefNo", "%"+blanketOrder.getRefNo()+"%")
                .setParameter("prmRemark", "%"+blanketOrder.getRemark()+"%")
                .setParameter("prmClosingStatus", closingStatus)
                .setParameter("prmFirstDate", blanketOrder.getTransactionFirstDateBo())
                .setParameter("prmLastDate", blanketOrder.getTransactionLastDateBo())
                .setParameter("prmLimitFrom", from)
                .setParameter("prmLimitTo", to)
                .setResultTransformer(Transformers.aliasToBean(CustomerBlanketOrder.class))
                .list(); 
                 
                return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public int countSearchData(CustomerBlanketOrder blanketOrder, Date firstDate,Date lastDate) {
        try {
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "CALL usp_customer_blanket_order_search_list(:prmFlag,:prmCode,:prmCustomerPurchaseOrderCode,:prmCustomerCode,:prmCustomerName,"
                    + ":prmEndUserCode,:prmEndUserName,:prmSalesPersonCode,:prmSalesPersonName,"
                    + ":prmFirstDate,:prmLastDate,0,0)"
            )
                    
                .setParameter("prmFlag", "COUNT")
                .setParameter("prmCode", "%"+blanketOrder.getCode()+"%")
                .setParameter("prmCustomerPurchaseOrderCode", "%"+blanketOrder.getCustomerPurchaseOrderCode()+"%")
                .setParameter("prmCustomerCode","%"+blanketOrder.getCustomerCode() +"%")
                .setParameter("prmCustomerName","%"+blanketOrder.getCustomerName()+"%")
                .setParameter("prmEndUserCode","%"+blanketOrder.getEndUserCode() +"%")
                .setParameter("prmEndUserName","%"+blanketOrder.getEndUserName()+"%")
                .setParameter("prmSalesPersonCode","%"+blanketOrder.getSalesPersonCode() +"%")
                .setParameter("prmSalesPersonName","%"+blanketOrder.getSalesPersonName()+"%")
                .setParameter("prmFirstDate", firstDate)
                .setParameter("prmLastDate", lastDate)
                .uniqueResult();
            return temp.intValue();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<CustomerBlanketOrder> findSearchData(CustomerBlanketOrder blanketOrder, Date firstDate,Date lastDate, int from, int to) {
        try {
            
            List<CustomerBlanketOrder> list = (List<CustomerBlanketOrder>)hbmSession.hSession.createSQLQuery(
                "CALL usp_customer_blanket_order_search_list(:prmFlag,:prmCode,:prmCustomerPurchaseOrderCode,:prmCustomerCode,:prmCustomerName,"
                    + ":prmEndUserCode,:prmEndUserName,:prmSalesPersonCode,:prmSalesPersonName,"
                    + ":prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitTo)")                       
                .addScalar("code", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("customerPurchaseOrderCode", Hibernate.STRING)
                .addScalar("customerCode", Hibernate.STRING)
                .addScalar("customerName", Hibernate.STRING)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("currencyName", Hibernate.STRING)
                .addScalar("endUserCode", Hibernate.STRING)
                .addScalar("endUserName", Hibernate.STRING)                                  
                .addScalar("salesPersonCode", Hibernate.STRING)    
                .addScalar("salesPersonName", Hibernate.STRING)    
                    
                .setParameter("prmFlag", "LISTS")
                .setParameter("prmCode", "%"+blanketOrder.getCode()+"%")
                .setParameter("prmCustomerPurchaseOrderCode", "%"+blanketOrder.getCustomerPurchaseOrderCode()+"%")
                .setParameter("prmCustomerCode","%"+blanketOrder.getCustomerCode() +"%")
                .setParameter("prmCustomerName","%"+blanketOrder.getCustomerName()+"%")
                .setParameter("prmEndUserCode","%"+blanketOrder.getEndUserCode() +"%")
                .setParameter("prmEndUserName","%"+blanketOrder.getEndUserName()+"%")
                .setParameter("prmSalesPersonCode","%"+blanketOrder.getSalesPersonCode() +"%")
                .setParameter("prmSalesPersonName","%"+blanketOrder.getSalesPersonName()+"%")
                .setParameter("prmFirstDate", firstDate)
                .setParameter("prmLastDate", lastDate)
                .setParameter("prmLimitFrom", from)
                .setParameter("prmLimitTo", to)
                .setResultTransformer(Transformers.aliasToBean(CustomerBlanketOrder.class))
                .list(); 
                 
                return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerBlanketOrderSalesQuotation> findDataSalesQuotation(String headerCode) {
        try {
            
            List<CustomerBlanketOrderSalesQuotation> list = (List<CustomerBlanketOrderSalesQuotation>)hbmSession.hSession.createSQLQuery(
                "SELECT " 
                + "sal_customer_blanket_order_jn_sales_quotation.SalesQuotationCode AS SalesQuotationCode, "
                + "sal_sales_quotation.TransactionDate AS SalesQuotationTransactionDate, "
                + "mst_customer.Code AS salesQuotationCustomerCode, "
                + "mst_customer.Name AS salesQuotationCustomerName, "
                + "sal_sales_quotation.EndUserCode AS salesQuotationEndUserCode, "
                + "endUser.Name AS salesQuotationEndUserName, "
                + "sal_sales_quotation.subject AS salesQuotationSubject, "
                + "sal_sales_quotation.RFQCode AS salesQuotationRfqCode, "
                + "sal_sales_quotation.ProjectCode AS salesQuotationProject, "
                + "sal_sales_quotation.Attn AS salesQuotationAttn, "
                + "sal_sales_quotation.RefNo AS salesQuotationRefNo, "
                + "sal_sales_quotation.Remark AS salesQuotationRemark "
                    + "FROM sal_customer_blanket_order_jn_sales_quotation "
                + "INNER JOIN "
                    + "sal_sales_quotation ON sal_sales_quotation.Code = sal_customer_blanket_order_jn_sales_quotation.SalesQuotationCode "
                + "INNER JOIN "
                    + "mst_customer ON mst_customer.Code = sal_sales_quotation.CustomerCode "
                + "INNER JOIN "
                    + "mst_customer endUser ON sal_sales_quotation.EndUserCode = endUser.Code "
                + "WHERE sal_customer_blanket_order_jn_sales_quotation.HeaderCode=:prmHeaderCode"
            )
                        
                .addScalar("salesQuotationCode", Hibernate.STRING)
                .addScalar("SalesQuotationTransactionDate", Hibernate.TIMESTAMP)
                .addScalar("salesQuotationCustomerCode", Hibernate.STRING)
                .addScalar("salesQuotationCustomerName", Hibernate.STRING)
                .addScalar("salesQuotationRfqCode", Hibernate.STRING)
                .addScalar("salesQuotationProject", Hibernate.STRING)
                .addScalar("salesQuotationAttn", Hibernate.STRING)
                .addScalar("salesQuotationRefNo", Hibernate.STRING)
                .addScalar("salesQuotationRemark", Hibernate.STRING)
                .addScalar("salesQuotationEndUserCode", Hibernate.STRING)
                .addScalar("salesQuotationEndUserName", Hibernate.STRING)
                .addScalar("salesQuotationSubject", Hibernate.STRING)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(CustomerBlanketOrderSalesQuotation.class))
                .list(); 
                 
            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerBlanketOrderItemDetail> findDataItemDetail(String headerCode) {
        try {
            
            List<CustomerBlanketOrderItemDetail> list = (List<CustomerBlanketOrderItemDetail>)hbmSession.hSession.createSQLQuery(
                "SELECT "
                + " sal_customer_blanket_order_item_detail.SalesQuotationCode, "
                + " sal_customer_blanket_order_item_detail.CustomerPurchaseOrderSortNo AS customerPurchaseOrderSortNo, "
                
                + " sal_customer_blanket_order_item_detail.ItemFinishGoodsCode AS itemFinishGoodsCode, "
                + " mst_item_finish_goods.Remark AS itemFinishGoodsRemark, "
                + " sal_customer_blanket_order_item_detail.Code,"
                + "'' AS customerBlanketOrderItemDetailCode, "
                + " sal_customer_blanket_order_item_detail.salesQuotationDetailCode,"
                + "'' AS salesQuotationDetailCode, "
                + " sal_customer_blanket_order_item_detail.ItemAlias AS itemAlias, "
                + " sal_customer_blanket_order_item_detail.ValveTag, "
                + "sal_customer_blanket_order_item_detail.dataSheet, "
                + "sal_customer_blanket_order_item_detail.description, "        
                
                + " sal_sales_quotation_detail.ValveTypeCode, "
                + " mst_valve_type.Name AS ValveTypeName, "
                
                + "sal_sales_quotation_detail.bodyConstruction, "
                + "sal_sales_quotation_detail.typeDesign, "
                + "sal_sales_quotation_detail.seatDesign, "
                + "sal_sales_quotation_detail.Size, "
                + "sal_sales_quotation_detail.Rating, "
                + "sal_sales_quotation_detail.Bore, "
                
                + "sal_sales_quotation_detail.EndCon, "
                + "sal_sales_quotation_detail.Body, "
                + "sal_sales_quotation_detail.Ball, "
                + "sal_sales_quotation_detail.Seat, "
                + "sal_sales_quotation_detail.SeatInsert, "
                + "sal_sales_quotation_detail.Stem, "
                        
                + "sal_sales_quotation_detail.Seal, "
                + "sal_sales_quotation_detail.Bolting, "
                + "sal_sales_quotation_detail.Disc, "
                + "sal_sales_quotation_detail.Plates, "
                + "sal_sales_quotation_detail.Shaft, "
                + "sal_sales_quotation_detail.Spring, "
                        
                + "sal_sales_quotation_detail.ArmPin, "
                + "sal_sales_quotation_detail.Backseat, "
                + "sal_sales_quotation_detail.Arm, "
                + "sal_sales_quotation_detail.HingePin, "
                + "sal_sales_quotation_detail.StopPin, "
                + "sal_sales_quotation_detail.Oper AS operator, "
                
                + " sal_sales_quotation_detail.Note, "
                + " sal_sales_quotation_detail.Quantity, "
                + " sal_sales_quotation_detail.UnitPrice, "
                + " sal_sales_quotation_detail.TotalAmount, "
                
                //FinishGoodQuotation
                + " IFNULL(mst_item_finish_goods.ItemBodyConstructionCode,'') AS itemBodyConstructionCode, "
                + " IFNULL(mst_item_body_construction.Name,'') AS itemBodyConstructionName, "
                + " IFNULL(mst_item_finish_goods.ItemTypeDesignCode,'') AS itemTypeDesignCode, "
                + " IFNULL(mst_item_type_design.Name,'') AS itemTypeDesignName, "
                + " IFNULL(mst_item_finish_goods.ItemSeatDesignCode,'') AS itemSeatDesignCode, "
                + " IFNULL(mst_item_seat_design.Name,'') AS itemSeatDesignName, "
                + " IFNULL(mst_item_finish_goods.ItemSizeCode,'') AS itemSizeCode, "
                + " IFNULL(mst_item_size.Name,'') AS itemSizeName, "
                + " IFNULL(mst_item_finish_goods.ItemRatingCode,'') AS itemRatingCode, "
                + " IFNULL(mst_item_rating.Name,'') AS itemRatingName, "
                + " IFNULL(mst_item_finish_goods.ItemBoreCode,'') AS itemBoreCode, "
                + " IFNULL(mst_item_bore.Name,'') AS itemBoreName, "
                
                + " IFNULL(mst_item_finish_goods.ItemEndConCode,'') AS itemEndConCode, "
                + " IFNULL(mst_item_end_con.Name,'') AS itemEndConName, "
                + " IFNULL(mst_item_finish_goods.ItemBodyCode,'') AS itemBodyCode, "
                + " IFNULL(mst_item_body.Name,'') AS itemBodyName, "
                + " IFNULL(mst_item_finish_goods.ItemBallCode,'') AS itemBallCode, "
                + " IFNULL(mst_item_ball.Name,'') AS itemBallName, "
                + " IFNULL(mst_item_finish_goods.ItemSeatCode,'') AS itemSeatCode, "
                + " IFNULL(mst_item_seat.Name,'') AS itemSeatName, "
                + " IFNULL(mst_item_finish_goods.ItemSeatInsertCode,'') AS itemSeatInsertCode, "
                + " IFNULL(mst_item_seat_insert.Name,'') AS itemSeatInsertName, "
                + " IFNULL(mst_item_finish_goods.ItemStemCode,'') AS itemStemCode, "
                + " IFNULL(mst_item_stem.Name,'') AS itemStemName, "
                
                + " IFNULL(mst_item_finish_goods.ItemSealCode,'') AS itemSealCode, "
                + " IFNULL(mst_item_seal.Name,'') AS itemSealName, "
                + " IFNULL(mst_item_finish_goods.ItemBoltCode,'') AS itemBoltCode, "
                + " IFNULL(mst_item_bolt.Name,'') AS itemBoltName, "
                + " IFNULL(mst_item_finish_goods.ItemDiscCode,'') AS itemDiscCode, "
                + " IFNULL(mst_item_disc.Name,'') AS itemDiscName, "
                + " IFNULL(mst_item_finish_goods.ItemPlatesCode,'') AS itemPlatesCode, "
                + " IFNULL(mst_item_plates.Name,'') AS itemPlatesName, "
                + " IFNULL(mst_item_finish_goods.ItemShaftCode,'') AS itemShaftCode, "
                + " IFNULL(mst_item_shaft.Name,'') AS itemShaftName, "
                + " IFNULL(mst_item_finish_goods.ItemSpringCode,'') AS itemSpringCode, "
                + " IFNULL(mst_item_spring.Name,'') ItemSpringName, "
                
                + " IFNULL(mst_item_finish_goods.ItemArmPinCode,'') AS itemArmPinCode, "
                + " IFNULL(mst_item_arm.Name,'') AS itemArmPinName, "

                + " IFNULL(mst_item_finish_goods.ItemBackSeatCode,'') AS itemBackSeatCode, "
                + " IFNULL(mst_item_backseat.Name,'') AS itemBackSeatName, "

                + " IFNULL(mst_item_finish_goods.ItemArmCode,'') AS itemArmCode, "
                + " IFNULL(mst_item_arm.Name,'') AS itemArmName, "

                + " IFNULL(mst_item_finish_goods.ItemHingePinCode,'') AS itemHingePinCode, "
                + " IFNULL(mst_item_hinge_pin.Name,'') AS itemHingePinName, "

                + " IFNULL(mst_item_finish_goods.ItemStopPinCode,'') AS itemStopPinCode, "
                + " IFNULL(mst_item_stop_pin.Name,'') AS itemStopPinName, "

                + " IFNULL(mst_item_finish_goods.ItemOperatorCode,'') AS itemOperatorCode, "
                + " IFNULL(mst_item_operator.Name,'') AS itemOperatorName "
                
                + " FROM "
                + " sal_customer_blanket_order_item_detail "
                + " INNER JOIN `mst_item_finish_goods` ON mst_item_finish_goods.`code` = sal_customer_blanket_order_item_detail.`ItemFinishGoodsCode` "
                + " INNER JOIN sal_sales_quotation_detail ON sal_sales_quotation_detail.Code = sal_customer_blanket_order_item_detail.SalesQuotationDetailCode "
                + " INNER JOIN mst_valve_type ON mst_valve_type.Code = sal_sales_quotation_detail.ValveTypeCode "
                //join Finish Goods
                + " LEFT JOIN mst_item_body_construction ON mst_item_body_construction.Code = mst_item_finish_goods.ItemBodyConstructionCode "
                + " LEFT JOIN mst_item_type_design ON mst_item_type_design.Code = mst_item_finish_goods.ItemTypeDesignCode "
                + " LEFT JOIN mst_item_seat_design ON mst_item_seat_design.Code = mst_item_finish_goods.ItemSeatDesignCode "
                + " LEFT JOIN mst_item_size ON mst_item_size.Code = mst_item_finish_goods.ItemSizeCode "
                + " LEFT JOIN mst_item_rating ON mst_item_rating.Code = mst_item_finish_goods.ItemRatingCode "
                + " LEFT JOIN mst_item_bore ON mst_item_bore.Code = mst_item_finish_goods.ItemBoreCode "
                    
                + " LEFT JOIN mst_item_end_con ON mst_item_end_con.Code = mst_item_finish_goods.ItemEndConCode "
                + " LEFT JOIN mst_item_body ON mst_item_body.Code = mst_item_finish_goods.ItemBodyCode "
                + " LEFT JOIN mst_item_ball ON mst_item_ball.Code = mst_item_finish_goods.ItemBallCode "
                + " LEFT JOIN mst_item_seat ON mst_item_seat.Code = mst_item_finish_goods.ItemSeatCode "
                + " LEFT JOIN mst_item_seat_insert ON mst_item_seat_insert.Code = mst_item_finish_goods.ItemSeatInsertCode "
                + " LEFT JOIN mst_item_stem ON mst_item_stem.Code = mst_item_finish_goods.ItemStemCode "
                        
                + " LEFT JOIN mst_item_seal ON mst_item_seal.Code = mst_item_finish_goods.ItemSealCode "
                + " LEFT JOIN mst_item_bolt ON mst_item_bolt.Code = mst_item_finish_goods.ItemBoltCode "
                + " LEFT JOIN mst_item_disc ON mst_item_disc.Code = mst_item_finish_goods.ItemDiscCode "
                + " LEFT JOIN mst_item_plates ON mst_item_plates.Code = mst_item_finish_goods.ItemPlatesCode "
                + " LEFT JOIN mst_item_shaft ON mst_item_shaft.Code = mst_item_finish_goods.ItemShaftCode "
                + " LEFT JOIN mst_item_spring ON mst_item_spring.Code = mst_item_finish_goods.ItemSpringCode "
                        
                + " LEFT JOIN mst_item_arm_pin ON mst_item_arm_pin.Code = mst_item_finish_goods.ItemArmPinCode "
                + " LEFT JOIN mst_item_backseat ON mst_item_backseat.Code = mst_item_finish_goods.ItemBackSeatCode "
                + " LEFT JOIN mst_item_arm ON mst_item_arm.Code = mst_item_finish_goods.ItemArmCode "
                + " LEFT JOIN mst_item_hinge_pin ON mst_item_hinge_pin.Code = mst_item_finish_goods.ItemHingePinCode "
                + " LEFT JOIN mst_item_stop_pin ON mst_item_stop_pin.Code = mst_item_finish_goods.ItemStopPinCode "
                + " LEFT JOIN mst_item_operator ON mst_item_operator.Code = mst_item_finish_goods.ItemOperatorCode "
                
                + " WHERE sal_customer_blanket_order_item_detail.HeaderCode =:prmHeaderCode "
            )

                .addScalar("customerBlanketOrderItemDetailCode", Hibernate.STRING)
                .addScalar("salesQuotationCode", Hibernate.STRING)
                .addScalar("customerPurchaseOrderSortNo", Hibernate.BIG_DECIMAL)
                .addScalar("itemFinishGoodsCode", Hibernate.STRING)
                .addScalar("itemFinishGoodsRemark", Hibernate.STRING)
                .addScalar("salesQuotationDetailCode", Hibernate.STRING)
                .addScalar("valveTypeCode", Hibernate.STRING)
                .addScalar("valveTypeName", Hibernate.STRING)
                .addScalar("valveTag", Hibernate.STRING)
                .addScalar("dataSheet", Hibernate.STRING)
                .addScalar("description", Hibernate.STRING)
                .addScalar("itemAlias", Hibernate.STRING)
                    
                .addScalar("bodyConstruction", Hibernate.STRING)
                .addScalar("typeDesign", Hibernate.STRING)
                .addScalar("seatDesign", Hibernate.STRING)
                .addScalar("size", Hibernate.STRING)
                .addScalar("rating", Hibernate.STRING)
                .addScalar("bore", Hibernate.STRING)
                    
                .addScalar("endCon", Hibernate.STRING)
                .addScalar("body", Hibernate.STRING)
                .addScalar("ball", Hibernate.STRING)
                .addScalar("seat", Hibernate.STRING)
                .addScalar("seatInsert", Hibernate.STRING)
                .addScalar("stem", Hibernate.STRING)
                    
                .addScalar("seal", Hibernate.STRING)
                .addScalar("bolting", Hibernate.STRING)
                .addScalar("disc", Hibernate.STRING)
                .addScalar("plates", Hibernate.STRING)
                .addScalar("shaft", Hibernate.STRING)
                .addScalar("spring", Hibernate.STRING)
                    
                .addScalar("armPin", Hibernate.STRING)
                .addScalar("backSeat", Hibernate.STRING)
                .addScalar("arm", Hibernate.STRING)
                .addScalar("hingePin", Hibernate.STRING)
                .addScalar("StopPin", Hibernate.STRING)
                .addScalar("operator", Hibernate.STRING)
                    
                .addScalar("note", Hibernate.STRING)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("unitPrice", Hibernate.BIG_DECIMAL)
                .addScalar("totalAmount", Hibernate.BIG_DECIMAL)
                    
                //finish goods
                .addScalar("itemBodyConstructionCode", Hibernate.STRING)
                .addScalar("itemBodyConstructionName", Hibernate.STRING)
                .addScalar("itemTypeDesignCode", Hibernate.STRING)
                .addScalar("itemTypeDesignName", Hibernate.STRING)
                .addScalar("itemSeatDesignCode", Hibernate.STRING)
                .addScalar("itemSeatDesignName", Hibernate.STRING)
                .addScalar("itemSizeCode", Hibernate.STRING)
                .addScalar("itemSizeName", Hibernate.STRING)
                .addScalar("itemRatingCode", Hibernate.STRING)
                .addScalar("itemRatingName", Hibernate.STRING)
                .addScalar("itemBoreCode", Hibernate.STRING)
                .addScalar("itemBoreName", Hibernate.STRING)
                    
                .addScalar("itemEndConCode", Hibernate.STRING)
                .addScalar("itemEndConName", Hibernate.STRING)
                .addScalar("itemBodyCode", Hibernate.STRING)
                .addScalar("itemBodyName", Hibernate.STRING)
                .addScalar("itemBallCode", Hibernate.STRING)
                .addScalar("itemBallName", Hibernate.STRING)
                .addScalar("itemSeatCode", Hibernate.STRING)
                .addScalar("itemSeatName", Hibernate.STRING)
                .addScalar("itemSeatInsertCode", Hibernate.STRING)
                .addScalar("itemSeatInsertName", Hibernate.STRING)
                .addScalar("itemStemCode", Hibernate.STRING)
                .addScalar("itemStemName", Hibernate.STRING)
                    
                .addScalar("itemSealCode", Hibernate.STRING)
                .addScalar("itemSealName", Hibernate.STRING)
                .addScalar("itemBoltCode", Hibernate.STRING)
                .addScalar("itemBoltName", Hibernate.STRING)
                .addScalar("itemDiscCode", Hibernate.STRING)
                .addScalar("itemDiscName", Hibernate.STRING)
                .addScalar("itemPlatesCode", Hibernate.STRING)
                .addScalar("itemPlatesName", Hibernate.STRING)
                .addScalar("itemShaftCode", Hibernate.STRING)
                .addScalar("itemShaftName", Hibernate.STRING)
                .addScalar("itemSpringCode", Hibernate.STRING)
                .addScalar("itemSpringName", Hibernate.STRING)
                    
                .addScalar("itemArmPinCode", Hibernate.STRING)
                .addScalar("itemArmPinName", Hibernate.STRING)
                .addScalar("itemBackSeatCode", Hibernate.STRING)
                .addScalar("itemBackSeatName", Hibernate.STRING)
                .addScalar("itemArmCode", Hibernate.STRING)
                .addScalar("itemArmName", Hibernate.STRING)
                .addScalar("itemHingePinCode", Hibernate.STRING)
                .addScalar("itemHingePinName", Hibernate.STRING)
                .addScalar("itemStopPinCode", Hibernate.STRING)
                .addScalar("itemStopPinName", Hibernate.STRING)
                .addScalar("itemOperatorCode", Hibernate.STRING)
                .addScalar("itemOperatorName", Hibernate.STRING)
                    
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(CustomerBlanketOrderItemDetail.class))
                .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerBlanketOrderItemDetail> findDataItemDetailArray(ArrayList arrSalesQuotationCode, String headerCode) {
        try {
            
            String strSalesQuotationNo=Arrays.toString(arrSalesQuotationCode.toArray());
            strSalesQuotationNo = strSalesQuotationNo.replaceAll("[\\[\\]]", "");
            strSalesQuotationNo = strSalesQuotationNo.replaceAll(",", "','");
            List<CustomerBlanketOrderItemDetail> list = (List<CustomerBlanketOrderItemDetail>)hbmSession.hSession.createSQLQuery(
                "SELECT "
                + " sal_customer_blanket_order_item_detail.SalesQuotationCode, "
                + " sal_customer_blanket_order_item_detail.CustomerPurchaseOrderSortNo AS customerPurchaseOrderSortNo, "
                
                + " sal_customer_blanket_order_item_detail.ItemFinishGoodsCode AS itemFinishGoodsCode, "
                + " mst_item_finish_goods.Remark AS itemFinishGoodsRemark, "
                + " sal_customer_blanket_order_item_detail.Code, "
                + " sal_customer_blanket_order_item_detail.salesQuotationDetailCode, "
                + " sal_customer_blanket_order_item_detail.ItemAlias AS itemAlias, "
                + " sal_sales_quotation.refNo, "        
                
                + " sal_sales_quotation_detail.ValveTypeCode, "
                + " mst_valve_type.Name AS ValveTypeName, "
                + " sal_sales_quotation_detail.ValveTag, "
                + "sal_sales_quotation_detail.dataSheet, "
                + "sal_sales_quotation_detail.description, "
                
                + "sal_sales_quotation_detail.bodyConstruction, "
                + "sal_sales_quotation_detail.typeDesign, "
                + "sal_sales_quotation_detail.seatDesign, "
                + "sal_sales_quotation_detail.Size, "
                + "sal_sales_quotation_detail.Rating, "
                + "sal_sales_quotation_detail.Bore, "
                
                + "sal_sales_quotation_detail.EndCon, "
                + "sal_sales_quotation_detail.Body, "
                + "sal_sales_quotation_detail.Ball, "
                + "sal_sales_quotation_detail.Seat, "
                + "sal_sales_quotation_detail.SeatInsert, "
                + "sal_sales_quotation_detail.Stem, "
                        
                + "sal_sales_quotation_detail.Seal, "
                + "sal_sales_quotation_detail.Bolting, "
                + "sal_sales_quotation_detail.Disc, "
                + "sal_sales_quotation_detail.Plates, "
                + "sal_sales_quotation_detail.Shaft, "
                + "sal_sales_quotation_detail.Spring, "
                        
                + "sal_sales_quotation_detail.ArmPin, "
                + "sal_sales_quotation_detail.Backseat, "
                + "sal_sales_quotation_detail.Arm, "
                + "sal_sales_quotation_detail.HingePin, "
                + "sal_sales_quotation_detail.StopPin, "
                + "sal_sales_quotation_detail.Oper AS operator, "
                
                + " sal_sales_quotation_detail.Note, "
                + " sal_sales_quotation_detail.Quantity, "
                + " sal_sales_quotation_detail.UnitPrice, "
                + " sal_sales_quotation_detail.TotalAmount, "
                
                //FinishGoodQuotation
                + " IFNULL(mst_item_finish_goods.ItemBodyConstructionCode,'') AS itemBodyConstructionCode, "
                + " IFNULL(mst_item_body_construction.Name,'') AS itemBodyConstructionName, "
                + " IFNULL(mst_item_finish_goods.ItemTypeDesignCode,'') AS itemTypeDesignCode, "
                + " IFNULL(mst_item_type_design.Name,'') AS itemTypeDesignName, "
                + " IFNULL(mst_item_finish_goods.ItemSeatDesignCode,'') AS itemSeatDesignCode, "
                + " IFNULL(mst_item_seat_design.Name,'') AS itemSeatDesignName, "
                + " IFNULL(mst_item_finish_goods.ItemSizeCode,'') AS itemSizeCode, "
                + " IFNULL(mst_item_size.Name,'') AS itemSizeName, "
                + " IFNULL(mst_item_finish_goods.ItemRatingCode,'') AS itemRatingCode, "
                + " IFNULL(mst_item_rating.Name,'') AS itemRatingName, "
                + " IFNULL(mst_item_finish_goods.ItemBoreCode,'') AS itemBoreCode, "
                + " IFNULL(mst_item_bore.Name,'') AS itemBoreName, "
                
                + " IFNULL(mst_item_finish_goods.ItemEndConCode,'') AS itemEndConCode, "
                + " IFNULL(mst_item_end_con.Name,'') AS itemEndConName, "
                + " IFNULL(mst_item_finish_goods.ItemBodyCode,'') AS itemBodyCode, "
                + " IFNULL(mst_item_body.Name,'') AS itemBodyName, "
                + " IFNULL(mst_item_finish_goods.ItemBallCode,'') AS itemBallCode, "
                + " IFNULL(mst_item_ball.Name,'') AS itemBallName, "
                + " IFNULL(mst_item_finish_goods.ItemSeatCode,'') AS itemSeatCode, "
                + " IFNULL(mst_item_seat.Name,'') AS itemSeatName, "
                + " IFNULL(mst_item_finish_goods.ItemSeatInsertCode,'') AS itemSeatInsertCode, "
                + " IFNULL(mst_item_seat_insert.Name,'') AS itemSeatInsertName, "
                + " IFNULL(mst_item_finish_goods.ItemStemCode,'') AS itemStemCode, "
                + " IFNULL(mst_item_stem.Name,'') AS itemStemName, "
                
                + " IFNULL(mst_item_finish_goods.ItemSealCode,'') AS itemSealCode, "
                + " IFNULL(mst_item_seal.Name,'') AS itemSealName, "
                + " IFNULL(mst_item_finish_goods.ItemBoltCode,'') AS itemBoltCode, "
                + " IFNULL(mst_item_bolt.Name,'') AS itemBoltName, "
                + " IFNULL(mst_item_finish_goods.ItemDiscCode,'') AS itemDiscCode, "
                + " IFNULL(mst_item_disc.Name,'') AS itemDiscName, "
                + " IFNULL(mst_item_finish_goods.ItemPlatesCode,'') AS itemPlatesCode, "
                + " IFNULL(mst_item_plates.Name,'') AS itemPlatesName, "
                + " IFNULL(mst_item_finish_goods.ItemShaftCode,'') AS itemShaftCode, "
                + " IFNULL(mst_item_shaft.Name,'') AS itemShaftName, "
                + " IFNULL(mst_item_finish_goods.ItemSpringCode,'') AS itemSpringCode, "
                + " IFNULL(mst_item_spring.Name,'') ItemSpringName, "
                
                + " IFNULL(mst_item_finish_goods.ItemArmPinCode,'') AS itemArmPinCode, "
                + " IFNULL(mst_item_arm.Name,'') AS itemArmPinName, "

                + " IFNULL(mst_item_finish_goods.ItemBackSeatCode,'') AS itemBackSeatCode, "
                + " IFNULL(mst_item_backseat.Name,'') AS itemBackSeatName, "

                + " IFNULL(mst_item_finish_goods.ItemArmCode,'') AS itemArmCode, "
                + " IFNULL(mst_item_arm.Name,'') AS itemArmName, "

                + " IFNULL(mst_item_finish_goods.ItemHingePinCode,'') AS itemHingePinCode, "
                + " IFNULL(mst_item_hinge_pin.Name,'') AS itemHingePinName, "

                + " IFNULL(mst_item_finish_goods.ItemStopPinCode,'') AS itemStopPinCode, "
                + " IFNULL(mst_item_stop_pin.Name,'') AS itemStopPinName, "

                + " IFNULL(mst_item_finish_goods.ItemOperatorCode,'') AS itemOperatorCode, "
                + " IFNULL(mst_item_operator.Name,'') AS itemOperatorName "
                
                + " FROM "
                + " sal_customer_blanket_order_item_detail "
                + " INNER JOIN `mst_item_finish_goods` ON mst_item_finish_goods.`code` = sal_customer_blanket_order_item_detail.`ItemFinishGoodsCode` "
                + " INNER JOIN sal_sales_quotation_detail ON sal_sales_quotation_detail.Code = sal_customer_blanket_order_item_detail.SalesQuotationDetailCode "
                + " INNER JOIN sal_sales_quotation ON sal_sales_quotation.Code = sal_sales_quotation_detail.HeaderCode "
                + " INNER JOIN mst_valve_type ON mst_valve_type.Code = sal_sales_quotation_detail.ValveTypeCode "
                //join Finish Goods
                + " LEFT JOIN mst_item_body_construction ON mst_item_body_construction.Code = mst_item_finish_goods.ItemBodyConstructionCode "
                + " LEFT JOIN mst_item_type_design ON mst_item_type_design.Code = mst_item_finish_goods.ItemTypeDesignCode "
                + " LEFT JOIN mst_item_seat_design ON mst_item_seat_design.Code = mst_item_finish_goods.ItemSeatDesignCode "
                + " LEFT JOIN mst_item_size ON mst_item_size.Code = mst_item_finish_goods.ItemSizeCode "
                + " LEFT JOIN mst_item_rating ON mst_item_rating.Code = mst_item_finish_goods.ItemRatingCode "
                + " LEFT JOIN mst_item_bore ON mst_item_bore.Code = mst_item_finish_goods.ItemBoreCode "
                    
                + " LEFT JOIN mst_item_end_con ON mst_item_end_con.Code = mst_item_finish_goods.ItemEndConCode "
                + " LEFT JOIN mst_item_body ON mst_item_body.Code = mst_item_finish_goods.ItemBodyCode "
                + " LEFT JOIN mst_item_ball ON mst_item_ball.Code = mst_item_finish_goods.ItemBallCode "
                + " LEFT JOIN mst_item_seat ON mst_item_seat.Code = mst_item_finish_goods.ItemSeatCode "
                + " LEFT JOIN mst_item_seat_insert ON mst_item_seat_insert.Code = mst_item_finish_goods.ItemSeatInsertCode "
                + " LEFT JOIN mst_item_stem ON mst_item_stem.Code = mst_item_finish_goods.ItemStemCode "
                        
                + " LEFT JOIN mst_item_seal ON mst_item_seal.Code = mst_item_finish_goods.ItemSealCode "
                + " LEFT JOIN mst_item_bolt ON mst_item_bolt.Code = mst_item_finish_goods.ItemBoltCode "
                + " LEFT JOIN mst_item_disc ON mst_item_disc.Code = mst_item_finish_goods.ItemDiscCode "
                + " LEFT JOIN mst_item_plates ON mst_item_plates.Code = mst_item_finish_goods.ItemPlatesCode "
                + " LEFT JOIN mst_item_shaft ON mst_item_shaft.Code = mst_item_finish_goods.ItemShaftCode "
                + " LEFT JOIN mst_item_spring ON mst_item_spring.Code = mst_item_finish_goods.ItemSpringCode "
                        
                + " LEFT JOIN mst_item_arm_pin ON mst_item_arm_pin.Code = mst_item_finish_goods.ItemArmPinCode "
                + " LEFT JOIN mst_item_backseat ON mst_item_backseat.Code = mst_item_finish_goods.ItemBackSeatCode "
                + " LEFT JOIN mst_item_arm ON mst_item_arm.Code = mst_item_finish_goods.ItemArmCode "
                + " LEFT JOIN mst_item_hinge_pin ON mst_item_hinge_pin.Code = mst_item_finish_goods.ItemHingePinCode "
                + " LEFT JOIN mst_item_stop_pin ON mst_item_stop_pin.Code = mst_item_finish_goods.ItemStopPinCode "
                + " LEFT JOIN mst_item_operator ON mst_item_operator.Code = mst_item_finish_goods.ItemOperatorCode "
                
                + " WHERE sal_customer_blanket_order_item_detail.SalesQuotationCode IN ('"+strSalesQuotationNo+"')"
                + " AND sal_customer_blanket_order_item_detail.HeaderCode =:prmHeaderCode"    
            )

                .addScalar("code", Hibernate.STRING)
                .addScalar("salesQuotationCode", Hibernate.STRING)
                .addScalar("customerPurchaseOrderSortNo", Hibernate.BIG_DECIMAL)
                .addScalar("itemFinishGoodsCode", Hibernate.STRING)
                .addScalar("itemFinishGoodsRemark", Hibernate.STRING)
                .addScalar("salesQuotationDetailCode", Hibernate.STRING)
                .addScalar("valveTypeCode", Hibernate.STRING)
                .addScalar("valveTypeName", Hibernate.STRING)
                .addScalar("valveTag", Hibernate.STRING)
                .addScalar("dataSheet", Hibernate.STRING)
                .addScalar("description", Hibernate.STRING)
                .addScalar("itemAlias", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                    
                .addScalar("bodyConstruction", Hibernate.STRING)
                .addScalar("typeDesign", Hibernate.STRING)
                .addScalar("seatDesign", Hibernate.STRING)
                .addScalar("size", Hibernate.STRING)
                .addScalar("rating", Hibernate.STRING)
                .addScalar("bore", Hibernate.STRING)
                    
                .addScalar("endCon", Hibernate.STRING)
                .addScalar("body", Hibernate.STRING)
                .addScalar("ball", Hibernate.STRING)
                .addScalar("seat", Hibernate.STRING)
                .addScalar("seatInsert", Hibernate.STRING)
                .addScalar("stem", Hibernate.STRING)
                    
                .addScalar("seal", Hibernate.STRING)
                .addScalar("bolting", Hibernate.STRING)
                .addScalar("disc", Hibernate.STRING)
                .addScalar("plates", Hibernate.STRING)
                .addScalar("shaft", Hibernate.STRING)
                .addScalar("spring", Hibernate.STRING)
                    
                .addScalar("armPin", Hibernate.STRING)
                .addScalar("backSeat", Hibernate.STRING)
                .addScalar("arm", Hibernate.STRING)
                .addScalar("hingePin", Hibernate.STRING)
                .addScalar("StopPin", Hibernate.STRING)
                .addScalar("operator", Hibernate.STRING)
                    
                .addScalar("note", Hibernate.STRING)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("unitPrice", Hibernate.BIG_DECIMAL)
                .addScalar("totalAmount", Hibernate.BIG_DECIMAL)
                    
                //finish goods
                .addScalar("itemBodyConstructionCode", Hibernate.STRING)
                .addScalar("itemBodyConstructionName", Hibernate.STRING)
                .addScalar("itemTypeDesignCode", Hibernate.STRING)
                .addScalar("itemTypeDesignName", Hibernate.STRING)
                .addScalar("itemSeatDesignCode", Hibernate.STRING)
                .addScalar("itemSeatDesignName", Hibernate.STRING)
                .addScalar("itemSizeCode", Hibernate.STRING)
                .addScalar("itemSizeName", Hibernate.STRING)
                .addScalar("itemRatingCode", Hibernate.STRING)
                .addScalar("itemRatingName", Hibernate.STRING)
                .addScalar("itemBoreCode", Hibernate.STRING)
                .addScalar("itemBoreName", Hibernate.STRING)
                    
                .addScalar("itemEndConCode", Hibernate.STRING)
                .addScalar("itemEndConName", Hibernate.STRING)
                .addScalar("itemBodyCode", Hibernate.STRING)
                .addScalar("itemBodyName", Hibernate.STRING)
                .addScalar("itemBallCode", Hibernate.STRING)
                .addScalar("itemBallName", Hibernate.STRING)
                .addScalar("itemSeatCode", Hibernate.STRING)
                .addScalar("itemSeatName", Hibernate.STRING)
                .addScalar("itemSeatInsertCode", Hibernate.STRING)
                .addScalar("itemSeatInsertName", Hibernate.STRING)
                .addScalar("itemStemCode", Hibernate.STRING)
                .addScalar("itemStemName", Hibernate.STRING)
                    
                .addScalar("itemSealCode", Hibernate.STRING)
                .addScalar("itemSealName", Hibernate.STRING)
                .addScalar("itemBoltCode", Hibernate.STRING)
                .addScalar("itemBoltName", Hibernate.STRING)
                .addScalar("itemDiscCode", Hibernate.STRING)
                .addScalar("itemDiscName", Hibernate.STRING)
                .addScalar("itemPlatesCode", Hibernate.STRING)
                .addScalar("itemPlatesName", Hibernate.STRING)
                .addScalar("itemShaftCode", Hibernate.STRING)
                .addScalar("itemShaftName", Hibernate.STRING)
                .addScalar("itemSpringCode", Hibernate.STRING)
                .addScalar("itemSpringName", Hibernate.STRING)
                    
                .addScalar("itemArmPinCode", Hibernate.STRING)
                .addScalar("itemArmPinName", Hibernate.STRING)
                .addScalar("itemBackSeatCode", Hibernate.STRING)
                .addScalar("itemBackSeatName", Hibernate.STRING)
                .addScalar("itemArmCode", Hibernate.STRING)
                .addScalar("itemArmName", Hibernate.STRING)
                .addScalar("itemHingePinCode", Hibernate.STRING)
                .addScalar("itemHingePinName", Hibernate.STRING)
                .addScalar("itemStopPinCode", Hibernate.STRING)
                .addScalar("itemStopPinName", Hibernate.STRING)
                .addScalar("itemOperatorCode", Hibernate.STRING)
                .addScalar("itemOperatorName", Hibernate.STRING)
                .setParameter("prmHeaderCode", headerCode)   
                .setResultTransformer(Transformers.aliasToBean(CustomerBlanketOrderItemDetail.class))
                .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerBlanketOrderItemDetail> findDataSyncItemDetail(ArrayList arrSalesQuotationNo,CustomerBlanketOrder customerBlanketOrder) {
        try {
            
            String strSalesQuotationNo=Arrays.toString(arrSalesQuotationNo.toArray());
            strSalesQuotationNo = strSalesQuotationNo.replaceAll("[\\[\\]]", "");
            strSalesQuotationNo = strSalesQuotationNo.replaceAll(",", "','");
            
            List<CustomerBlanketOrderItemDetail> list = (List<CustomerBlanketOrderItemDetail>)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "	customer_blanket_order_item_detail.SalesQuotationCode, " +
                "	customer_blanket_order_item_detail.CustomerPurchaseOrderSortNo, " +
                "	customer_blanket_order_item_detail.ItemCode, " +
                "	customer_blanket_order_item_detail.ValveTag, " +
                "	customer_blanket_order_item_detail.DataSheet, " +
                "	customer_blanket_order_item_detail.Description, " +
                "	customer_blanket_order_item_detail.Type, " +
                "	customer_blanket_order_item_detail.Size, " +
                "	customer_blanket_order_item_detail.Rating, " +
                "	customer_blanket_order_item_detail.EndCon, " +
                "	customer_blanket_order_item_detail.Body, " +
                "	customer_blanket_order_item_detail.Ball, " +
                "	customer_blanket_order_item_detail.Seat, " +
                "	customer_blanket_order_item_detail.Stem, " +
                "	customer_blanket_order_item_detail.seatInsert, " +
                "	customer_blanket_order_item_detail.Seal, " +
                "	customer_blanket_order_item_detail.Bolting, " +
                "	customer_blanket_order_item_detail.SeatDesign, " +
                "	customer_blanket_order_item_detail.Oper, " +
                "	customer_blanket_order_item_detail.Note, " +
                "	customer_blanket_order_item_detail.Quantity - IFNULL(customer_sales_order_by_blanket_order_item_detail.Quantity,0)AS Quantity, " +
                "	customer_blanket_order_item_detail.UnitPrice, " +
                "	ROUND((customer_blanket_order_item_detail.Quantity - IFNULL(customer_sales_order_by_blanket_order_item_detail.Quantity,0)) * customer_blanket_order_item_detail.UnitPrice,2)AS TotalAmount " +
                "FROM( " +
                "	SELECT " +
                "		sal_customer_blanket_order_item_detail.SalesQuotationCode, " +
                "		sal_customer_blanket_order_item_detail.CustomerPurchaseOrderSortNo, " +
                "		sal_customer_blanket_order_item_detail.ItemCode, " +
                "		sal_sales_quotation_detail.ValveTag, " +
                "		sal_sales_quotation_detail.DataSheet, " +
                "		sal_sales_quotation_detail.Description, " +
                "		sal_sales_quotation_detail.Type, " +
                "		sal_sales_quotation_detail.Size, " +
                "		sal_sales_quotation_detail.Rating, " +
                "		sal_sales_quotation_detail.EndCon, " +
                "		sal_sales_quotation_detail.Body, " +
                "		sal_sales_quotation_detail.Ball, " +
                "		sal_sales_quotation_detail.Seat, " +
                "		sal_sales_quotation_detail.Stem, " +
                "		sal_sales_quotation_detail.seatInsert, " +
                "		sal_sales_quotation_detail.Seal, " +
                "		sal_sales_quotation_detail.Bolting, " +
                "		sal_sales_quotation_detail.SeatDesign, " +
                "		sal_sales_quotation_detail.Oper, " +
                "		sal_sales_quotation_detail.Note, " +
                "		sal_customer_blanket_order_item_detail.Quantity, " +
                "		sal_sales_quotation_detail.UnitPrice " +
                "	FROM sal_customer_blanket_order_item_detail  " +
                "	INNER JOIN sal_sales_quotation_detail  " +
                "	ON  sal_customer_blanket_order_item_detail.SalesQuotationCode=sal_sales_quotation_detail.HeaderCode   " +
                "		AND sal_customer_blanket_order_item_detail.ItemCode=sal_sales_quotation_detail.Item  " +
                "	WHERE sal_customer_blanket_order_item_detail.SalesQuotationCode IN('"+strSalesQuotationNo+"')  " +
                ")AS customer_blanket_order_item_detail " +
                "LEFT JOIN( " +
                "	SELECT " +
                "		sal_customer_blanket_order_by_blanket_order_item_detail.SalesQuotationCode, " +
                "		sal_customer_blanket_order_by_blanket_order_item_detail.ItemCode, " +
                "		SUM(sal_customer_blanket_order_by_blanket_order_item_detail.Quantity)AS Quantity " +
                "	FROM sal_customer_blanket_order_by_blanket_order_item_detail " +
                "	INNER JOIN sal_customer_blanket_order_by_blanket_order ON sal_customer_blanket_order_by_blanket_order_item_detail.HeaderCode=sal_customer_blanket_order_by_blanket_order.Code " +
                "	WHERE sal_customer_blanket_order_by_blanket_order.BlanketOrderCode='"+customerBlanketOrder.getCode()+"' " +
                "	GROUP BY sal_customer_blanket_order_by_blanket_order_item_detail.SalesQuotationCode,sal_customer_blanket_order_by_blanket_order_item_detail.ItemCode " +
                ")AS customer_sales_order_by_blanket_order_item_detail  " +
                "ON customer_blanket_order_item_detail.SalesQuotationCode=customer_sales_order_by_blanket_order_item_detail.SalesQuotationCode " +
                "	AND customer_blanket_order_item_detail.ItemCode=customer_sales_order_by_blanket_order_item_detail.ItemCode " +
                "WHERE (customer_blanket_order_item_detail.Quantity-IFNULL(customer_sales_order_by_blanket_order_item_detail.Quantity,0))>0")
                        
                .addScalar("salesQuotationCode", Hibernate.STRING)
                .addScalar("customerPurchaseOrderSortNo", Hibernate.BIG_DECIMAL)
                .addScalar("itemCode", Hibernate.STRING)
                .addScalar("valveTag", Hibernate.STRING)
                .addScalar("dataSheet", Hibernate.STRING)
                .addScalar("description", Hibernate.STRING)
                .addScalar("type", Hibernate.STRING)
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
                .addScalar("note", Hibernate.STRING)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("unitPrice", Hibernate.BIG_DECIMAL)
                .addScalar("totalAmount", Hibernate.BIG_DECIMAL)
                .setResultTransformer(Transformers.aliasToBean(CustomerBlanketOrderItemDetail.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerBlanketOrderAdditionalFee> findDataAdditionalFee(String headerCode) {
        try {
            
            List<CustomerBlanketOrderAdditionalFee> list = (List<CustomerBlanketOrderAdditionalFee>)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "	sal_customer_blanket_order_additional_fee.Remark, " +
                "	sal_customer_blanket_order_additional_fee.Quantity, " +
                "	sal_customer_blanket_order_additional_fee.AdditionalFeeCode, " +
                "	mst_additional_fee.Name AS additionalFeeName, " +
                "	mst_additional_fee.SalesChartOfAccountCode AS coaCode, " +
                "	mst_chart_of_account.name AS coaName, " +
                "	sal_customer_blanket_order_additional_fee.UnitCode AS unitOfMeasureCode, " +
                "	sal_customer_blanket_order_additional_fee.Price, " +
                "	sal_customer_blanket_order_additional_fee.Total " +
                "FROM sal_customer_blanket_order_additional_fee " +
                "INNER JOIN  mst_additional_fee ON mst_additional_fee.Code = sal_customer_blanket_order_additional_fee.AdditionalFeeCode " +        
                "INNER JOIN  mst_chart_of_account ON mst_chart_of_account.Code = mst_additional_fee.SalesChartOfAccountCode " +        
                "WHERE sal_customer_blanket_order_additional_fee.HeaderCode=:prmHeaderCode")

                .addScalar("remark", Hibernate.STRING)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("additionalFeeCode", Hibernate.STRING)
                .addScalar("additionalFeeName", Hibernate.STRING)
                .addScalar("unitOfMeasureCode", Hibernate.STRING)
                .addScalar("coaCode", Hibernate.STRING)
                .addScalar("coaName", Hibernate.STRING)    
                .addScalar("price", Hibernate.BIG_DECIMAL)
                .addScalar("total", Hibernate.BIG_DECIMAL)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(CustomerBlanketOrderAdditionalFee.class))
                .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerBlanketOrderPaymentTerm> findDataPaymentTerm(String headerCode) {
        try {
            
            List<CustomerBlanketOrderPaymentTerm> list = (List<CustomerBlanketOrderPaymentTerm>)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "	sal_customer_blanket_order_payment_term.SortNo, " +
                "	sal_customer_blanket_order_payment_term.PaymentTermCode, " +
                "       mst_payment_term.Name AS paymentTermName, " +
                "	sal_customer_blanket_order_payment_term.Percentage, " +
                "	sal_customer_blanket_order_payment_term.Remark " +
                "FROM sal_customer_blanket_order_payment_term " +
                "INNER JOIN mst_payment_term ON sal_customer_blanket_order_payment_term.PaymentTermCode=mst_payment_term.Code " +
                "WHERE sal_customer_blanket_order_payment_term.HeaderCode=:prmHeaderCode")

                .addScalar("sortNo", Hibernate.BIG_DECIMAL)
                .addScalar("paymentTermCode", Hibernate.STRING)
                .addScalar("paymentTermName", Hibernate.STRING)
                .addScalar("percentage", Hibernate.BIG_DECIMAL)
                .addScalar("remark", Hibernate.STRING)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(CustomerBlanketOrderPaymentTerm.class))
                .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerBlanketOrderItemDeliveryDate> findDataItemDeliveryDate(String headerCode) {
        try {
            
            List<CustomerBlanketOrderItemDeliveryDate> list = (List<CustomerBlanketOrderItemDeliveryDate>)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "	sal_customer_blanket_order_item_delivery_date.Code, " +
                "	sal_customer_blanket_order_item_delivery_date.ItemFinishGoodsCode AS itemFinishGoodsCode, " +
                "	mst_item_finish_goods.Remark AS itemFinishGoodsRemark, " +
                "	sal_customer_blanket_order_item_delivery_date.Quantity, " +
                "	sal_customer_blanket_order_item_delivery_date.DeliveryDate, " +
                "	sal_customer_blanket_order_item_delivery_date.SalesQuotationCode AS salesQuotationCode, " +
                "	sal_customer_blanket_order_item_detail.CustomerPurchaseOrderSortNo AS customerPurchaseOrderSortNo, " +
                "       sal_sales_quotation.RefNo " +        
                "FROM sal_customer_blanket_order_item_delivery_date " +       
                "INNER JOIN sal_customer_blanket_order_item_detail ON sal_customer_blanket_order_item_delivery_date.Code = sal_customer_blanket_order_item_detail.Code " +       
                "INNER JOIN mst_item_finish_goods ON sal_customer_blanket_order_item_delivery_date.ItemFinishGoodsCode = mst_item_finish_goods.Code " +             
                "INNER JOIN sal_sales_quotation ON sal_sales_quotation.Code = sal_customer_blanket_order_item_delivery_date.SalesQuotationCode  " +             
                "WHERE sal_customer_blanket_order_item_delivery_date.HeaderCode=:prmHeaderCode "+
                "ORDER BY sal_customer_blanket_order_item_delivery_date.Code")

                .addScalar("itemFinishGoodsCode", Hibernate.STRING)
                .addScalar("itemFinishGoodsRemark", Hibernate.STRING)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("deliveryDate", Hibernate.DATE)
                .addScalar("salesQuotationCode", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("customerPurchaseOrderSortNo", Hibernate.BIG_DECIMAL)    
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(CustomerBlanketOrderItemDeliveryDate.class))
                .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    //sukha ini gua pake buat di production planning order
    public List<CustomerBlanketOrderItemDetail> findDataforPp(String headerCode) {
        try {
            
            List<CustomerBlanketOrderItemDetail> list = (List<CustomerBlanketOrderItemDetail>)hbmSession.hSession.createSQLQuery(
                "SELECT " 
                    + "sal_customer_blanket_order_item_detail.Code, "
                    + "sal_customer_blanket_order_item_detail.CustomerPurchaseOrderSortNo, "
                    + "sal_customer_blanket_order_item_detail.ItemFinishGoodsCode, "
                    + "sal_customer_blanket_order_item_detail.Quantity, "

                    + "sal_sales_quotation_detail.ValveTag, "
                    + "sal_sales_quotation_detail.DataSheet, "
                    + "sal_sales_quotation_detail.Description, "
                        
                    + "IFNULL(mst_item_finish_goods.ItemBodyConstructionCode,'') AS itemBodyConstructionCode,  "
                    + "IFNULL(mst_item_body_construction.Name,'') AS itemBodyConstructionName,  "
                    + "IFNULL(mst_item_finish_goods.ItemTypeDesignCode,'') AS itemTypeDesignCode,  "
                    + "IFNULL(mst_item_type_design.Name,'') AS itemTypeDesignName,  "
                    + "IFNULL(mst_item_finish_goods.ItemSeatDesignCode,'') AS itemSeatDesignCode,  "
                    + "IFNULL(mst_item_seat_design.Name,'') AS itemSeatDesignName,  "
                    + "IFNULL(mst_item_finish_goods.ItemSizeCode,'') AS itemSizeCode,  "
                    + "IFNULL(mst_item_size.Name,'') AS itemSizeName,  "
                    + "IFNULL(mst_item_finish_goods.ItemRatingCode,'') AS itemRatingCode,  "
                    + "IFNULL(mst_item_rating.Name,'') AS itemRatingName,  "
                    + "IFNULL(mst_item_finish_goods.ItemBoreCode,'') AS itemBoreCode,  "
                    + "IFNULL(mst_item_bore.Name,'') AS itemBoreName,  "

                    + "IFNULL(mst_item_finish_goods.ItemEndConCode,'') AS itemEndConCode,  "
                    + "IFNULL(mst_item_end_con.Name,'') AS itemEndConName,  "
                    + "IFNULL(mst_item_finish_goods.ItemBodyCode,'') AS itemBodyCode,  "
                    + "IFNULL(mst_item_body.Name,'') AS itemBodyName,  "
                    + "IFNULL(mst_item_finish_goods.ItemBallCode,'') AS itemBallCode,  "
                    + "IFNULL(mst_item_ball.Name,'') AS itemBallName,  "
                    + "IFNULL(mst_item_finish_goods.ItemSeatCode,'') AS itemSeatCode,  "
                    + "IFNULL(mst_item_seat.Name,'') AS itemSeatName,  "
                    + "IFNULL(mst_item_finish_goods.ItemSeatInsertCode,'') AS itemSeatInsertCode,  "
                    + "IFNULL(mst_item_seat_insert.Name,'') AS itemSeatInsertName,  "
                    + "IFNULL(mst_item_finish_goods.ItemStemCode,'') AS itemStemCode,  "
                    + "IFNULL(mst_item_stem.Name,'') AS itemStemName,  "

                    + "IFNULL(mst_item_finish_goods.ItemSealCode,'') AS itemSealCode,  "
                    + "IFNULL(mst_item_seal.Name,'') AS itemSealName,  "
                    + "IFNULL(mst_item_finish_goods.ItemBoltCode,'') AS itemBoltCode,  "
                    + "IFNULL(mst_item_bolt.Name,'') AS itemBoltName,  "
                    + "IFNULL(mst_item_finish_goods.ItemDiscCode,'') AS itemDiscCode,  "
                    + "IFNULL(mst_item_disc.Name,'') AS itemDiscName,  "
                    + "IFNULL(mst_item_finish_goods.ItemPlatesCode,'') AS itemPlatesCode,  "
                    + "IFNULL(mst_item_plates.Name,'') AS itemPlatesName,  "
                    + "IFNULL(mst_item_finish_goods.ItemShaftCode,'') AS itemShaftCode,  "
                    + "IFNULL(mst_item_shaft.Name,'') AS itemShaftName,  "
                    + "IFNULL(mst_item_finish_goods.ItemSpringCode,'') AS itemSpringCode,  "
                    + "IFNULL(mst_item_spring.Name,'') ItemSpringName,  "

                    + "IFNULL(mst_item_finish_goods.ItemArmPinCode,'') AS itemArmPinCode,  "
                    + "IFNULL(mst_item_arm.Name,'') AS itemArmPinName,  "
                    + "IFNULL(mst_item_finish_goods.ItemBackSeatCode,'') AS itemBackSeatCode,  "
                    + "IFNULL(mst_item_backseat.Name,'') AS itemBackSeatName,  "
                    + "IFNULL(mst_item_finish_goods.ItemArmCode,'') AS itemArmCode,  "
                    + "IFNULL(mst_item_arm.Name,'') AS itemArmName,  "
                    + "IFNULL(mst_item_finish_goods.ItemHingePinCode,'') AS itemHingePinCode,  "
                    + "IFNULL(mst_item_hinge_pin.Name,'') AS itemHingePinName,  "
                    + "IFNULL(mst_item_finish_goods.ItemStopPinCode,'') AS itemStopPinCode,  "
                    + "IFNULL(mst_item_stop_pin.Name,'') AS itemStopPinName,  "
                    + "IFNULL(mst_item_finish_goods.ItemOperatorCode,'') AS itemOperatorCode,  "
                    + "IFNULL(mst_item_operator.Name,'') AS itemOperatorName  "
                + "FROM sal_customer_blanket_order_item_detail  "
                    + "INNER JOIN mst_item_finish_goods ON mst_item_finish_goods.code = sal_customer_blanket_order_item_detail.ItemFinishGoodsCode  "
                    + "INNER JOIN sal_sales_quotation_detail ON sal_sales_quotation_detail.Code = sal_customer_blanket_order_item_detail.SalesQuotationDetailCode  "

                    + "LEFT JOIN mst_item_body_construction ON mst_item_body_construction.Code = mst_item_finish_goods.ItemBodyConstructionCode " 
                    + "LEFT JOIN mst_item_type_design ON mst_item_type_design.Code = mst_item_finish_goods.ItemTypeDesignCode  "
                    + "LEFT JOIN mst_item_seat_design ON mst_item_seat_design.Code = mst_item_finish_goods.ItemSeatDesignCode  "
                    + "LEFT JOIN mst_item_size ON mst_item_size.Code = mst_item_finish_goods.ItemSizeCode  "
                    + "LEFT JOIN mst_item_rating ON mst_item_rating.Code = mst_item_finish_goods.ItemRatingCode  "
                    + "LEFT JOIN mst_item_bore ON mst_item_bore.Code = mst_item_finish_goods.ItemBoreCode  "

                    + "LEFT JOIN mst_item_end_con ON mst_item_end_con.Code = mst_item_finish_goods.ItemEndConCode  "
                    + "LEFT JOIN mst_item_body ON mst_item_body.Code = mst_item_finish_goods.ItemBodyCode  "
                    + "LEFT JOIN mst_item_ball ON mst_item_ball.Code = mst_item_finish_goods.ItemBallCode   "
                    + "LEFT JOIN mst_item_seat ON mst_item_seat.Code = mst_item_finish_goods.ItemSeatCode  "
                    + "LEFT JOIN mst_item_seat_insert ON mst_item_seat_insert.Code = mst_item_finish_goods.ItemSeatInsertCode  "
                    + "LEFT JOIN mst_item_stem ON mst_item_stem.Code = mst_item_finish_goods.ItemStemCode  "

                    + "LEFT JOIN mst_item_seal ON mst_item_seal.Code = mst_item_finish_goods.ItemSealCode  "
                    + "LEFT JOIN mst_item_bolt ON mst_item_bolt.Code = mst_item_finish_goods.ItemBoltCode  "
                    + "LEFT JOIN mst_item_disc ON mst_item_disc.Code = mst_item_finish_goods.ItemDiscCode  "
                    + "LEFT JOIN mst_item_plates ON mst_item_plates.Code = mst_item_finish_goods.ItemPlatesCode  "
                    + "LEFT JOIN mst_item_shaft ON mst_item_shaft.Code = mst_item_finish_goods.ItemShaftCode  "
                    + "LEFT JOIN mst_item_spring ON mst_item_spring.Code = mst_item_finish_goods.ItemSpringCode  "

                    + "LEFT JOIN mst_item_arm_pin ON mst_item_arm_pin.Code = mst_item_finish_goods.ItemArmPinCode  "
                    + "LEFT JOIN mst_item_backseat ON mst_item_backseat.Code = mst_item_finish_goods.ItemBackSeatCode  "
                    + "LEFT JOIN mst_item_arm ON mst_item_arm.Code = mst_item_finish_goods.ItemArmCode  "
                    + "LEFT JOIN mst_item_hinge_pin ON mst_item_hinge_pin.Code = mst_item_finish_goods.ItemHingePinCode  "
                    + "LEFT JOIN mst_item_stop_pin ON mst_item_stop_pin.Code = mst_item_finish_goods.ItemStopPinCode  "
                    + "LEFT JOIN mst_item_operator ON mst_item_operator.Code = mst_item_finish_goods.ItemOperatorCode  "
                + "WHERE sal_customer_blanket_order_item_detail.HeaderCode=:prmHeaderCode" 
            )
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("itemFinishGoodsCode", Hibernate.STRING)
                .addScalar("customerPurchaseOrderSortNo", Hibernate.BIG_DECIMAL)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("valveTag", Hibernate.STRING)
                .addScalar("dataSheet", Hibernate.STRING)
                .addScalar("description", Hibernate.STRING)
                
                //finish goods
                .addScalar("itemBodyConstructionCode", Hibernate.STRING)
                .addScalar("itemBodyConstructionName", Hibernate.STRING)
                .addScalar("itemTypeDesignCode", Hibernate.STRING)
                .addScalar("itemTypeDesignName", Hibernate.STRING)
                .addScalar("itemSeatDesignCode", Hibernate.STRING)
                .addScalar("itemSeatDesignName", Hibernate.STRING)
                .addScalar("itemSizeCode", Hibernate.STRING)
                .addScalar("itemSizeName", Hibernate.STRING)
                .addScalar("itemRatingCode", Hibernate.STRING)
                .addScalar("itemRatingName", Hibernate.STRING)
                .addScalar("itemBoreCode", Hibernate.STRING)
                .addScalar("itemBoreName", Hibernate.STRING)
                    
                .addScalar("itemEndConCode", Hibernate.STRING)
                .addScalar("itemEndConName", Hibernate.STRING)
                .addScalar("itemBodyCode", Hibernate.STRING)
                .addScalar("itemBodyName", Hibernate.STRING)
                .addScalar("itemBallCode", Hibernate.STRING)
                .addScalar("itemBallName", Hibernate.STRING)
                .addScalar("itemSeatCode", Hibernate.STRING)
                .addScalar("itemSeatName", Hibernate.STRING)
                .addScalar("itemSeatInsertCode", Hibernate.STRING)
                .addScalar("itemSeatInsertName", Hibernate.STRING)
                .addScalar("itemStemCode", Hibernate.STRING)
                .addScalar("itemStemName", Hibernate.STRING)
                    
                .addScalar("itemSealCode", Hibernate.STRING)
                .addScalar("itemSealName", Hibernate.STRING)
                .addScalar("itemBoltCode", Hibernate.STRING)
                .addScalar("itemBoltName", Hibernate.STRING)
                .addScalar("itemDiscCode", Hibernate.STRING)
                .addScalar("itemDiscName", Hibernate.STRING)
                .addScalar("itemPlatesCode", Hibernate.STRING)
                .addScalar("itemPlatesName", Hibernate.STRING)
                .addScalar("itemShaftCode", Hibernate.STRING)
                .addScalar("itemShaftName", Hibernate.STRING)
                .addScalar("itemSpringCode", Hibernate.STRING)
                .addScalar("itemSpringName", Hibernate.STRING)
                    
                .addScalar("itemArmPinCode", Hibernate.STRING)
                .addScalar("itemArmPinName", Hibernate.STRING)
                .addScalar("itemBackSeatCode", Hibernate.STRING)
                .addScalar("itemBackSeatName", Hibernate.STRING)
                .addScalar("itemArmCode", Hibernate.STRING)
                .addScalar("itemArmName", Hibernate.STRING)
                .addScalar("itemHingePinCode", Hibernate.STRING)
                .addScalar("itemHingePinName", Hibernate.STRING)
                .addScalar("itemStopPinCode", Hibernate.STRING)
                .addScalar("itemStopPinName", Hibernate.STRING)
                .addScalar("itemOperatorCode", Hibernate.STRING)
                .addScalar("itemOperatorName", Hibernate.STRING)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(CustomerBlanketOrderItemDetail.class))
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
    
    public CustomerBlanketOrder get(String code) {
        try {
               return (CustomerBlanketOrder) hbmSession.hSession.get(CustomerBlanketOrder.class, code);
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public CustomerBlanketOrder getBlanketOrderUpdate(String code){
        try {
            CustomerBlanketOrder salesOrder = (CustomerBlanketOrder)hbmSession.hSession.createSQLQuery(
                "SELECT "
                    + " sal_customer_blanket_order.Code, "
                    + " sal_customer_blanket_order.CUSTBONo AS custBONo, "
                    + " sal_customer_blanket_order.Revision, "
                    + " sal_customer_blanket_order.RefCUSTBOCode, "
                    + " sal_customer_blanket_order.ValidStatus, "
                    + " sal_customer_blanket_order.TransactionDate, "
                    + " sal_customer_blanket_order.CustomerPurchaseOrderCode, "
                    + " sal_customer_blanket_order.BranchCode, "
                    + " sal_customer_blanket_order.RequestDeliveryDate, "
                    + " sal_customer_blanket_order.ExpiredDate, "
                    + " sal_customer_blanket_order.CustomerCode, "
                    + " sal_customer_blanket_order.EndUserCode, "
                    + " sal_customer_blanket_order.CurrencyCode, "
                    + " sal_customer_blanket_order.SalesPersonCode, "
                    + " sal_customer_blanket_order.ProjectCode, "
                    + " sal_customer_blanket_order.RefNo, "
                    + " sal_customer_blanket_order.Remark, "
                    + " sal_customer_blanket_order.RevisionRemark, "
                    + " sal_customer_blanket_order.TotalTransactionAmount, "
                    + " sal_customer_blanket_order.DiscountPercent, "
                    + " sal_customer_blanket_order.DiscountAmount, "
                    + " sal_customer_blanket_order.TaxBaseAmount, "
                    + " sal_customer_blanket_order.Vatpercent, "
                    + " sal_customer_blanket_order.Vatamount, "
                    + " sal_customer_blanket_order.GrandTotalAmount "
                + " FROM "
                    + " sal_customer_blanket_order "
                + " WHERE "
                    + " sal_customer_blanket_order.Code = '"+ code +"' "
                    )
                .addScalar("code", Hibernate.STRING)
                .addScalar("custBONo", Hibernate.STRING)
                .addScalar("revision", Hibernate.STRING)
                .addScalar("validStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(CustomerBlanketOrder.class))
                .uniqueResult(); 
                 
                return salesOrder;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public CustomerBlanketOrder totalAdditionalFeeAmount(String headerCode){
       try {   
            CustomerBlanketOrder customerBlanketOrder = (CustomerBlanketOrder)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "	sal_customer_blanket_order.TotalTransactionAmount, " +
                "	sal_customer_blanket_order.DiscountPercent, " +
                "	sal_customer_blanket_order.DiscountAmount, " +
                "	fn_getAdditionalFee(sal_customer_blanket_order.Code,'BOD') AS totalAdditionalFeeAmount, " +
                "	sal_customer_blanket_order.TaxBaseAmount, " +
                "	sal_customer_blanket_order.Vatpercent, " +
                "	sal_customer_blanket_order.Vatamount, " +
                "	sal_customer_blanket_order.GrandTotalAmount " +
                "FROM sal_customer_blanket_order " +
                "WHERE sal_customer_blanket_order.Code=:prmHeaderCode")
                    
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)
                .addScalar("discountPercent", Hibernate.BIG_DECIMAL)
                .addScalar("discountAmount", Hibernate.BIG_DECIMAL)
                .addScalar("totalAdditionalFeeAmount", Hibernate.BIG_DECIMAL)
                .addScalar("taxBaseAmount", Hibernate.BIG_DECIMAL)
                .addScalar("vatPercent", Hibernate.BIG_DECIMAL)
                .addScalar("vatAmount", Hibernate.BIG_DECIMAL)
                .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(CustomerBlanketOrder.class))
                .uniqueResult(); 
                 
                return customerBlanketOrder;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public CustomerBlanketOrder getFromWoForRevise(String code){
        try {
            CustomerBlanketOrder customerBlanketOrder = (CustomerBlanketOrder)hbmSession.hSession.createSQLQuery(
                "SELECT "
                    + " sal_customer_blanket_order.Code, "
                    + " sal_customer_blanket_order.CUSTBONo, "
                    + " sal_customer_blanket_order.Revision, "
                    + " sal_customer_blanket_order.RefCUSTBOCode, "
                    + " sal_customer_blanket_order.ValidStatus, "
                    + " sal_customer_blanket_order.TransactionDate, "
                    + " sal_customer_blanket_order.CustomerPurchaseOrderCode, "
                    + " sal_customer_blanket_order.BranchCode, "
                    + " sal_customer_blanket_order.RequestDeliveryDate, "
                    + " sal_customer_blanket_order.ExpiredDate, "
                    + " sal_customer_blanket_order.CustomerCode, "
                    + " sal_customer_blanket_order.EndUserCode, "
                    + " sal_customer_blanket_order.CurrencyCode, "
                    + " sal_customer_blanket_order.SalesPersonCode, "
                    + " sal_customer_blanket_order.ProjectCode, "
                    + " sal_customer_blanket_order.RefNo, "
                    + " sal_customer_blanket_order.Remark, "
                    + " sal_customer_blanket_order.RevisionRemark, "
                    + " sal_customer_blanket_order.TotalTransactionAmount, "
                    + " sal_customer_blanket_order.DiscountPercent, "
                    + " sal_customer_blanket_order.DiscountAmount, "
                    + " sal_customer_blanket_order.TaxBaseAmount, "
                    + " sal_customer_blanket_order.Vatpercent, "
                    + " sal_customer_blanket_order.Vatamount, "
                    + " sal_customer_blanket_order.GrandTotalAmount "
                + " FROM "
                    + " sal_customer_blanket_order "
                + " WHERE "
                    + " sal_customer_blanket_order.CustomerPurchaseOrderCode = '"+ code +"' "
                    + " AND sal_customer_blanket_order.ValidStatus = TRUE "
                    )
                .addScalar("code", Hibernate.STRING)
                .addScalar("custBONo", Hibernate.STRING)
                .addScalar("revision", Hibernate.STRING)
                .addScalar("validStatus", Hibernate.BOOLEAN)
                .setResultTransformer(Transformers.aliasToBean(CustomerBlanketOrder.class))
                .uniqueResult(); 
                 
                return customerBlanketOrder;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public String createCode(EnumActivity.ENUM_Activity enumActivity, CustomerBlanketOrder customerBlanketOrder){
        try{           
            String acronim="";
            String splitter=CommonConst.spliterNoRev;
            int transactionLength=0;
            if(enumActivity.equals(EnumActivity.ENUM_Activity.NEW) || enumActivity.equals(EnumActivity.ENUM_Activity.CLONE)){
                acronim = "/BO/"+AutoNumber.getYear(customerBlanketOrder.getTransactionDate(), true);
                transactionLength=AutoNumber.DEFAULT_TRANSACTION_LENGTH_4;
            }
            
            if(enumActivity.equals(EnumActivity.ENUM_Activity.REVISE)){
                acronim = customerBlanketOrder.getCustBONo() + splitter;
                transactionLength=AutoNumber.DEFAULT_TRANSACTION_LENGTH_2;
            }

            DetachedCriteria dc = DetachedCriteria.forClass(CustomerBlanketOrder.class)
                    .setProjection(Projections.max("code"))
                    .add(Restrictions.like("code","%" + acronim + "%" ));

            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            List list = criteria.list();

            String oldID = "";
            if(list != null){
                if (list.size() > 0)
                    if(list.get(0) != null){
                        if(enumActivity.equals(EnumActivity.ENUM_Activity.NEW)|| enumActivity.equals(EnumActivity.ENUM_Activity.CLONE)){
                            oldID = list.get(0).toString().split("["+splitter+"]",2)[0];
                        }
                        if(enumActivity.equals(EnumActivity.ENUM_Activity.REVISE)){
                            oldID = list.get(0).toString();
                        }
                    }
            }
            return AutoNumber.generate_revNew(enumActivity, transactionLength, acronim, oldID);
        }
        catch(HibernateException e){
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public String createCodeRevise(EnumActivity.ENUM_Activity enumActivity, CustomerBlanketOrder customerBlanketOrder){
        try{           
            
            String acronim="";
            String splitter=CommonConst.spliterNoRev;
            int transactionLength=0;
            if(enumActivity.equals(EnumActivity.ENUM_Activity.REVISE)){
                acronim = customerBlanketOrder.getCode().split("[.]")[0]+".";
                transactionLength=AutoNumber.DEFAULT_TRANSACTION_LENGTH_2;
            }

            DetachedCriteria dc = DetachedCriteria.forClass(CustomerBlanketOrder.class)
                    .setProjection(Projections.max("code"))
                    .add(Restrictions.like("code","%" + acronim + "%" ));

            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            List list = criteria.list();

            String oldID = "";
            if(list != null){
                if (list.size() > 0)
                    if(list.get(0) != null){
                        if(enumActivity.equals(EnumActivity.ENUM_Activity.REVISE)){
                            oldID = list.get(0).toString();
                        }
                    }
            }
            return AutoNumber.generate_rev(enumActivity, acronim, oldID, transactionLength);
        }
        catch(HibernateException e){
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public String createCodeBo(EnumActivity.ENUM_Activity enumActivity, CustomerPurchaseOrder customerPurchaseOrder){
        try{           
            
            String acronim="";
            String splitter=CommonConst.spliterNoRev;
            int transactionLength=0;
            if(enumActivity.equals(EnumActivity.ENUM_Activity.NEW) || enumActivity.equals(EnumActivity.ENUM_Activity.CLONE)){
                acronim = "/BO/"+AutoNumber.getYear(customerPurchaseOrder.getTransactionDate(), true);
                transactionLength=AutoNumber.DEFAULT_TRANSACTION_LENGTH_4;
            }
           
            DetachedCriteria dc = DetachedCriteria.forClass(CustomerBlanketOrder.class)
                    .setProjection(Projections.max("code"))
                    .add(Restrictions.like("code","%" +acronim + "%" ));

            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            List list = criteria.list();

           String oldID = "";
            if(list != null){
                if (list.size() > 0)
                    if(list.get(0) != null){
                        if(enumActivity.equals(EnumActivity.ENUM_Activity.NEW)|| enumActivity.equals(EnumActivity.ENUM_Activity.CLONE)){
                            oldID = list.get(0).toString().split("["+splitter+"]",2)[0];
                        }
                        if(enumActivity.equals(EnumActivity.ENUM_Activity.REVISE)){
                            oldID = list.get(0).toString();
                        }
                    }
            }
            return AutoNumber.generate_revNew(enumActivity,transactionLength, acronim, oldID);
        }
        catch(HibernateException e){
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void save(EnumActivity.ENUM_Activity enumActivity,CustomerBlanketOrder customerBlanketOrder,
            List<CustomerBlanketOrderSalesQuotation> listCustomerBlanketOrderSalesQuotation, 
            List<CustomerBlanketOrderItemDetail> listCustomerBlanketOrderItemDetail,
            List<CustomerBlanketOrderAdditionalFee> listCustomerBlanketOrderAdditionalFee,
            List<CustomerBlanketOrderPaymentTerm> listCustomerBlanketOrderPaymentTerm,
            List<CustomerBlanketOrderItemDeliveryDate> listCustomerBlanketOrderItemDeliveryDate, String moduleCode) throws Exception {
        try {
            
            String headerCode=createCode(enumActivity,customerBlanketOrder);
            
            hbmSession.hSession.beginTransaction();
            
            customerBlanketOrder.setCode(headerCode);
            customerBlanketOrder.setClosingStatus("OPEN");
            customerBlanketOrder.setCustBONo(customerBlanketOrder.getCode().split("["+CommonConst.spliterNo+"]")[0]);
            customerBlanketOrder.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            customerBlanketOrder.setCreatedDate(new Date());
            
            hbmSession.hSession.save(customerBlanketOrder);
            
            
            if (!processDetail(EnumActivity.ENUM_Activity.NEW, 
                    customerBlanketOrder,listCustomerBlanketOrderSalesQuotation,listCustomerBlanketOrderItemDetail,
                    listCustomerBlanketOrderAdditionalFee,listCustomerBlanketOrderPaymentTerm,listCustomerBlanketOrderItemDeliveryDate)) {
                hbmSession.hTransaction.rollback();
            }
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    customerBlanketOrder.getCode(),EnumActivity.toString(enumActivity)));
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
  
    public void update(CustomerBlanketOrder customerBlanketOrder,
            List<CustomerBlanketOrderSalesQuotation> listCustomerBlanketOrderSalesQuotation, 
            List<CustomerBlanketOrderItemDetail> listCustomerBlanketOrderItemDetail,
            List<CustomerBlanketOrderAdditionalFee> listCustomerBlanketOrderAdditionalFee,
            List<CustomerBlanketOrderPaymentTerm> listCustomerBlanketOrderPaymentTerm,
            List<CustomerBlanketOrderItemDeliveryDate> listCustomerBlanketOrderItemDeliveryDate, String moduleCode) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
            
            customerBlanketOrder.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            customerBlanketOrder.setUpdatedDate(new Date());
                        
            hbmSession.hSession.update(customerBlanketOrder);
            
            if (!processDetail(EnumActivity.ENUM_Activity.UPDATE, 
                    customerBlanketOrder,listCustomerBlanketOrderSalesQuotation,listCustomerBlanketOrderItemDetail,
                    listCustomerBlanketOrderAdditionalFee,listCustomerBlanketOrderPaymentTerm,listCustomerBlanketOrderItemDeliveryDate)) {
                hbmSession.hTransaction.rollback();
            }
                        
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    customerBlanketOrder.getCode(),EnumActivity.toString(EnumActivity.ENUM_Activity.UPDATE)));
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
    
    public void revise(CustomerBlanketOrder customerBlanketOrder,
            List<CustomerBlanketOrderSalesQuotation> listCustomerBlanketOrderSalesQuotation, 
            List<CustomerBlanketOrderItemDetail> listCustomerBlanketOrderItemDetail,
            List<CustomerBlanketOrderAdditionalFee> listCustomerBlanketOrderAdditionalFee,
            List<CustomerBlanketOrderPaymentTerm> listCustomerBlanketOrderPaymentTerm,
            List<CustomerBlanketOrderItemDeliveryDate> listCustomerBlanketOrderItemDeliveryDate, String moduleCode) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
            
            hbmSession.hSession.beginTransaction();
            
            Boolean validStatus = false;
            
            String customerBlanketOrderCode=customerBlanketOrder.getRefCUSTBOCode();
            CustomerBlanketOrder customerBlanketOrderOld = get(customerBlanketOrderCode);
            customerBlanketOrderOld.setValidStatus(validStatus);
            hbmSession.hSession.update(customerBlanketOrderOld);
  
            hbmSession.hSession.flush();
            
            customerBlanketOrder.setRefCUSTBOCode(customerBlanketOrderOld.getCode());
            String headerCode=createCodeRevise(EnumActivity.ENUM_Activity.REVISE,customerBlanketOrder);
            customerBlanketOrder.setCode(headerCode);
            customerBlanketOrder.setRevision(customerBlanketOrder.getCode().substring(customerBlanketOrder.getCode().length()-2));
            
            hbmSession.hSession.save(customerBlanketOrder);
            
            if (!processDetail(EnumActivity.ENUM_Activity.UPDATE, 
                    customerBlanketOrder,listCustomerBlanketOrderSalesQuotation,listCustomerBlanketOrderItemDetail,
                    listCustomerBlanketOrderAdditionalFee,listCustomerBlanketOrderPaymentTerm,listCustomerBlanketOrderItemDeliveryDate)) {
                hbmSession.hTransaction.rollback();
            }
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode,
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    customerBlanketOrder.getCode(),EnumActivity.toString(EnumActivity.ENUM_Activity.REVISE)));
            hbmSession.hTransaction.commit();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();                      
        }
        catch (Exception e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();
            throw e;
        }
    }

    public void delete(CustomerBlanketOrder customerBlanketOrder, String moduleCode){
        try{
            hbmSession.hSession.beginTransaction();
            
            if (!processDetail(EnumActivity.ENUM_Activity.DELETE, customerBlanketOrder,null,null,null,null,null)) {
                hbmSession.hTransaction.rollback();
            }
            
            hbmSession.hSession.createQuery("DELETE FROM BlanketOrder "
                    + " WHERE code  = :prmCode")
                    .setParameter("prmCode", customerBlanketOrder.getCode())
                    .executeUpdate();
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.DELETE), 
                                                                    customerBlanketOrder.getCode(), EnumActivity.toString(EnumActivity.ENUM_Activity.DELETE)));
            
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
       
    private boolean processDetail(EnumActivity.ENUM_Activity enumActivity, CustomerBlanketOrder customerBlanketOrder,
            List<CustomerBlanketOrderSalesQuotation> listCustomerBlanketOrderSalesQuotation, 
            List<CustomerBlanketOrderItemDetail> listCustomerBlanketOrderItemDetail,
            List<CustomerBlanketOrderAdditionalFee> listCustomerBlanketOrderAdditionalFee,
            List<CustomerBlanketOrderPaymentTerm> listCustomerBlanketOrderPaymentTerm,
            List<CustomerBlanketOrderItemDeliveryDate> listCustomerBlanketOrderItemDeliveryDate){
        try{
            
            if(enumActivity.equals(EnumActivity.ENUM_Activity.UPDATE) || enumActivity.equals(EnumActivity.ENUM_Activity.DELETE)){
                hbmSession.hSession.createQuery("DELETE FROM "+CustomerBlanketOrderSalesQuotationField.BEAN_NAME+" WHERE "+CustomerBlanketOrderSalesQuotationField.HEADERCODE+" = :prmCode")
                    .setParameter("prmCode", customerBlanketOrder.getCode())    
                    .executeUpdate();
            
                hbmSession.hSession.createQuery("DELETE FROM "+CustomerBlanketOrderItemDetailField.BEAN_NAME+" WHERE "+CustomerBlanketOrderItemDetailField.HEADERCODE+" = :prmCode")
                        .setParameter("prmCode", customerBlanketOrder.getCode())    
                        .executeUpdate();

                hbmSession.hSession.createQuery("DELETE FROM "+CustomerBlanketOrderAdditionalFeeField.BEAN_NAME+" WHERE "+CustomerBlanketOrderAdditionalFeeField.HEADERCODE+" = :prmCode")
                        .setParameter("prmCode", customerBlanketOrder.getCode())    
                        .executeUpdate();

                hbmSession.hSession.createQuery("DELETE FROM "+CustomerBlanketOrderPaymentTermField.BEAN_NAME+" WHERE "+CustomerBlanketOrderPaymentTermField.HEADERCODE+" = :prmCode")
                        .setParameter("prmCode", customerBlanketOrder.getCode())    
                        .executeUpdate();

                hbmSession.hSession.createQuery("DELETE FROM "+CustomerBlanketOrderItemDeliveryDateField.BEAN_NAME+" WHERE "+CustomerBlanketOrderItemDeliveryDateField.HEADERCODE+" = :prmCode")
                        .setParameter("prmCode", customerBlanketOrder.getCode())    
                        .executeUpdate();
            }
            
            
            if(enumActivity.equals(EnumActivity.ENUM_Activity.UPDATE) || enumActivity.equals(EnumActivity.ENUM_Activity.NEW)){
                int q = 1;
                for(CustomerBlanketOrderSalesQuotation blanketOrderSalesQuotation : listCustomerBlanketOrderSalesQuotation){

                    String detailCode = customerBlanketOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(q),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    blanketOrderSalesQuotation.setCode(detailCode);
                    blanketOrderSalesQuotation.setHeaderCode(customerBlanketOrder.getCode());

                    blanketOrderSalesQuotation.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    blanketOrderSalesQuotation.setCreatedDate(new Date());

                    hbmSession.hSession.save(blanketOrderSalesQuotation);

                    q++;
                }

                int i = 1;
                for(CustomerBlanketOrderItemDetail blanketOrderItemDetail : listCustomerBlanketOrderItemDetail){

                    String detailCode = customerBlanketOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    blanketOrderItemDetail.setCode(detailCode);
                    blanketOrderItemDetail.setHeaderCode(customerBlanketOrder.getCode());

                    blanketOrderItemDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    blanketOrderItemDetail.setCreatedDate(new Date());

                    hbmSession.hSession.save(blanketOrderItemDetail);

                    i++;
                }

                int f = 1;
                for(CustomerBlanketOrderAdditionalFee blanketOrderAdditionalFee : listCustomerBlanketOrderAdditionalFee){

                    String detailCode = customerBlanketOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(f),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    blanketOrderAdditionalFee.setCode(detailCode);
                    blanketOrderAdditionalFee.setHeaderCode(customerBlanketOrder.getCode());

                    blanketOrderAdditionalFee.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    blanketOrderAdditionalFee.setCreatedDate(new Date());

                    hbmSession.hSession.save(blanketOrderAdditionalFee);

                    f++;
                }

                int p = 1;
                for(CustomerBlanketOrderPaymentTerm blanketOrderPaymentTerm : listCustomerBlanketOrderPaymentTerm){

                    String detailCode = customerBlanketOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(p),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    blanketOrderPaymentTerm.setCode(detailCode);
                    blanketOrderPaymentTerm.setHeaderCode(customerBlanketOrder.getCode());

                    blanketOrderPaymentTerm.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    blanketOrderPaymentTerm.setCreatedDate(new Date());

                    hbmSession.hSession.save(blanketOrderPaymentTerm);

                    p++;
                }

                int d = 1;
                for(CustomerBlanketOrderItemDeliveryDate blanketOrderItemDeliveryDate : listCustomerBlanketOrderItemDeliveryDate){

                    String detailCode = customerBlanketOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(d),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    blanketOrderItemDeliveryDate.setCode(detailCode);
                    blanketOrderItemDeliveryDate.setHeaderCode(customerBlanketOrder.getCode());

                    blanketOrderItemDeliveryDate.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    blanketOrderItemDeliveryDate.setCreatedDate(new Date());

                    hbmSession.hSession.save(blanketOrderItemDeliveryDate);

                    d++;
                }
            }
            
            return Boolean.TRUE;
        }catch(HibernateException e){
            e.printStackTrace();
            return Boolean.FALSE;
        }
    }
        
    public void closing(CustomerBlanketOrder blanketOrderClosing, String moduleCode) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
            
            CustomerBlanketOrder customerBlanketOrder=get(blanketOrderClosing.getCode());
            
            customerBlanketOrder.setClosingStatus("CLOSED");
            customerBlanketOrder.setClosingBy(BaseSession.loadProgramSession().getUserName());
            customerBlanketOrder.setClosingDate(new Date());
            
            hbmSession.hSession.createQuery("UPDATE CustomerPurchaseOrder SET "
                    + "ClosingStatus = :prmClosingStatus, "
                    + "ClosingDate = :prmClosingDate, "
                    + "ClosingBy = :prmClosingBy "
                    + "WHERE code = :prmCode")
                    .setParameter("prmClosingStatus",customerBlanketOrder.getClosingStatus())
                    .setParameter("prmClosingDate", customerBlanketOrder.getClosingDate())
                    .setParameter("prmClosingBy",customerBlanketOrder.getClosingBy())
                    .setParameter("prmCode", customerBlanketOrder.getCustomerPurchaseOrder().getCode())
                    .executeUpdate();
            hbmSession.hSession.flush();
                
            hbmSession.hSession.update(customerBlanketOrder);
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    blanketOrderClosing.getClosingStatus() , 
                                                                    blanketOrderClosing.getCode(),""));
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
}

    

