
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
        txtItemRatingCode=$("#itemRating\\.code"),
        txtItemRatingName=$("#itemRating\\.name"),
        rdbItemRatingActiveStatus=$("#itemRating\\.activeStatus"),
        txtItemRatingRemark=$("#itemRating\\.remark"),
        txtItemRatingInActiveBy = $("#itemRating\\.inActiveBy"),
        dtpItemRatingInActiveDate = $("#itemRating\\.inActiveDate"),
        txtItemRatingCreatedBy = $("#itemRating\\.createdBy"),
        dtpItemRatingCreatedDate = $("#itemRating\\.createdDate"),
        
        allFieldsItemRating=$([])
            .add(txtItemRatingCode)
            .add(txtItemRatingName)
            .add(txtItemRatingRemark)
            .add(txtItemRatingInActiveBy)
            .add(txtItemRatingCreatedBy);


    function reloadGridItemRating(){
        $("#itemRating_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("itemRating");
        
        $('#itemRating\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#itemRatingSearchActiveStatusRadActive').prop('checked',true);
        $("#itemRatingSearchActiveStatus").val("true");
        
        $('input[name="itemRatingSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#itemRatingSearchActiveStatus").val(value);
        });
        
        $('input[name="itemRatingSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemRatingSearchActiveStatus").val(value);
        });
                
        $('input[name="itemRatingSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemRatingSearchActiveStatus").val(value);
        });
        
        $('input[name="itemRatingActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemRating\\.activeStatus").val(value);
            $("#itemRating\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="itemRatingActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemRating\\.activeStatus").val(value);
        });
        
        $("#btnItemRatingNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-rating-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemRating();
                showInput("itemRating");
                hideInput("itemRatingSearch");
                $('#itemRatingActiveStatusRadActive').prop('checked',true);
                $("#itemRating\\.activeStatus").val("true");
                $("#itemRating\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#itemRating\\.createdDate").val("01/01/1900 00:00:00");
                txtItemRatingCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtItemRatingCode.attr("readonly",true);
                txtItemRatingCode.val("AUTO");

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemRatingSave").click(function(ev) {
           if(!$("#frmItemRatingInput").valid()) {
//               handlers_input_itemRating();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           itemRatingFormatDate();
           if (updateRowId < 0){
               url = "master/item-rating-save";
           } else{
               url = "master/item-rating-update";
           }
           
           var params = $("#frmItemRatingInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    itemRatingFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("itemRating");
                showInput("itemRatingSearch");
                allFieldsItemRating.val('').siblings('label[class="error"]').hide();
                txtItemRatingCode.val("AUTO");
                reloadGridItemRating();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnItemRatingUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-rating-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemRating();
                updateRowId=$("#itemRating_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var itemRating=$("#itemRating_grid").jqGrid('getRowData',updateRowId);
                var url="master/item-rating-get-data";
                var params="itemRating.code=" + itemRating.code;

                txtItemRatingCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtItemRatingCode.val(data.itemRatingTemp.code);
                        txtItemRatingName.val(data.itemRatingTemp.name);
                        rdbItemRatingActiveStatus.val(data.itemRatingTemp.activeStatus);
                        txtItemRatingRemark.val(data.itemRatingTemp.remark);
                        txtItemRatingInActiveBy.val(data.itemRatingTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.itemRatingTemp.inActiveDate,true);
                        dtpItemRatingInActiveDate.val(inActiveDate);
                        txtItemRatingCreatedBy.val(data.itemRatingTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.itemRatingTemp.createdDate,true);
                        dtpItemRatingCreatedDate.val(createdDate);

                        if(data.itemRatingTemp.activeStatus===true) {
                           $('#itemRatingActiveStatusRadActive').prop('checked',true);
                           $("#itemRating\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#itemRatingActiveStatusRadInActive').prop('checked',true);              
                           $("#itemRating\\.activeStatus").val("false");
                        }

                        showInput("itemRating");
                        hideInput("itemRatingSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemRatingDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-rating-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#itemRating_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var itemRating=$("#itemRating_grid").jqGrid('getRowData',deleteRowID);
                var url="master/item-rating-delete";
                var params="itemRating.code=" + itemRating.code;
                var message="Are You Sure To Delete(Code : "+ itemRating.code + ")?";
                alertMessageDelete("itemRating",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ itemRating.code+ ')?</div>');
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
//                                var url="master/item-rating-delete";
//                                var params="itemRating.code=" + itemRating.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridItemRating();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + itemRating.code+ ")")){
//                    var url="master/item-rating-delete";
//                    var params="itemRating.code=" + itemRating.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridItemRating();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnItemRatingCancel").click(function(ev) {
            hideInput("itemRating");
            showInput("itemRatingSearch");
            allFieldsItemRating.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnItemRatingRefresh').click(function(ev) {
            $('#itemRatingSearchActiveStatusRadActive').prop('checked',true);
            $("#itemRatingSearchActiveStatus").val("true");
            $("#itemRating_grid").jqGrid("clearGridData");
            $("#itemRating_grid").jqGrid("setGridParam",{url:"master/item-rating-data?"});
            $("#itemRating_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnItemRatingPrint").click(function(ev) {
            
            var url = "reports/item-rating-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'itemRating','width=500,height=500');
        });
        
        $('#btnItemRating_search').click(function(ev) {
            $("#itemRating_grid").jqGrid("clearGridData");
            $("#itemRating_grid").jqGrid("setGridParam",{url:"master/item-rating-data?" + $("#frmItemRatingSearchInput").serialize()});
            $("#itemRating_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_itemRating(){
//        unHandlersInput(txtItemRatingCode);
//        unHandlersInput(txtItemRatingName);
//    }
//
//    function handlers_input_itemRating(){
//        if(txtItemRatingCode.val()===""){
//            handlersInput(txtItemRatingCode);
//        }else{
//            unHandlersInput(txtItemRatingCode);
//        }
//        if(txtItemRatingName.val()===""){
//            handlersInput(txtItemRatingName);
//        }else{
//            unHandlersInput(txtItemRatingName);
//        }
//    }
    
    function itemRatingFormatDate(){
        var inActiveDate=formatDate(dtpItemRatingInActiveDate.val(),true);
        dtpItemRatingInActiveDate.val(inActiveDate);
        $("#itemRatingTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpItemRatingCreatedDate.val(),true);
        dtpItemRatingCreatedDate.val(createdDate);
        $("#itemRatingTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlItemRating" action="item-rating-data" />
<b>Item Rating</b>
<hr>
<br class="spacer"/>


<sj:div id="itemRatingButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnItemRatingNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnItemRatingUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnItemRatingDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnItemRatingRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnItemRatingPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="itemRatingSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmItemRatingSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="itemRatingSearchCode" name="itemRatingSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="itemRatingSearchName" name="itemRatingSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="itemRatingSearchActiveStatus" name="itemRatingSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="itemRatingSearchActiveStatusRad" name="itemRatingSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnItemRating_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="itemRatingGrid">
    <sjg:grid
        id="itemRating_grid"
        dataType="json"
        href="%{remoteurlItemRating}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listItemRatingTemp"
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
    
<div id="itemRatingInput" class="content ui-widget">
    <s:form id="frmItemRatingInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="itemRating.code" name="itemRating.code" title="*" required="true" cssClass="required" maxLength="16" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="itemRating.name" name="itemRating.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="itemRatingActiveStatusRad" name="itemRatingActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="itemRating.activeStatus" name="itemRating.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="itemRating.remark" name="itemRating.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="itemRating.inActiveBy"  name="itemRating.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="itemRating.inActiveDate" name="itemRating.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemRating.createdBy"  name="itemRating.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="itemRating.createdDate" name="itemRating.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemRatingTemp.inActiveDateTemp" name="itemRatingTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="itemRatingTemp.createdDateTemp" name="itemRatingTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnItemRatingSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnItemRatingCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>