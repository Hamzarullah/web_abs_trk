
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
        txtProductTypeCode=$("#productType\\.code"),
        txtProductTypeName=$("#productType\\.name"),
        rdbProductTypeActiveStatus=$("#productType\\.activeStatus"),
        txtProductTypeRemark=$("#productType\\.remark"),
        txtProductTypeInActiveBy = $("#productType\\.inActiveBy"),
        dtpProductTypeInActiveDate = $("#productType\\.inActiveDate"),
        txtProductTypeCreatedBy = $("#productType\\.createdBy"),
        dtpProductTypeCreatedDate = $("#productType\\.createdDate"),
        
        allFieldsProductType=$([])
            .add(txtProductTypeCode)
            .add(txtProductTypeName)
            .add(txtProductTypeRemark)
            .add(txtProductTypeInActiveBy)
            .add(txtProductTypeCreatedBy);


    function reloadGridProductType(){
        $("#productType_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("productType");
        
        $('#productType\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#productTypeSearchActiveStatusRadActive').prop('checked',true);
        $("#productTypeSearchActiveStatus").val("true");
        
        $('input[name="productTypeSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#productTypeSearchActiveStatus").val(value);
        });
        
        $('input[name="productTypeSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#productTypeSearchActiveStatus").val(value);
        });
                
        $('input[name="productTypeSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#productTypeSearchActiveStatus").val(value);
        });
        
        $('input[name="productTypeActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#productType\\.activeStatus").val(value);
            $("#productType\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="productTypeActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#productType\\.activeStatus").val(value);
        });
        
        $("#btnProductTypeNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/product-type-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_productType();
                showInput("productType");
                hideInput("productTypeSearch");
                $('#productTypeActiveStatusRadActive').prop('checked',true);
                $("#productType\\.activeStatus").val("true");
                $("#productType\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#productType\\.createdDate").val("01/01/1900 00:00:00");
                txtProductTypeCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtProductTypeCode.attr("readonly",true);
                txtProductTypeCode.val("AUTO");

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnProductTypeSave").click(function(ev) {
           if(!$("#frmProductTypeInput").valid()) {
//               handlers_input_productType();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           productTypeFormatDate();
           if (updateRowId < 0){
               url = "master/product-type-save";
           } else{
               url = "master/product-type-update";
           }
           
           var params = $("#frmProductTypeInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    productTypeFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("productType");
                showInput("productTypeSearch");
                allFieldsProductType.val('').siblings('label[class="error"]').hide();
                txtProductTypeCode.val("AUTO");
                reloadGridProductType();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnProductTypeUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/product-type-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_productType();
                updateRowId=$("#productType_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var productType=$("#productType_grid").jqGrid('getRowData',updateRowId);
                var url="master/product-type-get-data";
                var params="productType.code=" + productType.code;

                txtProductTypeCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtProductTypeCode.val(data.productTypeTemp.code);
                        txtProductTypeName.val(data.productTypeTemp.name);
                        rdbProductTypeActiveStatus.val(data.productTypeTemp.activeStatus);
                        txtProductTypeRemark.val(data.productTypeTemp.remark);
                        txtProductTypeInActiveBy.val(data.productTypeTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.productTypeTemp.inActiveDate,true);
                        dtpProductTypeInActiveDate.val(inActiveDate);
                        txtProductTypeCreatedBy.val(data.productTypeTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.productTypeTemp.createdDate,true);
                        dtpProductTypeCreatedDate.val(createdDate);

                        if(data.productTypeTemp.activeStatus===true) {
                           $('#productTypeActiveStatusRadActive').prop('checked',true);
                           $("#productType\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#productTypeActiveStatusRadInActive').prop('checked',true);              
                           $("#productType\\.activeStatus").val("false");
                        }

                        showInput("productType");
                        hideInput("productTypeSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnProductTypeDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/product-type-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#productType_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var productType=$("#productType_grid").jqGrid('getRowData',deleteRowID);
                var url="master/product-type-delete";
                var params="productType.code=" + productType.code;
                var message="Are You Sure To Delete(Code : "+ productType.code + ")?";
                alertMessageDelete("productType",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ productType.code+ ')?</div>');
//
//                dynamicDialog.dialog({
//                    title : "Confirmation:",
//                    closeOnEscape: false,
//                    modal : true,
//                    width: 500,
//                    resizable: false,
//                    buttons : 
//                        [{
//                            text : "Yes",
//                            click : function() {
//
//                                $(this).dialog("close");
//                                var url="master/productType-delete";
//                                var params="productType.code=" + productType.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridProductType();
//                                });
//                            }
//                        },
//                        {
//                            text : "No",
//                            click : function() {
//
//                                $(this).dialog("close");
//                            }
//                        }]
//                });
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + productType.code+ ")")){
//                    var url="master/productType-delete";
//                    var params="productType.code=" + productType.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridProductType();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnProductTypeCancel").click(function(ev) {
            hideInput("productType");
            showInput("productTypeSearch");
            allFieldsProductType.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnProductTypeRefresh').click(function(ev) {
            $('#productTypeSearchActiveStatusRadActive').prop('checked',true);
            $("#productTypeSearchActiveStatus").val("true");
            $("#productType_grid").jqGrid("clearGridData");
            $("#productType_grid").jqGrid("setGridParam",{url:"master/product-type-data?"});
            $("#productType_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnProductTypePrint").click(function(ev) {
            
            var url = "reports/product-type-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'productType','width=500,height=500');
        });
        
        $('#btnProductType_search').click(function(ev) {
            $("#productType_grid").jqGrid("clearGridData");
            $("#productType_grid").jqGrid("setGridParam",{url:"master/product-type-data?" + $("#frmProductTypeSearchInput").serialize()});
            $("#productType_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_productType(){
//        unHandlersInput(txtProductTypeCode);
//        unHandlersInput(txtProductTypeName);
//    }
//
//    function handlers_input_productType(){
//        if(txtProductTypeCode.val()===""){
//            handlersInput(txtProductTypeCode);
//        }else{
//            unHandlersInput(txtProductTypeCode);
//        }
//        if(txtProductTypeName.val()===""){
//            handlersInput(txtProductTypeName);
//        }else{
//            unHandlersInput(txtProductTypeName);
//        }
//    }
    
    function productTypeFormatDate(){
        var inActiveDate=formatDate(dtpProductTypeInActiveDate.val(),true);
        dtpProductTypeInActiveDate.val(inActiveDate);
        $("#productTypeTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpProductTypeCreatedDate.val(),true);
        dtpProductTypeCreatedDate.val(createdDate);
        $("#productTypeTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlProductType" action="product-type-data" />
<b>PRODUCT TYPE</b>
<hr>
<br class="spacer"/>


<sj:div id="productTypeButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnProductTypeNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnProductTypeUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnProductTypeDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnProductTypeRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnProductTypePrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="productTypeSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmProductTypeSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="productTypeSearchCode" name="productTypeSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="productTypeSearchName" name="productTypeSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="productTypeSearchActiveStatus" name="productTypeSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="productTypeSearchActiveStatusRad" name="productTypeSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnProductType_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="productTypeGrid">
    <sjg:grid
        id="productType_grid"
        dataType="json"
        href="%{remoteurlProductType}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listProductTypeTemp"
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
    
<div id="productTypeInput" class="content ui-widget">
    <s:form id="frmProductTypeInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="productType.code" name="productType.code" title="*" required="true" cssClass="required" maxLength="45" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="productType.name" name="productType.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="productTypeActiveStatusRad" name="productTypeActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="productType.activeStatus" name="productType.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="productType.remark" name="productType.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="productType.inActiveBy"  name="productType.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="productType.inActiveDate" name="productType.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="productType.createdBy"  name="productType.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="productType.createdDate" name="productType.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="productTypeTemp.inActiveDateTemp" name="productTypeTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="productTypeTemp.createdDateTemp" name="productTypeTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnProductTypeSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnProductTypeCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>