/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.master.dao;

import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.model.CustomerDepositType;
import com.inkombizz.master.model.CustomerDepositTypeChartOfAccount;
import com.inkombizz.master.model.CustomerDepositTypeTemp;
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
public class CustomerDepositTypeDAO {
    
    private HBMSession hbmSession;
    
    public CustomerDepositTypeDAO(HBMSession session){
        this.hbmSession=session;
    }
    
    
    public int countData(){
        try{
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "SELECT "
                + "COUNT(*) " 
                + "FROM mst_customer_deposit_type "
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    } 
    
    public int countDataCoaDetail(CustomerDepositType customerDepositType){
        try{
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "SELECT  "
                    + " COUNT(*) "
                + " FROM "
                    + " mst_customer_deposit_type_jn_chart_of_account "
                + " LEFT JOIN mst_chart_of_account ON mst_chart_of_account.Code = mst_customer_deposit_type_jn_chart_of_account.ChartOfAccountCode "
                + " LEFT JOIN mst_branch ON mst_branch.Code = mst_customer_deposit_type_jn_chart_of_account.BranchCode "
                + " WHERE "
                    + " mst_customer_deposit_type_jn_chart_of_account.CustomerDepositTypeCode = '"+customerDepositType.getCode()+"' "
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    } 
    
    public int countSearchData(CustomerDepositType customerDepositType){
        try{
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "SELECT "
                + "COUNT(*) " 
                + "FROM mst_customer_deposit_type "
                + "LEFT JOIN mst_customer_deposit_type_jn_chart_of_account ON mst_customer_deposit_type_jn_chart_of_account.CustomerDepositTypeCode = mst_customer_deposit_type.Code "
                + "LEFT JOIN mst_chart_of_account ON mst_chart_of_account.Code = mst_customer_deposit_type_jn_chart_of_account.ChartOfAccountCode "
                + "WHERE "
                + "mst_customer_deposit_type.Code LIKE '%"+customerDepositType.getCode()+"%' "
                + "AND mst_customer_deposit_type.Name LIKE '%"+customerDepositType.getName()+"%' "
                + "AND mst_customer_deposit_type_jn_chart_of_account.BranchCode LIKE '%"+customerDepositType.getBranchCode()+"%' "
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    } 
    
    public int countSearchDataForReport(CustomerDepositType customerDepositType){
        try{
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                "SELECT "
                + "COUNT(*) " 
                + "FROM mst_customer_deposit_type "
                + "WHERE "
                + "mst_customer_deposit_type.Code LIKE '%"+customerDepositType.getCode()+"%' "
                + "AND mst_customer_deposit_type.Name LIKE '%"+customerDepositType.getName()+"%' "
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
                + "FROM mst_customer_deposit_type "
                + "WHERE mst_customer_deposit_type.code LIKE :prmCode "
                + "AND mst_customer_deposit_type.name LIKE :prmName "
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
    
    public List<CustomerDepositTypeTemp> findData(int from, int row) throws Exception {
        try {
            
            List<CustomerDepositTypeTemp> list = (List<CustomerDepositTypeTemp>)hbmSession.hSession.createSQLQuery(
                "SELECT  "
                + "mst_customer_deposit_type.Code, "
                + "mst_customer_deposit_type.name "
                + "FROM mst_customer_deposit_type "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(CustomerDepositTypeTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerDepositTypeChartOfAccount> findDataCoaDetail(CustomerDepositType customerDepositType, int from, int row) throws Exception {
        try {
            
            List<CustomerDepositTypeChartOfAccount> list = (List<CustomerDepositTypeChartOfAccount>)hbmSession.hSession.createSQLQuery(
                "SELECT  "
                    + " mst_customer_deposit_type_jn_chart_of_account.Code, "
                    + " mst_customer_deposit_type_jn_chart_of_account.CustomerDepositTypeCode, "
                    + " IFNULL(mst_chart_of_account.Code,'') AS chartOfAccountCode, "
                    + " IFNULL(mst_chart_of_account.Name,'') AS chartOfAccountName, "
                    + " IFNULL(mst_branch.Code,'') AS branchCode, "
                    + " IFNULL(mst_branch.Name,'') AS branchName "
                + " FROM "
                    + " mst_customer_deposit_type_jn_chart_of_account "
                + " LEFT JOIN mst_chart_of_account ON mst_chart_of_account.Code = mst_customer_deposit_type_jn_chart_of_account.ChartOfAccountCode "
                + " LEFT JOIN mst_branch ON mst_branch.Code = mst_customer_deposit_type_jn_chart_of_account.BranchCode "
                + " WHERE "
                    + " mst_customer_deposit_type_jn_chart_of_account.CustomerDepositTypeCode = '"+customerDepositType.getCode()+"' "
                + "LIMIT "+from+","+row+""
                )
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("chartOfAccountCode", Hibernate.STRING)
                .addScalar("chartOfAccountName", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(CustomerDepositTypeChartOfAccount.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerDepositTypeTemp> searchData(CustomerDepositType customerDepositType, int from, int row) throws Exception {
        try {
            
            List<CustomerDepositTypeTemp> list = (List<CustomerDepositTypeTemp>)hbmSession.hSession.createSQLQuery(
                "SELECT  "
                + "mst_customer_deposit_type.Code, "
                + "mst_customer_deposit_type.name, "
                + "IFNULL(mst_chart_of_account.Code,'') AS chartOfAccountCode, "
                + "IFNULL(mst_chart_of_account.Name,'') AS chartOfAccountName "
                + "FROM mst_customer_deposit_type "
                + "LEFT JOIN mst_customer_deposit_type_jn_chart_of_account ON mst_customer_deposit_type_jn_chart_of_account.CustomerDepositTypeCode = mst_customer_deposit_type.Code "
                + "LEFT JOIN mst_chart_of_account ON mst_chart_of_account.Code = mst_customer_deposit_type_jn_chart_of_account.ChartOfAccountCode "
                + "WHERE "
                + "mst_customer_deposit_type.Code LIKE '%"+customerDepositType.getCode()+"%' "
                + "AND mst_customer_deposit_type.Name LIKE '%"+customerDepositType.getName()+"%' "
                + "AND mst_customer_deposit_type_jn_chart_of_account.BranchCode LIKE '%"+customerDepositType.getBranchCode()+"%' "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("chartOfAccountCode", Hibernate.STRING)
                .addScalar("chartOfAccountName", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(CustomerDepositTypeTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerDepositTypeTemp> findDataReportPaging(String code, String name,int from, int row) {
        try {
            List<CustomerDepositTypeTemp> list = (List<CustomerDepositTypeTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "mst_customer_deposit_type.code, "             
                + "mst_customer_deposit_type.name "          
                + "FROM mst_customer_deposit_type "          
                + "WHERE mst_customer_deposit_type.code LIKE '%"+code+"%' "
                + "AND mst_customer_deposit_type.name LIKE '%"+name+"%' "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)     
                .addScalar("name", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(CustomerDepositTypeTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerDepositTypeTemp> searchDataForReport(CustomerDepositType customerDepositType, int from, int row) throws Exception {
        try {
            
            List<CustomerDepositTypeTemp> list = (List<CustomerDepositTypeTemp>)hbmSession.hSession.createSQLQuery(
                "SELECT  "
                + "mst_customer_deposit_type.Code, "
                + "mst_customer_deposit_type.name "
                + "FROM mst_customer_deposit_type "
                + "WHERE "
                + "mst_customer_deposit_type.Code LIKE '%"+customerDepositType.getCode()+"%' "
                + "AND mst_customer_deposit_type.Name LIKE '%"+customerDepositType.getName()+"%' "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(CustomerDepositTypeTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    // get
    public CustomerDepositTypeTemp findData(CustomerDepositType customerDepositType) {
        try {
                CustomerDepositTypeTemp customerDepositTypeTemp = (CustomerDepositTypeTemp) hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + " mst_customer_deposit_type.Code, "
                + " mst_customer_deposit_type.Name, "
                + " mst_customer_deposit_type_jn_chart_of_account.BranchCode, "
                + " mst_customer_deposit_type_jn_chart_of_account.ChartOfAccountCode, "
                + " mst_chart_of_account.Name AS chartOfAccountName "
                + "  FROM mst_customer_deposit_type "
                + " LEFT JOIN mst_customer_deposit_type_jn_chart_of_account ON mst_customer_deposit_type_jn_chart_of_account.CustomerDepositTypeCode = mst_customer_deposit_type.Code "
                + " LEFT JOIN mst_chart_of_account ON mst_chart_of_account.Code = mst_customer_deposit_type_jn_chart_of_account.ChartOfAccountCode "
                + " WHERE "
                    + " mst_customer_deposit_type.Code = '"+customerDepositType.getCode()+"' "
                    + " AND mst_customer_deposit_type_jn_chart_of_account.BranchCode = '"+customerDepositType.getBranchCode()+"' "
                )
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("chartOfAccountCode", Hibernate.STRING)
                .addScalar("chartOfAccountName", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(CustomerDepositTypeTemp.class))
                .uniqueResult(); 
                 
                return customerDepositTypeTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public CustomerDepositTypeTemp findDataForReport(CustomerDepositType customerDepositType) {
        try {
                CustomerDepositTypeTemp customerDepositTypeTemp = (CustomerDepositTypeTemp) hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + " mst_customer_deposit_type.Code, "
                + " mst_customer_deposit_type.Name "
                + "  FROM mst_customer_deposit_type "
                + " WHERE "
                    + " mst_customer_deposit_type.Code = '"+customerDepositType.getCode()+"' "
                )
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(CustomerDepositTypeTemp.class))
                .uniqueResult(); 
                 
                return customerDepositTypeTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<CustomerDepositTypeChartOfAccount> findDataChartOfAccount(String code) throws Exception {
        try {
            
            List<CustomerDepositTypeChartOfAccount> list = (List<CustomerDepositTypeChartOfAccount>)hbmSession.hSession.createSQLQuery(
                "SELECT  "
                + " mst_customer_deposit_type_jn_chart_of_account.BranchCode, "
                + " mst_branch.Name AS branchName, "
                + " IFNULL(mst_customer_deposit_type_jn_chart_of_account.ChartOfAccountCode,'') AS chartOfAccountCode, "
                + " IFNULL(mst_chart_of_account.Name,'') AS chartOfAccountName "
                + " FROM  "
                + " mst_customer_deposit_type_jn_chart_of_account "
                + " INNER JOIN mst_branch ON mst_branch.Code = mst_customer_deposit_type_jn_chart_of_account.BranchCode "
                + " LEFT JOIN mst_chart_of_account ON mst_chart_of_account.Code = mst_customer_deposit_type_jn_chart_of_account.ChartOfAccountCode "
                + " WHERE "
                + " mst_customer_deposit_type_jn_chart_of_account.CustomerDepositTypeCode ='"+code+"' "
            )
                    
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("chartOfAccountCode", Hibernate.STRING)
                .addScalar("chartOfAccountName", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(CustomerDepositTypeChartOfAccount.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public CustomerDepositType get(String code) {
        try {
            return (CustomerDepositType) hbmSession.hSession.get(CustomerDepositType.class, code);
           
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
                + " FROM mst_customer_deposit_type_jn_chart_of_account "
                + " WHERE mst_customer_deposit_type_jn_chart_of_account.CustomerDepositTypeCode = '"+code+"' "
            ).uniqueResult();
            return temp.intValue();
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public CustomerDepositTypeTemp getMin() {
        try {
            
            String qry = "SELECT mst_customer_deposit_type.code,mst_customer_deposit_type.Name FROM mst_customer_deposit_type ORDER BY mst_customer_deposit_type.code LIMIT 0,1";
            CustomerDepositTypeTemp customerDepositTypeTemp =(CustomerDepositTypeTemp)hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(CustomerDepositTypeTemp.class))
                    .uniqueResult();   
            
            return customerDepositTypeTemp;
            
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public CustomerDepositTypeTemp getMax() {
        try {
            
            String qry = "SELECT mst_customer_deposit_type.code,mst_customer_deposit_type.Name FROM mst_customer_deposit_type ORDER BY mst_customer_deposit_type.code DESC LIMIT 0,1";
            CustomerDepositTypeTemp customerDepositTypeTemp =(CustomerDepositTypeTemp)hbmSession.hSession.createSQLQuery(qry)
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("name", Hibernate.STRING)
            .setResultTransformer(Transformers.aliasToBean(CustomerDepositTypeTemp.class))
                    .uniqueResult();   
            
            return customerDepositTypeTemp;
            
        }
        catch (HibernateException e) {
            throw e;
        }
        
    }    
    
    public void save(CustomerDepositType customerDepositType, 
            List<CustomerDepositTypeChartOfAccount> listCustomerDepositTypeChartOfAccount,
            String MODULECODE) throws Exception {
        try {

            hbmSession.hSession.beginTransaction();

            //delete item
            String sql = "DELETE FROM mst_customer_deposit_type_jn_chart_of_account WHERE mst_customer_deposit_type_jn_chart_of_account.CustomerDepositTypeCode = :prmHeaderCode";
            hbmSession.hSession.createSQLQuery(sql)
                    .setParameter("prmHeaderCode", customerDepositType.getCode())
                    .executeUpdate();
            hbmSession.hSession.flush();
            
            //insertNew Data
            int i = 1;
            for (CustomerDepositTypeChartOfAccount detail : listCustomerDepositTypeChartOfAccount) {
                String detailCode = customerDepositType.getCode() +"-"+ detail.getBranch().getCode();
                
                detail.setCode(detailCode);
                detail.setCustomerDepositTypeCode(customerDepositType.getCode());
                
                hbmSession.hSession.save(detail);
                hbmSession.hSession.flush();
                i++;
            }

            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(MODULECODE,
                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT),
                    customerDepositType.getCode(), "CUSTOMER DEPOSIT TYPE"));
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
