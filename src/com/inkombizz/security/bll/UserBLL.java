
package com.inkombizz.security.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.StringValue;
import com.inkombizz.common.enumeration.EnumTriState.Enum_TriState;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.security.dao.UserDAO;
import com.inkombizz.security.model.ChangePassword;
import com.inkombizz.security.model.User;
import com.inkombizz.security.model.UserBranch;
import com.inkombizz.security.model.UserBranchTemp;
import com.inkombizz.security.model.UserDivision;
import com.inkombizz.security.model.UserDivisionTemp;
import com.inkombizz.security.model.UserField;
import com.inkombizz.security.model.UserTemp;
import com.inkombizz.system.model.Setup;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

public class UserBLL {
    
    public static final String MODULECODE = "007_SCR_USER";
    
    private UserDAO userDAO;
    
    public UserBLL(HBMSession hbmSession){
      this.userDAO = new UserDAO(hbmSession);  
    };
    
    public ListPaging<UserTemp> findData(String username,String fullName,String employeeCode,String employeeName,String roleCode,String roleName,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(UserTemp.class);           
    
            paging.setRecords(userDAO.countData(username,roleCode,roleName,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<UserTemp> listUserTemp = userDAO.findData(username,roleCode,roleName,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<UserTemp> listPaging = new ListPaging<UserTemp>();
            
            listPaging.setList(listUserTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<User> get(Paging paging) throws Exception {
      try{
          DetachedCriteria criteria = DetachedCriteria.forClass(User.class);
          
          //criteria = paging.addOrderCriteria(criteria);
          
          paging.setRecords(userDAO.countByCriteria(criteria));
          
          criteria.setProjection(null);
          criteria.setResultTransformer(Criteria.ROOT_ENTITY);
          criteria = paging.addOrderCriteria(criteria);
          
          paging.setTotal((int) Math.ceil((double) paging.getRecords()/ (double) paging.getRows()));
          
          List<User> listUser = userDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());
          
          ListPaging<User> listPaging = new ListPaging<User>();
          
          listPaging.setList(listUser);
          listPaging.setPaging(paging);
          
          return listPaging;
      }  
      catch(Exception ex){
          throw ex;
      }
    };
    
    public ListPaging<UserBranch> listDetail(Paging paging, String headerCode) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(UserBranch.class);
            DetachedCriteria user = criteria.createCriteria("user",DetachedCriteria.INNER_JOIN);
            
            user.add(Restrictions.eq("code", ""+ headerCode + ""));
            
            paging.setRecords(userDAO.countByCriteria(criteria));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<UserBranch> list = userDAO.findDetailByCriteria(criteria, paging.getFromRow(), paging.getToRow());
            
            ListPaging<UserBranch> listPaging = new ListPaging<UserBranch>();
            
            listPaging.setList(list);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<UserDivision> listDetailDivision(Paging paging, String headerCode) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(UserDivision.class);
            DetachedCriteria user = criteria.createCriteria("user",DetachedCriteria.INNER_JOIN);
            
            user.add(Restrictions.eq("code", ""+ headerCode + ""));
            
            paging.setRecords(userDAO.countByCriteria(criteria));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<UserDivision> list = userDAO.findDetailByCriteriaDivision(criteria, paging.getFromRow(), paging.getToRow());
            
            ListPaging<UserDivision> listPaging = new ListPaging<UserDivision>();
            
            listPaging.setList(list);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    
    public List<UserBranchTemp> getListUserBranchManual(String userCode) {
        try {
            List<UserBranchTemp> listUserBranchTemp = userDAO.getListUserBranchManual(userCode);
            return listUserBranchTemp;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<UserDivisionTemp> getListUserDivisionManual(String userCode) {
        try {
            List<UserDivisionTemp> listUserDivisionTemp = userDAO.getListUserDivisionManual(userCode);
            return listUserDivisionTemp;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<User> getList() throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(User.class);
            List<User> listUser = userDAO.findByCriteria(criteria);
            return listUser;
        }
        catch(Exception ex) {
            throw ex;
        }
    }

    public ListPaging<User> search(Paging paging, String code, String userName, Enum_TriState activeStatus) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(User.class)
                    .add(Restrictions.like(UserField.CODE, code + "%" ))
                    .add(Restrictions.like(UserField.USERNAME, "%" + userName + "%"));
            
            if (activeStatus == activeStatus.YES)
                criteria.add(Restrictions.eq(UserField.ACTIVESTATUS, true));
            else if (activeStatus == activeStatus.NO)
                criteria.add(Restrictions.eq(UserField.ACTIVESTATUS, false));
            
            
            paging.setRecords(userDAO.countByCriteria(criteria));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria = paging.addOrderCriteria(criteria);
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<User> listUser = userDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());
            
            ListPaging<User> listPaging = new ListPaging<User>();
            
            listPaging.setList(listUser);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public User get(String userCode) throws Exception {
        try {
            return userDAO.get(userCode);
        }  
        catch(Exception ex){
            throw ex;
        }
    }
    
    public UserTemp getUpdate(String userCode) throws Exception {
        try {
            return (UserTemp) userDAO.getUpdate(userCode);
        }  
        catch(Exception ex){
            throw ex;
        }
    }
    
    public Setup getSetup() throws Exception {
        try {
            return userDAO.getSetup();
        } catch (Exception e) {
            throw e;
        }
    }
 
    public void save(User user,List<UserBranch> listUserBranch,List<UserDivision> listUserDivision, String moduleCode) throws Exception{
        userDAO.save(user,listUserBranch,listUserDivision, moduleCode);
    }
    
    public void update(User user,List<UserBranch> listUserBranch,List<UserDivision> listUserDivision) throws Exception {
        try {
            userDAO.update(user,listUserBranch,listUserDivision, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            userDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
    
    public User isLogin(String userName, String password) throws Exception {
      try {
          return userDAO.isLogin(userName, password);
      }  
      catch (Exception ex) {
          throw ex;
      }
    };
    
//    public UserBranch isLog_in(String userName, String password,String branchCode) throws Exception {
//      try {
//          return userDAO.isLog_in(userName, password,branchCode);
//      }  
//      catch (Exception ex) {
//          throw ex;
//      }
//    };
    
   
    
//    public User userLogin(String userName, String password) throws Exception {
//      try {
//          return userDAO.userLogin(userName, password);
//      }  
//      catch (Exception ex) {
//          throw ex;
//      }
//    };
    
//    public List<Branch> getBranchList() throws Exception {
//        try {
//            DetachedCriteria criteria = DetachedCriteria.forClass(Branch.class);
//            List<Branch> listBranch = userDAO.getClub(criteria);
//            return listBranch;
//        }  
//        catch(Exception ex){
//            throw ex;
//        }
//    }
    

    public void ChangePassword(ChangePassword changePassword, String moduleCode) throws Exception{
        userDAO.ChangePassword(changePassword, moduleCode);
    }
    
    public void deleteUserSession(String username) throws Exception{
        userDAO.deleteUserSession(username);
    }
    
//    public User checkBasedPriceAuthority(String userName) throws Exception {
//      try {
//          return userDAO.checkBasedPriceAuthority(userName);
//      }  
//      catch (Exception ex) {
//          throw ex;
//      }
//    };
    
//    public List<UserTemp> listGjmTypeByUser(){
//        return userDAO.listGjmTypeByUser();        
//    }
}
