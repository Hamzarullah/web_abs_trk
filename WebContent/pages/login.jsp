<%@page import="com.inkombizz.action.BaseSession"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><%= BaseSession.loadProgramSession().getSetup().getWebTitle() %></title>

    <sj:head
            loadAtOnce="true"
            compressed="false"
            jqueryui="true"
            jquerytheme="cupertino"
            loadFromGoogle="false"
            debug="true" />
	
    <script type="text/javascript" src="<s:url value="/js/jquery.layout.js" />"></script>
    <script type="text/javascript" src="<s:url value="/js/jquery_ready.js" />"></script>
    <script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
    <link href="css/mainstyle.css" rel="stylesheet" type="text/css" />
    <link href="css/pagestyle.css" rel="stylesheet" type="text/css" />
    <link rel="shortcut icon" href="<s:url value="/images/logo_trk.png" />"></link>
    
<style>
    .ui-dialog-titlebar-close{
        display: none;
    }
    #goodsIssueToCostCentreDetailInput_grid_pager_center{
        display: none;
    }
    #login_periodMonth{ border-radius: 3px; height: 18px;}
    #login_periodYear{ border-radius: 3px; height: 18px;}
    
</style>    
    <script type="text/javascript">
        
        var 
//            txtBranchCode = "#user\\.branchCode";
            txtUserName = "#user\\.userName";
            txtPassword = "#user\\.password"; 
            lblWebTitle="#user\\.password"; 
            
        $(document).ready(function(){  
            
           $('body').keypress(function (e){
               if(e.which===13){
                    $("#btnUserLogin").trigger('click');
               }
           });
            $('body').layout({
                south__resizable: false
                
            });

             $("#user\\.username").focus();
            $("#btnUserLogin").click(function(ev){
               var url = "security/user-login" ;
               var params = $("#frmUserInput").serialize();
                $.post(url, params, function(result) {
                    if (result.login) {
                        window.location = "panel";
                    }
                    else {
                        alert("LOGIN FAILED");
                        $("#user\\.username").focus();
                    }
                });
                ev.preventDefault();
             });

    	});
        
    </script>
</head>
<style>
    .ui-autocomplete-input {
        width:190px;
    }
</style>
    
<body>
    <div id="CenterPane" class="ui-layout-center ui-helper-reset" style="background-color: #FDFDFC;" >
        <br/><br/>
        <div style="width: 500px; display: block; margin: 50px auto;">
            <div class="ui-widget ui-widget-header ui-corner-top" style="height: 20px;">&nbsp;&nbsp;Login</div>
            <div class="ui-widget ui-widget-content">
                <s:form id="frmUserInput">
                    <table cellpadding="7" cellspacing="2" align="center" style="margin-left: 0px; width: 100%;">
                        <tr>
                            <td rowspan="5" style="width: 30%;"><img src="images/logo_trk.png" style="margin-left: 10px;"/></td>
                            <!--<td style="width: 70px;"><B>Branch</B></td>-->
                            <td style="width: 70px;"></td>
                            <td 
                                style="width: 189px;display: none">
                                <sj:autocompleter  
                                listKey="code" 
                                listValue="name"
                                listLabel="MMS"
                                list="listBranchs" 
                                id="user.branchCode"
                                selectBox="true"
                                selectBoxIcon="true"
                                resizable="true"
                                value="-1"
                                name="branchCode"/>
                            </td>
                        </tr>
                        <tr>
                            <td><B>User Name</B></td>
                            <td><s:textfield id="user.username" name="user.username" value="" style="width: 90%;"></s:textfield></td>
                        </tr>
                        <tr>
                            <td><B>Password</B></td>
                            <td><s:password id="user.password" name="user.password" value="" style="width: 90%;"></s:password></td>
                        </tr>
                        <tr>
                            <td><B>Period</B></td>
                            <td><s:select id="login_periodMonth" name="login_periodMonth" width="20" list="login_monthlyList" listKey="code" listValue="name" key="login_periodMonth" />
                                &nbsp;<s:select id="login_periodYear" name="login_periodYear" width="5" list="login_yearList" listKey="code" listValue="name" key="login_periodYear" />
                            </td>
                        </tr>
                        <br class="spacer" />
                        <tr>
                            <td/>
                            <td>
                                <sj:a href="#" id="btnUserLogin" button="true">Login</sj:a>
                            </td>
                        </tr>
                    </table>
                    <br></br><br></br>
                </s:form>
            </div>
        </div>
    </div>
    <div id="BottomPane" class="ui-layout-south ui-widget-content" style="text-align: center;">
        <b><%= BaseSession.loadProgramSession().getSetup().getWebTitle() %></b>
    </div>
</body>

</html>