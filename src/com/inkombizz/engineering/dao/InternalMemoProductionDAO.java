/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.engineering.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.CommonFunction;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumActivity;
import com.inkombizz.common.enumeration.EnumApprovalStatus;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionType;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.dao.common.AutoNumber;
import com.inkombizz.engineering.model.InternalMemoProduction;
import com.inkombizz.engineering.model.InternalMemoProductionDetail;
import com.inkombizz.engineering.model.InternalMemoProductionDetailField;
import com.inkombizz.engineering.model.InternalMemoProductionDetailTemp;
import com.inkombizz.engineering.model.InternalMemoProductionField;
import com.inkombizz.engineering.model.InternalMemoProductionTemp;
import com.inkombizz.system.dao.TransactionLogDAO;
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

/**
 *
 * @author ikb
 */
public class InternalMemoProductionDAO {
     private HBMSession hbmSession;
     private CommonFunction commonFunction=new CommonFunction();
    
    public InternalMemoProductionDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(String code,String customerCode,String customerName, String refNo, String remark, Date firstDate, Date lastDate){
        try{
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT COUNT(eng_internal_memo_production.code)  "
                + "FROM eng_internal_memo_production "
                + "LEFT JOIN mst_project ON eng_internal_memo_production.projectCode = mst_project.Code "
                + "INNER JOIN mst_branch ON eng_internal_memo_production.BranchCode = mst_branch.Code "
                + "INNER JOIN mst_customer ON eng_internal_memo_production.`CustomerCode` = mst_customer.Code "
                + "INNER JOIN mst_sales_person ON eng_internal_memo_production.salesPersonCode = mst_sales_person.Code "
                + "WHERE eng_internal_memo_production.code LIKE '%"+code+"%' "
                + "AND eng_internal_memo_production.CustomerCode LIKE '%"+customerCode+"%' "
                + "AND mst_customer.name LIKE '%"+customerName+"%' "
                + "AND eng_internal_memo_production.refNo LIKE '%"+refNo+"%' "
                + "AND eng_internal_memo_production.remark LIKE '%"+remark+"%' "
                + "AND eng_internal_memo_production.ClosingStatus = 'OPEN' "
                + "AND DATE(eng_internal_memo_production.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
     public List<InternalMemoProductionTemp> findData(String code,String customerCode, String customerName, String refNo, String remark, int from,int to, Date firstDate, Date lastDate) {
        try {
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            List<InternalMemoProductionTemp> list = (List<InternalMemoProductionTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "eng_internal_memo_production.code, "
                + "eng_internal_memo_production.Transactiondate, "
                + "mst_customer.code AS customerCode, "
                + "mst_customer.name AS customerName, "
                + "mst_branch.Code AS branchCode, "
                + "mst_branch.Name AS branchName, "
                + "mst_project.code AS projectCode, "
                + "mst_project.name AS projectName, "
                + "mst_sales_person.code AS salesPersonCode, "
                + "mst_sales_person.name AS salesPersonName, "
                + "eng_internal_memo_production.subject, "
                + "eng_internal_memo_production.attention, "
                + "eng_internal_memo_production.IM_To, "
                + "eng_internal_memo_production.RefNo, "
                + "eng_internal_memo_production.Remark "
                + "FROM eng_internal_memo_production "
                + "INNER JOIN mst_customer ON eng_internal_memo_production.`CustomerCode` = mst_customer.Code "
                + "INNER JOIN mst_branch ON eng_internal_memo_production.BranchCode = mst_branch.Code "
                + "LEFT JOIN mst_project ON eng_internal_memo_production.projectCode = mst_project.Code "
                + "INNER JOIN mst_sales_person ON eng_internal_memo_production.salesPersonCode = mst_sales_person.Code "
                + "WHERE eng_internal_memo_production.code LIKE '%"+code+"%' "
                + "AND eng_internal_memo_production.CustomerCode LIKE '%"+customerCode+"%' "
                + "AND mst_customer.name LIKE '%"+customerName+"%' "
                + "AND eng_internal_memo_production.refNo LIKE '%"+refNo+"%' "
                + "AND eng_internal_memo_production.remark LIKE '%"+remark+"%' "
                + "AND eng_internal_memo_production.ClosingStatus = 'OPEN' "        
                + "AND DATE(eng_internal_memo_production.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                + "ORDER BY eng_internal_memo_production.TransactionDate DESC "
                + "LIMIT "+from+","+to+""
            )
                 
                .addScalar("code", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("salesPersonCode", Hibernate.STRING)
                .addScalar("salesPersonName", Hibernate.STRING)
                .addScalar("projectCode", Hibernate.STRING)
                .addScalar("projectName", Hibernate.STRING)
                .addScalar("customerCode", Hibernate.STRING)
                .addScalar("customerName", Hibernate.STRING)
                .addScalar("subject", Hibernate.STRING)
                .addScalar("attention", Hibernate.STRING)
                .addScalar("im_To", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                    
                .setResultTransformer(Transformers.aliasToBean(InternalMemoProductionTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
     
    public int countDataApproval(String code,String customerCode,String customerName, String refNo, String remark, String approvalStatus, Date firstDate, Date lastDate){
        try{
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            String concat_apprv = "";
            if(!approvalStatus.equals("")){
                concat_apprv = "AND eng_internal_memo_production.ApprovalStatus = '"+approvalStatus+"' " ;
            }
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT COUNT(eng_internal_memo_production.code)  "
                + "FROM eng_internal_memo_production "
                + "LEFT JOIN mst_project ON eng_internal_memo_production.projectCode = mst_project.Code "
                + "INNER JOIN mst_branch ON eng_internal_memo_production.BranchCode = mst_branch.Code "
                + "INNER JOIN mst_customer ON eng_internal_memo_production.`CustomerCode` = mst_customer.Code "
                + "INNER JOIN mst_sales_person ON eng_internal_memo_production.salesPersonCode = mst_sales_person.Code "
                + "WHERE eng_internal_memo_production.code LIKE '%"+code+"%' "
                + "AND eng_internal_memo_production.CustomerCode LIKE '%"+customerCode+"%' "
                + "AND mst_customer.name LIKE '%"+customerName+"%' "
                + "AND eng_internal_memo_production.refNo LIKE '%"+refNo+"%' "
                + "AND eng_internal_memo_production.remark LIKE '%"+remark+"%' "
                + concat_apprv
                + "AND eng_internal_memo_production.ClosingStatus = 'OPEN' "            
                + "AND DATE(eng_internal_memo_production.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
     public List<InternalMemoProductionTemp> findDataApproval(String code,String customerCode, String customerName, String refNo, String remark, String approvalStatus, int from,int to, Date firstDate, Date lastDate) {
        try {
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            String concat_apprv = "";
            if(!approvalStatus.equals("")){
                concat_apprv = "AND eng_internal_memo_production.ApprovalStatus = '"+approvalStatus+"' " ;
            }
            List<InternalMemoProductionTemp> list = (List<InternalMemoProductionTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "eng_internal_memo_production.code, "
                + "eng_internal_memo_production.Transactiondate, "
                + "mst_customer.code AS customerCode, "
                + "mst_customer.name AS customerName, "
                + "mst_branch.Code AS branchCode, "
                + "mst_branch.Name AS branchName, "
                + "mst_project.code AS projectCode, "
                + "mst_project.name AS projectName, "
                + "mst_sales_person.code AS salesPersonCode, "
                + "mst_sales_person.name AS salesPersonName, "
                + "eng_internal_memo_production.subject, "
                + "eng_internal_memo_production.attention, "
                + "eng_internal_memo_production.IM_To, "
                + "eng_internal_memo_production.RefNo, "
                + "eng_internal_memo_production.Remark, "
                + "eng_internal_memo_production.ApprovalStatus "
                + "FROM eng_internal_memo_production "
                + "INNER JOIN mst_customer ON eng_internal_memo_production.`CustomerCode` = mst_customer.Code "
                + "INNER JOIN mst_branch ON eng_internal_memo_production.BranchCode = mst_branch.Code "
                + "LEFT JOIN mst_project ON eng_internal_memo_production.projectCode = mst_project.Code "
                + "INNER JOIN mst_sales_person ON eng_internal_memo_production.salesPersonCode = mst_sales_person.Code "
                + "WHERE eng_internal_memo_production.code LIKE '%"+code+"%' "
                + "AND eng_internal_memo_production.CustomerCode LIKE '%"+customerCode+"%' "
                + "AND mst_customer.name LIKE '%"+customerName+"%' "
                + "AND eng_internal_memo_production.refNo LIKE '%"+refNo+"%' "
                + "AND eng_internal_memo_production.remark LIKE '%"+remark+"%' "
                + concat_apprv
                + "AND eng_internal_memo_production.ClosingStatus = 'OPEN' "            
                + "AND DATE(eng_internal_memo_production.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                + "ORDER BY eng_internal_memo_production.TransactionDate DESC "
                + "LIMIT "+from+","+to+""
            )
                 
                .addScalar("code", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("salesPersonCode", Hibernate.STRING)
                .addScalar("salesPersonName", Hibernate.STRING)
                .addScalar("projectCode", Hibernate.STRING)
                .addScalar("projectName", Hibernate.STRING)
                .addScalar("customerCode", Hibernate.STRING)
                .addScalar("customerName", Hibernate.STRING)
                .addScalar("subject", Hibernate.STRING)
                .addScalar("attention", Hibernate.STRING)
                .addScalar("im_To", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("approvalStatus", Hibernate.STRING)
                    
                .setResultTransformer(Transformers.aliasToBean(InternalMemoProductionTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
     
    public int countDataClosing(String code,String customerCode,String customerName, String refNo, String remark, String closingStatus, Date firstDate, Date lastDate){
        try{
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            String concat_cls = "";
            if(!closingStatus.equals("")){
                concat_cls = "AND eng_internal_memo_production.ClosingStatus = '"+closingStatus+"' " ;
            }
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT COUNT(eng_internal_memo_production.code)  "
                + "FROM eng_internal_memo_production "
                + "LEFT JOIN mst_project ON eng_internal_memo_production.projectCode = mst_project.Code "
                + "INNER JOIN mst_branch ON eng_internal_memo_production.BranchCode = mst_branch.Code "
                + "INNER JOIN mst_customer ON eng_internal_memo_production.`CustomerCode` = mst_customer.Code "
                + "INNER JOIN mst_sales_person ON eng_internal_memo_production.salesPersonCode = mst_sales_person.Code "
                + "WHERE eng_internal_memo_production.code LIKE '%"+code+"%' "
                + "AND eng_internal_memo_production.CustomerCode LIKE '%"+customerCode+"%' "
                + "AND mst_customer.name LIKE '%"+customerName+"%' "
                + "AND eng_internal_memo_production.refNo LIKE '%"+refNo+"%' "
                + "AND eng_internal_memo_production.remark LIKE '%"+remark+"%' "
                + concat_cls
                + "AND DATE(eng_internal_memo_production.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    } 
    
    public List<InternalMemoProductionTemp> findDataClosing(String code,String customerCode, String customerName, String refNo, String remark, String closingStatus, int from,int to, Date firstDate, Date lastDate) {
        try {
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(firstDate);
            String dateLast = DATE_FORMAT.format(lastDate);
            
            String concat_cls = "";
            if(!closingStatus.equals("")){
                concat_cls = "AND eng_internal_memo_production.ClosingStatus = '"+closingStatus+"' " ;
            }
            List<InternalMemoProductionTemp> list = (List<InternalMemoProductionTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "eng_internal_memo_production.code, "
                + "eng_internal_memo_production.Transactiondate, "
                + "mst_customer.code AS customerCode, "
                + "mst_customer.name AS customerName, "
                + "mst_branch.Code AS branchCode, "
                + "mst_branch.Name AS branchName, "
                + "mst_project.code AS projectCode, "
                + "mst_project.name AS projectName, "
                + "mst_sales_person.code AS salesPersonCode, "
                + "mst_sales_person.name AS salesPersonName, "
                + "eng_internal_memo_production.subject, "
                + "eng_internal_memo_production.attention, "
                + "eng_internal_memo_production.IM_To, "
                + "eng_internal_memo_production.RefNo, "
                + "eng_internal_memo_production.Remark, "
                + "eng_internal_memo_production.ApprovalStatus, "
                + "eng_internal_memo_production.closingStatus "
                + "FROM eng_internal_memo_production "
                + "INNER JOIN mst_customer ON eng_internal_memo_production.`CustomerCode` = mst_customer.Code "
                + "INNER JOIN mst_branch ON eng_internal_memo_production.BranchCode = mst_branch.Code "
                + "LEFT JOIN mst_project ON eng_internal_memo_production.projectCode = mst_project.Code "
                + "INNER JOIN mst_sales_person ON eng_internal_memo_production.salesPersonCode = mst_sales_person.Code "
                + "WHERE eng_internal_memo_production.code LIKE '%"+code+"%' "
                + "AND eng_internal_memo_production.CustomerCode LIKE '%"+customerCode+"%' "
                + "AND mst_customer.name LIKE '%"+customerName+"%' "
                + "AND eng_internal_memo_production.refNo LIKE '%"+refNo+"%' "
                + "AND eng_internal_memo_production.remark LIKE '%"+remark+"%' "
                + concat_cls
                + "AND DATE(eng_internal_memo_production.TransactionDate) BETWEEN '"+dateFirst+"' AND '"+dateLast+"' "
                + "ORDER BY eng_internal_memo_production.TransactionDate DESC "
                + "LIMIT "+from+","+to+""
            )
                 
                .addScalar("code", Hibernate.STRING)
                .addScalar("transactionDate", Hibernate.TIMESTAMP)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("salesPersonCode", Hibernate.STRING)
                .addScalar("salesPersonName", Hibernate.STRING)
                .addScalar("projectCode", Hibernate.STRING)
                .addScalar("projectName", Hibernate.STRING)
                .addScalar("customerCode", Hibernate.STRING)
                .addScalar("customerName", Hibernate.STRING)
                .addScalar("subject", Hibernate.STRING)
                .addScalar("attention", Hibernate.STRING)
                .addScalar("im_To", Hibernate.STRING)
                .addScalar("refNo", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("approvalStatus", Hibernate.STRING)
                .addScalar("closingStatus", Hibernate.STRING)
                    
                .setResultTransformer(Transformers.aliasToBean(InternalMemoProductionTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
     
     public List<InternalMemoProductionDetailTemp> findDataDetail(String headerCode,String customerCode) {
        try {
                String concat_qry_customer="";
                if(!customerCode.equals("")){
                concat_qry_customer="AND mst_item_finish_goods.CustomerCode='"+customerCode+"' ";
                }
            List<InternalMemoProductionDetailTemp> list = (List<InternalMemoProductionDetailTemp>)hbmSession.hSession.createSQLQuery(
                "SELECT "
                + "eng_internal_memo_production_detail.code, "
                + "eng_internal_memo_production_detail.Headercode, "
                + "eng_internal_memo_production_detail.internalMemoSortNo, "
                + "eng_internal_memo_production_detail.Description, "
                + "eng_internal_memo_production_detail.ValveTag, "
                + "eng_internal_memo_production_detail.DataSheet, "
                + "eng_internal_memo_production_detail.ItemFinishGoodsCode, "
                + "mst_item_finish_goods.remark AS itemFinishGoodsRemark, "
                + "mst_item_finish_goods.name AS ItemFinishGoodName, "
                + "mst_item_finish_goods.ItemBodyConstructionCode AS itemBodyConstructionCode, "
                + "mst_item_body_construction.Name AS itemBodyConstructionName, "        
                + "mst_item_finish_goods.itemTypeDesignCode, "
                + "mst_item_type_design.name AS ItemTypeDesignName, "
                + "mst_item_finish_goods.ItemSeatDesignCode, "
                + "mst_item_seat_design.name AS ItemSeatDesignName, "
                + "mst_item_finish_goods.itemSizeCode, "
                + "mst_item_size.name AS ItemSizeName, "         
                + "mst_item_finish_goods.itemRatingCode, "
                + "mst_item_rating.name AS ItemRatingName, "                  
                + "mst_item_finish_goods.itemBoreCode, "
                + "mst_item_bore.name AS ItemBoreName, "        
                + "mst_item_finish_goods.itemEndConCode, "
                + "mst_item_end_con.name AS ItemEndConName, "         
                + "mst_item_finish_goods.ItemBodyCode, "
                + "mst_item_body.name AS ItemBodyName, "        
                + "mst_item_finish_goods.ItemBallCode, "
                + "mst_item_ball.name AS ItemBallName, "        
                + "mst_item_finish_goods.ItemSeatCode, "
                + "mst_item_seat.name AS ItemSeatName, "             
                + "mst_item_finish_goods.ItemSeatInsertCode, "
                + "mst_item_seat_insert.name AS ItemSeatInsertName, "
                + "mst_item_finish_goods.ItemStemCode, "
                + "mst_item_stem.name AS itemStemName, "
                + "mst_item_finish_goods.ItemSealCode, "
                + "mst_item_seal.name AS itemSealName, "        
                + "mst_item_finish_goods.ItemBoltCode, "
                + "mst_item_bolt.name AS itemBoltName, "
                + "mst_item_finish_goods.ItemDiscCode, "
                + "mst_item_disc.name AS itemDiscName, "        
                + "mst_item_finish_goods.ItemPlatesCode, "
                + "mst_item_plates.name AS itemPlatesName, "        
                + "mst_item_finish_goods.ItemShaftCode, "
                + "mst_item_shaft.name AS itemShaftName, "           
                + "mst_item_finish_goods.ItemSpringCode, "
                + "mst_item_spring.name AS itemSpringName, "        
                + "mst_item_finish_goods.ItemArmPinCode, "
                + "mst_item_arm_pin.name AS itemArmPinName, "        
                + "mst_item_finish_goods.ItemBackSeatCode, "
                + "mst_item_backseat.name AS itemBackseatName, "            
                + "mst_item_finish_goods.ItemArmCode, "
                + "mst_item_arm.name AS itemArmName, "            
                + "mst_item_finish_goods.ItemHingePinCode, "
                + "mst_item_hinge_pin.name AS itemHingePinName, "         
                + "mst_item_finish_goods.ItemStopPinCode, "
                + "mst_item_stop_pin.name AS itemStopPinName, "          
                + "mst_item_finish_goods.ItemOperatorCode, "
                + "mst_item_operator.name AS itemOperatorName, "         
                + "eng_internal_memo_production_detail.Quantity "
                + "FROM eng_internal_memo_production_detail "
                + "INNER JOIN mst_item_finish_goods ON eng_internal_memo_production_detail.ItemFinishGoodsCode = mst_item_finish_goods.Code "
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
                + "WHERE eng_internal_memo_production_detail.HeaderCode='"+headerCode+"' "
                + concat_qry_customer)
                        
                .addScalar("code", Hibernate.STRING)
                .addScalar("valveTag", Hibernate.STRING)
                .addScalar("dataSheet", Hibernate.STRING)
                .addScalar("description", Hibernate.STRING)
                .addScalar("internalMemoSortNo", Hibernate.BIG_DECIMAL)
                .addScalar("headerCode", Hibernate.STRING)
                .addScalar("itemFinishGoodsCode", Hibernate.STRING)
                .addScalar("itemFinishGoodsRemark", Hibernate.STRING)
//                .addScalar("itemBodyConstructionCode", Hibernate.STRING)
//                .addScalar("itemBodyConstructionName", Hibernate.STRING)
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
                .addScalar("itemBackseatCode", Hibernate.STRING)
                .addScalar("itemBackseatName", Hibernate.STRING)
                .addScalar("itemArmCode", Hibernate.STRING)
                .addScalar("itemArmName", Hibernate.STRING)
                .addScalar("itemHingePinCode", Hibernate.STRING)
                .addScalar("itemHingePinName", Hibernate.STRING)
                .addScalar("itemStopPinCode", Hibernate.STRING)
                .addScalar("itemStopPinName", Hibernate.STRING)
                .addScalar("itemOperatorCode", Hibernate.STRING)
                .addScalar("itemOperatorName", Hibernate.STRING)
                .addScalar("quantity", Hibernate.BIG_DECIMAL)   
                .setResultTransformer(Transformers.aliasToBean(InternalMemoProductionDetailTemp .class))
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
    
    private String createCode(InternalMemoProduction internalMemoProduction){
        try{
            String tempKode = EnumTransactionType.ENUM_TransactionType.IM.toString();
            String acronim =  internalMemoProduction.getBranch().getCode()+"/"+tempKode+"/"+AutoNumber.formatingDate(internalMemoProduction.getTransactionDate(), true, true, false);

            DetachedCriteria dc = DetachedCriteria.forClass(InternalMemoProduction.class)
                    .setProjection(Projections.max("code"))
                    .add(Restrictions.like("code", acronim + "%" ));

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
    
    public void save(InternalMemoProduction internalMemoProduction, List<InternalMemoProductionDetail> listInternalMemoProductionDetail, String moduleCode) throws Exception {
        try {
            
            internalMemoProduction.setCode(createCode(internalMemoProduction));
            String headerCode=internalMemoProduction.getCode();
            
            hbmSession.hSession.beginTransaction();
            
            internalMemoProduction.setCode(headerCode);
            internalMemoProduction.setCreatedBy(BaseSession.loadProgramSession().getUserName());
            internalMemoProduction.setCreatedDate(new Date());

            hbmSession.hSession.save(internalMemoProduction);
            
            if(listInternalMemoProductionDetail==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!<br/><br/><B>e.g. Special Character Percent[%] Not Allowed!<B/>");
            }
            
            int i = 1;
            for(InternalMemoProductionDetail detail : listInternalMemoProductionDetail){
                                                            
                String detailCode = internalMemoProduction.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                detail.setCode(detailCode);
                detail.setHeaderCode(internalMemoProduction.getCode());
                                    
                detail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                detail.setCreatedDate(new Date());
                detail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                detail.setUpdatedDate(new Date());
                
                hbmSession.hSession.save(detail);
                            
                i++;
            }
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    internalMemoProduction.getCode(), ""));
            hbmSession.hTransaction.commit();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();
                      
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void update(InternalMemoProduction internalMemoProduction, List<InternalMemoProductionDetail> listInternalMemoProductionDetail, String moduleCode) throws Exception {
        try {

            hbmSession.hSession.beginTransaction();

            internalMemoProduction.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
            internalMemoProduction.setUpdatedDate(new Date());

            hbmSession.hSession.update(internalMemoProduction);

            hbmSession.hSession.createQuery("DELETE FROM "+InternalMemoProductionDetailField.BEAN_NAME+" WHERE "+InternalMemoProductionDetailField.HEADERCODE+" = :prmCode")
                    .setParameter("prmCode", internalMemoProduction.getCode())    
                    .executeUpdate();
            
            hbmSession.hSession.flush();
            
            if(listInternalMemoProductionDetail==null){
                hbmSession.hTransaction.rollback();
                throw new Exception("FAILED DATA DETAIL INPUT!<br/><br/><B>e.g. Special Character Percent[%] Not Allowed!<B/>");
            }
            
            int i = 1;
            for(InternalMemoProductionDetail detail : listInternalMemoProductionDetail){
                                                            
                String detailCode = internalMemoProduction.getCode()+ "-" + org.apache.commons.lang.StringUtils.leftPad(Integer.toString(i),AutoNumber.DEFAULT_TRANSACTION_LENGTH_3, "0");
                detail.setCode(detailCode);
                detail.setHeaderCode(internalMemoProduction.getCode());
                                    
                detail.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                detail.setCreatedDate(new Date());
                detail.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                detail.setUpdatedDate(new Date());
                
                    
                hbmSession.hSession.save(detail);
                            
                i++;
            }
            

            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    internalMemoProduction.getCode(), ""));
            hbmSession.hTransaction.commit();
            hbmSession.hSession.clear();
            hbmSession.hSession.close();
                      
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
        
    }
    
    public void delete(String code, String moduleCode){
        try{
            hbmSession.hSession.beginTransaction();
                    
            hbmSession.hSession.createQuery("DELETE FROM "+InternalMemoProductionField.BEAN_NAME+" WHERE "+InternalMemoProductionField.CODE+" = :prmCode")
                    .setParameter("prmCode", code)    
                    .executeUpdate();
            
            hbmSession.hSession.createQuery("DELETE FROM "+InternalMemoProductionDetailField.BEAN_NAME+" WHERE "+InternalMemoProductionDetailField.HEADERCODE+" = :prmCode")
                    .setParameter("prmCode", code)    
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
        
    public void approval(InternalMemoProduction internalMemoProduction,String moduleCode) throws Exception{
        try {
            
            String approvalBy="";
            Date approvalDate=commonFunction.setDateTime("01/01/1900 00:00:00");
                        
            if(internalMemoProduction.getApprovalStatus().equals(EnumApprovalStatus.ENUM_ApprovalStatus.APPROVED.toString())){
                approvalBy=BaseSession.loadProgramSession().getUserName();
                approvalDate=new Date();
            }

            hbmSession.hSession.beginTransaction();
            
             String prmActivity = "";
            if ("APPROVED".equals(internalMemoProduction.getApprovalStatus())) {
                prmActivity = EnumActivity.toString(EnumActivity.ENUM_Activity.APPROVED);
            }else if ("REJECTED".equals(internalMemoProduction.getApprovalStatus())) {
                prmActivity = EnumActivity.toString(EnumActivity.ENUM_Activity.REJECTED);
            }
//            purchaseOrder.setLastStatus(prmActivity);
            internalMemoProduction.setApprovalBy(approvalBy);
            internalMemoProduction.setApprovalDate(approvalDate);
            //hbmSession.hSession.update(purchaseOrder);
            
            hbmSession.hSession.createQuery("UPDATE InternalMemoProduction SET "
                    + "ApprovalStatus = :prmApprovalstatus, "
                    + "ApprovalBy = :prmApprovalBy, "
                    + "ApprovalDate = :prmApprovalDate, "
                    + "ApprovalRemark = :prmApprovalRemark, "
                    + "approvalReason = :prmApprovalReason "
                    + "WHERE code = :prmCode")
                    .setParameter("prmApprovalstatus", prmActivity)
                    .setParameter("prmApprovalBy", BaseSession.loadProgramSession().getUserName())
                    .setParameter("prmApprovalDate", new Date())
                    .setParameter("prmApprovalRemark", internalMemoProduction.getApprovalRemark())
                    .setParameter("prmApprovalReason", internalMemoProduction.getApprovalReason())
                    .setParameter("prmCode", internalMemoProduction.getCode())
                    .executeUpdate();
            hbmSession.hSession.flush();
                       
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.UPDATE), 
                                                                    internalMemoProduction.getCode(), "Approval: "+internalMemoProduction.getApprovalStatus()));
            hbmSession.hTransaction.commit();
            hbmSession.hSession.close();
        } catch (Exception e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    public void closing(InternalMemoProduction internalMemoProductionClosing, String moduleCode) throws Exception {
        try {
            hbmSession.hSession.beginTransaction();
            
            InternalMemoProduction internalMemoProduction=get(internalMemoProductionClosing.getCode());
            
            String closingBy=BaseSession.loadProgramSession().getUserName();
            Date closingDate=new Date();
            
            internalMemoProduction.setClosingBy(closingBy);
            internalMemoProduction.setClosingDate(closingDate);
            internalMemoProduction.setClosingStatus(internalMemoProductionClosing.getClosingStatus());
            hbmSession.hSession.update(internalMemoProduction);
           

            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    internalMemoProduction.getClosingStatus(), 
                                                                    internalMemoProductionClosing.getCode(), "Closing Process: "+internalMemoProductionClosing.getClosingStatus()));
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
    
    public InternalMemoProduction get(String code) {
        try {
               return (InternalMemoProduction) hbmSession.hSession.get(InternalMemoProduction.class, code);
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
}
