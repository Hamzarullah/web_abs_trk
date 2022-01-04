
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
    var 
        txtBusinessEntityCode = $("#businessEntity\\.code"),
        txtBusinessEntityName = $("#businessEntity\\.name"),
        rdbBusinessEntityActiveStatus = $("#businessEntity\\.activeStatus"),
        txtBusinessEntityRemark = $("#businessEntity\\.remark"),
        txtBusinessEntityInActiveBy = $("#businessEntity\\.inActiveBy"),
        dtpBusinessEntityInActiveDate = $("#businessEntity\\.inActiveDate"),
        txtBusinessEntityCreatedBy = $("#businessEntity\\.createdBy"),
        txtBusinessEntityCreatedDate = $("#businessEntity\\.createdDate"),
        
        allFieldsBusinessEntity=$([])
            .add(txtBusinessEntityCode)
            .add(txtBusinessEntityName)
            .add(rdbBusinessEntityActiveStatus)
            .add(txtBusinessEntityRemark)
            .add(txtBusinessEntityInActiveBy)
            .add(dtpBusinessEntityInActiveDate)
            .add(txtBusinessEntityCreatedBy)
            .add(txtBusinessEntityCreatedDate);  
            
            
    function reloadGridBusinessEntity() {
        $("#businessEntity_grid").trigger("reloadGrid");
    };
    
      
    $(document).ready(function(){
        hoverButton();
        var updateRowId = -1;
        hideInput("businessEntity");
        $('#businessEntity\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#businessEntitySearchActiveStatusRadActive').prop('checked',true);
        $("#businessEntitySearchActiveStatus").val("true");
        
        $('input[name="businessEntitySearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#businessEntitySearchActiveStatus").val(value);
        });
        
        $('input[name="businessEntitySearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#businessEntitySearchActiveStatus").val(value);
        });
                
        $('input[name="businessEntitySearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#businessEntitySearchActiveStatus").val(value);
        });
        
        
        $('input[name="businessEntity\\.activeStatus"][value="Active"]').change(function(ev){
            var value="true";
            $("#businessEntity\\.activeStatus").val(value);
            
        });
                
        $('input[name="businessEntity\\.activeStatus"][value="InActive"]').change(function(ev){
            var value="false";
            $("#businessEntity\\.activeStatus").val(value);
        });
        
        $("#btnBusinessEntityNew").click(function(ev){
            var url="master/business-entity-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                unHandlers_input_businessEntity();
                showInput("businessEntity");
                hideInput("businessEntitySearch");
                $('#businessEntity\\.activeStatusActive').prop('checked',true);
                $("#businessEntity\\.activeStatus").val("true");
                dtpBusinessEntityInActiveDate.val("01/01/1900 00:00:00");
                updateRowId = -1;
                txtBusinessEntityCode.attr("readonly",false);
            });
            ev.preventDefault();
        });
        
        
        $("#btnBusinessEntitySave").click(function(ev) {
           if(!$("#frmBusinessEntityInput").valid()) {
               handlers_input_businessEntity();
               ev.preventDefault();
               return;
           };
           
            /* Start Format Date  */   
            var inActiveDate=formatDate(dtpBusinessEntityInActiveDate.val(),true);
            dtpBusinessEntityInActiveDate.val(inActiveDate);
            /* End Format Date  */
           var url = "";
           
           if (updateRowId < 0) 
               url = "master/business-entity-save";
           else
               url = "master/business-entity-update";
                      
           var params = $("#frmBusinessEntityInput").serialize();
       
           $.post(url, params, function(data) {
                if (data.error) {
                        /* Start Format Date  */   
                        var inActiveDate=formatDate(dtpBusinessEntityInActiveDate.val(),true);
                        dtpBusinessEntityInActiveDate.val(inActiveDate);
                        /* End Format Date  */
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                        /* Start Format Date  */   
                        var inActiveDate=formatDate(dtpBusinessEntityInActiveDate.val(),true);
                        dtpBusinessEntityInActiveDate.val(inActiveDate);
                        /* End Format Date  */
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("businessEntity");
                showInput("businessEntitySearch");
                allFieldsBusinessEntity.val('').removeClass('ui-state-error');
                reloadGridBusinessEntity();           
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnBusinessEntityUpdate").click(function(ev){
            var url="master/business-entity-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                unHandlers_input_businessEntity();
                updateRowId = $("#businessEntity_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId === null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var businessEntity = $("#businessEntity_grid").jqGrid('getRowData', updateRowId);
                var url = "master/business-entity-get-data";
                var params = "businessEntity.code=" + businessEntity.code;

                txtBusinessEntityCode.attr("readonly",true);

                $.post(url, params, function(result) {
                    var data = (result);
                        txtBusinessEntityCode.val(data.businessEntityTemp.code);
                        txtBusinessEntityName.val(data.businessEntityTemp.name);
                        rdbBusinessEntityActiveStatus.val(data.businessEntityTemp.activeStatus);
                        txtBusinessEntityRemark.val(data.businessEntityTemp.remark);
                        txtBusinessEntityInActiveBy.val(data.businessEntityTemp.inActiveBy);
                    var inActiveDate=formatDateRemoveT(data.businessEntityTemp.inActiveDate,true);
                        dtpBusinessEntityInActiveDate.val(inActiveDate);
                        txtBusinessEntityCreatedBy.val(data.businessEntityTemp.createdBy);
                        txtBusinessEntityCreatedDate.val(data.businessEntityTemp.createdDate);

                        if(data.businessEntityTemp.activeStatus===true) {
                           $('#businessEntity\\.activeStatusActive').prop('checked',true);
                           $("#businessEntity\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#businessEntity\\.activeStatusInActive').prop('checked',true);              
                           $("#businessEntity\\.activeStatus").val("false");
                        }

                    showInput("businessEntity");
                    hideInput("businessEntitySearch");
                });
            });
            ev.preventDefault();
        });
        
        
        $('#btnBusinessEntityDelete').click(function(ev) {
            var url="master/business-entity-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowId = $("#businessEntity_grid").jqGrid('getGridParam','selrow');
            
                if (deleteRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                var businessEntity = $("#businessEntity_grid").jqGrid('getRowData', deleteRowId);

                if (confirm("Are You Sure To Delete (Code : " + businessEntity.code + ")")) {
                    var url = "master/business-entity-delete";
                    var params = "businessEntity.code=" + businessEntity.code;

                    $.post(url, params, function(data) {
                        if (data.error) {
                            alertMessage(data.errorMessage);
                            return;
                        }
                        alertMessage(data.message);
                        reloadGridBusinessEntity();
                    });
                }
            });
            ev.preventDefault();
        });
        
       
       $("#btnBusinessEntityCancel").click(function(ev) {
            hideInput("businessEntity");
            showInput("businessEntitySearch");
            allFieldsBusinessEntity.val('').removeClass('ui-state-error');
            ev.preventDefault();
        });
        
        
        $('#btnBusinessEntityRefresh').click(function(ev) {
            $('#businessEntitySearchActiveStatusRadActive').prop('checked',true);
            $("#businessEntitySearchActiveStatus").val("true");
            $("#businessEntity_grid").jqGrid("clearGridData");
            $("#businessEntity_grid").jqGrid("setGridParam",{url:"master/business-entity-data?"});
            $("#businessEntity_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnBusinessEntityPrint").click(function(ev) {
            var status=$('#businessEntitySearchActiveStatus').val();
            var url = "report/business-entity-print-out-pdf?";
            var params = "activeStatus=" + status;
              
            window.open(url+params,'company','width=500,height=500');
        });
        
        $('#btnBusinessEntity_search').click(function(ev) {
            $("#businessEntity_grid").jqGrid("clearGridData");
            $("#businessEntity_grid").jqGrid("setGridParam",{url:"master/business-entity-data?" + $("#frmBusinessEntitySearchInput").serialize()});
            $("#businessEntity_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
       
    });
    
    function unHandlers_input_businessEntity(){
        unHandlersInput(txtBusinessEntityCode);
        unHandlersInput(txtBusinessEntityName);
    }

    function handlers_input_businessEntity(){
        if(txtBusinessEntityCode.val()===""){
            handlersInput(txtBusinessEntityCode);
        }else{
            unHandlersInput(txtBusinessEntityCode);
        }
        if(txtBusinessEntityName.val()===""){
            handlersInput(txtBusinessEntityName);
        }else{
            unHandlersInput(txtBusinessEntityName);
        }
    }
</script>

<s:url id="remoteurlBusinessEntity" action="business-entity-data" />
<b>CURRENCY</b>
<hr>
<br class="spacer" />
<sj:div id="businessEntityButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnBusinessEntityNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnBusinessEntityUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnBusinessEntityDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnBusinessEntityRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnBusinessEntityPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
    </table>
</sj:div>   
    
<div id="businessEntitySearchInput" class="content ui-widget">
    <br class="spacer" />
    <br class="spacer" />
    <s:form id="frmBusinessEntitySearchInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right" valign="centre"><b>Code</b></td>
                <td>
                    <s:textfield id="businessEntitySearchCode" name="businessEntitySearchCode" size="20"></s:textfield>
                </td>
                <td align="right" valign="centre"><b>Name</b></td>
                <td>
                    <s:textfield id="businessEntitySearchName" name="businessEntitySearchName" size="50"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="businessEntitySearchActiveStatus" name="businessEntitySearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="businessEntitySearchActiveStatusRad" name="businessEntitySearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>  
        </table>
        <br />
        <sj:a href="#" id="btnBusinessEntity_search" button="true">Search</sj:a>
        <br />
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float:left;margin-right:1em;"></span>
        </div>
    </s:form>
</div>
<br class="spacer" />  
    
<div id="businessEntityGrid">
    <sjg:grid
        id="businessEntity_grid"
        dataType="json"
        href="%{remoteurlBusinessEntity}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listBusinessEntityTemp"
        rowList="10,20,30"
        rowNum="10"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
    >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="name" index="name" title="Name" width="400" sortable="true"
        />
        <sjg:gridColumn
            name="remark" index="remark" title="Remark" width="400" sortable="true" hidden="true"
        />  
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center" 
        />
    </sjg:grid >
</div>
    
<div id="businessEntityInput" class="content ui-widget">
    <s:form id="frmBusinessEntityInput">
        <table cellpadding="2" cellspacing="2" >
            <tr>
                <td align="right"><B>Code *</B></td>
                <td><s:textfield id="businessEntity.code" name="businessEntity.code" title="*" required="true" cssClass="required" maxLength="45"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Name *</B></td>
                <td><s:textfield id="businessEntity.name" name="businessEntity.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
             <tr>
                <td align="right"><B>Active Status *</B>
                <s:textfield id="businessEntity.activeStatus" name="businessEntity.activeStatus" readonly="false" size="5" style="display:none"></s:textfield></td>
                <td><s:radio id="businessEntity.activeStatus" name="businessEntity.activeStatus" list="{'Active','InActive'}"></s:radio></td>                    
            </tr>
            <tr>
                <td align="right">Remark </td>
                <td><s:textfield id="businessEntity.remark" name="businessEntity.remark" size="50" title="*" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive By </td>
                <td><s:textfield id="businessEntity.inActiveBy"  name="businessEntity.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date </td>
                <td><sj:datepicker id="businessEntity.inActiveDate" name="businessEntity.inActiveDate" displayFormat="dd/mm/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus" disabled="true" readonly="true"></sj:datepicker></td>
            </tr>
            <tr>
                <td><s:textfield id="businessEntity.createdBy"  name="businessEntity.createdBy" size="20" style="display:none"></s:textfield></td>
                <td><s:textfield id="businessEntity.createdDate" name="businessEntity.createdDate" size="20" style="display:none"></s:textfield></td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnBusinessEntitySave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnBusinessEntityCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>
