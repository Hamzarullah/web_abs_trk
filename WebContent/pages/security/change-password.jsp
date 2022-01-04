
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>

<style>
    input{border-radius: 3px;height:18px}
    input[readonly="readonly"] { background:#FFF1A0 }
</style>
<script type="text/javascript">
    
    var txtChangePasswordOldPassword=$("#changePassword\\.oldPassword"),
        txtChangePasswordCurrenctPassword=$("#changePassword\\.password"),
        txtChangePasswordConfirmPassword=$("#confirm\\.password"),
        
        allFieldsChangePassword=$([])
            .add(txtChangePasswordOldPassword)
            .add(txtChangePasswordCurrenctPassword)
            .add(txtChangePasswordConfirmPassword);
    
    $(document).ready(function(){
        
    });
    
    function alert_change_password(txt_message,txt_focus){
        var dynamicDialog= $(
            '<div id="conformBoxError">'+
                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                    '</span>'+txt_message+'<span style="float:left; margin:0 7px 20px 0;">'+
                '</span>' +
            '</div>');

        dynamicDialog.dialog({
            title : "Attention!",
            closeOnEscape: false,
            modal : true,
            width: 400,
            height:120,
            resizable: false,
            closeText: "hide",
            buttons : 
                [{
                    text : "OK",
                    click : function() {
                        $(this).dialog("close");
                        txt_focus.focus();
                    }
                }]
        });
    }
    
        $("#btnChangePasswordSave").click(function(ev){
            
             if(!$("#frmChangePasswordInput").valid()) {
                ev.preventDefault();
                return;
             };
        
             url = "security/change-password-user";
             var params = $("#frmChangePasswordInput").serialize();
             
             if($("#confirm\\.password").val() === $("#changePassword\\.password").val()){
                 $.post(url, params, function(data) {
                    if (data.error) {
                        alert(data.errorMessage);
                        return;
                    }
                    alert_change_password(data.message,txtChangePasswordOldPassword);
                    allFieldsChangePassword.val('').removeClass('ui-state-error');
                });
             }else{
                alert_change_password("Confirm Password Not Equal!",txtChangePasswordConfirmPassword);
                
             }

            ev.preventDefault();
        });
    
</script>
<b>CHANGE PASSWORD</b>
<hr>
<br class="spacer" />

 <div id="userInputChangePassword" class="content ui-widget">
        <s:form id="frmChangePasswordInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right"><B>User Name *</B></td>
                    <td>
                        <s:textfield id="changePassword.username" name="changePassword.username" required="true" cssClass="required" readonly="true"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Old Password *</B></td>
                    <td><s:password id="changePassword.oldPassword" name="changePassword.oldPassword" required="true" cssClass="required"></s:password></td>
                </tr>
                <tr>
                    <td align="right"><B>Password *</B></td>
                    <td><s:password id="changePassword.password" name="changePassword.password" title="Please Enter Password!" required="true" cssClass="required"></s:password></td>
                </tr>
                <tr>
                    <td align="right"><B>Confirm Password *</B></td>
                    <td><s:password id="confirm.password" name="confirm.password" title="Please Enter Password!" required="true" cssClass="required"></s:password></td>
                </tr>
                <tr>
                    <td height="10%"/>
                </tr>
                <tr>
                    <td/>
                    <td>
                        <sj:a href="#" id="btnChangePasswordSave" button="true">Save</sj:a>
                    </td>
                </tr>
            </table>
        </s:form>
        <br />
        <br />
</div>