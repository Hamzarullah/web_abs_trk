/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.master.dao;

import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.model.VendorDepositType;
import com.inkombizz.master.model.VendorDepositTypeChartOfAccount;
import com.inkombizz.master.model.VendorDepositTypeTemp;
import com.inkombizz.system.dao.TransactionLogDAO;
import java.math.BigInteger;
import java.util.List;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.transform.Transformers;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author CHRIST
 */
public class VendorDepositTypeDAO {
    
    private HBMSession hbmSession;
    
    public VendorDepositTypeDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    
    public int countData(){
        try{
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "SELECT "
                + "COUNT(*) " 
                + "FROM mst_vendor_deposit_type "
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    } 
    
    public int countDataCoaDetail(VendorDepositType vendorDepositType){
        try{
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "SELECT  "
                    + " COUNT(*) "
                + " FROM "
                    + " mst_vendor_deposit_type_jn_chart_of_account "
                + " LEFT JOIN mst_chart_of_account ON mst_chart_of_account.Code = mst_vendor_deposit_type_jn_chart_of_account.ChartOfAccountCode "
                + " LEFT JOIN mst_branch ON mst_branch.Code = mst_vendor_deposit_type_jn_chart_of_account.BranchCode "
                + " WHERE "
                    + " mst_vendor_deposit_type_jn_chart_of_account.VendorDepositTypeCode = '"+vendorDepositType.getCode()+"' "
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    } 
    
    public int countDataReportPaging(String code,String name){
        try{
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) " 
                + "FROM mst_vendor_deposit_type "
                + "WHERE mst_vendor_deposit_type.code LIKE :prmCode "
                + "AND mst_vendor_deposit_type.name LIKE :prmName "
                )
                    .setParameter("prmCode", "%"+code+"%")
                    .setParameter("prmName", "%"+name+"%")
                    .uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public int countSearchDataForReport(VendorDepositType vendorDepositType){
        try{
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "SELECT "
                + "COUNT(*) " 
                + "FROM mst_vendor_deposit_type "
                + "WHERE "
                + "mst_vendor_deposit_type.Code LIKE '%"+vendorDepositType.getCode()+"%' "
                + "AND mst_vendor_deposit_type.Name LIKE '%"+vendorDepositType.getName()+"%' "
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    } 
    
    public int countSearchData(VendorDepositType vendorDepositType){
        try{
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "SELECT "
                + "COUNT(*) " 
                + "FROM mst_vendor_deposit_type "
                + "LEFT JOIN mst_vendor_deposit_type_jn_chart_of_account ON mst_vendor_deposit_type_jn_chart_of_account.VendorDepositTypeCode = mst_vendor_deposit_type.Code "
                + "LEFT JOIN mst_chart_of_account ON mst_chart_of_account.Code = mst_vendor_deposit_type_jn_chart_of_account.ChartOfAccountCode "
                + "WHERE "
                + "mst_vendor_deposit_type.Code LIKE '%"+vendorDepositType.getCode()+"%' "
                + "AND mst_vendor_deposit_type.Name LIKE '%"+vendorDepositType.getName()+"%' "
                + "AND mst_vendor_deposit_type_jn_chart_of_account.BranchCode LIKE '%"+vendorDepositType.getBranchCode()+"%' "
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    } 
    
    public List<VendorDepositTypeTemp> searchDataForReport(VendorDepositType vendorDepositType, int from, int row) throws Exception {
        try {
            
            List<VendorDepositTypeTemp> list = (List<VendorDepositTypeTemp>)hbmSession.hSession.createSQLQuery(
                "SELECT  "
                + "mst_vendor_deposit_type.Code, "
                + "mst_vendor_deposit_type.name "
                + "FROM mst_vendor_deposit_type "
                + "WHERE "
                + "mst_vendor_deposit_type.Code LIKE '%"+vendorDepositType.getCode()+"%' "
                + "AND mst_vendor_deposit_type.Name LIKE '%"+vendorDepositType.getName()+"%' "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(VendorDepositTypeTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<VendorDepositTypeTemp> findDataReportPaging(String code, String name,int from, int row) {
        try {
            List<VendorDepositTypeTemp> list = (List<VendorDepositTypeTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_vendor_deposit_type.code, "             
                + "mst_vendor_deposit_type.name "          
                + "FROM mst_vendor_deposit_type "          
                + "WHERE mst_vendor_deposit_type.code LIKE '%"+code+"%' "
                + "AND mst_vendor_deposit_type.name LIKE '%"+name+"%' "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)     
                .addScalar("name", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(VendorDepositTypeTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public VendorDepositTypeTemp findDataForReport(VendorDepositType vendorDepositType) {
        try {
                VendorDepositTypeTemp vendorDepositTypeTemp = (VendorDepositTypeTemp) hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + " mst_vendor_deposit_type.Code, "
                + " mst_vendor_deposit_type.Name "
                + "  FROM mst_vendor_deposit_type "
                + " WHERE "
                    + " mst_vendor_deposit_type.Code = '"+vendorDepositType.getCode()+"' "
                )
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(VendorDepositTypeTemp.class))
                .uniqueResult(); 
                 
                return vendorDepositTypeTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public VendorDepositTypeTemp getMin() {
        try {
            
            String qry = "SELECT mst_vendor_deposit_type.code,mst_vendor_deposit_type.Name FROM mst_vendor_deposit_type ORDER BY mst_vendor_deposit_type.code LIMIT 0,1";
            VendorDepositTypeTemp vendorDepositTypeTemp =(VendorDepositTypeTemp)hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(VendorDepositTypeTemp.class))
                    .uniqueResult();   
            
            return vendorDepositTypeTemp;
            
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public VendorDepositTypeTemp getMax() {
        try {
            
            String qry = "SELECT mst_vendor_deposit_type.code,mst_vendor_deposit_type.Name FROM mst_vendor_deposit_type ORDER BY mst_vendor_deposit_type.code DESC LIMIT 0,1";
            VendorDepositTypeTemp vendorDepositTypeTemp =(VendorDepositTypeTemp)hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(VendorDepositTypeTemp.class))
                    .uniqueResult();   
            
            return vendorDepositTypeTemp;
            
        }
        catch (HibernateException e) {
            throw e;
        }
        
    }
    
    public List<VendorDepositTypeTemp> findData(int from, int row) throws Exception {
        try {
            
            List<VendorDepositTypeTemp> list = (List<VendorDepositTypeTemp>)hbmSession.hSession.createSQLQuery(
                "SELECT  "
                + "mst_vendor_deposit_type.Code, "
                + "mst_vendor_deposit_type.name "
                + "FROM mst_vendor_deposit_type "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(VendorDepositTypeTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<VendorDepositTypeChartOfAccount> findDataCoaDetail(VendorDepositType vendorDepositType, int from, int row) throws Exception {
        try {
            
            List<VendorDepositTypeChartOfAccount> list = (List<VendorDepositTypeChartOfAccount>)hbmSession.hSession.createSQLQuery(
                "SELECT  "
                    + " mst_vendor_deposit_type_jn_chart_of_account.Code, "
                    + " mst_vendor_deposit_type_jn_chart_of_account.VendorDepositTypeCode, "
                    + " IFNULL(mst_chart_of_account.Code,'') AS chartOfAccountCode, "
                    + " IFNULL(mst_chart_of_account.Name,'') AS chartOfAccountName, "
                    + " IFNULL(mst_branch.Code,'') AS branchCode, "
                    + " IFNULL(mst_branch.Name,'') AS branchName "
                + " FROM "
                    + " mst_vendor_deposit_type_jn_chart_of_account "
                + " LEFT JOIN mst_chart_of_account ON mst_chart_of_account.Code = mst_vendor_deposit_type_jn_chart_of_account.ChartOfAccountCode "
                + " LEFT JOIN mst_branch ON mst_branch.Code = mst_vendor_deposit_type_jn_chart_of_account.BranchCode "
                + " WHERE "
                    + " mst_vendor_deposit_type_jn_chart_of_account.VendorDepositTypeCode = '"+vendorDepositType.getCode()+"' "
                + "LIMIT "+from+","+row+""
                )
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("chartOfAccountCode", Hibernate.STRING)
                .addScalar("chartOfAccountName", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(VendorDepositTypeChartOfAccount.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<VendorDepositTypeTemp> searchData(VendorDepositType vendorDepositType, int from, int row) throws Exception {
        try {
            
            List<VendorDepositTypeTemp> list = (List<VendorDepositTypeTemp>)hbmSession.hSession.createSQLQuery(
                "SELECT  "
                + "mst_vendor_deposit_type.Code, "
                + "mst_vendor_deposit_type.name, "
                + "IFNULL(mst_chart_of_account.Code,'') AS chartOfAccountCode, "
                + "IFNULL(mst_chart_of_account.Name,'') AS chartOfAccountName "
                + "FROM mst_vendor_deposit_type "
                + "LEFT JOIN mst_vendor_deposit_type_jn_chart_of_account ON mst_vendor_deposit_type_jn_chart_of_account.VendorDepositTypeCode = mst_vendor_deposit_type.Code "
                + "LEFT JOIN mst_chart_of_account ON mst_chart_of_account.Code = mst_vendor_deposit_type_jn_chart_of_account.ChartOfAccountCode "
                + "WHERE "
                + "mst_vendor_deposit_type.Code LIKE '%"+vendorDepositType.getCode()+"%' "
                + "AND mst_vendor_deposit_type.Name LIKE '%"+vendorDepositType.getName()+"%' "
                + "AND mst_vendor_deposit_type_jn_chart_of_account.BranchCode LIKE '%"+vendorDepositType.getBranchCode()+"%' "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("chartOfAccountCode", Hibernate.STRING)
                .addScalar("chartOfAccountName", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(VendorDepositTypeTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    // get
    public VendorDepositTypeTemp findData(VendorDepositType vendorDepositType) {
        try {
                VendorDepositTypeTemp vendorDepositTypeTemp = (VendorDepositTypeTemp) hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + " mst_vendor_deposit_type.Code, "
                + " mst_vendor_deposit_type.Name, "
                + " mst_vendor_deposit_type_jn_chart_of_account.BranchCode, "
                + " mst_vendor_deposit_type_jn_chart_of_account.ChartOfAccountCode, "
                + " mst_chart_of_account.Name AS chartOfAccountName "
                + "  FROM mst_vendor_deposit_type "
                + " LEFT JOIN mst_vendor_deposit_type_jn_chart_of_account ON mst_vendor_deposit_type_jn_chart_of_account.VendorDepositTypeCode = mst_vendor_deposit_type.Code "
                + " LEFT JOIN mst_chart_of_account ON mst_chart_of_account.Code = mst_vendor_deposit_type_jn_chart_of_account.ChartOfAccountCode "
                + " WHERE "
                    + " mst_vendor_deposit_type.Code = '"+vendorDepositType.getCode()+"' "
                    + " AND mst_vendor_deposit_type_jn_chart_of_account.BranchCode = '"+vendorDepositType.getBranchCode()+"' "
                )
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("chartOfAccountCode", Hibernate.STRING)
                .addScalar("chartOfAccountName", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(VendorDepositTypeTemp.class))
                .uniqueResult(); 
                 
                return vendorDepositTypeTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<VendorDepositTypeChartOfAccount> findDataChartOfAccount(String code) throws Exception {
        try {
            
            List<VendorDepositTypeChartOfAccount> list = (List<VendorDepositTypeChartOfAccount>)hbmSession.hSession.createSQLQuery(
                "SELECT  "
                + " mst_vendor_deposit_type_jn_chart_of_account.BranchCode, "
                + " mst_branch.Name AS branchName, "
                + " IFNULL(mst_vendor_deposit_type_jn_chart_of_account.ChartOfAccountCode,'') AS chartOfAccountCode, "
                + " IFNULL(mst_chart_of_account.Name,'') AS chartOfAccountName "
                + " FROM  "
                + " mst_vendor_deposit_type_jn_chart_of_account "
                + " INNER JOIN mst_branch ON mst_branch.Code = mst_vendor_deposit_type_jn_chart_of_account.BranchCode "
                + " LEFT JOIN mst_chart_of_account ON mst_chart_of_account.Code = mst_vendor_deposit_type_jn_chart_of_account.ChartOfAccountCode "
                + " WHERE "
                + " mst_vendor_deposit_type_jn_chart_of_account.VendorDepositTypeCode ='"+code+"' "
            )
                    
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("chartOfAccountCode", Hibernate.STRING)
                .addScalar("chartOfAccountName", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(VendorDepositTypeChartOfAccount.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public VendorDepositType get(String code) {
        try {
            return (VendorDepositType) hbmSession.hSession.get(VendorDepositType.class, code);
           
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public int getDetailStatus(String code) {
        try {
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                " SELECT "
                + " COUNT(*) " 
                + " FROM mst_vendor_deposit_type_jn_chart_of_account "
                + " WHERE mst_vendor_deposit_type_jn_chart_of_account.VendorDepositTypeCode = '"+code+"' "
            ).uniqueResult();
            return temp.intValue();
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public void save(VendorDepositType vendorDepositType, 
            List<VendorDepositTypeChartOfAccount> listVendorDepositTypeChartOfAccount,
            String MODULECODE) throws Exception {
        try {

            hbmSession.hSession.beginTransaction();

            //delete item
            String sql = "DELETE FROM mst_vendor_deposit_type_jn_chart_of_account WHERE mst_vendor_deposit_type_jn_chart_of_account.VendorDepositTypeCode = :prmHeaderCode";
            hbmSession.hSession.createSQLQuery(sql)
                    .setParameter("prmHeaderCode", vendorDepositType.getCode())
                    .executeUpdate();
            hbmSession.hSession.flush();
            
            //insertNew Data
            int i = 1;
            for (VendorDepositTypeChartOfAccount detail : listVendorDepositTypeChartOfAccount) {
                String detailCode = vendorDepositType.getCode() +"-"+ detail.getBranch().getCode();
                
                detail.setCode(detailCode);
                detail.setVendorDepositTypeCode(vendorDepositType.getCode());
                
                hbmSession.hSession.save(detail);
                hbmSession.hSession.flush();
                i++;
            }

            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(MODULECODE,
                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT),
                    vendorDepositType.getCode(), "CUSTOMER DEPOSIT TYPE"));
            hbmSession.hTransaction.commit();

        } catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    
    
    
    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }
    
    
    
}
