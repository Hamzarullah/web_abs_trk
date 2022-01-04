
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #errmsgMinStock,#errmsgMaxStock{
        color: red;
    }
</style>

<script type="text/javascript">

    var 
        txtItemMaterialCode = $("#itemMaterial\\.code"),
        txtItemMaterialName = $("#itemMaterial\\.name"),
        txtItemMaterialItemMaterialSubCategoryCode = $("#itemMaterial\\.itemSubCategory\\.code"),
        txtItemMaterialItemMaterialSubCategoryName = $("#itemMaterial\\.itemSubCategory\\.name"),
        txtItemMaterialItemMaterialCategoryCode = $("#itemMaterial\\.itemSubCategory\\.itemCategory\\.code"),
        txtItemMaterialItemMaterialCategoryName = $("#itemMaterial\\.itemSubCategory\\.itemCategory\\.name"),
        txtItemMaterialItemMaterialDivisionCode = $("#itemMaterial\\.itemSubCategory\\.itemCategory\\.itemDivision\\.code"),
        txtItemMaterialItemMaterialDivisionName = $("#itemMaterial\\.itemSubCategory\\.itemCategory\\.itemDivision\\.name"),
        txtItemMaterialUnitOfMeasureCode = $("#itemMaterial\\.unitOfMeasure\\.code"),
        txtItemMaterialUnitOfMeasureName = $("#itemMaterial\\.unitOfMeasure\\.name"),
        txtItemMaterialItemBrandCode = $("#itemMaterial\\.itemBrand\\.code"),
        txtItemMaterialItemBrandName = $("#itemMaterial\\.itemBrand\\.name"),
        rdbItemMaterialInventoryType = $("#itemMaterial\\.inventoryType"),
        txtItemMaterialMinStock = $("#itemMaterial\\.minStock"),
        txtItemMaterialMaxStock = $("#itemMaterial\\.maxStock"),
        txtItemMaterialRemark = $("#itemMaterial\\.remark"),
        rdbItemMaterialActiveStatus = $("#itemMaterial\\.activeStatus"),
        txtItemMaterialInActiveBy = $("#itemMaterial\\.inActiveBy"),
        txtItemMaterialInActiveDate = $("#itemMaterial\\.inActiveDate"),
        txtItemMaterialCreatedBy = $("#itemMaterial\\.createdBy"),
        txtItemMaterialCreatedDate = $("#itemMaterial\\.createdDate"),
        
        allFieldsItemMaterial=$([])
            .add(txtItemMaterialCode)
            .add(txtItemMaterialName)
            .add(txtItemMaterialItemMaterialSubCategoryCode)
            .add(txtItemMaterialItemMaterialSubCategoryName)
            .add(txtItemMaterialItemMaterialCategoryCode)
            .add(txtItemMaterialItemMaterialCategoryName)
            .add(txtItemMaterialItemMaterialDivisionCode)
            .add(txtItemMaterialItemMaterialDivisionName)
            .add(txtItemMaterialUnitOfMeasureCode)
            .add(txtItemMaterialUnitOfMeasureName)
            .add(txtItemMaterialItemBrandCode)
            .add(txtItemMaterialItemBrandName)
            .add(rdbItemMaterialInventoryType)
            .add(txtItemMaterialMinStock)
            .add(txtItemMaterialMaxStock)
            .add(txtItemMaterialRemark)
            .add(rdbItemMaterialActiveStatus)
            .add(txtItemMaterialInActiveBy)
            .add(txtItemMaterialInActiveDate)
            .add(txtItemMaterialCreatedBy)
            .add(txtItemMaterialCreatedDate);
               
    $(document).ready(function(){
        hoverButton();
        var updateRowId = -1;
        hideInput("itemMaterial");
        
        $('#itemMaterial\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $("#itemMaterial\\.minStock").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgMinStock").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });

        $("#itemMaterial\\.minStock").keyup(function(e){
           $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                return numberWithCommasItemMaterial(value);
            });
           
        });
        
        $("#itemMaterial\\.minStock").change(function(e){
            var minStock=$("#itemMaterial\\.minStock").val();
            
            if(minStock==="" || parseFloat(minStock)===0){
               $("#itemMaterial\\.minStock").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                
                return formatNumber(parseFloat(value),2); 
            });
           
        });
        
        $("#itemMaterial\\.maxStock").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgMaxStock").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });

        $("#itemMaterial\\.maxStock").keyup(function(e){
           $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                return numberWithCommasItemMaterial(value);
            });
        });
        
        $("#itemMaterial\\.maxStock").change(function(e){
            var maxStock=$("#itemMaterial\\.maxStock").val();
            
            if(maxStock==="" || parseFloat(maxStock)===0){
               $("#itemMaterial\\.maxStock").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                
                return formatNumber(parseFloat(value),2); 
            });
        });
        
        $('#itemMaterialSearchActiveStatusRadActive').prop('checked',true);
        $("#itemMaterialSearchActiveStatus").val("true");
        
        $('#itemMaterialSearchInventoryTypeRadAll').prop('checked',true);
        $("#itemMaterialSearchInventoryType").val("");
        
        $('input[name="itemMaterialSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#itemMaterialSearchActiveStatus").val(value);
            $('#btnItemMaterial_search').trigger('click');
        });
        
        $('input[name="itemMaterialSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemMaterialSearchActiveStatus").val(value);
            $('#btnItemMaterial_search').trigger('click');
        });
                
        $('input[name="itemMaterialSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemMaterialSearchActiveStatus").val(value);
            $('#btnItemMaterial_search').trigger('click');
        });
        
        // search inventory type
        
        $('input[name="itemMaterialSearchInventoryTypeRad"][value="All"]').change(function(ev){
            var value="";
            $("#itemMaterialSearchInventoryType").val(value);
            $('#btnItemMaterial_search').trigger('click');
        });
        
        $('input[name="itemMaterialSearchInventoryTypeRad"][value="INVENTORY"]').change(function(ev){
            var value="INVENTORY";
            $("#itemMaterialSearchInventoryType").val(value);
            $('#btnItemMaterial_search').trigger('click');
        });
                
        $('input[name="itemMaterialSearchInventoryTypeRad"][value="NON_INVENTORY"]').change(function(ev){
            var value="NON_INVENTORY";
            $("#itemMaterialSearchInventoryType").val(value);
            $('#btnItemMaterial_search').trigger('click');
        });
        
        $('input[name="itemMaterialRadInventoryType"][value="INVENTORY"]').change(function(ev){
            var value="INVENTORY";
            $("#itemMaterial\\.inventoryType").val(value);
            decisionSerialStatus("INVENTORY");
        });
                
        $('input[name="itemMaterialRadInventoryType"][value="NON_INVENTORY"]').change(function(ev){
            var value="NON_INVENTORY";
            $("#itemMaterial\\.inventoryType").val(value);
            decisionSerialStatus("NON_INVENTORY");
        });
        
        $('input[name="itemMaterial\\.conversionStatus"][value="YES"]').change(function(ev){
            var value="true";
            $("#itemMaterial\\.conversionStatus").val(value);
        });
                
        $('input[name="itemMaterial\\.conversionStatus"][value="NO"]').change(function(ev){
            var value="false";
            $("#itemMaterial\\.conversionStatus").val(value);
        });
        
        $('input[name="itemMaterial\\.serialNoStatus"][value="YES"]').change(function(ev){
            var value="true";
            $("#itemMaterial\\.serialNoStatus").val(value);
        });
                
        $('input[name="itemMaterial\\.serialNoStatus"][value="NO"]').change(function(ev){
            var value="false";
            $("#itemMaterial\\.serialNoStatus").val(value);
        });
        
        $('input[name="itemMaterial\\.activeStatus"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemMaterial\\.activeStatus").val(value);
        });
                
        $('input[name="itemMaterial\\.activeStatus"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemMaterial\\.activeStatus").val(value);
        });
               
        $.subscribe("itemMaterial_grid_onSelect", function(event, data){
            var selectedRowID = $("#itemMaterial_grid").jqGrid("getGridParam", "selrow"); 
            var itemMaterial = $("#itemMaterial_grid").jqGrid("getRowData", selectedRowID);
            
            $("#itemMaterialVendor_grid").jqGrid("setGridParam",{url:"master/item-material-vendor-detail-exisitng?itemMaterialVendor.code=" + itemMaterial.code});
            $("#itemMaterialVendor_grid").jqGrid("setCaption", "ITEM MATERIAL VENDOR : " + itemMaterial.code);
            $("#itemMaterialVendor_grid").trigger("reloadGrid");
        });
               
        $("#btnItemMaterialNew").click(function(ev){
            var url="master/itemMaterial-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                unHandlers_input_itemMaterial();
                allFieldsItemMaterial.val('').removeClass('ui-state-error');
                showInput("itemMaterial");
                hideInput("itemMaterialSearch");
                $('#itemMaterialRadInventoryTypeINVENTORY').prop('checked',true);
                $("#itemMaterial\\.inventoryType").val("INVENTORY");
                txtItemMaterialMinStock.val("0.00");
                txtItemMaterialMaxStock.val("0.00");
                $('#itemMaterial\\.activeStatusActive').prop('checked',true);
                $("#itemMaterial\\.activeStatus").val("true");
                $("#itemMaterial\\.code").val("AUTO");
                $("#itemMaterial\\.code").attr("readonly",true);
                updateRowId = -1;
                txtItemMaterialCode.attr("readonly",true);
                txtItemMaterialCode.val("AUTO");
                $("#itemMaterial\\.activeStatus").val("true");
            });
            ev.preventDefault();
        });
        
        $("#btnItemMaterialSave").click(function(ev) {
        
            if(txtItemMaterialCode.val()===""){
                handlersInput(txtItemMaterialCode);
                alertMessage("ItemMaterial Code Can't Empty!",txtItemMaterialCode);
                return;
            }else{
                unHandlersInput(txtItemMaterialCode);
            }
            
            if(txtItemMaterialName.val()===""){
                handlersInput(txtItemMaterialName);
                alertMessage("ItemMaterial Name Can't Empty!",txtItemMaterialName);
                return;
            }else{
                unHandlersInput(txtItemMaterialName);
            }
            
            if(txtItemMaterialItemMaterialSubCategoryCode.val()===""){
                handlersInput(txtItemMaterialItemMaterialSubCategoryCode);
                alertMessage("ItemMaterial Category Can't Empty!",txtItemMaterialItemMaterialSubCategoryCode);
                return;
            }else{
                unHandlersInput(txtItemMaterialItemMaterialSubCategoryCode);
            }

            if(txtItemMaterialUnitOfMeasureCode.val()===""){
                handlersInput(txtItemMaterialUnitOfMeasureCode);
                alertMessage("Unit Code Can't Empty!",txtItemMaterialUnitOfMeasureCode);
                return;
            }else{
                unHandlersInput(txtItemMaterialUnitOfMeasureCode);
            }
            
            if(txtItemMaterialItemBrandCode.val()===""){
                handlersInput(txtItemMaterialItemBrandCode);
                alertMessage("Brand Code Can't Empty!",txtItemMaterialItemBrandCode);
                return;
            }else{
                unHandlersInput(txtItemMaterialItemBrandCode);
            }

             if(parseFloat(removeCommas(txtItemMaterialMinStock.val())) > parseFloat(removeCommas(txtItemMaterialMaxStock.val()))){
                alertMessage("Minimum Stock Should be Less Than Max stock!");
                return;
            }else{
                unHandlersInput(txtItemMaterialMinStock);
            }
        
            var url = "";
           
            if (updateRowId < 0){
                url = "master/item-material-save";
            }
            else{
                url = "master/item-material-update";
            }

            formatDateAndNumericInItemMaterial();
            var params = $("#frmItemMaterialInput").serialize();

        $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                hideInput("itemMaterial");
                showInput("itemMaterialSearch");
                allFieldsItemMaterial.val('').removeClass('ui-state-error');
                txtItemMaterialMinStock.val("0");
                txtItemMaterialMaxStock.val("0");
//                txtItemMaterialPartConversion.val("0");
//                txtItemMaterialTolerance.val("0");
//                txtItemMaterialConversion.val("0");
//                txtItemMaterialCogsIDR.val("0");
                txtItemMaterialCode.val("AUTO");
                reloadGridItemMaterial();           
           });
           
           ev.preventDefault();
        });
        
        $("#btnItemMaterialUpdate").click(function(ev){
            var url="master/item-material-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                unHandlers_input_itemMaterial();
                updateRowId = $("#itemMaterial_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId === null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var itemMaterial = $("#itemMaterial_grid").jqGrid('getRowData', updateRowId);
                var url = "master/item-material-get-data";
                var params = "itemMaterial.code=" + itemMaterial.code;

                txtItemMaterialCode.attr("readonly",true);

                $.post(url, params, function(result) {

                    var data = (result);
                        txtItemMaterialCode.val(data.itemMaterialTemp.code);
                        txtItemMaterialName.val(data.itemMaterialTemp.name);
                        txtItemMaterialItemMaterialSubCategoryCode.val(data.itemMaterialTemp.itemSubCategoryCode);
                        txtItemMaterialItemMaterialSubCategoryName.val(data.itemMaterialTemp.itemSubCategoryName);
                        txtItemMaterialItemMaterialCategoryCode.val(data.itemMaterialTemp.itemCategoryCode);
                        txtItemMaterialItemMaterialCategoryName.val(data.itemMaterialTemp.itemCategoryName);
                        txtItemMaterialItemMaterialDivisionCode.val(data.itemMaterialTemp.itemDivisionCode);
                        txtItemMaterialItemMaterialDivisionName.val(data.itemMaterialTemp.itemDivisionName);
                        txtItemMaterialUnitOfMeasureCode.val(data.itemMaterialTemp.unitOfMeasureCode);
                        txtItemMaterialUnitOfMeasureName.val(data.itemMaterialTemp.unitOfMeasureName);
//                        txtItemMaterialUnitOfMeasureConversionCode.val(data.itemMaterialTemp.unitOfMeasureConversionCode);
//                        txtItemMaterialUnitOfMeasureConversionName.val(data.itemMaterialTemp.unitOfMeasureConversionName);
                        txtItemMaterialItemBrandCode.val(data.itemMaterialTemp.itemBrandCode);
                        txtItemMaterialItemBrandName.val(data.itemMaterialTemp.itemBrandName);
//                        txtItemMaterialPartConversion.val(formatNumber(parseFloat(data.itemMaterialTemp.partConversion),2));
//                        txtItemMaterialTolerance.val(formatNumber(parseFloat(data.itemMaterialTemp.tolerance),2));
//                        rdbItemMaterialConversionStatus.val(data.itemMaterialTemp.conversionStatus);
//                        txtItemMaterialConversion.val(formatNumber(parseFloat(data.itemMaterialTemp.conversion),2));
                        rdbItemMaterialInventoryType.val(data.itemMaterialTemp.inventoryType);
                        txtItemMaterialMinStock.val(formatNumber(parseFloat(data.itemMaterialTemp.minStock),2));
                        txtItemMaterialMaxStock.val(formatNumber(parseFloat(data.itemMaterialTemp.maxStock),2));
//                        txtItemMaterialCogsIDR.val(formatNumber(parseFloat(data.itemMaterialTemp.cogsIDR),2));
                        rdbItemMaterialActiveStatus.val(data.itemMaterialTemp.activeStatus);
                        txtItemMaterialCreatedBy.val(data.itemMaterialTemp.createdBy);
                        txtItemMaterialCreatedDate.val(data.itemMaterialTemp.createdDate);
                        
                        if(data.itemMaterialTemp.inventoryType==="INVENTORY") {
                           $('#itemMaterialRadInventoryTypeINVENTORY').prop('checked',true);
                           $("#itemMaterial\\.InventoryType").val("INVENTORY");
                        }
                        else {  
                           $('#itemMaterialRadInventoryTypeNON_INVENTORY').prop('checked',true);              
                           $("#itemMaterial\\.InventoryType").val("NON_INVENTORY");
                        }
                        
                        if(data.itemMaterialTemp.conversionStatus===true) {
                           $('#itemMaterial\\.conversionStatusYES').prop('checked',true);
                           $("#itemMaterial\\.conversionStatus").val("true");
                        }
                        else {                        
                           $('#itemMaterial\\.conversionStatusNO').prop('checked',true);              
                           $("#itemMaterial\\.conversionStatus").val("false");
                        }
                        
                        if(data.itemMaterialTemp.serialNoStatus===true) {
                           $('#itemMaterial\\.serialNoStatusYES').prop('checked',true);
                           $("#itemMaterial\\.serialNoStatus").val("true");
                        }
                        else {                        
                           $('#itemMaterial\\.serialNoStatusNO').prop('checked',true);              
                           $("#itemMaterial\\.serialNoStatus").val("false");
                        }
                        
                        if(data.itemMaterialTemp.activeStatus===true) {
                           $('#itemMaterial\\.activeStatusActive').prop('checked',true);
                           $("#itemMaterial\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#itemMaterial\\.activeStatusInActive').prop('checked',true);              
                           $("#itemMaterial\\.activeStatus").val("false");
                        }

                    showInput("itemMaterial");
                    hideInput("itemMaterialSearch");
                });    
            });
            ev.preventDefault();
        });
        
        $("#btnItemMaterialAddVendor").click(function(ev){
            updateRowId = $("#itemMaterial_grid").jqGrid("getGridParam","selrow");
            if(updateRowId === null){
                alertMessage("Please Select Row!");
                return;
            }

            var itemMaterial = $("#itemMaterial_grid").jqGrid('getRowData', updateRowId);
            var url = "master/item-material-vendor-input";
            var param = "itemMaterialVendor.code=" + itemMaterial.code;

            pageLoad(url, param, "#tabmnuITEM_MATERIAL");
            ev.preventDefault();  
        });
        
        $('#btnItemMaterialDelete').click(function(ev) {
            var url="master/item-material-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowId = $("#itemMaterial_grid").jqGrid('getGridParam','selrow');
            
                if (deleteRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                var itemMaterial = $("#itemMaterial_grid").jqGrid('getRowData', deleteRowId);
                if (confirm("Are You Sure To Delete (Code : " + itemMaterial.code + ")")) {
                    var url = "master/item-material-delete";
                    var params = "itemMaterial.code=" + itemMaterial.code;

                    $.post(url, params, function(data) {
                        if (data.error) {
                            alertMessage(data.errorMessage);
                            return;
                        }

                        alertMessage(data.message);
                        reloadGridItemMaterial();
                    });
                }
                
            }); 
            ev.preventDefault();
        });
        
        $("#btnItemMaterialCancel").click(function(ev) {
             hideInput("itemMaterial");
             showInput("itemMaterialSearch");
             allFieldsItemMaterial.val('').removeClass('ui-state-error');
             txtItemMaterialMinStock.val("0");
             txtItemMaterialMaxStock.val("0");
             ev.preventDefault();
         });
     
        $('#btnItemMaterialRefresh').click(function(ev) {
            var url = "master/item-material";
            var params = "";
            pageLoad(url, params, "#tabmnuITEM_MATERIAL");
            ev.preventDefault();    
        });
        
        $('#btnItemMaterial_search').click(function(ev) {
            $("#itemMaterial_grid").jqGrid("clearGridData");
            $("#itemMaterial_grid").jqGrid("setGridParam",{url:"master/item-material-data?" + $("#frmItemMaterialSearchInput").serialize()});
            $("#itemMaterial_grid").trigger("reloadGrid");
            $("#itemMaterialVendor_grid").jqGrid("clearGridData");
            $("#itemMaterialVendor_grid").jqGrid("setCaption", "Item Material Vendor");
            ev.preventDefault();
        });
       
        $('#itemMaterial_btnIteSubCategory  ').click(function(ev) {
            window.open("./pages/search/search-item-sub-category.jsp?iddoc=itemMaterial&idsubdoc=itemSubCategory","Search", "width=550, height=500");
        });
       
        $('#itemMaterial_btnUnitOfMeasure').click(function(ev) {
            window.open("./pages/search/search-unit-of-measure.jsp?iddoc=itemMaterial&idsubdoc=unitOfMeasure","Search", "scrollbars=1, width=550, height=500");
        });
        
        $('#itemMaterial_btnUnitOfMeasureConversion').click(function(ev) {
            window.open("./pages/search/search-unit-of-measure.jsp?iddoc=itemMaterial&idsubdoc=unitOfMeasureConversion","Search", "scrollbars=1, width=550, height=500");
        });
        
        $('#itemMaterial_btnItemBrand').click(function(ev) {
            window.open("./pages/search/search-item-brand.jsp?iddoc=itemMaterial&idsubdoc=itemBrand","Search", "scrollbars=1, width=550, height=500");
        });
        
       
    });
    
   function reloadGridItemMaterial() {
        $("#itemMaterial_grid").trigger("reloadGrid");
    };
    
    function formatDateAndNumericInItemMaterial(){
        var minStock =removeCommas(txtItemMaterialMinStock.val());
        var maxStock =removeCommas(txtItemMaterialMaxStock.val());
        
        txtItemMaterialMinStock.val(minStock);
        txtItemMaterialMaxStock.val(maxStock);
    }
    
    function numberWithCommasItemMaterial(x) {
        var parts = x.toString().split(".");
        
        parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        return parts.join(".");
    }
    
    function unHandlers_input_itemMaterial(){
        unHandlersInput(txtItemMaterialCode);
        unHandlersInput(txtItemMaterialName);
        unHandlersInput(txtItemMaterialItemMaterialSubCategoryCode);
        unHandlersInput(txtItemMaterialUnitOfMeasureCode);
        unHandlersInput(txtItemMaterialItemBrandCode);
    };
    
    function decisionSerialStatus(data){
        switch (data){
            case "INVENTORY":
                $('#itemMaterial\\.serialNoStatusYES').prop('checked',true);
                $("#itemMaterial\\.serialNoStatus").val("true");
                $('#itemMaterial\\.serialNoStatusYES').attr('disabled',false);
                break;
            case "NON_INVENTORY":
                $('#itemMaterial\\.serialNoStatusNO').prop('checked',true);              
                $("#itemMaterial\\.serialNoStatus").val("false");
                $('#itemMaterial\\.serialNoStatusYES').attr('disabled',true);
                break;
        }
            
    }
    
</script>

<s:url id="remoteurlItemMaterial" action="item-material-data" />
<b>ITEM MATERIAL</b>
<hr>
<br class="spacer" />
<sj:div id="itemMaterialButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
        <td><a href="#" id="btnItemMaterialNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a></td>
        <td><a href="#" id="btnItemMaterialUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a></td>
        <td><a href="#" id="btnItemMaterialDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a></td>
        <td><a href="#" id="btnItemMaterialRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a></td>
        <td><a href="#" id="btnItemMaterialPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print Out</a></td>
        <td><a href="#" id="btnItemMaterialAddVendor" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>Add Vendor</a></td>
<!--    <a href="#" id="btnItemMaterialPrintXls" class="ikb-button ui-state-default ui-corner-left ui-corner-right"><img src="images/button_excel.PNG" border="0" title="Excel"/></a>-->
    </table>
</sj:div>   
    
<div id="itemMaterialSearchInput" class="content ui-widget">
    <br class="spacer" />
    <br class="spacer" />
    <s:form id="frmItemMaterialSearchInput">
        <table cellpadding="2" cellspacing="2" width="100%">
            <tr>
                <td align="right" width="80px">Item Material</td>
                <td width="300px">
                    <s:textfield id="itemMaterialSearchCode" name="itemMaterialSearchCode" size="15" PlaceHolder=" Code"></s:textfield>
                    <s:textfield id="itemMaterialSearchName" name="itemMaterialSearchName" cssStyle="width:60%" PlaceHolder=" Name"></s:textfield>
                </td>

                <td align="right" width="100px">Inventory Type</td>
                <td>
                    <s:textfield id="itemMaterialSearchInventoryType" name="itemMaterialSearchInventoryType" readonly="false" size="5" style="display:none"></s:textfield>
                    <s:radio id="itemMaterialSearchInventoryTypeRad" name="itemMaterialSearchInventoryTypeRad" list="{'INVENTORY','NON_INVENTORY','All'}"></s:radio>
                </td>
            </tr>  
            <tr>
                <td align="right">Status</td>                
                <td>
                    <s:textfield id="itemMaterialSearchActiveStatus" name="itemMaterialSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                    <s:radio id="itemMaterialSearchActiveStatusRad" name="itemMaterialSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br />
        <sj:a href="#" id="btnItemMaterial_search" button="true">Search</sj:a>
    </s:form>
    <br class="spacer" />

    
<div id="itemMaterialGrid">
    <sjg:grid
        id="itemMaterial_grid"
        dataType="json"
        href="%{remoteurlItemMaterial}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listItemMaterialTemp"
        rowList="10,20,30"
        rowNum="10"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        width="$('#tabmnuitemMaterial').width()"
        onSelectRowTopics="itemMaterial_grid_onSelect"
    >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="name" index="name" title="Name" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="itemSubCategoryName" index="itemSubCategoryName" title="Sub Category" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="itemCategoryName" index="itemCategoryName" title="Category" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="itemDivisionCode" index="itemDivisionCode" title="Division" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="unitOfMeasureCode" index="unitOfMeasureCode" title="Unit" width="80" sortable="true" 
        />
        <sjg:gridColumn
            name="itemBrandCode" index="itemBrandCode" title="Brand" width="80" sortable="true" 
        />
        <sjg:gridColumn
            name="inventoryType" index="inventoryType" title="InventoryType" width="100" sortable="true"
        />
        
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center" 
        />
    </sjg:grid >
    <br class="spacer" />
    
    <sjg:grid
        id="itemMaterialVendor_grid"
        caption=""
        dataType="json"   
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listItemMaterialVendorDetailExisting"
        rowList="10,20,30"
        rowNum="10"
        sortable="true"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        width="1100"
    >
        <sjg:gridColumn
            name="vendorCode" index="vendorCode" key="vendorCode" title="Vendor Code" width="150" sortable="true"
        />
        <sjg:gridColumn
            name="vendorName" index="vendorName" key="vendorName" title="Vendor Name" width="350" sortable="true"
        />
    </sjg:grid >
    
</div>
<br/>
</div>

<br/>   
<div id="itemMaterialInput" class="content ui-widget">
    <s:form id="frmItemMaterialInput">
        <table cellpadding="2" cellspacing="2" style="float : left">
            <tr>
                <td align="right"><B>Code *</B></td>
                 <td><s:textfield id="itemMaterial.code" name="itemMaterial.code" size="25" title="*" required="true" cssClass="required" maxLength="45" cssStyle="text-align: left;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Name *</B></td>
                <td><s:textfield id="itemMaterial.name" name="itemMaterial.name" size="50" title="*" required="true" cssClass="required"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Sub Category *</B></td>
                <td>
                    <script type = "text/javascript">

                    txtItemMaterialItemMaterialSubCategoryCode.change(function(ev) {
                            if(txtItemMaterialItemMaterialSubCategoryCode.val()===""){
                                txtItemMaterialItemMaterialSubCategoryCode.val("");
                                txtItemMaterialItemMaterialSubCategoryName.val("");
                                txtItemMaterialItemMaterialCategoryCode.val("");
                                txtItemMaterialItemMaterialCategoryName.val("");
                                txtItemMaterialItemMaterialDivisionCode.val("");
                                txtItemMaterialItemMaterialDivisionName.val("");
                                return;
                            }
                            var url = "master/item-sub-category-get";
                            var params = "itemSubCategory.code=" + txtItemMaterialItemMaterialSubCategoryCode.val();
                                params += "&itemSubCategory.activeStatus="+true;
                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.itemSubCategoryTemp){
                                    txtItemMaterialItemMaterialSubCategoryCode.val(data.itemSubCategoryTemp.code);
                                    txtItemMaterialItemMaterialSubCategoryName.val(data.itemSubCategoryTemp.name);
                                    txtItemMaterialItemMaterialCategoryCode.val(data.itemSubCategoryTemp.itemCategoryCode);
                                    txtItemMaterialItemMaterialCategoryName.val(data.itemSubCategoryTemp.itemCategoryName);
                                    txtItemMaterialItemMaterialDivisionCode.val(data.itemSubCategoryTemp.itemDivisionCode);
                                    txtItemMaterialItemMaterialDivisionName.val(data.itemSubCategoryTemp.itemDivisionName);
                                }else{ 
                                    alertMessage("Item Sub Category Not Found!",txtItemMaterialItemMaterialSubCategoryCode);
                                    txtItemMaterialItemMaterialSubCategoryCode.val("");
                                    txtItemMaterialItemMaterialSubCategoryName.val("");
                                    txtItemMaterialItemMaterialCategoryCode.val("");
                                    txtItemMaterialItemMaterialCategoryName.val("");
                                    txtItemMaterialItemMaterialDivisionCode.val("");
                                    txtItemMaterialItemMaterialDivisionName.val("");
                                }

                            });
                        });

                    </script>
                        <div class="searchbox ui-widget-header">
                        <s:textfield id="itemMaterial.itemSubCategory.code" name="itemMaterial.itemSubCategory.code" title="*" required="true" cssClass="required" size="20"></s:textfield>
                            <sj:a id="itemMaterial_btnIteSubCategory" href="#" openDialog="">&nbsp;&nbsp;<span id="subCategorySearch" class="ui-icon ui-icon-search"/></sj:a>
                        </div>
                    <s:textfield id="itemMaterial.itemSubCategory.name" name="itemMaterial.itemSubCategory.name" size="25" readonly="true"></s:textfield> 

                </td>
            </tr>
            
            <tr>
                <td align="right">Item Category</td>
                <td colspan="2">
                    <s:textfield id="itemMaterial.itemSubCategory.itemCategory.code" name="itemMaterial.itemSubCategory.itemCategory.code" readonly="true" size="15"></s:textfield>
                    <s:textfield id="itemMaterial.itemSubCategory.itemCategory.name" name="itemMaterial.itemSubCategory.itemCategory.name" readonly="true" size="25"></s:textfield> 
                </td>
            </tr>
            
            <tr>
                <td align="right">Division</td>
                <td colspan="2">
                    <s:textfield id="itemMaterial.itemSubCategory.itemCategory.itemDivision.code" name="itemMaterial.itemSubCategory.itemCategory.itemDivision.code" readonly="true" size="15"></s:textfield>
                    <s:textfield id="itemMaterial.itemSubCategory.itemCategory.itemDivision.name" name="itemMaterial.itemSubCategory.itemCategory.itemDivision.name" readonly="true" size="25"></s:textfield> 
                </td>
            </tr>
            <tr>
                <td align="right"><B>UOM *</B></td>
                <td>
                    <script type = "text/javascript">

                    txtItemMaterialUnitOfMeasureCode.change(function(ev) {
                            if(txtItemMaterialUnitOfMeasureCode.val()===""){
                                txtItemMaterialUnitOfMeasureCode.val("");
                                txtItemMaterialUnitOfMeasureName.val("");
                                return;
                            }

                            var url = "master/unit-of-measure-get";
                            var params = "unitOfMeasure.code=" + txtItemMaterialUnitOfMeasureCode.val();
                                params += "&unitOfMeasure.activeStatus="+true;
                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.unitOfMeasureTemp){
                                    txtItemMaterialUnitOfMeasureCode.val(data.unitOfMeasureTemp.code);
                                    txtItemMaterialUnitOfMeasureName.val(data.unitOfMeasureTemp.name);
                                }else{ 
                                    alertMessage("Unit Of Measure Not Found!",txtItemMaterialUnitOfMeasureCode);
                                    txtItemMaterialUnitOfMeasureCode.val("");
                                    txtItemMaterialUnitOfMeasureName.val("");
                                }
                            });
                        });

                    </script>
                        <div class="searchbox ui-widget-header">
                        <s:textfield id="itemMaterial.unitOfMeasure.code" name="itemMaterial.unitOfMeasure.code" title=" " required="true" cssClass="required" size="20"></s:textfield>
                            <sj:a id="itemMaterial_btnUnitOfMeasure" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                        </div>
                    <s:textfield id="itemMaterial.unitOfMeasure.name" name="itemMaterial.unitOfMeasure.name" size="25" readonly="true"></s:textfield> 
                </td>
            </tr>
            <tr>
                <td align="right"><B>Brand *</B></td>
                <td>
                    <script type = "text/javascript">

                    txtItemMaterialItemBrandCode.change(function(ev) {
                            if(txtItemMaterialItemBrandCode.val()===""){
                                txtItemMaterialItemBrandCode.val("");
                                txtItemMaterialItemBrandName.val("");
                                return;
                            }

                            var url = "master/item-brand-get";
                            var params = "itemBrand.code=" + txtItemMaterialItemBrandCode.val();
                                params += "&itemBrand.activeStatus="+true;
                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.itemBrandTemp){
                                    txtItemMaterialItemBrandCode.val(data.itemBrandTemp.code);
                                    txtItemMaterialItemBrandName.val(data.itemBrandTemp.name);
                                }else{ 
                                    alertMessage("Unit Of Measure Not Found!",txtItemMaterialItemBrandCode);
                                    txtItemMaterialItemBrandCode.val("");
                                    txtItemMaterialItemBrandName.val("");
                                }
                            });
                        });

                    </script>
                        <div class="searchbox ui-widget-header">
                        <s:textfield id="itemMaterial.itemBrand.code" name="itemMaterial.itemBrand.code" title=" " required="true" cssClass="required" size="20"></s:textfield>
                            <sj:a id="itemMaterial_btnItemBrand" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                        </div>
                    <s:textfield id="itemMaterial.itemBrand.name" name="itemMaterial.itemBrand.name" size="25" readonly="true"></s:textfield> 
                </td>
            </tr>
<!--            <tr>
                <td align="right">Part Conversion</td>
                <td><s:textfield id="itemMaterial.partConversion" name="itemMaterial.partConversion" size="20" cssStyle="text-align:right" 
                         value = "0.00" formatter="number" formatoptions= "{ thousandsSeparator:','}"></s:textfield></td> 
            </tr>-->
<!--            <tr>
                <td align="right">Tolerance</td>
                <td><s:textfield id="itemMaterial.tolerance" name="itemMaterial.tolerance" size="20" cssStyle="text-align:right" 
                         value = "0.00" formatter="number" formatoptions= "{ thousandsSeparator:','}"></s:textfield></td> 
            </tr>-->
        </table>
        <table> 
             <tr>
                <td align="right"><B>Inventory Type *</B>
                <s:textfield id="itemMaterial.inventoryType" name="itemMaterial.inventoryType" readonly="false" size="20" value = "INVENTORY" style="display:none"></s:textfield></td>
                <td><s:radio id="itemMaterialRadInventoryType" name="itemMaterialRadInventoryType" list="{'INVENTORY','NON_INVENTORY'}"></s:radio></td>                    
            </tr>     
            <tr>
                <td align="right">Min Stock</td>
                <td><s:textfield id="itemMaterial.minStock" name="itemMaterial.minStock" size="20" cssStyle="text-align:right" 
                         value = "1.00" formatter="number" formatoptions= "{ thousandsSeparator:','}"></s:textfield></td>   
            </tr>
            <tr>
                <td align="right">Max Stock</td>
                <td><s:textfield id="itemMaterial.maxStock" name="itemMaterial.maxStock" size="20" cssStyle="text-align:right" 
                         value = "1.00" formatter="number" formatoptions= "{ thousandsSeparator:','}"></s:textfield></td> 
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B>
                <s:textfield id="itemMaterial.activeStatus" name="itemMaterial.activeStatus" readonly="false" size="5" style="display:none"></s:textfield></td>
                <td><s:radio id="itemMaterial.activeStatus" name="itemMaterial.activeStatus" list="{'Active','InActive'}"></s:radio></td> 
            </tr>
            <tr>
                <td><s:textfield id="itemMaterial.createdBy"  name="itemMaterial.createdBy" size="20" style="display:none"></s:textfield></td>
                <td><s:textfield id="itemMaterial.createdDate" name="itemMaterial.createdDate" size="20" style="display:none"></s:textfield></td>
            </tr>
           <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnItemMaterialSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnItemMaterialCancel" button="true">Cancel</sj:a>            
                </td>
            </tr>
        </table>
    </s:form>
</div>
    
    
    

    
    
    
    