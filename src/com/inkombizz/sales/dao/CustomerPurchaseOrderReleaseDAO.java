
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
import com.inkombizz.sales.model.CustomerPurchaseOrder;
import com.inkombizz.sales.model.CustomerSalesOrder;
import com.inkombizz.sales.model.CustomerPurchaseOrderAdditionalFee;
import com.inkombizz.sales.model.CustomerPurchaseOrderAdditionalFeeField;
import com.inkombizz.sales.model.CustomerPurchaseOrderItemDeliveryDate;
import com.inkombizz.sales.model.CustomerPurchaseOrderItemDeliveryDateField;
import com.inkombizz.sales.model.CustomerPurchaseOrderItemDetail;
import com.inkombizz.sales.model.CustomerPurchaseOrderItemDetailField;
import com.inkombizz.sales.model.CustomerPurchaseOrderPaymentTerm;
import com.inkombizz.sales.model.CustomerPurchaseOrderPaymentTermField;
import com.inkombizz.sales.model.CustomerPurchaseOrderSalesQuotation;
import com.inkombizz.sales.model.CustomerPurchaseOrderSalesQuotationField;
import com.inkombizz.sales.model.CustomerSalesOrder;
import com.inkombizz.sales.model.CustomerSalesOrderAdditionalFee;
import com.inkombizz.sales.model.CustomerSalesOrderAdditionalFeeField;
import com.inkombizz.sales.model.CustomerSalesOrderItemDeliveryDate;
import com.inkombizz.sales.model.CustomerSalesOrderItemDeliveryDateField;
import com.inkombizz.sales.model.CustomerSalesOrderItemDetail;
import com.inkombizz.sales.model.CustomerSalesOrderItemDetailField;
import com.inkombizz.sales.model.CustomerSalesOrderPaymentTerm;
import com.inkombizz.sales.model.CustomerSalesOrderPaymentTermField;
import com.inkombizz.sales.model.CustomerSalesOrderSalesQuotation;
import com.inkombizz.sales.model.CustomerSalesOrderSalesQuotationField;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
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


public class CustomerPurchaseOrderReleaseDAO {
    private HBMSession hbmSession;
    
    public CustomerPurchaseOrderReleaseDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(CustomerPurchaseOrder customerPurchaseOrderRelease,String closingStatus, String validStatus) {
        try {
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(customerPurchaseOrderRelease.getTransactionFirstDate());
            String dateLast = DATE_FORMAT.format(customerPurchaseOrderRelease.getTransactionLastDate());
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "CALL usp_customer_purchase_order_release_list(:prmFlag,:prmCode,:prmCustomerCode,:prmCustomerName,"
                        + ":prmSalesPersonCode,:prmSalesPersonName,:prmRefNo,:prmRemark,:prmClosingStatus,:prmValidStatus,:prmFirstDate,:prmLastDate,0,0)")
                    
                .setParameter("prmFlag", "COUNT")
                .setParameter("prmCode", "%"+customerPurchaseOrderRelease.getCode()+"%")
                .setParameter("prmCustomerCode","%"+customerPurchaseOrderRelease.getCustomerCode()+"%")
                .setParameter("prmCustomerName","%"+customerPurchaseOrderRelease.getCustomerName()+"%")
                .setParameter("prmSalesPersonCode", "%"+customerPurchaseOrderRelease.getSalesPersonCode()+"%")
                .setParameter("prmSalesPersonName", "%"+customerPurchaseOrderRelease.getSalesPersonName()+"%")
                .setParameter("prmRefNo", "%"+customerPurchaseOrderRelease.getRefNo()+"%")
                .setParameter("prmRemark", "%"+customerPurchaseOrderRelease.getRemark()+"%")
                .setParameter("prmClosingStatus", "%"+closingStatus+"%")        
                .setParameter("prmValidStatus", validStatus)    
                .setParameter("prmFirstDate", customerPurchaseOrderRelease.getTransactionFirstDate())
                .setParameter("prmLastDate", customerPurchaseOrderRelease.getTransactionLastDate())
                .uniqueResult();
            return temp.intValue();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<CustomerPurchaseOrder> findData(CustomerPurchaseOrder customerPurchaseOrderRelease,String closingStatus, String validStatus, int from, int to) {
        try {
            
            List<CustomerPurchaseOrder> list = (List<CustomerPurchaseOrder>)hbmSession.hSession.createSQLQuery(
                    "CALL usp_customer_purchase_order_release_list(:prmFlag,:prmCode,:prmCustomerCode,:prmCustomerName,"
                        + ":prmSalesPersonCode,:prmSalesPersonName,:prmRefNo,:prmRemark,:prmClosingStatus,:prmValidStatus,:prmFirstDate,:prmLastDate,:prmLimitFrom,:prmLimitTo)")                       
                .addScalar("code", Hibernate.STRING)
                .addScalar("custPONo", Hibernate.STRING)
                .addScalar("customerPurchaseOrderBOCode", Hibernate.STRING)
                .addScalar("salesOrderCode", Hibernate.STRING)
                .addScalar("blanketOrderCode", Hibernate.STRING)
                .addScalar("revision", Hibernate.STRING)
                .addScalar("refCUSTPOCode", Hibernate.STRING) 
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("customerPurchaseOrderNo", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("customerCode", Hibernate.STRING)
                .addScalar("customerName", Hibernate.STRING)
                .addScalar("currencyCode", Hibernate.STRING)
                .addScalar("currencyName", Hibernate.STRING)
                .addScalar("endUserCode", Hibernate.STRING)
                .addScalar("endUserName", Hibernate.STRING)                                 
                .addScalar("partialShipmentStatus", Hibernate.STRING) 
                .addScalar("orderStatus", Hibernate.STRING) 
                .addScalar("retentionPercent", Hibernate.BIG_DECIMAL)    
                .addScalar("currencyCode", Hibernate.STRING)    
                .addScalar("currencyName", Hibernate.STRING)    
                .addScalar("salesPersonCode", Hibernate.STRING)    
                .addScalar("salesPersonName", Hibernate.STRING)    
                .addScalar("projectCode", Hibernate.STRING)     
                .addScalar("projectName", Hibernate.STRING)     
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("closingStatus", Hibernate.STRING)    
                .addScalar("validStatus", Hibernate.BOOLEAN)    
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)
                .addScalar("discountPercent", Hibernate.BIG_DECIMAL)
                .addScalar("discountAmount", Hibernate.BIG_DECIMAL)
                .addScalar("totalAdditionalFeeAmount", Hibernate.BIG_DECIMAL)
                .addScalar("taxBaseAmount", Hibernate.BIG_DECIMAL)
                .addScalar("vatPercent", Hibernate.BIG_DECIMAL)
                .addScalar("vatAmount", Hibernate.BIG_DECIMAL)
                .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                .setParameter("prmFlag", "LISTS")
                .setParameter("prmCode", "%"+customerPurchaseOrderRelease.getCode()+"%")
                .setParameter("prmCustomerCode","%"+customerPurchaseOrderRelease.getCustomerCode() +"%")
                .setParameter("prmCustomerName","%"+customerPurchaseOrderRelease.getCustomerName()+"%")
                .setParameter("prmSalesPersonCode", "%"+customerPurchaseOrderRelease.getSalesPersonCode()+"%")
                .setParameter("prmSalesPersonName", "%"+customerPurchaseOrderRelease.getSalesPersonName()+"%")
                .setParameter("prmRefNo", "%"+customerPurchaseOrderRelease.getRefNo()+"%")
                .setParameter("prmRemark", "%"+customerPurchaseOrderRelease.getRemark()+"%")
                .setParameter("prmClosingStatus", "%"+closingStatus+"%")    
                .setParameter("prmValidStatus", validStatus)    
                .setParameter("prmFirstDate", customerPurchaseOrderRelease.getTransactionFirstDate())
                .setParameter("prmLastDate", customerPurchaseOrderRelease.getTransactionLastDate())
                .setParameter("prmLimitFrom", from)
                .setParameter("prmLimitTo", to)
                .setResultTransformer(Transformers.aliasToBean(CustomerPurchaseOrder.class))
                .list(); 
                 
                return list;
        } catch (HibernateException e) {
            throw e;
        }
    }
//    
    public List<CustomerPurchaseOrderSalesQuotation> findDataSalesQuotation(String headerCode) {
        try {
            
            List<CustomerPurchaseOrderSalesQuotation> list = (List<CustomerPurchaseOrderSalesQuotation>)hbmSession.hSession.createSQLQuery(
                "SELECT " 
                + "sal_customer_purchase_order_jn_sales_quotation.SalesQuotationCode AS SalesQuotationCode, "
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
                    + "FROM sal_customer_purchase_order_jn_sales_quotation "
                + "INNER JOIN "
                    + "sal_sales_quotation ON sal_sales_quotation.Code = sal_customer_purchase_order_jn_sales_quotation.SalesQuotationCode "
                + "INNER JOIN "
                    + "mst_customer ON mst_customer.Code = sal_sales_quotation.CustomerCode "
                + "INNER JOIN "
                    + "mst_customer endUser ON sal_sales_quotation.EndUserCode = endUser.Code "
                + "WHERE sal_customer_purchase_order_jn_sales_quotation.HeaderCode=:prmHeaderCode"
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
                .addScalar("salesQuotationRemark", Hibernate.STRING)
                .addScalar("salesQuotationEndUserCode", Hibernate.STRING)
                .addScalar("salesQuotationEndUserName", Hibernate.STRING)
                .addScalar("salesQuotationSubject", Hibernate.STRING)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(CustomerPurchaseOrderSalesQuotation.class))
                .list(); 
                 
            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerPurchaseOrderItemDetail> findDataItemDetail(ArrayList arrSalesQuotationNo) {
        try {
            String strSalesQuotationNo=Arrays.toString(arrSalesQuotationNo.toArray());
            strSalesQuotationNo = strSalesQuotationNo.replaceAll("[\\[\\]]", "");
            strSalesQuotationNo = strSalesQuotationNo.replaceAll(",", "','");
            
            List<CustomerPurchaseOrderItemDetail> list = (List<CustomerPurchaseOrderItemDetail>)hbmSession.hSession.createSQLQuery(
                "SELECT "
                + " sal_customer_purchase_order_item_detail.SalesQuotationCode, "
                + " sal_customer_purchase_order_item_detail.CustomerPurchaseOrderSortNo AS customerPurchaseOrderSortNo, "
                
                + " sal_customer_purchase_order_item_detail.ItemFinishGoodsCode AS itemFinishGoodsCode, "
                + " mst_item_finish_goods.Remark AS itemFinishGoodsRemark, "
                + " sal_customer_purchase_order_item_detail.Code AS salesQuotationDetailCode, "
                + " sal_customer_purchase_order_item_detail.ItemAlias AS itemAlias, "
                + " sal_sales_quotation_detail.ValveTag, "
                + "sal_customer_purchase_order_item_detail.dataSheet, "
                + "sal_customer_purchase_order_item_detail.description, "        
                
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
                + " sal_customer_purchase_order_item_detail "
                + " INNER JOIN `mst_item_finish_goods` ON mst_item_finish_goods.`code` = sal_customer_purchase_order_item_detail.`ItemFinishGoodsCode` "
                + " INNER JOIN sal_sales_quotation_detail ON sal_sales_quotation_detail.Code = sal_customer_purchase_order_item_detail.SalesQuotationDetailCode "
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
                
                + " WHERE sal_customer_purchase_order_item_detail.HeaderCode IN('"+strSalesQuotationNo+"')  "
            )

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
                    
                .setResultTransformer(Transformers.aliasToBean(CustomerPurchaseOrderItemDetail.class))
                .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerPurchaseOrderItemDetail> findDataUpdateItemDetail(String headerCode) {
        try {
            
            List<CustomerPurchaseOrderItemDetail> list = (List<CustomerPurchaseOrderItemDetail>)hbmSession.hSession.createSQLQuery(
                "SELECT "
                + " sal_customer_purchase_order_item_detail.SalesQuotationCode, "
                + " sal_customer_purchase_order_item_detail.CustomerPurchaseOrderSortNo AS customerPurchaseOrderSortNo, "
                
                + " sal_customer_purchase_order_item_detail.ItemFinishGoodsCode AS itemFinishGoodsCode, "
                + " mst_item_finish_goods.Remark AS itemFinishGoodsRemark, "
                + " sal_sales_quotation_detail.Code AS salesQuotationDetailCode, "
                + " sal_customer_purchase_order_item_detail.ItemAlias AS itemAlias, "
                
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
                + " sal_customer_purchase_order_item_detail "
                + " INNER JOIN `mst_item_finish_goods` ON mst_item_finish_goods.`code` = sal_customer_purchase_order_item_detail.`ItemFinishGoodsCode` "
                + " INNER JOIN sal_sales_quotation_detail ON sal_sales_quotation_detail.Code = sal_customer_purchase_order_item_detail.SalesQuotationDetailCode "
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
                
                + " WHERE sal_customer_purchase_order_item_detail.HeaderCode =:prmHeaderCode "
            )

                .addScalar("salesQuotationDetailCode", Hibernate.STRING)
                .addScalar("salesQuotationCode", Hibernate.STRING)
                .addScalar("customerPurchaseOrderSortNo", Hibernate.BIG_DECIMAL)
                .addScalar("itemFinishGoodsCode", Hibernate.STRING)
                .addScalar("itemFinishGoodsRemark", Hibernate.STRING)
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
                .setResultTransformer(Transformers.aliasToBean(CustomerPurchaseOrderItemDetail.class))
                .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerPurchaseOrderItemDetail> findDataItemDetail(ArrayList arrSalesQuotationNo,CustomerPurchaseOrderItemDetail customerPurchaseOrderItemDetail) {
        try {
            
            String strSalesQuotationNo=Arrays.toString(arrSalesQuotationNo.toArray());
            strSalesQuotationNo = strSalesQuotationNo.replaceAll("[\\[\\]]", "");
            strSalesQuotationNo = strSalesQuotationNo.replaceAll(",", "','");
            
            List<CustomerPurchaseOrderItemDetail> list = (List<CustomerPurchaseOrderItemDetail>)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "	sal_customer_purchase_order_item_detail.SalesQuotationCode, " +
                "	sal_customer_purchase_order_item_detail.CustomerPurchaseOrderSortNo, " +
                "	sal_customer_purchase_order_item_detail.ItemFinishGoodsCode, " +
                "	mst_item_finish_goods.Name AS itemFinishGoodsName, " +
                "	sal_sales_quotation_detail.code AS salesQuotationDetailCode, " +
                "	sal_sales_quotation_detail.valveTypeCode, " +
                "	mst_valve_type.name AS valveTypeName, " +
                "	sal_sales_quotation_detail.ValveTag, " +
                "	sal_sales_quotation_detail.DataSheet, " +
                "	sal_sales_quotation_detail.bodyConstruction, " +
                "	sal_sales_quotation_detail.Description, " +
                "	sal_sales_quotation_detail.Type, " +
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
                "	sal_customer_purchase_order_item_detail.Quantity, " +
                "	sal_sales_quotation_detail.UnitPrice, " +
                "	sal_sales_quotation_detail.TotalAmount " +
                "FROM sal_customer_purchase_order_item_detail " +
                "INNER JOIN `mst_item_finish_goods` ON mst_item_finish_goods.`code`=sal_customer_purchase_order_item_detail.`ItemFinishGoodsCode` " +          
                "INNER JOIN sal_sales_quotation_detail ON " +
                "	sal_customer_purchase_order_item_detail.SalesQuotationCode=sal_sales_quotation_detail.HeaderCode " +
                "INNER JOIN `mst_valve_type` ON mst_valve_type.`code`=sal_sales_quotation_detail.ValveTypeCode " +            
                "WHERE sal_customer_purchase_order_item_detail.SalesQuotationCode IN('"+strSalesQuotationNo+"') " +
                "AND sal_customer_purchase_order_item_detail.SalesQuotationCode LIKE '%"+customerPurchaseOrderItemDetail.getSalesQuotationCode()+"%' " +
                "AND sal_customer_purchase_order_item_detail.ItemFinishGoodsCode LIKE '%"+customerPurchaseOrderItemDetail.getItemFinishGoodsCode() +"%' " +
                "ORDER BY sal_customer_purchase_order_item_detail.CustomerPurchaseOrderSortNo ASC")
                        
                .addScalar("salesQuotationCode", Hibernate.STRING)
                .addScalar("customerPurchaseOrderSortNo", Hibernate.BIG_DECIMAL)
                .addScalar("itemFinishGoodsCode", Hibernate.STRING)
                .addScalar("itemFinishGoodsName", Hibernate.STRING)
                .addScalar("salesQuotationDetailCode", Hibernate.STRING)
                .addScalar("valveTypeCode", Hibernate.STRING)
                .addScalar("valveTypeName", Hibernate.STRING)   
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
                .setResultTransformer(Transformers.aliasToBean(CustomerPurchaseOrderItemDetail.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerPurchaseOrderItemDetail> findDataSyncItemDetail(ArrayList arrSalesQuotationNo,CustomerPurchaseOrder customerPurchaseOrder) {
        try {
            
            String strSalesQuotationNo=Arrays.toString(arrSalesQuotationNo.toArray());
            strSalesQuotationNo = strSalesQuotationNo.replaceAll("[\\[\\]]", "");
            strSalesQuotationNo = strSalesQuotationNo.replaceAll(",", "','");
            
            List<CustomerPurchaseOrderItemDetail> list = (List<CustomerPurchaseOrderItemDetail>)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "	customer_purchase_order_item_detail.SalesQuotationCode, " +
                "	customer_purchase_order_item_detail.CustomerPurchaseOrderSortNo, " +
                "	customer_purchase_order_item_detail.ItemCode, " +
                "	customer_purchase_order_item_detail.ValveTag, " +
                "	customer_purchase_order_item_detail.DataSheet, " +
                "	customer_purchase_order_item_detail.Description, " +
                "	customer_purchase_order_item_detail.Type, " +
                "	customer_purchase_order_item_detail.Size, " +
                "	customer_purchase_order_item_detail.Rating, " +
                "	customer_purchase_order_item_detail.EndCon, " +
                "	customer_purchase_order_item_detail.Body, " +
                "	customer_purchase_order_item_detail.Ball, " +
                "	customer_purchase_order_item_detail.Seat, " +
                "	customer_purchase_order_item_detail.Stem, " +
                "	customer_purchase_order_item_detail.seatInsert, " +
                "	customer_purchase_order_item_detail.Seal, " +
                "	customer_purchase_order_item_detail.Bolting, " +
                "	customer_purchase_order_item_detail.SeatDesign, " +
                "	customer_purchase_order_item_detail.Oper, " +
                "	customer_purchase_order_item_detail.Note, " +
                "	customer_purchase_order_item_detail.Quantity - IFNULL(customer_blanket_order_item_detail.Quantity,0)AS Quantity, " +
                "	customer_purchase_order_item_detail.UnitPrice, " +
                "	ROUND((customer_purchase_order_item_detail.Quantity - IFNULL(customer_blanket_order_item_detail.Quantity,0)) * customer_purchase_order_item_detail.UnitPrice,2)AS TotalAmount " +
                "FROM( " +
                "	SELECT " +
                "		sal_customer_purchase_order_item_detail.SalesQuotationCode, " +
                "		sal_customer_purchase_order_item_detail.CustomerPurchaseOrderSortNo, " +
                "		sal_customer_purchase_order_item_detail.ItemCode, " +
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
                "		sal_customer_purchase_order_item_detail.Quantity, " +
                "		sal_sales_quotation_detail.UnitPrice, " +
                "		sal_sales_quotation_detail.TotalAmount  " +
                "	FROM sal_customer_purchase_order_item_detail  " +
                "	INNER JOIN sal_sales_quotation_detail  " +
                "	ON  sal_customer_purchase_order_item_detail.SalesQuotationCode=sal_sales_quotation_detail.HeaderCode   " +
                "		AND sal_customer_purchase_order_item_detail.ItemCode=sal_sales_quotation_detail.Item  " +
                "	WHERE sal_customer_purchase_order_item_detail.SalesQuotationCode IN('"+strSalesQuotationNo+"')  " +
                ")AS customer_purchase_order_item_detail " +
                "LEFT JOIN( " +
                "	SELECT " +
                "		sal_customer_purchase_order_item_detail.SalesQuotationCode, " +
                "		sal_customer_purchase_order_item_detail.ItemCode, " +
                "		SUM(sal_customer_purchase_order_item_detail.Quantity)AS Quantity " +
                "	FROM sal_customer_purchase_order_item_detail " +
                "	INNER JOIN sal_customer_blanket_order ON sal_customer_purchase_order_item_detail.HeaderCode=sal_customer_blanket_order.Code " +
                "	WHERE sal_customer_blanket_order.CustomerPurchaseOrderCode='"+customerPurchaseOrder.getCode()+"' " +
                "	GROUP BY sal_customer_purchase_order_item_detail.SalesQuotationCode,sal_customer_purchase_order_item_detail.ItemCode " +
                ")AS customer_blanket_order_item_detail  " +
                "ON customer_purchase_order_item_detail.SalesQuotationCode=customer_blanket_order_item_detail.SalesQuotationCode " +
                "	AND customer_purchase_order_item_detail.ItemCode=customer_blanket_order_item_detail.ItemCode " +
                "WHERE (customer_purchase_order_item_detail.Quantity-IFNULL(customer_blanket_order_item_detail.Quantity,0))>0")
                        
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
                .setResultTransformer(Transformers.aliasToBean(CustomerPurchaseOrderItemDetail.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerPurchaseOrderItemDetail> findDataItemDetailArray(ArrayList arrSalesQuotationCode, String headerCode) {
        try {
            
            String strSalesQuotationNo=Arrays.toString(arrSalesQuotationCode.toArray());
            strSalesQuotationNo = strSalesQuotationNo.replaceAll("[\\[\\]]", "");
            strSalesQuotationNo = strSalesQuotationNo.replaceAll(",", "','");
            List<CustomerPurchaseOrderItemDetail> list = (List<CustomerPurchaseOrderItemDetail>)hbmSession.hSession.createSQLQuery(
                "SELECT "
                + " sal_customer_purchase_order_item_detail.SalesQuotationCode, "
                + " sal_customer_purchase_order_item_detail.CustomerPurchaseOrderSortNo AS customerPurchaseOrderSortNo, "
                
                + " sal_customer_purchase_order_item_detail.ItemFinishGoodsCode AS itemFinishGoodsCode, "
                + " mst_item_finish_goods.Remark AS itemFinishGoodsRemark, "
                + " sal_customer_purchase_order_item_detail.Code, "
                + " sal_customer_purchase_order_item_detail.salesQuotationDetailCode, "
                + " sal_customer_purchase_order_item_detail.ItemAlias AS itemAlias, "
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
                + " sal_customer_purchase_order_item_detail "
                + " INNER JOIN `mst_item_finish_goods` ON mst_item_finish_goods.`code` = sal_customer_purchase_order_item_detail.`ItemFinishGoodsCode` "
                + " INNER JOIN sal_sales_quotation_detail ON sal_sales_quotation_detail.Code = sal_customer_purchase_order_item_detail.SalesQuotationDetailCode "
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
                
                + " WHERE sal_customer_purchase_order_item_detail.SalesQuotationCode IN ('"+strSalesQuotationNo+"')"
                + " AND sal_customer_purchase_order_item_detail.HeaderCode =:prmHeaderCode"    
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
                .setResultTransformer(Transformers.aliasToBean(CustomerPurchaseOrderItemDetail.class))
                .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerPurchaseOrderAdditionalFee> findDataAdditionalFee(String headerCode) {
        try {
            
            List<CustomerPurchaseOrderAdditionalFee> list = (List<CustomerPurchaseOrderAdditionalFee>)hbmSession.hSession.createSQLQuery(
                " SELECT " +
                "	sal_customer_purchase_order_additional_fee.Remark, " +
                "	sal_customer_purchase_order_additional_fee.Quantity, " +
                "	sal_customer_purchase_order_additional_fee.AdditionalFeeCode, " +
                "	mst_additional_fee.Name AS additionalFeeName, " +
                "	mst_additional_fee.SalesChartOfAccountCode AS coaCode, " +
                "	mst_chart_of_account.name AS coaName, " +
                "	sal_customer_purchase_order_additional_fee.UnitCode AS unitOfMeasureCode, " +
                "	sal_customer_purchase_order_additional_fee.Price, " +
                "	sal_customer_purchase_order_additional_fee.Total " +
                " FROM sal_customer_purchase_order_additional_fee " +
                " INNER JOIN  mst_additional_fee ON mst_additional_fee.Code = sal_customer_purchase_order_additional_fee.AdditionalFeeCode " +
                " INNER JOIN  mst_chart_of_account ON mst_chart_of_account.Code = mst_additional_fee.SalesChartOfAccountCode " +
                " WHERE sal_customer_purchase_order_additional_fee.HeaderCode=:prmHeaderCode")

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
                .setResultTransformer(Transformers.aliasToBean(CustomerPurchaseOrderAdditionalFee.class))
                .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerPurchaseOrderPaymentTerm> findDataPaymentTerm(String headerCode) {
        try {
            
            List<CustomerPurchaseOrderPaymentTerm> list = (List<CustomerPurchaseOrderPaymentTerm>)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "	sal_customer_purchase_order_payment_term.SortNo, " +
                "	sal_customer_purchase_order_payment_term.PaymentTermCode, " +
                        "mst_payment_term.Name AS paymentTermName, " +
                "	sal_customer_purchase_order_payment_term.Percentage, " +
                "	sal_customer_purchase_order_payment_term.Remark " +
                "FROM sal_customer_purchase_order_payment_term " +
                "INNER JOIN mst_payment_term ON sal_customer_purchase_order_payment_term.PaymentTermCode=mst_payment_term.Code " +
                "WHERE sal_customer_purchase_order_payment_term.HeaderCode=:prmHeaderCode")

                .addScalar("sortNo", Hibernate.BIG_DECIMAL)
                .addScalar("paymentTermCode", Hibernate.STRING)
                .addScalar("paymentTermName", Hibernate.STRING)
                .addScalar("percentage", Hibernate.BIG_DECIMAL)
                .addScalar("remark", Hibernate.STRING)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(CustomerPurchaseOrderPaymentTerm.class))
                .list(); 

            return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerPurchaseOrderItemDeliveryDate> findDataItemDeliveryDate(String headerCode) {
        try {
            
            List<CustomerPurchaseOrderItemDeliveryDate> list = (List<CustomerPurchaseOrderItemDeliveryDate>)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "	sal_customer_purchase_order_item_delivery_date.Code, " +
                "	sal_customer_purchase_order_item_delivery_date.ItemFinishGoodsCode AS itemFinishGoodsCode, " +
                "	mst_item_finish_goods.Remark AS itemFinishGoodsRemark, " +
                "	sal_customer_purchase_order_item_delivery_date.Quantity, " +
                "	sal_customer_purchase_order_item_delivery_date.DeliveryDate, " +
                "	sal_customer_purchase_order_item_delivery_date.SalesQuotationCode AS salesQuotationCode, " +
                "	sal_customer_purchase_order_item_detail.CustomerPurchaseOrderSortNo AS customerPurchaseOrderSortNo, " +
                "	sal_sales_quotation.RefNo " +
                "FROM sal_customer_purchase_order_item_delivery_date " +       
                "INNER JOIN sal_customer_purchase_order_item_detail ON sal_customer_purchase_order_item_delivery_date.Code = sal_customer_purchase_order_item_detail.Code " +       
                "INNER JOIN mst_item_finish_goods ON sal_customer_purchase_order_item_delivery_date.ItemFinishGoodsCode = mst_item_finish_goods.Code " +             
                "INNER JOIN sal_sales_quotation ON sal_sales_quotation.Code = sal_customer_purchase_order_item_delivery_date.SalesQuotationCode " +             
                "WHERE sal_customer_purchase_order_item_delivery_date.HeaderCode=:prmHeaderCode "+
                "ORDER BY sal_customer_purchase_order_item_delivery_date.Code")

                .addScalar("itemFinishGoodsCode", Hibernate.STRING)
                .addScalar("itemFinishGoodsRemark", Hibernate.STRING)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)
                .addScalar("customerPurchaseOrderSortNo", Hibernate.BIG_DECIMAL)
                .addScalar("deliveryDate", Hibernate.DATE)
                .addScalar("salesQuotationCode", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(CustomerPurchaseOrderItemDeliveryDate.class))
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
    
    public CustomerPurchaseOrder get(String code) {
        try {
               return (CustomerPurchaseOrder) hbmSession.hSession.get(CustomerPurchaseOrder.class, code);
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public CustomerPurchaseOrder findDataGet(String code){
        try {
            CustomerPurchaseOrder customerPurchaseOrderRelease = (CustomerPurchaseOrder)hbmSession.hSession.createSQLQuery(
                    "SELECT " +
                    "sal_customer_purchase_order.`Code`, " +
                    "sal_customer_purchase_order.`CUSTPONo`, " +
                    "sal_customer_purchase_order.`Revision`, " +
                    "sal_customer_purchase_order.`RefCUSTPOCode`, " +
                    "sal_customer_purchase_order.`TransactionDate`, " +
                    "sal_customer_purchase_order.`CustomerPurchaseOrderNo`, " +
                    "sal_customer_purchase_order.`CustomerCode`, " +
                    "mst_customer.Name AS CustomerName, " +
                    "sal_customer_purchase_order.`EndUserCode`, " +
                    "EndUser.`Name` AS EndUserName, " +
                    "sal_customer_purchase_order.`PartialShipmentStatus`, " +
                    "sal_customer_purchase_order.`RetentionPercent`, " +
                    "sal_customer_purchase_order.`CurrencyCode`, " +
                    "mst_currency.name AS `CurrencyName`, " +
                    "sal_customer_purchase_order.`SalesPersonCode`, " +
                    "mst_sales_person.`Name` AS SalesPersonName, " +
                    "sal_customer_purchase_order.`ProjectCode`, " +
                    "mst_project.`Name` AS ProjectName, " +
                    "sal_customer_purchase_order.`RefNo`, " +
                    "sal_customer_purchase_order.`Remark`, " +
                    "sal_customer_purchase_order.`TotalTransactionAmount`, " +
                    "sal_customer_purchase_order.`DiscountPercent`, " +
                    "sal_customer_purchase_order.`DiscountAmount`, " +
                    "(SELECT fn_getAdditionalFee(sal_customer_purchase_order.`Code`))AS TotalAdditionalFeeAmount, " +
                    "sal_customer_purchase_order.`TaxBaseAmount`, " +
                    "sal_customer_purchase_order.`Vatpercent`, " +
                    "sal_customer_purchase_order.`Vatamount`, " +
                    "sal_customer_purchase_order.`GrandTotalAmount` " +
                    "FROM sal_customer_purchase_order " +
                    "INNER JOIN mst_customer ON sal_customer_purchase_order.CustomerCode=mst_customer.Code " +
                    "INNER JOIN `mst_customer` EndUser ON sal_customer_purchase_order.`EndUserCode`=EndUser.`Code` " +
                    "INNER JOIN mst_sales_person ON sal_customer_purchase_order.SalesPersonCode=mst_sales_person.Code " +
                    "INNER JOIN `mst_project` ON sal_customer_purchase_order.`ProjectCode`=mst_project.`Code` " +
                    "INNER JOIN mst_currency ON sal_customer_purchase_order.`CurrencyCode`=mst_currency.Code "+
                    "WHERE sal_customer_purchase_order.ValidStatus=1 " +
                    "AND sal_customer_purchase_order.Code LIKE ='"+code+"'" )
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("custPONo", Hibernate.STRING)
                .addScalar("revision", Hibernate.STRING)
                .addScalar("refCUSTPOCode", Hibernate.STRING) 
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("customerPurchaseOrderNo", Hibernate.STRING)
                .addScalar("customerCode", Hibernate.STRING)
                .addScalar("customerName", Hibernate.STRING)
                .addScalar("endUserCode", Hibernate.STRING)
                .addScalar("endUserName", Hibernate.STRING)                                 
                .addScalar("partialShipmentStatus", Hibernate.STRING) 
                .addScalar("retentionPercent", Hibernate.BIG_DECIMAL)    
                .addScalar("currencyCode", Hibernate.STRING)    
                .addScalar("currencyName", Hibernate.STRING)    
                .addScalar("salesPersonCode", Hibernate.STRING)    
                .addScalar("salesPersonName", Hibernate.STRING)    
                .addScalar("projectCode", Hibernate.STRING)     
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
                .setResultTransformer(Transformers.aliasToBean(CustomerPurchaseOrder.class))
                .uniqueResult(); 
                 
                return customerPurchaseOrderRelease;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerPurchaseOrderSalesQuotation> findGetData(String code){
        try {
            List<CustomerPurchaseOrderSalesQuotation> list = (List<CustomerPurchaseOrderSalesQuotation>)hbmSession.hSession.createSQLQuery(
                    "SELECT " +
                    "sal_customer_purchase_order_jn_sales_quotation.HeaderCode AS Code, "+
                    "sal_customer_purchase_order_jn_sales_quotation.SalesQuotationCode, "+
                    "sal_sales_quotation.TransactionDate, "+
                    "sal_sales_quotation.Subject AS SalesQuotationSubject "+
                    "FROM sal_customer_purchase_order " +
                    "INNER JOIN sal_customer_purchase_order_jn_sales_quotation ON sal_customer_purchase_order_jn_sales_quotation.HeaderCode = sal_customer_purchase_order.Code " +
                    "INNER JOIN sal_sales_quotation ON sal_customer_purchase_order_jn_sales_quotation.SalesQuotationCode = sal_sales_quotation.Code " +
                    "WHERE sal_customer_purchase_order_jn_sales_quotation.HeaderCode = '"+code+"'")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("salesQuotationCode", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("salesQuotationSubject", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(CustomerPurchaseOrderSalesQuotation.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public CustomerPurchaseOrder totalAdditionalFeeAmount(String headerCode){
       try {   
            CustomerPurchaseOrder customerPurchaseOrder = (CustomerPurchaseOrder)hbmSession.hSession.createSQLQuery(
                "SELECT " +
                "	sal_customer_purchase_order.TotalTransactionAmount, " +
                "	sal_customer_purchase_order.DiscountPercent, " +
                "	sal_customer_purchase_order.DiscountAmount, " +
                "	fn_getAdditionalFee(sal_customer_purchase_order.Code,'POC') AS totalAdditionalFeeAmount, " +
                "	sal_customer_purchase_order.TaxBaseAmount, " +
                "	sal_customer_purchase_order.Vatpercent, " +
                "	sal_customer_purchase_order.Vatamount, " +
                "	sal_customer_purchase_order.GrandTotalAmount " +
                "FROM sal_customer_purchase_order " +
                "WHERE sal_customer_purchase_order.Code=:prmHeaderCode")
                    
                .addScalar("totalTransactionAmount", Hibernate.BIG_DECIMAL)
                .addScalar("discountPercent", Hibernate.BIG_DECIMAL)
                .addScalar("discountAmount", Hibernate.BIG_DECIMAL)
                .addScalar("totalAdditionalFeeAmount", Hibernate.BIG_DECIMAL)
                .addScalar("taxBaseAmount", Hibernate.BIG_DECIMAL)
                .addScalar("vatPercent", Hibernate.BIG_DECIMAL)
                .addScalar("vatAmount", Hibernate.BIG_DECIMAL)
                .addScalar("grandTotalAmount", Hibernate.BIG_DECIMAL)
                .setParameter("prmHeaderCode", headerCode)
                .setResultTransformer(Transformers.aliasToBean(CustomerPurchaseOrder.class))
                .uniqueResult(); 
                 
                return customerPurchaseOrder;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public String createCode(EnumActivity.ENUM_Activity enumActivity,CustomerPurchaseOrder customerPurchaseOrderRelease){
        try{
            String acronim="";
            String splitter=CommonConst.spliterNoRev;
            int transactionLength=0;
            if(enumActivity.equals(EnumActivity.ENUM_Activity.NEW) || enumActivity.equals(EnumActivity.ENUM_Activity.CLONE)){
                acronim = customerPurchaseOrderRelease.getBranch().getCode()+"/"+EnumTransactionType.ENUM_TransactionType.PCO.toString()+"/"+AutoNumber.formatingDate(customerPurchaseOrderRelease.getTransactionDate(), true, true, false);
                transactionLength=AutoNumber.DEFAULT_TRANSACTION_LENGTH_4;
            }
            
            if(enumActivity.equals(EnumActivity.ENUM_Activity.REVISE)){
                acronim = customerPurchaseOrderRelease.getCustPONo() + splitter;
                transactionLength=AutoNumber.DEFAULT_TRANSACTION_LENGTH_2;
            }

            DetachedCriteria dc = DetachedCriteria.forClass(CustomerPurchaseOrder.class)
                    .setProjection(Projections.max("code"))
                    .add(Restrictions.like("code",acronim + "%" ));

            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            List list = criteria.list();

           String oldID = "";
            if(list != null){
                if (list.size() > 0)
                    if(list.get(0) != null){
                        if(enumActivity.equals(EnumActivity.ENUM_Activity.NEW)|| enumActivity.equals(EnumActivity.ENUM_Activity.CLONE)){
                            oldID = list.get(0).toString().split(splitter)[0];
                        }
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
    
    public void save(EnumActivity.ENUM_Activity enumActivity,CustomerPurchaseOrder customerPurchaseOrderRelease,
            List<CustomerPurchaseOrderSalesQuotation> listCustomerPurchaseOrderSalesQuotation, 
            List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderItemDetail,
            List<CustomerPurchaseOrderAdditionalFee> listCustomerPurchaseOrderAdditionalFee,
            List<CustomerPurchaseOrderPaymentTerm> listCustomerPurchaseOrderPaymentTerm,
            List<CustomerPurchaseOrderItemDeliveryDate> listCustomerPurchaseOrderItemDeliveryDate, String moduleCode) throws Exception {
            CustomerSalesOrder salesOrder = new CustomerSalesOrder();
        try {
            
            String headerCode=createCode(enumActivity,customerPurchaseOrderRelease);
            
            hbmSession.hSession.beginTransaction();
            
            customerPurchaseOrderRelease.setCode(headerCode);
            String[] custPONo=customerPurchaseOrderRelease.getCode().split("_REV.");
            String custPONo1 = custPONo[0];
            customerPurchaseOrderRelease.setCustPONo(custPONo1);
            customerPurchaseOrderRelease.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            customerPurchaseOrderRelease.setCreatedDate(new Date());
            
            hbmSession.hSession.save(customerPurchaseOrderRelease);
//            salesOrder = customerPurchaseOrder;
            
            if (!processDetail(EnumActivity.ENUM_Activity.NEW, 
                    customerPurchaseOrderRelease,listCustomerPurchaseOrderSalesQuotation,listCustomerPurchaseOrderItemDetail,
                    listCustomerPurchaseOrderAdditionalFee,listCustomerPurchaseOrderPaymentTerm,listCustomerPurchaseOrderItemDeliveryDate)) {
                hbmSession.hTransaction.rollback();
            }
            
            if (!saveSalesOrderHeader(EnumActivity.ENUM_Activity.NEW, 
                    customerPurchaseOrderRelease,listCustomerPurchaseOrderSalesQuotation,listCustomerPurchaseOrderItemDetail,
                    listCustomerPurchaseOrderAdditionalFee,listCustomerPurchaseOrderPaymentTerm,
                    listCustomerPurchaseOrderItemDeliveryDate,moduleCode)) {
                hbmSession.hTransaction.rollback();
            }


            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    customerPurchaseOrderRelease.getCode(),EnumActivity.toString(enumActivity)));
            
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
  
    public void update(CustomerPurchaseOrder customerPurchaseOrder,
            List<CustomerPurchaseOrderSalesQuotation> listCustomerPurchaseOrderSalesQuotation, 
            List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderItemDetail,
            List<CustomerPurchaseOrderAdditionalFee> listCustomerPurchaseOrderAdditionalFee,
            List<CustomerPurchaseOrderPaymentTerm> listCustomerPurchaseOrderPaymentTerm,
            List<CustomerPurchaseOrderItemDeliveryDate> listCustomerPurchaseOrderItemDeliveryDate, String moduleCode) throws Exception {
        try {
            
            hbmSession.hSession.beginTransaction();
            
            customerPurchaseOrder.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            customerPurchaseOrder.setUpdatedDate(new Date());
                        
            hbmSession.hSession.update(customerPurchaseOrder);
            
            if (!processDetail(EnumActivity.ENUM_Activity.UPDATE, 
                    customerPurchaseOrder,listCustomerPurchaseOrderSalesQuotation,listCustomerPurchaseOrderItemDetail,
                    listCustomerPurchaseOrderAdditionalFee,listCustomerPurchaseOrderPaymentTerm,listCustomerPurchaseOrderItemDeliveryDate)) {
                hbmSession.hTransaction.rollback();
            }
            
            if (!updateSalesOrderHeader(EnumActivity.ENUM_Activity.NEW, 
                    customerPurchaseOrder,listCustomerPurchaseOrderSalesQuotation,listCustomerPurchaseOrderItemDetail,
                    listCustomerPurchaseOrderAdditionalFee,listCustomerPurchaseOrderPaymentTerm,
                    listCustomerPurchaseOrderItemDeliveryDate,moduleCode)) {
                hbmSession.hTransaction.rollback();
            }
                        
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    customerPurchaseOrder.getCode(),EnumActivity.toString(EnumActivity.ENUM_Activity.UPDATE)));
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
    
    public void revise(CustomerPurchaseOrder customerPurchaseOrderRelease,
            List<CustomerPurchaseOrderSalesQuotation> listCustomerPurchaseOrderSalesQuotation, 
            List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderItemDetail,
            List<CustomerPurchaseOrderAdditionalFee> listCustomerPurchaseOrderAdditionalFee,
            List<CustomerPurchaseOrderPaymentTerm> listCustomerPurchaseOrderPaymentTerm,
            List<CustomerPurchaseOrderItemDeliveryDate> listCustomerPurchaseOrderItemDeliveryDate, String moduleCode) throws Exception {
        try {
            hbmSession.hSession.beginTransaction();
            
            String oldCustomerPurchaseOderCode=customerPurchaseOrderRelease.getRefCUSTPOCode();
            CustomerPurchaseOrder customerPurchaseOrderOld=get(oldCustomerPurchaseOderCode);
            customerPurchaseOrderOld.setValidStatus(false);
            hbmSession.hSession.update(customerPurchaseOrderOld);
  
            hbmSession.hSession.flush();
            
            customerPurchaseOrderRelease.setRefCUSTPOCode(customerPurchaseOrderOld.getCode());
            String headerCode=createCode(EnumActivity.ENUM_Activity.REVISE, customerPurchaseOrderRelease);
            customerPurchaseOrderRelease.setCode(headerCode);
            customerPurchaseOrderRelease.setRevision(customerPurchaseOrderRelease.getCode().substring(customerPurchaseOrderRelease.getCode().length()-2));
            
            hbmSession.hSession.save(customerPurchaseOrderRelease);
            
            CustomerSalesOrderDAO salesOrderDAO = new CustomerSalesOrderDAO(hbmSession);
            CustomerSalesOrder salesOrderNew = new CustomerSalesOrder();
            CustomerSalesOrder salesOrder = salesOrderDAO.getFromWoForRevise(oldCustomerPurchaseOderCode);
            
            String oldSalesOrder = salesOrder.getCode();
            CustomerSalesOrder salesOrderOld = salesOrderDAO.get(oldSalesOrder);
            salesOrderOld.setValidStatus(false);
            hbmSession.hSession.update(salesOrderOld);
            
            hbmSession.hSession.flush();
            
            salesOrder.setRefCUSTSOCode(salesOrderOld.getCode());
            
            String headerCodeSo = salesOrderDAO.createCodeRevise(EnumActivity.ENUM_Activity.REVISE, salesOrderOld);
            salesOrderNew.setCode(headerCodeSo);
            salesOrderNew.setRefCUSTSOCode(salesOrderOld.getCode());
            salesOrderNew.setRevision(salesOrderNew.getCode().substring(salesOrderNew.getCode().length()-2));
            salesOrderNew.setCustomerBlanketOrder(salesOrderOld.getCustomerBlanketOrder());
            
            String custSoNoRevise = salesOrder.getCode().split("["+CommonConst.spliterNoRev+"]")[0];
            salesOrderNew.setCustSONo(custSoNoRevise);
            salesOrderNew.setApprovalStatus("PENDING");
            salesOrderNew.setClosingStatus("OPEN");
            
            salesOrderNew.setTransactionDate(customerPurchaseOrderRelease.getTransactionDate());
            salesOrderNew.setRequestDeliveryDate(customerPurchaseOrderRelease.getTransactionDate());
            salesOrderNew.setExpiredDate(customerPurchaseOrderRelease.getTransactionDate());
            
            salesOrderNew.setRefNo(customerPurchaseOrderRelease.getRefNo());
            salesOrderNew.setRemark(customerPurchaseOrderRelease.getRemark());
            
            salesOrderNew.setTotalTransactionAmount(customerPurchaseOrderRelease.getTotalTransactionAmount());
            salesOrderNew.setDiscountPercent(customerPurchaseOrderRelease.getDiscountPercent());
            salesOrderNew.setDiscountAmount(customerPurchaseOrderRelease.getDiscountAmount());
            salesOrderNew.setTaxBaseAmount(customerPurchaseOrderRelease.getTaxBaseAmount());
            salesOrderNew.setVatPercent(customerPurchaseOrderRelease.getVatPercent());
            salesOrderNew.setVatAmount(customerPurchaseOrderRelease.getVatAmount());
            salesOrderNew.setGrandTotalAmount(customerPurchaseOrderRelease.getGrandTotalAmount());

            salesOrderNew.setBranch(customerPurchaseOrderRelease.getBranch());
            salesOrderNew.setCustomer(customerPurchaseOrderRelease.getCustomer());
            salesOrderNew.setEndUser(customerPurchaseOrderRelease.getEndUser());
            salesOrderNew.setCurrency(customerPurchaseOrderRelease.getCurrency());
            salesOrderNew.setSalesPerson(customerPurchaseOrderRelease.getSalesPerson());
            salesOrderNew.setProject(customerPurchaseOrderRelease.getProject());
            salesOrderNew.setCustomerPurchaseOrder(customerPurchaseOrderRelease);
            salesOrderNew.setOrderType(customerPurchaseOrderRelease.getPurchaseOrderType());
            
            salesOrderNew.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            salesOrderNew.setCreatedDate(new Date());
            hbmSession.hSession.flush();
            hbmSession.hSession.save(salesOrderNew);
                        
            if (!processDetail(EnumActivity.ENUM_Activity.UPDATE, 
                    customerPurchaseOrderRelease,listCustomerPurchaseOrderSalesQuotation,listCustomerPurchaseOrderItemDetail,
                    listCustomerPurchaseOrderAdditionalFee,listCustomerPurchaseOrderPaymentTerm,listCustomerPurchaseOrderItemDeliveryDate)) {
                hbmSession.hTransaction.rollback();
            }
             if (!processReviseDetailSalesOrder(EnumActivity.ENUM_Activity.UPDATE, 
                    salesOrderNew,customerPurchaseOrderRelease,listCustomerPurchaseOrderSalesQuotation,listCustomerPurchaseOrderItemDetail,
                    listCustomerPurchaseOrderAdditionalFee,listCustomerPurchaseOrderPaymentTerm,listCustomerPurchaseOrderItemDeliveryDate)) {
                hbmSession.hTransaction.rollback();
            }
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode,
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    customerPurchaseOrderRelease.getCode(),EnumActivity.toString(EnumActivity.ENUM_Activity.REVISE)));
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

     public void delete(CustomerPurchaseOrder customerPurchaseOrderRelease, String moduleCode){
        try{
            hbmSession.hSession.beginTransaction();
            
            if (!processDetail(EnumActivity.ENUM_Activity.DELETE, customerPurchaseOrderRelease,null,null,null,null,null)) {
                hbmSession.hTransaction.rollback();
            }
            
            hbmSession.hSession.createQuery("DELETE FROM CustomerPurchaseOrder "
                    + " WHERE code  = :prmCode")
                    .setParameter("prmCode", customerPurchaseOrderRelease.getCode())
                    .executeUpdate();
            
            CustomerSalesOrderDAO salesOrderDAO = new CustomerSalesOrderDAO(hbmSession);
            CustomerSalesOrder salesOrderUpdate = salesOrderDAO.getFromWoForRevise(customerPurchaseOrderRelease.getCode());
            
            String oldSalesOrder = salesOrderUpdate.getCode();
            CustomerSalesOrder salesOrderOld = salesOrderDAO.getSalesOrderUpdate(oldSalesOrder);
            
            if (!processDetailSalesOrder(EnumActivity.ENUM_Activity.DELETE, salesOrderOld,null,null,null,null,null)) {
                hbmSession.hTransaction.rollback();
            }
            
            hbmSession.hSession.createQuery("DELETE FROM CustomerSalesOrder "
                    + " WHERE code  = :prmCode")
                    .setParameter("prmCode", salesOrderOld.getCode())
                    .executeUpdate();
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.DELETE), 
                                                                    customerPurchaseOrderRelease.getCode(), EnumActivity.toString(EnumActivity.ENUM_Activity.DELETE)));
            
            hbmSession.hTransaction.commit();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();
            
        }catch(HibernateException e){
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();
            throw e;
        }
    }
       
    private boolean processDetail(EnumActivity.ENUM_Activity enumActivity, CustomerPurchaseOrder customerPurchaseOrderRelease,
            List<CustomerPurchaseOrderSalesQuotation> listCustomerPurchaseOrderSalesQuotation, 
            List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderItemDetail,
            List<CustomerPurchaseOrderAdditionalFee> listCustomerPurchaseOrderAdditionalFee,
            List<CustomerPurchaseOrderPaymentTerm> listCustomerPurchaseOrderPaymentTerm,
            List<CustomerPurchaseOrderItemDeliveryDate> listCustomerPurchaseOrderItemDeliveryDate){
        try{
            
            if(enumActivity.equals(EnumActivity.ENUM_Activity.UPDATE) || enumActivity.equals(EnumActivity.ENUM_Activity.DELETE)){
                hbmSession.hSession.createQuery("DELETE FROM "+CustomerPurchaseOrderSalesQuotationField.BEAN_NAME+" WHERE "+CustomerPurchaseOrderSalesQuotationField.HEADERCODE+" = :prmCode")
                    .setParameter("prmCode", customerPurchaseOrderRelease.getCode())    
                    .executeUpdate();
            
                hbmSession.hSession.createQuery("DELETE FROM "+CustomerPurchaseOrderItemDetailField.BEAN_NAME+" WHERE "+CustomerPurchaseOrderItemDetailField.HEADERCODE+" = :prmCode")
                        .setParameter("prmCode", customerPurchaseOrderRelease.getCode())    
                        .executeUpdate();

                hbmSession.hSession.createQuery("DELETE FROM "+CustomerPurchaseOrderAdditionalFeeField.BEAN_NAME+" WHERE "+CustomerPurchaseOrderAdditionalFeeField.HEADERCODE+" = :prmCode")
                        .setParameter("prmCode", customerPurchaseOrderRelease.getCode())    
                        .executeUpdate();

                hbmSession.hSession.createQuery("DELETE FROM "+CustomerPurchaseOrderPaymentTermField.BEAN_NAME+" WHERE "+CustomerPurchaseOrderPaymentTermField.HEADERCODE+" = :prmCode")
                        .setParameter("prmCode", customerPurchaseOrderRelease.getCode())    
                        .executeUpdate();

                hbmSession.hSession.createQuery("DELETE FROM "+CustomerPurchaseOrderItemDeliveryDateField.BEAN_NAME+" WHERE "+CustomerPurchaseOrderItemDeliveryDateField.HEADERCODE+" = :prmCode")
                        .setParameter("prmCode", customerPurchaseOrderRelease.getCode())    
                        .executeUpdate();
            }
            
            
            if(enumActivity.equals(EnumActivity.ENUM_Activity.UPDATE) || enumActivity.equals(EnumActivity.ENUM_Activity.NEW)){
                int q = 1;
                for(CustomerPurchaseOrderSalesQuotation customerPurchaseOrderSalesQuotation : listCustomerPurchaseOrderSalesQuotation){

                    String detailCode = customerPurchaseOrderRelease.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(q),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    customerPurchaseOrderSalesQuotation.setCode(detailCode);
                    customerPurchaseOrderSalesQuotation.setHeaderCode(customerPurchaseOrderRelease.getCode());

                    customerPurchaseOrderSalesQuotation.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    customerPurchaseOrderSalesQuotation.setCreatedDate(new Date());

                    hbmSession.hSession.save(customerPurchaseOrderSalesQuotation);

                    q++;
                }

                int i = 1;
                for(CustomerPurchaseOrderItemDetail customerPurchaseOrderItemDetail : listCustomerPurchaseOrderItemDetail){

                    String detailCode = customerPurchaseOrderRelease.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    customerPurchaseOrderItemDetail.setCode(detailCode);
                    customerPurchaseOrderItemDetail.setHeaderCode(customerPurchaseOrderRelease.getCode());

                    customerPurchaseOrderItemDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    customerPurchaseOrderItemDetail.setCreatedDate(new Date());

                    hbmSession.hSession.save(customerPurchaseOrderItemDetail);

                    i++;
                }

                int f = 1;
                for(CustomerPurchaseOrderAdditionalFee customerPurchaseOrderAdditionalFee : listCustomerPurchaseOrderAdditionalFee){

                    String detailCode = customerPurchaseOrderRelease.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(f),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    customerPurchaseOrderAdditionalFee.setCode(detailCode);
                    customerPurchaseOrderAdditionalFee.setHeaderCode(customerPurchaseOrderRelease.getCode());

                    customerPurchaseOrderAdditionalFee.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    customerPurchaseOrderAdditionalFee.setCreatedDate(new Date());

                    hbmSession.hSession.save(customerPurchaseOrderAdditionalFee);

                    f++;
                }

                int p = 1;
                for(CustomerPurchaseOrderPaymentTerm customerPurchaseOrderPaymentTerm : listCustomerPurchaseOrderPaymentTerm){

                    String detailCode = customerPurchaseOrderRelease.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(p),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    customerPurchaseOrderPaymentTerm.setCode(detailCode);
                    customerPurchaseOrderPaymentTerm.setHeaderCode(customerPurchaseOrderRelease.getCode());

                    customerPurchaseOrderPaymentTerm.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    customerPurchaseOrderPaymentTerm.setCreatedDate(new Date());

                    hbmSession.hSession.save(customerPurchaseOrderPaymentTerm);

                    p++;
                }

                int d = 1;
                for(CustomerPurchaseOrderItemDeliveryDate customerPurchaseOrderItemDeliveryDate : listCustomerPurchaseOrderItemDeliveryDate){

                    String detailCode = customerPurchaseOrderRelease.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(d),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    customerPurchaseOrderItemDeliveryDate.setCode(detailCode);
                    customerPurchaseOrderItemDeliveryDate.setHeaderCode(customerPurchaseOrderRelease.getCode());

                    customerPurchaseOrderItemDeliveryDate.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    customerPurchaseOrderItemDeliveryDate.setCreatedDate(new Date());

                    hbmSession.hSession.save(customerPurchaseOrderItemDeliveryDate);

                    d++;
                }
            }
            
            return Boolean.TRUE;
        }catch(HibernateException e){
            e.printStackTrace();
            return Boolean.FALSE;
        }
    }
        
    private boolean saveSalesOrderHeader(EnumActivity.ENUM_Activity enumActivity,CustomerPurchaseOrder customerPurchaseOrderRelease,
            List<CustomerPurchaseOrderSalesQuotation> listCustomerPurchaseOrderSalesQuotation, 
            List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderItemDetail,
            List<CustomerPurchaseOrderAdditionalFee> listCustomerPurchaseOrderAdditionalFee,
            List<CustomerPurchaseOrderPaymentTerm> listCustomerPurchaseOrderPaymentTerm,
            List<CustomerPurchaseOrderItemDeliveryDate> listCustomerPurchaseOrderItemDeliveryDate, String moduleCode) throws Exception{

            CustomerSalesOrder salesOrder = new CustomerSalesOrder();
            
        try{
        
            CustomerSalesOrderDAO salesOrderDAO = new CustomerSalesOrderDAO(hbmSession);
            
            String headerCode= salesOrderDAO.createCodeSo(enumActivity, customerPurchaseOrderRelease);
            
            salesOrder.setCode(headerCode);
            String[] custSoNo=salesOrder.getCode().split("_REV.");
            String custSoNo1 = custSoNo[0];
            salesOrder.setCustSONo(custSoNo1);
            salesOrder.setCustomerBlanketOrder(customerPurchaseOrderRelease.getCustomerBlanketOrder());
            salesOrder.setApprovalStatus("PENDING");
            salesOrder.setClosingStatus("OPEN");
            salesOrder.setRevision("00");
            salesOrder.setTransactionDate(customerPurchaseOrderRelease.getTransactionDate());
            salesOrder.setRequestDeliveryDate(customerPurchaseOrderRelease.getTransactionDate());
            salesOrder.setExpiredDate(customerPurchaseOrderRelease.getTransactionDate());
            
            salesOrder.setRefNo(customerPurchaseOrderRelease.getRefNo());
            salesOrder.setRemark(customerPurchaseOrderRelease.getRemark());
            
            salesOrder.setTotalTransactionAmount(customerPurchaseOrderRelease.getTotalTransactionAmount());
            salesOrder.setDiscountPercent(customerPurchaseOrderRelease.getDiscountPercent());
            salesOrder.setDiscountAmount(customerPurchaseOrderRelease.getDiscountAmount());
            salesOrder.setTaxBaseAmount(customerPurchaseOrderRelease.getTaxBaseAmount());
            salesOrder.setVatPercent(customerPurchaseOrderRelease.getVatPercent());
            salesOrder.setVatAmount(customerPurchaseOrderRelease.getVatAmount());
            salesOrder.setGrandTotalAmount(customerPurchaseOrderRelease.getGrandTotalAmount());

            salesOrder.setBranch(customerPurchaseOrderRelease.getBranch());
            salesOrder.setCustomer(customerPurchaseOrderRelease.getCustomer());
            salesOrder.setEndUser(customerPurchaseOrderRelease.getEndUser());
            salesOrder.setCurrency(customerPurchaseOrderRelease.getCurrency());
            salesOrder.setSalesPerson(customerPurchaseOrderRelease.getSalesPerson());
            salesOrder.setProject(customerPurchaseOrderRelease.getProject());
            salesOrder.setCustomerPurchaseOrder(customerPurchaseOrderRelease);
            salesOrder.setOrderType(customerPurchaseOrderRelease.getPurchaseOrderType());
            
            salesOrder.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            salesOrder.setCreatedDate(new Date());

            hbmSession.hSession.save(salesOrder);
            
             // save Detail
            //SalesQuotation
            int q = 1;  
            CustomerSalesOrderSalesQuotation salesOrderSalesQuotation = new CustomerSalesOrderSalesQuotation(); 
                for(CustomerPurchaseOrderSalesQuotation customerPurchaseOrderSalesQuotation : listCustomerPurchaseOrderSalesQuotation){

                    String detailCode = salesOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(q),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    salesOrderSalesQuotation.setCode(detailCode);
                    salesOrderSalesQuotation.setHeaderCode(salesOrder.getCode());
                    salesOrderSalesQuotation.setSalesQuotation(customerPurchaseOrderSalesQuotation.getSalesQuotation());

                    salesOrderSalesQuotation.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    salesOrderSalesQuotation.setCreatedDate(new Date());

                    hbmSession.hSession.save(salesOrderSalesQuotation);
                    hbmSession.hSession.flush();
                    hbmSession.hSession.clear();
                    q++;
                }
            
            //Item
            int i = 1;
            CustomerSalesOrderItemDetail salesOrderItemDetail = new CustomerSalesOrderItemDetail();
                for(CustomerPurchaseOrderItemDetail customerPurchaseOrderItemDetail : listCustomerPurchaseOrderItemDetail){

                    String detailCode = salesOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    
                    salesOrderItemDetail.setCode(detailCode);
                    salesOrderItemDetail.setHeaderCode(salesOrder.getCode());
                    salesOrderItemDetail.setSalesQuotation(customerPurchaseOrderItemDetail.getSalesQuotation());
                    salesOrderItemDetail.setSalesQuotationDetail(customerPurchaseOrderItemDetail.getSalesQuotationDetail());
                    salesOrderItemDetail.setItemFinishGoods(customerPurchaseOrderItemDetail.getItemFinishGoods());
                    salesOrderItemDetail.setQuantity(customerPurchaseOrderItemDetail.getQuantity());
                    salesOrderItemDetail.setItemAlias(customerPurchaseOrderItemDetail.getItemAlias());
                    salesOrderItemDetail.setCustomerPurchaseOrderSortNo(customerPurchaseOrderItemDetail.getCustomerPurchaseOrderSortNo());
                    salesOrderItemDetail.setValveTag(customerPurchaseOrderItemDetail.getValveTag());
                    salesOrderItemDetail.setDataSheet(customerPurchaseOrderItemDetail.getDataSheet());
                    salesOrderItemDetail.setDescription(customerPurchaseOrderItemDetail.getDescription());

                    salesOrderItemDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    salesOrderItemDetail.setCreatedDate(new Date());

                    hbmSession.hSession.save(salesOrderItemDetail);
                    hbmSession.hSession.flush();
                    hbmSession.hSession.clear();
                    i++;
                }
            
            //AdditionalFee
            int f = 1;
            CustomerSalesOrderAdditionalFee salesOrderAdditionalFee = new CustomerSalesOrderAdditionalFee(); 
                for(CustomerPurchaseOrderAdditionalFee customerPurchaseOrderAdditionalFee : listCustomerPurchaseOrderAdditionalFee){

                    String detailCode = salesOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(f),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    salesOrderAdditionalFee.setCode(detailCode);
                    salesOrderAdditionalFee.setHeaderCode(salesOrder.getCode());
                    salesOrderAdditionalFee.setRemark(customerPurchaseOrderAdditionalFee.getRemark());
                    salesOrderAdditionalFee.setQuantity(customerPurchaseOrderAdditionalFee.getQuantity());
                    salesOrderAdditionalFee.setUnitOfMeasure(customerPurchaseOrderAdditionalFee.getUnitOfMeasure());
                    salesOrderAdditionalFee.setAdditionalFee(customerPurchaseOrderAdditionalFee.getAdditionalFee());
                    salesOrderAdditionalFee.setPrice(customerPurchaseOrderAdditionalFee.getPrice());
                    salesOrderAdditionalFee.setTotal(customerPurchaseOrderAdditionalFee.getTotal());

                    salesOrderAdditionalFee.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    salesOrderAdditionalFee.setCreatedDate(new Date());

                    hbmSession.hSession.save(salesOrderAdditionalFee);
                    hbmSession.hSession.flush();
                    hbmSession.hSession.clear();
                    f++;
                }

            //PaymentTerm
            int p = 1;
            CustomerSalesOrderPaymentTerm salesOrderPaymentTerm = new CustomerSalesOrderPaymentTerm();
            for(CustomerPurchaseOrderPaymentTerm customerPurchaseOrderPaymentTerm : listCustomerPurchaseOrderPaymentTerm){

                String detailCode = salesOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(p),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                salesOrderPaymentTerm.setCode(detailCode);
                salesOrderPaymentTerm.setHeaderCode(salesOrder.getCode());
                salesOrderPaymentTerm.setSortNo(customerPurchaseOrderPaymentTerm.getSortNo());
                salesOrderPaymentTerm.setPaymentTerm(customerPurchaseOrderPaymentTerm.getPaymentTerm());
                salesOrderPaymentTerm.setPercentage(customerPurchaseOrderPaymentTerm.getPercentage());
                salesOrderPaymentTerm.setRemark(customerPurchaseOrderPaymentTerm.getRemark());


                salesOrderPaymentTerm.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                salesOrderPaymentTerm.setCreatedDate(new Date());

                hbmSession.hSession.save(salesOrderPaymentTerm);
                hbmSession.hSession.flush();
                hbmSession.hSession.clear();
                p++;
            }
            
            //ItemDeliveryDate
            int d = 1;
                CustomerSalesOrderItemDeliveryDate salesOrderItemDeliveryDate = new CustomerSalesOrderItemDeliveryDate();
                for(CustomerPurchaseOrderItemDeliveryDate customerPurchaseOrderItemDeliveryDate : listCustomerPurchaseOrderItemDeliveryDate){

                    String detailCode = salesOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(d),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    salesOrderItemDeliveryDate.setCode(detailCode);
                    salesOrderItemDeliveryDate.setHeaderCode(salesOrder.getCode());
                    salesOrderItemDeliveryDate.setItemFinishGoods(customerPurchaseOrderItemDeliveryDate.getItemFinishGoods());
                    salesOrderItemDeliveryDate.setQuantity(customerPurchaseOrderItemDeliveryDate.getQuantity());
                    salesOrderItemDeliveryDate.setDeliveryDate(customerPurchaseOrderItemDeliveryDate.getDeliveryDate());
                    salesOrderItemDeliveryDate.setSalesQuotation(customerPurchaseOrderItemDeliveryDate.getSalesQuotation());
                    

                    salesOrderItemDeliveryDate.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    salesOrderItemDeliveryDate.setCreatedDate(new Date());

                    hbmSession.hSession.save(salesOrderItemDeliveryDate);
                    hbmSession.hSession.flush();
                    hbmSession.hSession.clear();
                    d++;
                }
            
            return Boolean.TRUE;
        }catch(HibernateException e){
            e.printStackTrace();
            return Boolean.FALSE;
        }
    }
    
    private boolean processDetailSalesOrder(EnumActivity.ENUM_Activity enumActivity,
            CustomerSalesOrder salesOrder,
            List<CustomerSalesOrderSalesQuotation> listCustomerSalesOrderByCustomerPurchaseOrderSalesQuotation, 
            List<CustomerSalesOrderItemDetail> listCustomerSalesOrderByCustomerPurchaseOrderItemDetail,
            List<CustomerSalesOrderAdditionalFee> listCustomerSalesOrderByCustomerPurchaseOrderAdditionalFee,
            List<CustomerSalesOrderPaymentTerm> listCustomerSalesOrderByCustomerPurchaseOrderPaymentTerm,
            List<CustomerSalesOrderItemDeliveryDate> listCustomerSalesOrderByCustomerPurchaseOrderItemDeliveryDate){
        try{
            
            if(enumActivity.equals(EnumActivity.ENUM_Activity.UPDATE) || enumActivity.equals(EnumActivity.ENUM_Activity.DELETE)){
                hbmSession.hSession.createQuery("DELETE FROM "+CustomerSalesOrderSalesQuotationField.BEAN_NAME+" WHERE "+CustomerSalesOrderSalesQuotationField.HEADERCODE+" = :prmCode")
                    .setParameter("prmCode", salesOrder.getCode())    
                    .executeUpdate();
            
                hbmSession.hSession.createQuery("DELETE FROM "+CustomerSalesOrderItemDetailField.BEAN_NAME+" WHERE "+CustomerSalesOrderItemDetailField.HEADERCODE+" = :prmCode")
                        .setParameter("prmCode", salesOrder.getCode())    
                        .executeUpdate();

                hbmSession.hSession.createQuery("DELETE FROM "+CustomerSalesOrderAdditionalFeeField.BEAN_NAME+" WHERE "+CustomerSalesOrderAdditionalFeeField.HEADERCODE+" = :prmCode")
                        .setParameter("prmCode", salesOrder.getCode())    
                        .executeUpdate();

                hbmSession.hSession.createQuery("DELETE FROM "+CustomerSalesOrderPaymentTermField.BEAN_NAME+" WHERE "+CustomerSalesOrderPaymentTermField.HEADERCODE+" = :prmCode")
                        .setParameter("prmCode", salesOrder.getCode())    
                        .executeUpdate();

                hbmSession.hSession.createQuery("DELETE FROM "+CustomerSalesOrderItemDeliveryDateField.BEAN_NAME+" WHERE "+CustomerSalesOrderItemDeliveryDateField.HEADERCODE+" = :prmCode")
                        .setParameter("prmCode", salesOrder.getCode())    
                        .executeUpdate();
            }
            
            
            if(enumActivity.equals(EnumActivity.ENUM_Activity.UPDATE) || enumActivity.equals(EnumActivity.ENUM_Activity.NEW)){
                int q = 1;
                for(CustomerSalesOrderSalesQuotation salesOrderSalesQuotation : listCustomerSalesOrderByCustomerPurchaseOrderSalesQuotation){

                    String detailCode = salesOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(q),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    salesOrderSalesQuotation.setCode(detailCode);
                    salesOrderSalesQuotation.setHeaderCode(salesOrder.getCode());

                    salesOrderSalesQuotation.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    salesOrderSalesQuotation.setCreatedDate(new Date());

                    hbmSession.hSession.save(salesOrderSalesQuotation);

                    q++;
                }

                int i = 1;
                for(CustomerSalesOrderItemDetail salesOrderItemDetail : listCustomerSalesOrderByCustomerPurchaseOrderItemDetail){

                    String detailCode = salesOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    salesOrderItemDetail.setCode(detailCode);
                    salesOrderItemDetail.setHeaderCode(salesOrder.getCode());

                    salesOrderItemDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    salesOrderItemDetail.setCreatedDate(new Date());

                    hbmSession.hSession.save(salesOrderItemDetail);

                    i++;
                }

                int f = 1;
                for(CustomerSalesOrderAdditionalFee salesOrderAdditionalFee : listCustomerSalesOrderByCustomerPurchaseOrderAdditionalFee){

                    String detailCode = salesOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(f),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    salesOrderAdditionalFee.setCode(detailCode);
                    salesOrderAdditionalFee.setHeaderCode(salesOrder.getCode());

                    salesOrderAdditionalFee.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    salesOrderAdditionalFee.setCreatedDate(new Date());

                    hbmSession.hSession.save(salesOrderAdditionalFee);

                    f++;
                }

                int p = 1;
                for(CustomerSalesOrderPaymentTerm salesOrderPaymentTerm : listCustomerSalesOrderByCustomerPurchaseOrderPaymentTerm){

                    String detailCode = salesOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(p),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    salesOrderPaymentTerm.setCode(detailCode);
                    salesOrderPaymentTerm.setHeaderCode(salesOrder.getCode());

                    salesOrderPaymentTerm.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    salesOrderPaymentTerm.setCreatedDate(new Date());

                    hbmSession.hSession.save(salesOrderPaymentTerm);

                    p++;
                }

                int d = 1;
                for(CustomerSalesOrderItemDeliveryDate salesOrderItemDeliveryDate : listCustomerSalesOrderByCustomerPurchaseOrderItemDeliveryDate){

                    String detailCode = salesOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(d),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    salesOrderItemDeliveryDate.setCode(detailCode);
                    salesOrderItemDeliveryDate.setHeaderCode(salesOrder.getCode());

                    salesOrderItemDeliveryDate.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    salesOrderItemDeliveryDate.setCreatedDate(new Date());

                    hbmSession.hSession.save(salesOrderItemDeliveryDate);

                    d++;
                }
            }
            
            return Boolean.TRUE;
        }catch(HibernateException e){
            e.printStackTrace();
            return Boolean.FALSE;
        }
    }
    
    private boolean updateSalesOrderHeader(EnumActivity.ENUM_Activity enumActivity,CustomerPurchaseOrder customerPurchaseOrderRelease,
            List<CustomerPurchaseOrderSalesQuotation> listCustomerPurchaseOrderSalesQuotation, 
            List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderItemDetail,
            List<CustomerPurchaseOrderAdditionalFee> listCustomerPurchaseOrderAdditionalFee,
            List<CustomerPurchaseOrderPaymentTerm> listCustomerPurchaseOrderPaymentTerm,
            List<CustomerPurchaseOrderItemDeliveryDate> listCustomerPurchaseOrderItemDeliveryDate, String moduleCode) throws Exception{

            CustomerSalesOrder salesOrder = new CustomerSalesOrder();
            
        try{
        
            //get old sales Order
            CustomerSalesOrderDAO salesOrderDAO = new CustomerSalesOrderDAO(hbmSession);
//            CustomerSalesOrder salesOrderNew = new CustomerSalesOrder();
            CustomerSalesOrder salesOrderUpdate = salesOrderDAO.getFromWoForReviseNew(customerPurchaseOrderRelease.getCode());
            
            String oldSalesOrder = salesOrderUpdate.getCode();
            CustomerSalesOrder salesOrderOld = salesOrderDAO.getSalesOrderUpdate(oldSalesOrder);
            
            salesOrder.setCode(salesOrderOld.getCode());
            salesOrder.setCustSONo(salesOrderOld.getCustSONo());
            salesOrder.setRevision(salesOrderOld.getRevision());
            salesOrder.setRefCUSTSOCode(salesOrderUpdate.getRefCUSTSOCode());
//            salesOrder.setCustomerPurchaseOrderCode(customerPurchaseOrderRelease.getCode());
            salesOrder.setCustomerBlanketOrder(customerPurchaseOrderRelease.getCustomerBlanketOrder());
            salesOrder.setTransactionDate(customerPurchaseOrderRelease.getTransactionDate());
            salesOrder.setRequestDeliveryDate(customerPurchaseOrderRelease.getTransactionDate());
            salesOrder.setExpiredDate(customerPurchaseOrderRelease.getTransactionDate());
            salesOrder.setApprovalStatus("PENDING");
            salesOrder.setClosingStatus("OPEN");
            
            salesOrder.setRefNo(customerPurchaseOrderRelease.getRefNo());
            salesOrder.setRemark(customerPurchaseOrderRelease.getRemark());
            
            salesOrder.setTotalTransactionAmount(customerPurchaseOrderRelease.getTotalTransactionAmount());
            salesOrder.setDiscountPercent(customerPurchaseOrderRelease.getDiscountPercent());
            salesOrder.setDiscountAmount(customerPurchaseOrderRelease.getDiscountAmount());
            salesOrder.setTaxBaseAmount(customerPurchaseOrderRelease.getTaxBaseAmount());
            salesOrder.setVatPercent(customerPurchaseOrderRelease.getVatPercent());
            salesOrder.setVatAmount(customerPurchaseOrderRelease.getVatAmount());
            salesOrder.setGrandTotalAmount(customerPurchaseOrderRelease.getGrandTotalAmount());

            salesOrder.setBranch(customerPurchaseOrderRelease.getBranch());
            salesOrder.setCustomer(customerPurchaseOrderRelease.getCustomer());
            salesOrder.setEndUser(customerPurchaseOrderRelease.getEndUser());
            salesOrder.setCurrency(customerPurchaseOrderRelease.getCurrency());
            salesOrder.setSalesPerson(customerPurchaseOrderRelease.getSalesPerson());
            salesOrder.setProject(customerPurchaseOrderRelease.getProject());
            salesOrder.setCustomerPurchaseOrder(customerPurchaseOrderRelease);
            salesOrder.setOrderType(customerPurchaseOrderRelease.getPurchaseOrderType());
            
            salesOrder.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            salesOrder.setCreatedDate(new Date());

            hbmSession.hSession.update(salesOrder);
            
            // update Detail
            hbmSession.hSession.createQuery("DELETE FROM "+CustomerSalesOrderSalesQuotationField.BEAN_NAME+" WHERE "+ CustomerSalesOrderSalesQuotationField.HEADERCODE+" = :prmCode")
                .setParameter("prmCode", salesOrderOld.getCode())    
                .executeUpdate();

            hbmSession.hSession.createQuery("DELETE FROM "+CustomerSalesOrderItemDetailField.BEAN_NAME+" WHERE "+ CustomerSalesOrderItemDetailField.HEADERCODE+" = :prmCode")
                    .setParameter("prmCode", salesOrderOld.getCode())    
                    .executeUpdate();

            hbmSession.hSession.createQuery("DELETE FROM "+CustomerSalesOrderAdditionalFeeField.BEAN_NAME+" WHERE "+ CustomerSalesOrderAdditionalFeeField.HEADERCODE+" = :prmCode")
                    .setParameter("prmCode", salesOrderOld.getCode())    
                    .executeUpdate();

            hbmSession.hSession.createQuery("DELETE FROM "+CustomerSalesOrderPaymentTermField.BEAN_NAME+" WHERE "+ CustomerSalesOrderPaymentTermField.HEADERCODE+" = :prmCode")
                    .setParameter("prmCode", salesOrderOld.getCode())    
                    .executeUpdate();

            hbmSession.hSession.createQuery("DELETE FROM "+CustomerSalesOrderItemDeliveryDateField.BEAN_NAME+" WHERE "+ CustomerSalesOrderItemDeliveryDateField.HEADERCODE+" = :prmCode")
                    .setParameter("prmCode", salesOrderOld.getCode())    
                    .executeUpdate(); 
            //SalesQuotation
            int q = 1;  
            CustomerSalesOrderSalesQuotation salesOrderSalesQuotation = new CustomerSalesOrderSalesQuotation(); 
                for(CustomerPurchaseOrderSalesQuotation customerPurchaseOrderSalesQuotation : listCustomerPurchaseOrderSalesQuotation){

                    String detailCode = salesOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(q),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    salesOrderSalesQuotation.setCode(detailCode);
                    salesOrderSalesQuotation.setHeaderCode(salesOrder.getCode());
                    salesOrderSalesQuotation.setSalesQuotation(customerPurchaseOrderSalesQuotation.getSalesQuotation());

                    salesOrderSalesQuotation.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    salesOrderSalesQuotation.setCreatedDate(new Date());

                    hbmSession.hSession.save(salesOrderSalesQuotation);
                    hbmSession.hSession.flush();
                    hbmSession.hSession.clear();
                    q++;
                }
            
            //Item
            int i = 1;
            CustomerSalesOrderItemDetail salesOrderItemDetail = new CustomerSalesOrderItemDetail();
                for(CustomerPurchaseOrderItemDetail customerPurchaseOrderItemDetail : listCustomerPurchaseOrderItemDetail){

                    String detailCode = salesOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    
                    salesOrderItemDetail.setCode(detailCode);
                    salesOrderItemDetail.setHeaderCode(salesOrder.getCode());
                    salesOrderItemDetail.setSalesQuotation(customerPurchaseOrderItemDetail.getSalesQuotation());
                    salesOrderItemDetail.setSalesQuotationDetail(customerPurchaseOrderItemDetail.getSalesQuotationDetail());
                    salesOrderItemDetail.setItemFinishGoods(customerPurchaseOrderItemDetail.getItemFinishGoods());
                    salesOrderItemDetail.setQuantity(customerPurchaseOrderItemDetail.getQuantity());
                    salesOrderItemDetail.setItemAlias(customerPurchaseOrderItemDetail.getItemAlias());
                    salesOrderItemDetail.setCustomerPurchaseOrderSortNo(customerPurchaseOrderItemDetail.getCustomerPurchaseOrderSortNo());
                    salesOrderItemDetail.setValveTag(customerPurchaseOrderItemDetail.getValveTag());
                    salesOrderItemDetail.setDataSheet(customerPurchaseOrderItemDetail.getDataSheet());
                    salesOrderItemDetail.setDescription(customerPurchaseOrderItemDetail.getDescription());

                    salesOrderItemDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    salesOrderItemDetail.setCreatedDate(new Date());

                    hbmSession.hSession.save(salesOrderItemDetail);
                    hbmSession.hSession.flush();
                    hbmSession.hSession.clear();
                    i++;
                }
            
            //AdditionalFee
            int f = 1;
            CustomerSalesOrderAdditionalFee salesOrderAdditionalFee = new CustomerSalesOrderAdditionalFee(); 
                for(CustomerPurchaseOrderAdditionalFee customerPurchaseOrderAdditionalFee : listCustomerPurchaseOrderAdditionalFee){

                    String detailCode = salesOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(f),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    salesOrderAdditionalFee.setCode(detailCode);
                    salesOrderAdditionalFee.setHeaderCode(salesOrder.getCode());
                    salesOrderAdditionalFee.setRemark(customerPurchaseOrderAdditionalFee.getRemark());
                    salesOrderAdditionalFee.setQuantity(customerPurchaseOrderAdditionalFee.getQuantity());
                    salesOrderAdditionalFee.setUnitOfMeasure(customerPurchaseOrderAdditionalFee.getUnitOfMeasure());
                    salesOrderAdditionalFee.setAdditionalFee(customerPurchaseOrderAdditionalFee.getAdditionalFee());
                    salesOrderAdditionalFee.setPrice(customerPurchaseOrderAdditionalFee.getPrice());
                    salesOrderAdditionalFee.setTotal(customerPurchaseOrderAdditionalFee.getTotal());

                    salesOrderAdditionalFee.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    salesOrderAdditionalFee.setCreatedDate(new Date());

                    hbmSession.hSession.save(salesOrderAdditionalFee);
                    hbmSession.hSession.flush();
                    hbmSession.hSession.clear();
                    f++;
                }

            //PaymentTerm
            int p = 1;
            CustomerSalesOrderPaymentTerm salesOrderPaymentTerm = new CustomerSalesOrderPaymentTerm();
            for(CustomerPurchaseOrderPaymentTerm customerPurchaseOrderPaymentTerm : listCustomerPurchaseOrderPaymentTerm){

                String detailCode = salesOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(p),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                salesOrderPaymentTerm.setCode(detailCode);
                salesOrderPaymentTerm.setHeaderCode(salesOrder.getCode());
                salesOrderPaymentTerm.setSortNo(customerPurchaseOrderPaymentTerm.getSortNo());
                salesOrderPaymentTerm.setPaymentTerm(customerPurchaseOrderPaymentTerm.getPaymentTerm());
                salesOrderPaymentTerm.setPercentage(customerPurchaseOrderPaymentTerm.getPercentage());
                salesOrderPaymentTerm.setRemark(customerPurchaseOrderPaymentTerm.getRemark());


                salesOrderPaymentTerm.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                salesOrderPaymentTerm.setCreatedDate(new Date());

                hbmSession.hSession.save(salesOrderPaymentTerm);
                hbmSession.hSession.flush();
                hbmSession.hSession.clear();
                p++;
            }
            
            //ItemDeliveryDate
            int d = 1;
                CustomerSalesOrderItemDeliveryDate salesOrderItemDeliveryDate = new CustomerSalesOrderItemDeliveryDate();
                for(CustomerPurchaseOrderItemDeliveryDate customerPurchaseOrderItemDeliveryDate : listCustomerPurchaseOrderItemDeliveryDate){

                    String detailCode = salesOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(d),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    salesOrderItemDeliveryDate.setCode(detailCode);
                    salesOrderItemDeliveryDate.setHeaderCode(salesOrder.getCode());
                    salesOrderItemDeliveryDate.setItemFinishGoods(customerPurchaseOrderItemDeliveryDate.getItemFinishGoods());
                    salesOrderItemDeliveryDate.setQuantity(customerPurchaseOrderItemDeliveryDate.getQuantity());
                    salesOrderItemDeliveryDate.setDeliveryDate(customerPurchaseOrderItemDeliveryDate.getDeliveryDate());
                    salesOrderItemDeliveryDate.setSalesQuotation(customerPurchaseOrderItemDeliveryDate.getSalesQuotation());
                    

                    salesOrderItemDeliveryDate.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    salesOrderItemDeliveryDate.setCreatedDate(new Date());

                    hbmSession.hSession.save(salesOrderItemDeliveryDate);
                    hbmSession.hSession.flush();
                    hbmSession.hSession.clear();
                    d++;
                }
            
            return Boolean.TRUE;
        }catch(HibernateException e){
            e.printStackTrace();
            return Boolean.FALSE;
        }
    }
    private boolean processReviseDetailSalesOrder(EnumActivity.ENUM_Activity enumActivity, 
            CustomerSalesOrder salesOrder,
            CustomerPurchaseOrder customerPurchaseOrder,
            List<CustomerPurchaseOrderSalesQuotation> listCustomerPurchaseOrderSalesQuotation, 
            List<CustomerPurchaseOrderItemDetail> listCustomerPurchaseOrderItemDetail,
            List<CustomerPurchaseOrderAdditionalFee> listCustomerPurchaseOrderAdditionalFee,
            List<CustomerPurchaseOrderPaymentTerm> listCustomerPurchaseOrderPaymentTerm,
            List<CustomerPurchaseOrderItemDeliveryDate> listCustomerPurchaseOrderItemDeliveryDate){
        try{
            CustomerSalesOrderDAO salesOrderDAO = new CustomerSalesOrderDAO(hbmSession);
           
            //SalesQuotation
            int q = 1;  
            CustomerSalesOrderSalesQuotation salesOrderSalesQuotation = new CustomerSalesOrderSalesQuotation(); 
                for(CustomerPurchaseOrderSalesQuotation customerPurchaseOrderSalesQuotation : listCustomerPurchaseOrderSalesQuotation){

                    String detailCode = salesOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(q),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    salesOrderSalesQuotation.setCode(detailCode);
                    salesOrderSalesQuotation.setHeaderCode(salesOrder.getCode());
                    salesOrderSalesQuotation.setSalesQuotation(customerPurchaseOrderSalesQuotation.getSalesQuotation());

                    salesOrderSalesQuotation.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    salesOrderSalesQuotation.setCreatedDate(new Date());

                    hbmSession.hSession.save(salesOrderSalesQuotation);
                    hbmSession.hSession.flush();
                    hbmSession.hSession.clear();
                    q++;
                }
            
            //Item
            int i = 1;
            CustomerSalesOrderItemDetail salesOrderItemDetail = new CustomerSalesOrderItemDetail();
                for(CustomerPurchaseOrderItemDetail customerPurchaseOrderItemDetail : listCustomerPurchaseOrderItemDetail){

                    String detailCode = salesOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    
                    salesOrderItemDetail.setCode(detailCode);
                    salesOrderItemDetail.setHeaderCode(salesOrder.getCode());
                    salesOrderItemDetail.setSalesQuotation(customerPurchaseOrderItemDetail.getSalesQuotation());
                    salesOrderItemDetail.setSalesQuotationDetail(customerPurchaseOrderItemDetail.getSalesQuotationDetail());
                    salesOrderItemDetail.setItemFinishGoods(customerPurchaseOrderItemDetail.getItemFinishGoods());
                    salesOrderItemDetail.setQuantity(customerPurchaseOrderItemDetail.getQuantity());
                    salesOrderItemDetail.setItemAlias(customerPurchaseOrderItemDetail.getItemAlias());
                    salesOrderItemDetail.setCustomerPurchaseOrderSortNo(customerPurchaseOrderItemDetail.getCustomerPurchaseOrderSortNo());
                    salesOrderItemDetail.setValveTag(customerPurchaseOrderItemDetail.getValveTag());
                    salesOrderItemDetail.setDataSheet(customerPurchaseOrderItemDetail.getDataSheet());
                    salesOrderItemDetail.setDescription(customerPurchaseOrderItemDetail.getDescription());

                    salesOrderItemDetail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    salesOrderItemDetail.setCreatedDate(new Date());

                    hbmSession.hSession.save(salesOrderItemDetail);
                    hbmSession.hSession.flush();
                    hbmSession.hSession.clear();
                    i++;
                }
            
            //AdditionalFee
            int f = 1;
            CustomerSalesOrderAdditionalFee salesOrderAdditionalFee = new CustomerSalesOrderAdditionalFee(); 
                for(CustomerPurchaseOrderAdditionalFee customerPurchaseOrderAdditionalFee : listCustomerPurchaseOrderAdditionalFee){

                    String detailCode = salesOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(f),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    salesOrderAdditionalFee.setCode(detailCode);
                    salesOrderAdditionalFee.setHeaderCode(salesOrder.getCode());
                    salesOrderAdditionalFee.setRemark(customerPurchaseOrderAdditionalFee.getRemark());
                    salesOrderAdditionalFee.setQuantity(customerPurchaseOrderAdditionalFee.getQuantity());
                    salesOrderAdditionalFee.setUnitOfMeasure(customerPurchaseOrderAdditionalFee.getUnitOfMeasure());
                    salesOrderAdditionalFee.setAdditionalFee(customerPurchaseOrderAdditionalFee.getAdditionalFee());
                    salesOrderAdditionalFee.setPrice(customerPurchaseOrderAdditionalFee.getPrice());
                    salesOrderAdditionalFee.setTotal(customerPurchaseOrderAdditionalFee.getTotal());

                    salesOrderAdditionalFee.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    salesOrderAdditionalFee.setCreatedDate(new Date());

                    hbmSession.hSession.save(salesOrderAdditionalFee);
                    hbmSession.hSession.flush();
                    hbmSession.hSession.clear();
                    f++;
                }

            //PaymentTerm
            int p = 1;
            CustomerSalesOrderPaymentTerm salesOrderPaymentTerm = new CustomerSalesOrderPaymentTerm();
            for(CustomerPurchaseOrderPaymentTerm customerPurchaseOrderPaymentTerm : listCustomerPurchaseOrderPaymentTerm){

                String detailCode = salesOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(p),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                salesOrderPaymentTerm.setCode(detailCode);
                salesOrderPaymentTerm.setHeaderCode(salesOrder.getCode());
                salesOrderPaymentTerm.setSortNo(customerPurchaseOrderPaymentTerm.getSortNo());
                salesOrderPaymentTerm.setPaymentTerm(customerPurchaseOrderPaymentTerm.getPaymentTerm());
                salesOrderPaymentTerm.setPercentage(customerPurchaseOrderPaymentTerm.getPercentage());
                salesOrderPaymentTerm.setRemark(customerPurchaseOrderPaymentTerm.getRemark());


                salesOrderPaymentTerm.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                salesOrderPaymentTerm.setCreatedDate(new Date());

                hbmSession.hSession.save(salesOrderPaymentTerm);
                hbmSession.hSession.flush();
                hbmSession.hSession.clear();
                p++;
            }
            
            //ItemDeliveryDate
            int d = 1;
                CustomerSalesOrderItemDeliveryDate salesOrderItemDeliveryDate = new CustomerSalesOrderItemDeliveryDate();
                for(CustomerPurchaseOrderItemDeliveryDate customerPurchaseOrderItemDeliveryDate : listCustomerPurchaseOrderItemDeliveryDate){

                    String detailCode = salesOrder.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(d),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                    salesOrderItemDeliveryDate.setCode(detailCode);
                    salesOrderItemDeliveryDate.setHeaderCode(salesOrder.getCode());
                    salesOrderItemDeliveryDate.setItemFinishGoods(customerPurchaseOrderItemDeliveryDate.getItemFinishGoods());
                    salesOrderItemDeliveryDate.setQuantity(customerPurchaseOrderItemDeliveryDate.getQuantity());
                    salesOrderItemDeliveryDate.setDeliveryDate(customerPurchaseOrderItemDeliveryDate.getDeliveryDate());
                    salesOrderItemDeliveryDate.setSalesQuotation(customerPurchaseOrderItemDeliveryDate.getSalesQuotation());
                    

                    salesOrderItemDeliveryDate.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    salesOrderItemDeliveryDate.setCreatedDate(new Date());

                    hbmSession.hSession.save(salesOrderItemDeliveryDate);
                    hbmSession.hSession.flush();
                    hbmSession.hSession.clear();
                    d++;
                }
            
            
            return Boolean.TRUE;
        }catch(HibernateException e){
            e.printStackTrace();
            return Boolean.FALSE;
        }
    }
}

    

