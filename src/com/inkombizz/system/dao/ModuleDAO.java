package com.inkombizz.system.dao;

import java.util.List;

import org.hibernate.HibernateException;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.system.model.Module;
import com.inkombizz.system.model.ModuleTemp;
import java.math.BigInteger;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;

public class ModuleDAO {
    private HBMSession hbmSession;
	
    public ModuleDAO(HBMSession session) {
        this.hbmSession = session;
    }

    public int countData(String name){
        try{
            
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) "
                + "FROM sys_module "
                + "LEFT JOIN mst_branch ON sys_module.BranchCode=mst_branch.Code "
                + "LEFT JOIN mst_company ON sys_module.CompanyCode=mst_company.Code "
                + "WHERE sys_module.Name LIKE '%"+name+"%' "
                + "AND sys_module.ActiveStatus=1 "
                + "AND sys_module.ModuleInputStatus=1 "
                ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
        
    public List<ModuleTemp> findData(String name, int from,int to) {
        try {

                        
            List<ModuleTemp> list = (List<ModuleTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "sys_module.Code, "
                + "sys_module.Name, "
                + "sys_module.BranchCode, "
                + "mst_branch.Name AS BranchName, "
                + "sys_module.CompanyCode, "
                + "mst_company.Name AS CompanyName "
                + "FROM sys_module "
                + "LEFT JOIN mst_branch ON sys_module.BranchCode=mst_branch.Code "
                + "LEFT JOIN mst_company ON sys_module.CompanyCode=mst_company.Code "
                + "WHERE sys_module.Name LIKE '%"+name+"%' "
                + "AND sys_module.ActiveStatus=1 "
                + "AND sys_module.ModuleInputStatus=1 "
                + "ORDER BY sys_module.Code "
                + "LIMIT "+from+","+to+"")
                 
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)    
                .addScalar("branchName", Hibernate.STRING)    
                .addScalar("companyCode", Hibernate.STRING)    
                .addScalar("companyName", Hibernate.STRING)
                .setResultTransformer(Transformers.aliasToBean(ModuleTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }

    public List<ModuleTemp> findDataForUpdate(){
        try{
            
            String qry =
                    "SELECT "
                + "sys_module.Code, "
                + "sys_module.Name, "
                + "sys_module.ActiveStatus, "
                + "sys_module.BranchCode, "
                + "mst_branch.Name AS BranchName, "
                + "sys_module.CompanyCode, "
                + "mst_company.Name AS CompanyName,"
                + "sys_module.ModuleInputStatus, "
                + "sys_module.CreatedBy,"
                + "sys_module.CreatedDate "
                + "FROM sys_module "
                + "LEFT JOIN mst_branch ON sys_module.BranchCode=mst_branch.Code "
                + "LEFT JOIN mst_company ON sys_module.CompanyCode=mst_company.Code "
                + "WHERE sys_module.ModuleInputStatus=1 "
                + "AND sys_module.ActiveStatus=1 "
                + "ORDER BY sys_module.Code";
            
            List<ModuleTemp> listModuleTemp = hbmSession.hSession.createSQLQuery(qry)
                .addScalar("code", Hibernate.STRING)
                .addScalar("name", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("companyCode", Hibernate.STRING)
                .addScalar("companyName", Hibernate.STRING)
                .addScalar("moduleInputStatus", Hibernate.BOOLEAN)
                .addScalar("createdBy", Hibernate.STRING)
                .addScalar("createdDate", Hibernate.DATE)
                .setResultTransformer(Transformers.aliasToBean(ModuleTemp.class))
                .list();
            
            return listModuleTemp;
        }
        catch(HibernateException e){
            e.printStackTrace();
        }
        return null;
    }
        
    public void update(List<Module> listModule) {
        try {
            hbmSession.hSession.beginTransaction();
            
            for (Module module : listModule) {
                      
                hbmSession.hSession.createSQLQuery(
                        "UPDATE sys_module "
                    + "SET "
                    + "sys_module.BranchCode='"+module.getBranch().getCode()+"', "
//                    + "sys_module.CompanyCode='"+module.getCompany().getCode()+"' "
                    + "WHERE Code='"+module.getCode()+"'"
                ).executeUpdate();
            }   
            
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }

}