
<%@page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="sj" uri="/struts-jquery-tags" %>
<%@taglib prefix="sjg" uri="/struts-jquery-grid-tags" %>

<script type-design="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js"/>"></script>
<script type-design="text/javascript" src="<s:url value="/js/jquery.validate.min.js"/>"></script>
<link href="css/pagestyle.css" rel="stylesheet" type-design="text/css" />
<style>
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>

<script type-design="text/javascript">
     
    var 
        txtItemTypeDesignCode=$("#itemTypeDesign\\.code"),
        txtItemTypeDesignName=$("#itemTypeDesign\\.name"),
        rdbItemTypeDesignActiveStatus=$("#itemTypeDesign\\.activeStatus"),
        txtItemTypeDesignRemark=$("#itemTypeDesign\\.remark"),
        txtItemTypeDesignInActiveBy = $("#itemTypeDesign\\.inActiveBy"),
        dtpItemTypeDesignInActiveDate = $("#itemTypeDesign\\.inActiveDate"),
        txtItemTypeDesignCreatedBy = $("#itemTypeDesign\\.createdBy"),
        dtpItemTypeDesignCreatedDate = $("#itemTypeDesign\\.createdDate"),
        
        allFieldsItemTypeDesign=$([])
            .add(txtItemTypeDesignCode)
            .add(txtItemTypeDesignName)
            .add(txtItemTypeDesignRemark)
            .add(txtItemTypeDesignInActiveBy)
            .add(txtItemTypeDesignCreatedBy);


    function reloadGridItemTypeDesign(){
        $("#itemTypeDesign_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("itemTypeDesign");
        
        $('#itemTypeDesign\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#itemTypeDesignSearchActiveStatusRadActive').prop('checked',true);
        $("#itemTypeDesignSearchActiveStatus").val("true");
        
        $('input[name="itemTypeDesignSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#itemTypeDesignSearchActiveStatus").val(value);
        });
        
        $('input[name="itemTypeDesignSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemTypeDesignSearchActiveStatus").val(value);
        });
                
        $('input[name="itemTypeDesignSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemTypeDesignSearchActiveStatus").val(value);
        });
        
        $('input[name="itemTypeDesignActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemTypeDesign\\.activeStatus").val(value);
            $("#itemTypeDesign\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="itemTypeDesignActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemTypeDesign\\.activeStatus").val(value);
        });
        
        $("#btnItemTypeDesignNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-type-design-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemTypeDesign();
                showInput("itemTypeDesign");
                hideInput("itemTypeDesignSearch");
                $('#itemTypeDesignActiveStatusRadActive').prop('checked',true);
                $("#itemTypeDesign\\.activeStatus").val("true");
                $("#itemTypeDesign\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#itemTypeDesign\\.createdDate").val("01/01/1900 00:00:00");
                txtItemTypeDesignCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtItemTypeDesignCode.attr("readonly",true);
                txtItemTypeDesignCode.val("AUTO");

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemTypeDesignSave").click(function(ev) {
           if(!$("#frmItemTypeDesignInput").valid()) {
//               handlers_input_itemTypeDesign();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           itemTypeDesignFormatDate();
           if (updateRowId < 0){
               url = "master/item-type-design-save";
           } else{
               url = "master/item-type-design-update";
           }
           
           var params = $("#frmItemTypeDesignInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    itemTypeDesignFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("itemTypeDesign");
                showInput("itemTypeDesignSearch");
                allFieldsItemTypeDesign.val('').siblings('label[class="error"]').hide();
                txtItemTypeDesignCode.val("AUTO");
                reloadGridItemTypeDesign();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnItemTypeDesignUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-type-design-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemTypeDesign();
                updateRowId=$("#itemTypeDesign_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var itemTypeDesign=$("#itemTypeDesign_grid").jqGrid('getRowData',updateRowId);
                var url="master/item-type-design-get-data";
                var params="itemTypeDesign.code=" + itemTypeDesign.code;

                txtItemTypeDesignCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtItemTypeDesignCode.val(data.itemTypeDesignTemp.code);
                        txtItemTypeDesignName.val(data.itemTypeDesignTemp.name);
                        rdbItemTypeDesignActiveStatus.val(data.itemTypeDesignTemp.activeStatus);
                        txtItemTypeDesignRemark.val(data.itemTypeDesignTemp.remark);
                        txtItemTypeDesignInActiveBy.val(data.itemTypeDesignTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.itemTypeDesignTemp.inActiveDate,true);
                        dtpItemTypeDesignInActiveDate.val(inActiveDate);
                        txtItemTypeDesignCreatedBy.val(data.itemTypeDesignTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.itemTypeDesignTemp.createdDate,true);
                        dtpItemTypeDesignCreatedDate.val(createdDate);

                        if(data.itemTypeDesignTemp.activeStatus===true) {
                           $('#itemTypeDesignActiveStatusRadActive').prop('checked',true);
                           $("#itemTypeDesign\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#itemTypeDesignActiveStatusRadInActive').prop('checked',true);              
                           $("#itemTypeDesign\\.activeStatus").val("false");
                        }

                        showInput("itemTypeDesign");
                        hideInput("itemTypeDesignSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemTypeDesignDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-type-design-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#itemTypeDesign_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var itemTypeDesign=$("#itemTypeDesign_grid").jqGrid('getRowData',deleteRowID);
                var url="master/item-type-design-delete";
                var params="itemTypeDesign.code=" + itemTypeDesign.code;
                var message="Are You Sure To Delete(Code : "+ itemTypeDesign.code + ")?";
                alertMessageDelete("itemTypeDesign",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ itemTypeDesign.code+ ')?</div>');
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
//                                var url="master/item-type-design-delete";
//                                var params="itemTypeDesign.code=" + itemTypeDesign.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridItemTypeDesign();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + itemTypeDesign.code+ ")")){
//                    var url="master/item-type-design-delete";
//                    var params="itemTypeDesign.code=" + itemTypeDesign.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridItemTypeDesign();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnItemTypeDesignCancel").click(function(ev) {
            hideInput("itemTypeDesign");
            showInput("itemTypeDesignSearch");
            allFieldsItemTypeDesign.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnItemTypeDesignRefresh').click(function(ev) {
            $('#itemTypeDesignSearchActiveStatusRadActive').prop('checked',true);
            $("#itemTypeDesignSearchActiveStatus").val("true");
            $("#itemTypeDesign_grid").jqGrid("clearGridData");
            $("#itemTypeDesign_grid").jqGrid("setGridParam",{url:"master/item-type-design-data?"});
            $("#itemTypeDesign_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnItemTypeDesignPrint").click(function(ev) {
            
            var url = "reports/item-type-design-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'itemTypeDesign','width=500,height=500');
        });
        
        $('#btnItemTypeDesign_search').click(function(ev) {
            $("#itemTypeDesign_grid").jqGrid("clearGridData");
            $("#itemTypeDesign_grid").jqGrid("setGridParam",{url:"master/item-type-design-data?" + $("#frmItemTypeDesignSearchInput").serialize()});
            $("#itemTypeDesign_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_itemTypeDesign(){
//        unHandlersInput(txtItemTypeDesignCode);
//        unHandlersInput(txtItemTypeDesignName);
//    }
//
//    function handlers_input_itemTypeDesign(){
//        if(txtItemTypeDesignCode.val()===""){
//            handlersInput(txtItemTypeDesignCode);
//        }else{
//            unHandlersInput(txtItemTypeDesignCode);
//        }
//        if(txtItemTypeDesignName.val()===""){
//            handlersInput(txtItemTypeDesignName);
//        }else{
//            unHandlersInput(txtItemTypeDesignName);
//        }
//    }
    
    function itemTypeDesignFormatDate(){
        var inActiveDate=formatDate(dtpItemTypeDesignInActiveDate.val(),true);
        dtpItemTypeDesignInActiveDate.val(inActiveDate);
        $("#itemTypeDesignTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpItemTypeDesignCreatedDate.val(),true);
        dtpItemTypeDesignCreatedDate.val(createdDate);
        $("#itemTypeDesignTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlItemTypeDesign" action="item-type-design-data" />
<b>Item Type Design</b>
<hr>
<br class="spacer"/>


<sj:div id="itemTypeDesignButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnItemTypeDesignNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnItemTypeDesignUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnItemTypeDesignDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnItemTypeDesignRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnItemTypeDesignPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="itemTypeDesignSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmItemTypeDesignSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="itemTypeDesignSearchCode" name="itemTypeDesignSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="itemTypeDesignSearchName" name="itemTypeDesignSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="itemTypeDesignSearchActiveStatus" name="itemTypeDesignSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="itemTypeDesignSearchActiveStatusRad" name="itemTypeDesignSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnItemTypeDesign_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="itemTypeDesignGrid">
    <sjg:grid
        id="itemTypeDesign_grid"
        dataType="json"
        href="%{remoteurlItemTypeDesign}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listItemTypeDesignTemp"
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
    
<div id="itemTypeDesignInput" class="content ui-widget">
    <s:form id="frmItemTypeDesignInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="itemTypeDesign.code" name="itemTypeDesign.code" title="*" required="true" cssClass="required" maxLength="16" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="itemTypeDesign.name" name="itemTypeDesign.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="itemTypeDesignActiveStatusRad" name="itemTypeDesignActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="itemTypeDesign.activeStatus" name="itemTypeDesign.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="itemTypeDesign.remark" name="itemTypeDesign.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="itemTypeDesign.inActiveBy"  name="itemTypeDesign.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker disabled="true" id="itemTypeDesign.inActiveDate" name="itemTypeDesign.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemTypeDesign.createdBy"  name="itemTypeDesign.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="itemTypeDesign.createdDate" name="itemTypeDesign.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemTypeDesignTemp.inActiveDateTemp" name="itemTypeDesignTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="itemTypeDesignTemp.createdDateTemp" name="itemTypeDesignTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnItemTypeDesignSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnItemTypeDesignCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>