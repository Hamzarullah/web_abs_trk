package com.inkombizz.security.dao;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.TransactionLogCommon;
import com.inkombizz.common.enumeration.EnumTransactionAction;
import com.inkombizz.common.enumeration.EnumTransactionAction.ENUM_TransactionAction;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.security.model.ChangePassword;
import com.inkombizz.security.model.User;
import com.inkombizz.security.model.UserBranch;
import com.inkombizz.security.model.UserBranchTemp;
import com.inkombizz.security.model.UserDivision;
import com.inkombizz.security.model.UserDivisionTemp;
import com.inkombizz.security.model.UserField;
import com.inkombizz.security.model.UserTemp;
import com.inkombizz.system.dao.TransactionLogDAO;
import com.inkombizz.system.model.Setup;
import java.math.BigInteger;
import java.util.Date;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.transform.Transformers;

public class UserDAO {
    
    private HBMSession hbmSession;
    
    public UserDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
    public int countData(String username,String roleCode,String roleName,String active){
        try{
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND scr_user.ActiveStatus="+active+"";
            }
            BigInteger temp = (BigInteger)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "COUNT(*) "
                + "FROM scr_user "
                + "INNER JOIN scr_role ON scr_user.RoleCode=scr_role.Code "
                + "LEFT JOIN mst_employee ON scr_user.EmployeeCode=mst_employee.Code "
                + "WHERE scr_user.Username LIKE '%"+username+"%' "
//                + "AND scr_user.FullName LIKE '%"+fullName+"%' "
//                + "AND scr_user.EmployeeCode LIKE '%"+employeeCode+"%' "
//                + "AND mst_employee.Name LIKE '%"+employeeName+"%' "
                + "AND scr_user.RoleCode LIKE '%"+roleCode+"%' "
                + "AND scr_role.Name LIKE '%"+roleName+"%' "
                + concat_qry
            ).uniqueResult();
            return temp.intValue();
            
        }catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    
    public List<User> findByCriteria(DetachedCriteria dc, int from, int size){
        try{
            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            
            criteria.setFirstResult(from);
            criteria.setMaxResults(size);
            
            return criteria.list();
        }
        catch(HibernateException e){
            throw e;
        }        
    };
    
    public List<UserTemp> findData(String username,String roleCode,String roleName,String active,int from, int row) {
        try {
            String concat_qry="";
            if(!active.equals("")){
                concat_qry="AND scr_user.ActiveStatus="+active+" ";
            }
            List<UserTemp> list = (List<UserTemp>)hbmSession.hSession.createSQLQuery(
                    "SELECT  "
                + "scr_user.Code, "
                + "scr_user.employeeCode, "
                + "mst_employee.Name AS EmployeeName, "
                + "scr_user.Password, "
                + "scr_user.Username, "
                + "scr_user.FullName, "
                + "scr_user.RoleCode, "
                + "scr_role.Name AS RoleName, "            
                + "scr_user.ActiveStatus "
                + "FROM scr_user "
                + "LEFT JOIN mst_employee ON scr_user.employeeCode=mst_employee.Code "
                + "INNER JOIN scr_role ON scr_user.RoleCode=scr_role.Code "
                + "WHERE scr_user.Username LIKE '%"+username+"%' "
//                + "AND scr_user.FullName LIKE '%"+fullName+"%' "
//                + "AND scr_user.EmployeeCode LIKE '%"+employeeCode+"%' "
//                + "AND mst_employee.Name LIKE '%"+employeeName+"%' "
                + "AND scr_user.RoleCode LIKE '%"+roleCode+"%' "
                + "AND scr_role.Name LIKE '%"+roleName+"%' "
                + concat_qry
                + "ORDER BY scr_user.code ASC "
                + "LIMIT "+from+","+row+"")
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("username", Hibernate.STRING)
                .addScalar("fullName", Hibernate.STRING)
                .addScalar("employeeCode", Hibernate.STRING)
                .addScalar("employeeName", Hibernate.STRING)
                .addScalar("password", Hibernate.STRING)
                .addScalar("roleCode", Hibernate.STRING)
                .addScalar("roleName", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)    
                .setResultTransformer(Transformers.aliasToBean(UserTemp.class))
                .list(); 
                 
                return list;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public UserTemp getUpdate(String code) {
        try {
            UserTemp userTemp = (UserTemp)hbmSession.hSession.createSQLQuery(
                    "SELECT "
                + "scr_user.Code, "
                + "scr_user.Username, "
                + "scr_user.FullName, "
                + "scr_user.Password, "
                + "scr_user.EmployeeCode AS employeeCode, "
                + "mst_employee.Name AS employeeName, "
                + "scr_user.ActiveStatus, "
                + "scr_user.RoleCode AS roleCode, "
                + "scr_role.Name AS roleName, "
                + "scr_user.DefaultBranchCode AS branchCode, "
                + "mst_branch.Name AS branchName, "
                + "mst_division.Code AS divisionCode, "
                + "mst_division.Name AS divisionName, "
                + "scr_user.Remark "
                + "FROM "
                + "scr_user "
                + "LEFT JOIN mst_employee ON mst_employee.Code = scr_user.EmployeeCode "
                + "INNER JOIN scr_role ON scr_role.Code = scr_user.RoleCode "
                + "LEFT JOIN mst_branch ON mst_branch.Code = scr_user.DefaultBranchCode "
                + "LEFT JOIN mst_division ON mst_division.Code = scr_user.DefaultDivisionCode "
                + "WHERE scr_user.Code ='"+code+"' "
            )
                    
                .addScalar("code", Hibernate.STRING)
                .addScalar("username", Hibernate.STRING)
                .addScalar("fullName", Hibernate.STRING)
                .addScalar("password", Hibernate.STRING)
                .addScalar("employeeCode", Hibernate.STRING)
                .addScalar("employeeName", Hibernate.STRING)
                .addScalar("roleCode", Hibernate.STRING)
                .addScalar("roleName", Hibernate.STRING)
                .addScalar("branchCode", Hibernate.STRING)
                .addScalar("branchName", Hibernate.STRING)
                .addScalar("remark", Hibernate.STRING)
                .addScalar("divisionCode", Hibernate.STRING)
                .addScalar("divisionName", Hibernate.STRING)
                .addScalar("activeStatus", Hibernate.BOOLEAN)
                    
                .setResultTransformer(Transformers.aliasToBean(UserTemp.class))
                .uniqueResult(); 
                 
                return userTemp;
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<User> findByCriteria(DetachedCriteria dc) {
        try {
            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            return criteria.list();
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<UserBranch> findDetailByCriteria(DetachedCriteria dc, int from, int size) {
        try {
            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            criteria.setFirstResult(from)
                    .setMaxResults(size);
            return criteria.list();
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<UserDivision>findDetailByCriteriaDivision(DetachedCriteria dc, int from, int size) {
        try {
            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            criteria.setFirstResult(from)
                    .setMaxResults(size);
            return criteria.list();
        }
        catch (HibernateException e) {
            throw e;
        }
    }
    
    public List<UserBranchTemp> getListUserBranchManual(String userCode){
        try{
            List<UserBranchTemp> list = (List<UserBranchTemp>)hbmSession.hSession.createSQLQuery(""
                    + "SELECT "
                        + "scr_user_branch.Code, "
                        + "scr_user_branch.UserCode, "
                        + "scr_user_branch.BranchCode, "
                        + "mst_branch.Name AS BranchName "
                    + "FROM scr_user_branch "
                    + "LEFT JOIN mst_branch ON mst_branch.Code = scr_user_branch.BranchCode "
                    + "WHERE scr_user_branch.UserCode = '"+userCode+"' ")
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("userCode", Hibernate.STRING)
                    .addScalar("branchCode", Hibernate.STRING)
                    .addScalar("branchName", Hibernate.STRING)
                    .setResultTransformer(Transformers.aliasToBean(UserBranchTemp.class))
                    .list(); 
            
            return list;
        }
        catch(HibernateException e){
            throw e;
        }
    }
    
    public List<UserDivisionTemp> getListUserDivisionManual(String userCode){
        try{
            List<UserDivisionTemp> list = (List<UserDivisionTemp>)hbmSession.hSession.createSQLQuery(""
                    + "SELECT "
                        + "scr_user_division.Code, "
                        + "scr_user_division.UserCode, "
                        + "scr_user_division.DivisionCode, "
                        + "mst_division.Name AS DivisionName "
                    + "FROM scr_user_division "
                    + "LEFT JOIN mst_division ON mst_division.Code = scr_user_division.DivisionCode "
                    + "WHERE scr_user_division.UserCode = '"+userCode+"' ")
                    .addScalar("code", Hibernate.STRING)
                    .addScalar("userCode", Hibernate.STRING)
                    .addScalar("divisionCode", Hibernate.STRING)
                    .addScalar("divisionName", Hibernate.STRING)
                    .setResultTransformer(Transformers.aliasToBean(UserDivisionTemp.class))
                    .list(); 
            
            return list; 
        }
        catch(HibernateException e){
            throw e;
        }
    }
    
    public int countByCriteria(DetachedCriteria dc){
        try{
            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            
            criteria.setProjection(Projections.rowCount() );
            
            if(criteria.list().isEmpty())
                return 0;
            else
                return ((Integer) criteria.list().get(0)).intValue();
        }
        catch(HibernateException e){
            throw e;
        }
    };
    
    public User get(String code) {
        try{
            return (User) hbmSession.hSession.get(User.class, code);
        }
        catch(HibernateException e) {
            throw e;
        }
    };
    
    public Setup getSetup(){
        DetachedCriteria criteria = DetachedCriteria.forClass(Setup.class, "Setup");
        Setup setup = (Setup) criteria.getExecutableCriteria(hbmSession.hSession).list().get(0);
        return setup;
                
    }
    
    public User isLogin(String userName, String password) {//ini akan tidak dipakai
      try{
         User user = new User();
          String hql = "FROM " + UserField.BEAN_NAME + 
                       " WHERE " + UserField.CODE + " = :prmUserName" +
                       " AND " + UserField.PASSWORD + " = :prmPassword";
          
          List<User> listUser =  hbmSession.hSession.createQuery(hql)
                  .setParameter("prmUserName", userName)
                  .setParameter("prmPassword", password)
                  .list();
          
          if(!listUser.isEmpty()) {
              user=listUser.get(0);
          }
          
          return user;
      }  
      catch(HibernateException e){
        throw e;  
      }
    };
    
    public void save(User user,List<UserBranch> listUserBranch,List<UserDivision> listUserDivision,String moduleCode) throws Exception {
        try {
            hbmSession.hSession.beginTransaction();
            
            user.setCode(user.getUsername());
            
            hbmSession.hSession.save(user);

             if(!saveDetail(user, listUserBranch,listUserDivision)){
                hbmSession.hTransaction.rollback();
            }
            
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    user.getCode(), "User"));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
        }
    }
    
    private Boolean saveDetail(User user,List<UserBranch> listUserBranch,List<UserDivision> listUserDivision) throws Exception{
        try {

         
            for(UserBranch userBranch : listUserBranch){
                String detailCode = user.getCode() + "-" + userBranch.getBranch().getCode();
                userBranch.setCode(detailCode);
                userBranch.setUser(user);
                
                hbmSession.hSession.save(userBranch);
                hbmSession.hSession.flush();
            }
         
            for(UserDivision userDivision : listUserDivision){
                String detailCode = user.getCode() + "-" + userDivision.getDivision().getCode();
                userDivision.setCode(detailCode);
                userDivision.setUser(user);
                
                hbmSession.hSession.save(userDivision);
                hbmSession.hSession.flush();
            }
            
            return Boolean.TRUE;
        } catch (HibernateException e) {
            e.printStackTrace();
            return Boolean.FALSE;
        }
    }
    
    public void update(User user,List<UserBranch> listUserBranch,List<UserDivision> listUserDivision, String moduleCode) throws Exception {
      try{
          
            hbmSession.hSession.beginTransaction();
            hbmSession.hSession.update(user);
            hbmSession.hSession.flush();
            
            hbmSession.hSession.createSQLQuery("DELETE FROM scr_user_branch "+ 
                " WHERE scr_user_branch.UserCode = :prmHeaderCode")
            .setParameter("prmHeaderCode", user.getCode())
            .executeUpdate();
          
            hbmSession.hSession.createSQLQuery("DELETE FROM scr_user_division "+ 
                " WHERE scr_user_division.UserCode = :prmHeaderCode")
            .setParameter("prmHeaderCode", user.getCode())
            .executeUpdate();
            
             if(!saveDetail(user, listUserBranch,listUserDivision)){
                hbmSession.hTransaction.rollback();
            }
            
          
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                      EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
                                                                      user.getCode(), "User"));
          
          hbmSession.hTransaction.commit();
      }  
      catch(HibernateException e){
          hbmSession.hTransaction.rollback();
          throw e;          
      }
    };
    
    public void delete(String code, String moduleCode) {
      try{
          hbmSession.hSession.beginTransaction();
          
          hbmSession.hSession.createSQLQuery("DELETE FROM scr_user_branch WHERE scr_user_branch.usercode ='"+code+"'")
                  .executeUpdate();
          
          hbmSession.hSession.createSQLQuery("DELETE FROM scr_user_division WHERE scr_user_division.usercode ='"+code+"'")
                  .executeUpdate();
          
          hbmSession.hSession.createQuery("DELETE FROM " + UserField.BEAN_NAME + " WHERE " + UserField.CODE + "= :prmCode")
                  .setParameter("prmCode", code)
                  .executeUpdate();
          
          
          TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
          transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.DELETE), 
                                                                    code, ""));
          
          hbmSession.hTransaction.commit();
      }  
      catch(HibernateException e){
          hbmSession.hTransaction.rollback();
          throw e;
      }
    };
    
    // </editor-fold> 
    
    
    
//    public void adInHelp (User user ,String moduleCode,String status) {
//        try{
//            
//            if (status=="save") {
//                user.setBranchCode(BaseSession.loadProgramSession().getBranchCode());
//                user.setUsername(user.getCode());
//
//                TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
//                transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
//                                                                        EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
//                                                                        user.getCode(), ""));
//                hbmSession.hSession.save(user);
//            }else{
//                user.setBranchCode(BaseSession.loadProgramSession().getBranchCode());
//                user.setUsername(user.getCode());
//
//                TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
//                transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
//                                                                        EnumTransactionAction.toString(ENUM_TransactionAction.INSERT), 
//                                                                        user.getCode(), ""));
//                hbmSession.hSession.update(user);
//            }
//            
//            
//
//        }catch(HibernateException e){
//          hbmSession.hTransaction.rollback();
//            throw e;          
//        }
//    };
 
    public void ChangePassword(ChangePassword changePassword, String moduleCode) throws Exception {
        try {
            hbmSession.hSession.beginTransaction();

            hbmSession.hSession.createSQLQuery("UPDATE scr_user SET password = '"+changePassword.getPassword()+"' "
                    + "WHERE code = '"+changePassword.getUsername()+"' ")
                    .executeUpdate();
                    
            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
            transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
                                                                    changePassword.getCode(), "User"));
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
        }
    }
    
    public void deleteUserSession(String username) throws Exception {
        try {
            hbmSession.hSession.beginTransaction();
            
            hbmSession.hSession.createSQLQuery("DELETE FROM scr_user_session WHERE Username = '" + username + "';")
                .executeUpdate();
             
            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
        }
    }
    
//    public List<UserTemp> listGjmTypeByUser(){
//        
//        String username=BaseSession.loadProgramSession().getUserName();
////        List<StringValue> listStringValue = new ArrayList<StringValue>();
//        
//        List<UserTemp> list = (List<UserTemp>)hbmSession.hSession.createSQLQuery(
//            "SELECT * FROM( "
//        + "SELECT "
//        + "'GJM' AS GjmAdjStatus "
//        + "FROM `scr_user` "
//        + "WHERE scr_user.`Username`='"+username+"' "
//        + "AND scr_user.`GJMStatus`=1 "
//        + " "
//        + "UNION ALL "
//        + " "
//        + "SELECT "
//        + "'ADJ' AS GjmAdjStatus "
//        + "FROM `scr_user` "
//        + "WHERE scr_user.`Username`='"+username+"' "
//        + "AND scr_user.`ADJStatus`=1)AS uniStatus "
//        + "ORDER BY uniStatus.GjmAdjStatus=( "
//        + "SELECT "
//        + "CASE WHEN scr_user.`DefaultGJM`='GJM' THEN "
//        + "'GJM' ELSE 'ADJ' END "
//        + "FROM `scr_user` "
//        + "WHERE scr_user.`Username`='"+username+"' "
//        + ")DESC")
//
//        .addScalar("gjmAdjStatus", Hibernate.STRING)               
//        .setResultTransformer(Transformers.aliasToBean(UserTemp.class))
//        .list();
//        
////        int idx=0;
////        for(int i=1;i<=list.size();i++){
////            StringValue sv = new StringValue();
////            idx-=i;
////            sv.setCode(Integer.toString(i));
////            sv.setName(list.get(idx).getGjmAdjStatus());
////
////            listStringValue.add(sv);
////        }
//        
//        return list;
//        
//    }

}
