
<%@page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="sj" uri="/struts-jquery-tags" %>
<%@taglib prefix="sjg" uri="/struts-jquery-grid-tags" %>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js"/>"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js"/>"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />
<style>
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>

<script type="text/javascript">
     
    var 
        txtCustomerCategoryCode=$("#customerCategory\\.code"),
        txtCustomerCategoryName=$("#customerCategory\\.name"),
        rdbCustomerCategoryActiveStatus=$("#customerCategory\\.activeStatus"),
        txtCustomerCategoryRemark=$("#customerCategory\\.remark"),
        txtCustomerCategoryInActiveBy = $("#customerCategory\\.inActiveBy"),
        dtpCustomerCategoryInActiveDate = $("#customerCategory\\.inActiveDate"),
        txtCustomerCategoryCreatedBy = $("#customerCategory\\.createdBy"),
        dtpCustomerCategoryCreatedDate = $("#customerCategory\\.createdDate"),
        
        allFieldsCustomerCategory=$([])
            .add(txtCustomerCategoryCode)
            .add(txtCustomerCategoryName)
            .add(txtCustomerCategoryRemark)
            .add(txtCustomerCategoryInActiveBy)
            .add(txtCustomerCategoryCreatedBy);


    function reloadGridCustomerCategory(){
        $("#customerCategory_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("customerCategory");
        
        $('#customerCategory\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#customerCategorySearchActiveStatusRadActive').prop('checked',true);
        $("#customerCategorySearchActiveStatus").val("true");
        
        $('input[name="customerCategorySearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#customerCategorySearchActiveStatus").val(value);
        });
        
        $('input[name="customerCategorySearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#customerCategorySearchActiveStatus").val(value);
        });
                
        $('input[name="customerCategorySearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#customerCategorySearchActiveStatus").val(value);
        });
        
        $('input[name="customerCategoryActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#customerCategory\\.activeStatus").val(value);
            $("#customerCategory\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="customerCategoryActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#customerCategory\\.activeStatus").val(value);
        });
        
        $("#btnCustomerCategoryNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/customer-category-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_customerCategory();
                showInput("customerCategory");
                hideInput("customerCategorySearch");
                $('#customerCategoryActiveStatusRadActive').prop('checked',true);
                $("#customerCategory\\.activeStatus").val("true");
                $("#customerCategory\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#customerCategory\\.createdDate").val("01/01/1900 00:00:00");
                txtCustomerCategoryCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtCustomerCategoryCode.val("AUTO");
                txtCustomerCategoryCode.attr("readonly",true);

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnCustomerCategorySave").click(function(ev) {
           if(!$("#frmCustomerCategoryInput").valid()) {
//               handlers_input_customerCategory();
               ev.preventDefault();
               return;
           };
  
           var url = "";
           customerCategoryFormatDate();
           if (updateRowId < 0){
               url = "master/customer-category-save";
           } else{
               url = "master/customer-category-update";
           }
           
           var params = $("#frmCustomerCategoryInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    customerCategoryFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("customerCategory");
                showInput("customerCategorySearch");
                allFieldsCustomerCategory.val('').siblings('label[class="error"]').hide();
                txtCustomerCategoryCode.val("AUTO");
                reloadGridCustomerCategory();           
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnCustomerCategoryUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/customer-category-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_customerCategory();
                updateRowId=$("#customerCategory_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var customerCategory=$("#customerCategory_grid").jqGrid('getRowData',updateRowId);
                var url="master/customer-category-get-data";
                var params="customerCategory.code=" + customerCategory.code;

                txtCustomerCategoryCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtCustomerCategoryCode.val(data.customerCategoryTemp.code);
                        txtCustomerCategoryName.val(data.customerCategoryTemp.name);
                        rdbCustomerCategoryActiveStatus.val(data.customerCategoryTemp.activeStatus);
                        txtCustomerCategoryRemark.val(data.customerCategoryTemp.remark);
                        txtCustomerCategoryInActiveBy.val(data.customerCategoryTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.customerCategoryTemp.inActiveDate,true);
                        dtpCustomerCategoryInActiveDate.val(inActiveDate);
                        txtCustomerCategoryCreatedBy.val(data.customerCategoryTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.customerCategoryTemp.createdDate,true);
                        dtpCustomerCategoryCreatedDate.val(createdDate);

                        if(data.customerCategoryTemp.activeStatus===true) {
                           $('#customerCategoryActiveStatusRadActive').prop('checked',true);
                           $("#customerCategory\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#customerCategoryActiveStatusRadInActive').prop('checked',true);              
                           $("#customerCategory\\.activeStatus").val("false");
                        }

                        showInput("customerCategory");
                        hideInput("customerCategorySearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnCustomerCategoryDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/customer-category-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#customerCategory_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var customerCategory=$("#customerCategory_grid").jqGrid('getRowData',deleteRowID);
                var url="master/customer-category-delete";
                var params="customerCategory.code=" + customerCategory.code;
                var message="Are You Sure To Delete(Code : "+ customerCategory.code + ")?";
                alertMessageDelete("customerCategory",url,params,message,400);
  
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnCustomerCategoryCancel").click(function(ev) {
            hideInput("customerCategory");
            showInput("customerCategorySearch");
            allFieldsCustomerCategory.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnCustomerCategoryRefresh').click(function(ev) {
            $('#customerCategorySearchActiveStatusRadActive').prop('checked',true);
            $("#customerCategorySearchActiveStatus").val("true");
            $("#customerCategory_grid").jqGrid("clearGridData");
            $("#customerCategory_grid").jqGrid("setGridParam",{url:"master/customer-category-data?"});
            $("#customerCategory_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnCustomerCategoryPrint").click(function(ev) {
            
            var url = "reports/customer-category-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'customerCategory','width=500,height=500');
        });
        
        $('#btnCustomerCategory_search').click(function(ev) {
            $("#customerCategory_grid").jqGrid("clearGridData");
            $("#customerCategory_grid").jqGrid("setGridParam",{url:"master/customer-category-data?" + $("#frmCustomerCategorySearchInput").serialize()});
            $("#customerCategory_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_customerCategory(){
//        unHandlersInput(txtCustomerCategoryCode);
//        unHandlersInput(txtCustomerCategoryName);
//    }
//
//    function handlers_input_customerCategory(){
//        if(txtCustomerCategoryCode.val()===""){
//            handlersInput(txtCustomerCategoryCode);
//        }else{
//            unHandlersInput(txtCustomerCategoryCode);
//        }
//        if(txtCustomerCategoryName.val()===""){
//            handlersInput(txtCustomerCategoryName);
//        }else{
//            unHandlersInput(txtCustomerCategoryName);
//        }
//    }
    
    function customerCategoryFormatDate(){
        var inActiveDate=formatDate(dtpCustomerCategoryInActiveDate.val(),true);
        dtpCustomerCategoryInActiveDate.val(inActiveDate);
        $("#customerCategoryTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpCustomerCategoryCreatedDate.val(),true);
        dtpCustomerCategoryCreatedDate.val(createdDate);
        $("#customerCategoryTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlCustomerCategory" action="customer-category-data" />
<b>CUSTOMERCATEGORY</b>
<hr>
<br class="spacer"/>


<sj:div id="customerCategoryButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnCustomerCategoryNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnCustomerCategoryUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnCustomerCategoryDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnCustomerCategoryRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnCustomerCategoryPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="customerCategorySearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmCustomerCategorySearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="customerCategorySearchCode" name="customerCategorySearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="customerCategorySearchName" name="customerCategorySearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="customerCategorySearchActiveStatus" name="customerCategorySearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="customerCategorySearchActiveStatusRad" name="customerCategorySearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnCustomerCategory_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="customerCategoryGrid">
    <sjg:grid
        id="customerCategory_grid"
        dataType="json"
        href="%{remoteurlCustomerCategory}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listCustomerCategoryTemp"
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
            name="name" index="name" title="Name" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="remark" index="remark" title="Remark" width="400" sortable="true"
        />
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center" 
        />
    </sjg:grid>
</div>
    
<div id="customerCategoryInput" class="content ui-widget">
    <s:form id="frmCustomerCategoryInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="customerCategory.code" name="customerCategory.code" title="*" required="true" cssClass="required" maxLength="45" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="customerCategory.name" name="customerCategory.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="customerCategoryActiveStatusRad" name="customerCategoryActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="customerCategory.activeStatus" name="customerCategory.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="customerCategory.remark" name="customerCategory.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="customerCategory.inActiveBy"  name="customerCategory.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="customerCategory.inActiveDate" name="customerCategory.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="customerCategory.createdBy"  name="customerCategory.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="customerCategory.createdDate" name="customerCategory.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="customerCategoryTemp.inActiveDateTemp" name="customerCategoryTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="customerCategoryTemp.createdDateTemp" name="customerCategoryTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnCustomerCategorySave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnCustomerCategoryCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>