
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
        txtItemCode = $("#item\\.code"),
        txtItemName = $("#item\\.name"),
        txtItemItemProductCategoryCode = $("#item\\.itemProductCategory\\.code"),
        txtItemItemProductCategoryName = $("#item\\.itemProductCategory\\.name"),
        txtItemItemProductHeadCode = $("#item\\.itemProductCategory\\.itemProductHead\\.code"),
        txtItemItemProductHeadName = $("#item\\.itemProductCategory\\.itemProductHead\\.name"),
        txtItemItemDivisionCode = $("#item\\.itemProductCategory\\.itemProductHead\\.itemDivision\\.code"),
        txtItemItemDivisionName = $("#item\\.itemProductCategory\\.itemProductHead\\.itemDivision\\.name"),
        txtItemUnitOfMeasureCode = $("#item\\.unitOfMeasure\\.code"),
        txtItemUnitOfMeasureName = $("#item\\.unitOfMeasure\\.name"),
        txtItemSize = $("#item\\.size"),
        rdbItemInventoryType = $("#item\\.inventoryType"),
        rdbItemInventoryCategory = $("#item\\.inventoryCategory"),
        txtItemMinStock = $("#item\\.minStock"),
        txtItemMaxStock = $("#item\\.maxStock"),
        txtItemStandardWeight = $("#item\\.standardWeight"),
        txtItemRemark = $("#item\\.remark"),
        rdbItemActiveStatus = $("#item\\.activeStatus"),
        rdbItemPackageStatus = $("#item\\.packageStatus"),
        txtItemInActiveBy = $("#item\\.inActiveBy"),
        txtItemInActiveDate = $("#item\\.inActiveDate"),
        txtItemCreatedBy = $("#item\\.createdBy"),
        txtItemCreatedDate = $("#item\\.createdDate"),
        
        allFieldsItem=$([])
            .add(txtItemCode)
            .add(txtItemName)
            .add(txtItemItemProductCategoryCode)
            .add(txtItemItemProductCategoryName)
            .add(txtItemItemProductHeadCode)
            .add(txtItemItemProductHeadName)
            .add(txtItemItemDivisionCode)
            .add(txtItemItemDivisionName)
            .add(txtItemUnitOfMeasureCode)
            .add(txtItemUnitOfMeasureName)
            .add(txtItemSize)
//            .add(txtItemCommissionAmount)
            .add(rdbItemInventoryType)
            .add(rdbItemInventoryCategory)
            .add(txtItemMinStock)
            .add(txtItemMaxStock)
            .add(txtItemStandardWeight)
//            .add(txtItemCOGSIDR)    
            .add(txtItemRemark)
            .add(rdbItemActiveStatus)
            .add(rdbItemPackageStatus)
            .add(txtItemInActiveBy)
            .add(txtItemInActiveDate)
            .add(txtItemCreatedBy)
            .add(txtItemCreatedDate);
               
    $(document).ready(function(){
        hoverButton();
        var updateRowId = -1;
        hideInput("item");
        
        $('#item\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $("#item\\.minStock").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgMinStock").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });

        $("#item\\.minStock").keyup(function(e){
           $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                return numberWithCommasItem(value);
            });
           
        });
        
        $("#item\\.minStock").change(function(e){
            var minStock=$("#item\\.minStock").val();
            
            if(minStock==="" || parseFloat(minStock)===0){
               $("#item\\.minStock").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                
                return formatNumber(parseFloat(value),2); 
            });
           
        });
        
        $("#item\\.maxStock").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgMaxStock").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });

        $("#item\\.maxStock").keyup(function(e){
           $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                return numberWithCommasItem(value);
            });
        });
        
        $("#item\\.maxStock").change(function(e){
            var maxStock=$("#item\\.maxStock").val();
            
            if(maxStock==="" || parseFloat(maxStock)===0){
               $("#item\\.maxStock").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                
                return formatNumber(parseFloat(value),2); 
            });
        });
        
        
        $("#item\\.standardWeight").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgStandardWeight").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });

        $("#item\\.standardWeight").keyup(function(e){
           $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                return numberWithCommasItem(value);
            });
           
        });
        
        $("#item\\.standardWeight").change(function(e){
            var standardWeight=$("#item\\.standardWeight").val();
            
            if(standardWeight==="" || parseFloat(standardWeight)===0){
               $("#item\\.standardWeight").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                
                return formatNumber(parseFloat(value),2); 
            });
           
        });
       
        $('#itemSearchActiveStatusRadActive').prop('checked',true);
        $("#itemSearchActiveStatus").val("true");
        
        $('#itemSearchInventoryTypeRadAll').prop('checked',true);
        $("#itemSearchInventoryType").val("");
                
        $('input[name="itemSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#itemSearchActiveStatus").val(value);
            $('#btnItem_search').trigger('click');
        });
        
        $('input[name="itemSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemSearchActiveStatus").val(value);
            $('#btnItem_search').trigger('click');
        });
                
        $('input[name="itemSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemSearchActiveStatus").val(value);
            $('#btnItem_search').trigger('click');
        });
                
        $('input[name="itemSearchPackageStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#itemSearchPackageStatus").val(value);
            $('#btnItem_search').trigger('click');
        });
        
        $('input[name="itemSearchPackageStatusRad"][value="Yes"]').change(function(ev){
            var value="true";
            $("#itemSearchPackageStatus").val(value);
            $('#btnItem_search').trigger('click');
        });
                
        $('input[name="itemSearchPackageStatusRad"][value="No"]').change(function(ev){
            var value="false";
            $("#itemSearchPackageStatus").val(value);
            $('#btnItem_search').trigger('click');
        });
        
        // search inventory type
        
        $('input[name="itemSearchInventoryTypeRad"][value="All"]').change(function(ev){
            var value="";
            $("#itemSearchInventoryType").val(value);
            $('#btnItem_search').trigger('click');
        });
        
        $('input[name="itemSearchInventoryTypeRad"][value="INVENTORY"]').change(function(ev){
            var value="INVENTORY";
            $("#itemSearchInventoryType").val(value);
            $('#btnItem_search').trigger('click');
        });
                
        $('input[name="itemSearchInventoryTypeRad"][value="NON_INVENTORY"]').change(function(ev){
            var value="NON_INVENTORY";
            $("#itemSearchInventoryType").val(value);
            $('#btnItem_search').trigger('click');
        });
        
        $('input[name="itemRadInventoryType"][value="INVENTORY"]').change(function(ev){
            var value="INVENTORY";
            $("#item\\.inventoryType").val(value);
        });
                
        $('input[name="itemRadInventoryType"][value="NON_INVENTORY"]').change(function(ev){
            var value="NON_INVENTORY";
            $("#item\\.inventoryType").val(value);
        });
        
         $('input[name="itemRadInventoryCategory"][value="RAW_MATERIAL"]').change(function(ev){
            var value="RAW_MATERIAL";
            $("#item\\.inventoryCategory").val(value);
        });
                
        $('input[name="itemRadInventoryCategory"][value="FINISH_GOODS"]').change(function(ev){
            var value="FINISH_GOODS";
            $("#item\\.inventoryCategory").val(value);
        }); 
        
        $('input[name="item\\.activeStatus"][value="Active"]').change(function(ev){
            var value="true";
            $("#item\\.activeStatus").val(value);
        });
                
        $('input[name="item\\.activeStatus"][value="InActive"]').change(function(ev){
            var value="false";
            $("#item\\.activeStatus").val(value);
        });
        
        $('input[name="item\\.packageStatus"][value="Yes"]').change(function(ev){
            var value="true";
            $("#item\\.packageStatus").val(value);
        });
                
        $('input[name="item\\.packageStatus"][value="No"]').change(function(ev){
            var value="false";
            $("#item\\.packageStatus").val(value);
        });
               
        $("#btnItemNew").click(function(ev){
            var url="master/item-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                unHandlers_input_item();
                allFieldsItem.val('').removeClass('ui-state-error');
                showInput("item");
                hideInput("itemSearch");
                $('#itemRadInventoryTypeINVENTORY').prop('checked',true);
                $("#item\\.inventoryType").val("INVENTORY");
                $('#itemRadInventoryCategoryRAW_MATERIAL').prop('checked',true);
                $("#item\\.inventoryCategory").val("RAW_MATERIAL");
                txtItemMinStock.val("0.00");
                txtItemMaxStock.val("0.00");
//                txtItemCommissionAmount.val("0.00");
                txtItemStandardWeight.val("0.00");
//                txtItemCOGSIDR.val("0.00");
                $('#item\\.activeStatusActive').prop('checked',true);
                $("#item\\.activeStatus").val("true");
                $('#item\\.packageStatusYes').prop('checked',true);
                $("#item\\.packageStatus").val("true");
                updateRowId = -1;
                $("#item\\.activeStatus").val("true");
                $("#item\\.packageStatus").val("true");
            });
            ev.preventDefault();
        });
        
        $("#btnItemSave").click(function(ev) {

            if(txtItemCode.val()===""){
                handlersInput(txtItemCode);
                alertMessage("Item Code Can't Empty!",txtItemCode);
                return;
            }else{
                unHandlersInput(txtItemCode);
            }
            
            if(txtItemName.val()===""){
                handlersInput(txtItemName);
                alertMessage("Item Name Can't Empty!",txtItemName);
                return;
            }else{
                unHandlersInput(txtItemName);
            }
                       
            if(txtItemItemProductCategoryCode.val()===""){
                handlersInput(txtItemItemProductCategoryCode);
                alertMessage("Item Type Can't Empty!",txtItemItemProductCategoryCode);
                return;
            }else{
                unHandlersInput(txtItemItemProductCategoryCode);
            }

            if(txtItemUnitOfMeasureCode.val()===""){
                handlersInput(txtItemUnitOfMeasureCode);
                alertMessage("Unit Code Can't Empty!",txtItemUnitOfMeasureCode);
                return;
            }else{
                unHandlersInput(txtItemUnitOfMeasureCode);
            }
        
            var url = "";
           
            if (updateRowId < 0){
                url = "master/item-save";
            }
            else{
                url = "master/item-update";
            }

            formatDateAndNumericInItem();
            
            var params = $("#frmItemInput").serialize();

        $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                hideInput("item");
                showInput("itemSearch");
                allFieldsItem.val('').removeClass('ui-state-error');
                txtItemMinStock.val("0");
                txtItemMaxStock.val("0");
//                txtItemCommissionAmount.val("0");
                txtItemStandardWeight.val("0");
//                txtItemCOGSIDR.val("0");
                reloadGridItem();           
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnItemUpdate").click(function(ev){
            var url="master/item-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                unHandlers_input_item();
                updateRowId = $("#item_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId === null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var item = $("#item_grid").jqGrid('getRowData', updateRowId);
                var url = "master/item-get-data";
                var params = "item.code=" + item.code;

                txtItemCode.attr("readonly",true);

                $.post(url, params, function(result) {

                    var data = (result);
                        txtItemCode.val(data.itemTemp.code);
                        txtItemName.val(data.itemTemp.name);
                        txtItemItemProductCategoryCode.val(data.itemTemp.itemProductCategoryCode);
                        txtItemItemProductCategoryName.val(data.itemTemp.itemProductCategoryName);
                        txtItemItemProductHeadCode.val(data.itemTemp.itemProductHeadCode);
                        txtItemItemProductHeadName.val(data.itemTemp.itemProductHeadName);
                        txtItemItemDivisionCode.val(data.itemTemp.itemDivisionCode);
                        txtItemItemDivisionName.val(data.itemTemp.itemDivisionName);
                        txtItemUnitOfMeasureCode.val(data.itemTemp.unitOfMeasureCode);
                        txtItemUnitOfMeasureName.val(data.itemTemp.unitOfMeasureName);
                        txtItemSize.val(data.itemTemp.size);
//                        txtItemCommissionAmount.val(formatNumber(parseFloat(data.itemTemp.commissionAmount),2));
                        rdbItemInventoryType.val(data.itemTemp.inventoryType);
                        rdbItemInventoryCategory.val(data.itemTemp.inventoryCategory);
                        txtItemMinStock.val(formatNumber(parseFloat(data.itemTemp.minStock),2));
                        txtItemMaxStock.val(formatNumber(parseFloat(data.itemTemp.maxStock),2));
                        txtItemStandardWeight.val(formatNumber(parseFloat(data.itemTemp.standardWeight),2));
//                        txtItemCOGSIDR.val(formatNumber(parseFloat(data.itemTemp.cogsIDR),2));
                        rdbItemActiveStatus.val(data.itemTemp.activeStatus);
                        rdbItemPackageStatus.val(data.itemTemp.packageStatus);
                        txtItemCreatedBy.val(data.itemTemp.createdBy);
                        txtItemCreatedDate.val(data.itemTemp.createdDate);
                        
                        if(data.itemTemp.inventoryType==="INVENTORY") {
                           $('#itemRadInventoryTypeINVENTORY').prop('checked',true);
                           $("#item\\.InventoryType").val("INVENTORY");
                        }
                        else {  
                           $('#itemRadInventoryTypeNON_INVENTORY').prop('checked',true);              
                           $("#item\\.InventoryType").val("NON_INVENTORY");
                        }
                        
                         if(data.itemTemp.inventoryCategory==="RAW_MATERIAL") {
                           $('#itemRadInventoryTypeRAW_MATERIAL').prop('checked',true);
                           $("#item\\.InventoryCategory").val("RAW_MATERIAL");
                        }
                        else {  
                           $('#itemRadInventoryCategoryFINISH_GOODS').prop('checked',true);              
                           $("#item\\.InventoryCategory").val("FINISH_GOODS");
                        }
                        
                        if(data.itemTemp.activeStatus===true) {
                           $('#item\\.activeStatusActive').prop('checked',true);
                           $("#item\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#item\\.activeStatusInActive').prop('checked',true);              
                           $("#item\\.activeStatus").val("false");
                        }
                        
                        if(data.itemTemp.packageStatus===true) {
                           $('#item\\.packageStatusYes').prop('checked',true);
                           $("#item\\.packageStatus").val("true");
                        }
                        else {                        
                           $('#item\\.packageStatusNo').prop('checked',true);              
                           $("#item\\.packageStatus").val("false");
                        }

                    showInput("item");
                    hideInput("itemSearch");
                });    
            });
            ev.preventDefault();
        });
        
        
        $('#btnItemDelete').click(function(ev) {
            var url="master/item-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowId = $("#item_grid").jqGrid('getGridParam','selrow');
            
                if (deleteRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                var item = $("#item_grid").jqGrid('getRowData', deleteRowId);
                if (confirm("Are You Sure To Delete (Code : " + item.code + ")")) {
                    var url = "master/item-delete";
                    var params = "item.code=" + item.code;

                    $.post(url, params, function(data) {
                        if (data.error) {
                            alertMessage(data.errorMessage);
                            return;
                        }

                        alertMessage(data.message);
                        reloadGridItem();
                    });
                }
                
            }); 
            ev.preventDefault();
        });
        
       $("#btnItemCancel").click(function(ev) {
            hideInput("item");
            showInput("itemSearch");
            allFieldsItem.val('').removeClass('ui-state-error');
            txtItemMinStock.val("0");
            txtItemMaxStock.val("0");
//            txtItemCommissionPercent.val("0");
//            txtItemCommissionAmount.val("0");
            txtItemStandardWeight.val("0");
            ev.preventDefault();
        });
     
        $('#btnItemRefresh').click(function(ev) {
            var url = "master/item";
            var params = "";
            pageLoad(url, params, "#tabmnuITEM");
            ev.preventDefault();    
        });
        
        $('#btnItem_search').click(function(ev) {
            $("#item_grid").jqGrid("clearGridData");
            $("#item_grid").jqGrid("setGridParam",{url:"master/item-data?" + $("#frmItemSearchInput").serialize()});
            $("#item_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        $('#item_btnItemProductCategory').click(function(ev) {
            window.open("./pages/search/search-item-product-category.jsp?iddoc=item&idsubdoc=itemProductCategory","Search", "width=550, height=500");
        });
       
        $('#item_btnUnitOfMeasure').click(function(ev) {
            window.open("./pages/search/search-unit-of-measure.jsp?iddoc=item&idsubdoc=unitOfMeasure","Search", "scrollbars=1, width=550, height=500");
        });
     
       
    });
    
   function reloadGridItem() {
        $("#item_grid").trigger("reloadGrid");
    };
    
    function formatDateAndNumericInItem(){
        var minStock =removeCommas(txtItemMinStock.val());
        var maxStock =removeCommas(txtItemMaxStock.val());
        var standardWeight = removeCommas(txtItemStandardWeight.val());
//        var cogsIDR = removeCommas(txtItemCOGSIDR.val());
        
        txtItemMinStock.val(minStock);
        txtItemMaxStock.val(maxStock);
        txtItemStandardWeight.val(standardWeight);
//        txtItemCOGSIDR.val(cogsIDR);
    }
    
    function numberWithCommasItem(x) {
        var parts = x.toString().split(".");
        
        parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        return parts.join(".");
    }
    
    function unHandlers_input_item(){
        unHandlersInput(txtItemCode);
        unHandlersInput(txtItemName);
        unHandlersInput(txtItemItemProductCategoryCode);
        unHandlersInput(txtItemUnitOfMeasureCode);
    };
    

</script>

<s:url id="remoteurlItem" action="item-data" />
<b>ITEM</b>
<hr>
<br class="spacer" />
<sj:div id="itemButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <a href="#" id="btnItemNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/></a>
    <a href="#" id="btnItemUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/></a>
    <a href="#" id="btnItemDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/></a>
    <a href="#" id="btnItemRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/></a>
    <a href="#" id="btnItemPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/></a>
    <!--<a href="#" id="btnItemPrintXls" class="ikb-button ui-state-default ui-corner-left ui-corner-right"><img src="images/button_excel.PNG" border="0" title="Excel"/></a>-->
</sj:div>   
    
<div id="itemSearchInput" class="content ui-widget">
    <br class="spacer" />
    <br class="spacer" />
    <s:form id="frmItemSearchInput">
        <table cellpadding="2" cellspacing="2" width="100%">
            <tr>
                <td align="right" width="80px">Item</td>
                <td width="300px">
                    <s:textfield id="itemSearchCode" name="itemSearchCode" size="15" PlaceHolder=" Code"></s:textfield>
                    <s:textfield id="itemSearchName" name="itemSearchName" cssStyle="width:60%" PlaceHolder=" Name"></s:textfield>
                </td>

                <td align="right" width="100px">Inventory Type</td>
                <td>
                    <s:textfield id="itemSearchInventoryType" name="itemSearchInventoryType" readonly="false" size="5" style="display:none"></s:textfield>
                    <s:radio id="itemSearchInventoryTypeRad" name="itemSearchInventoryTypeRad" list="{'INVENTORY','NON_INVENTORY','All'}"></s:radio>
                </td>
            </tr>  
            <tr>
                <td align="right">Status</td>                
                <td>
                    <s:textfield id="itemSearchActiveStatus" name="itemSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                    <s:radio id="itemSearchActiveStatusRad" name="itemSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
            <tr>
                <td align="right">Package Status</td>                
                <td>
                    <s:textfield id="itemSearchPackageStatus" name="itemSearchPackageStatus" readonly="false" size="5" style="display:none"></s:textfield>
                    <s:radio id="itemSearchPackageStatusRad" name="itemSearchPackageStatusRad" list="{'Yes','No','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br />
        <sj:a href="#" id="btnItem_search" button="true">Search</sj:a>
    </s:form>
    <br class="spacer" />
</div>
    
<div id="itemGrid">
    <sjg:grid
        id="item_grid"
        dataType="json"
        href="%{remoteurlItem}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listItemTemp"
        rowList="10,20,30"
        rowNum="10"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        width="$('#tabmnuitem').width()"
    >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="name" index="name" title="Name" width="400" sortable="true"
        />

        <sjg:gridColumn
            name="itemProductCategoryCode" index="itemProductCategoryCode" title="Product Category" width="80" sortable="true"
        />
        <sjg:gridColumn
            name="itemProductHeadCode" index="itemProductHeadCode" title="Product Head" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="itemDivisionCode" index="itemDivisionCode" title="Division" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="unitOfMeasureCode" index="unitOfMeasureCode" title="Unit" width="80" sortable="true" 
        />

        <sjg:gridColumn
            name="inventoryType" index="inventoryType" title="InventoryType" width="100" sortable="true"
        />
        
        <sjg:gridColumn
            name="inventoryCategory" index="inventoryCategory" title="InventoryCategory" width="100" sortable="true"
        />
        
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center" 
        />
        
        <sjg:gridColumn
            name="packageStatus" index="packageStatus" title="Package" width="50" formatter="checkbox" align="center" 
        />
    </sjg:grid >
</div>
   
<div id="itemInput" class="content ui-widget">
    <s:form id="frmItemInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><B>Code *</B></td>
                 <td><s:textfield id="item.code" name="item.code" size="25" title="*" required="true" cssClass="required" maxLength="45"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Name *</B></td>
                <td><s:textfield id="item.name" name="item.name" size="50" title="*" required="true" cssClass="required"></s:textfield></td>
            </tr>
             <tr>
                <td align="right"><B>Package Status *</B>
                <s:textfield id="item.packageStatus" name="item.packageStatus" readonly="false" size="5" style="display:none"></s:textfield></td>
                <td><s:radio id="item.packageStatus" name="item.packageStatus" list="{'Yes','No'}"></s:radio></td>                    
            </tr>
            <tr>
            <tr>
                <td align="right"><B>Product Category *</B></td>
                <td>
                    <script type = "text/javascript">

                    txtItemItemProductCategoryCode.change(function(ev) {
                            if(txtItemItemProductCategoryCode.val()===""){
                                txtItemItemProductCategoryCode.val("");
                                txtItemItemProductCategoryName.val("");
                                txtItemItemDivisionCode.val("");
                                txtItemItemDivisionName.val("");
                                return;
                            }
                            var url = "master/item-product-category-get";
                            var params = "itemProductCategory.code=" + txtItemItemProductCategoryCode.val();
                                params += "&itemProductCategory.activeStatus="+true;
                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.itemProductCategoryTemp){
                                    txtItemItemProductCategoryCode.val(data.itemProductCategoryTemp.code);
                                    txtItemItemProductCategoryName.val(data.itemProductCategoryTemp.name);
                                    txtItemItemDivisionCode.val(data.itemProductCategoryTemp.itemDivisionCode);
                                    txtItemItemDivisionName.val(data.itemProductCategoryTemp.itemDivisionName);
                                }else{ 
                                    alertMessage("Item Product Category Not Found!",txtItemItemProductCategoryCode);
                                    txtItemItemProductCategoryCode.val("");
                                    txtItemItemProductCategoryName.val("");
                                    txtItemItemDivisionCode.val("");
                                    txtItemItemDivisionName.val("");
                                }

                            });
                        });

                    </script>
                        <div class="searchbox ui-widget-header">
                        <s:textfield id="item.itemProductCategory.code" name="item.itemProductCategory.code" title="*" required="true" cssClass="required" size="20"></s:textfield>
                            <sj:a id="item_btnItemProductCategory" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                        </div>
                    <s:textfield id="item.itemProductCategory.name" name="item.itemProductCategory.name" size="45" readonly="true"></s:textfield> 

                </td>
            </tr>
            
            <tr>
                <td align="right">Item Product Head</td>
                <td colspan="2">
                    <s:textfield id="item.itemProductCategory.itemProductHead.code" name="item.itemProductCategory.itemProductHead.code" readonly="true" size="15"></s:textfield>
                    <s:textfield id="item.itemProductCategory.itemProductHead.name" name="item.itemProductCategory.itemProductHead.name" readonly="true" size="25"></s:textfield> 
                </td>
            </tr>
            
            <tr>
                <td align="right">Division</td>
                <td colspan="2">
                    <s:textfield id="item.itemProductCategory.itemProductHead.itemDivision.code" name="item.itemProductCategory.itemProductHead.itemDivision.code" readonly="true" size="15"></s:textfield>
                    <s:textfield id="item.itemProductCategory.itemProductHead.itemDivision.name" name="item.itemProductCategory.itemProductHead.itemDivision.name" readonly="true" size="25"></s:textfield> 
                </td>
            </tr>
            
            <tr>
                <td align="right"><B>UOM *</B></td>
                <td>
                    <script type = "text/javascript">

                    txtItemUnitOfMeasureCode.change(function(ev) {
                            if(txtItemUnitOfMeasureCode.val()===""){
                                txtItemUnitOfMeasureCode.val("");
                                txtItemUnitOfMeasureName.val("");
                                return;
                            }

                            var url = "master/unit-of-measure-get";
                            var params = "unitOfMeasure.code=" + txtItemUnitOfMeasureCode.val();
                                params += "&unitOfMeasure.activeStatus="+true;
                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.unitOfMeasureTemp){
                                    txtItemUnitOfMeasureCode.val(data.unitOfMeasureTemp.code);
                                    txtItemUnitOfMeasureName.val(data.unitOfMeasureTemp.name);
                                }else{ 
                                    alertMessage("Unit Of Measure Not Found!",txtItemUnitOfMeasureCode);
                                    txtItemUnitOfMeasureCode.val("");
                                    txtItemUnitOfMeasureName.val("");
                                }
                            });
                        });

                    </script>
                        <div class="searchbox ui-widget-header">
                        <s:textfield id="item.unitOfMeasure.code" name="item.unitOfMeasure.code" title=" " required="true" cssClass="required" size="20"></s:textfield>
                            <sj:a id="item_btnUnitOfMeasure" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                        </div>
                    <s:textfield id="item.unitOfMeasure.name" name="item.unitOfMeasure.name" size="45" readonly="true"></s:textfield> 
                </td>
            </tr>
            
            <tr>
                <td align="right"><B>Size *</B></td>
                <td><s:textfield id="item.size" name="item.size" size="20" title="*" required="true" cssClass="required" cssStyle="text-align:left"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Standard Weight</td>
                <td><s:textfield id="item.standardWeight" name="item.standardWeight" size="20" cssStyle="text-align:right" 
                         value = "1.00" formatter="number" formatoptions= "{ thousandsSeparator:','}"></s:textfield><s:textfield id="uomConversionName" name="uomConversionName" readonly="true" size="5" value="KG"></s:textfield></td> 
            </tr>
            <tr>
                <td align="right"><B>Inventory Type *</B>
                <s:textfield id="item.inventoryType" name="item.inventoryType" readonly="false" size="20" value = "INVENTORY" style="display:none"></s:textfield></td>
                <td><s:radio id="itemRadInventoryType" name="itemRadInventoryType" list="{'INVENTORY','NON_INVENTORY'}"></s:radio></td>                    
            </tr>
            
            <tr>
                <td align="right"><B>Inventory Category *</B>
                <s:textfield id="item.inventoryCategory" name="item.inventoryCategory" readonly="false" size="20" value = "RAW_MATERIAL" style="display:none"></s:textfield></td>
                <td><s:radio id="itemRadInventoryCategory" name="itemRadInventoryCategory" list="{'RAW_MATERIAL','FINISH_GOODS'}"></s:radio></td>                    
            </tr>

            <tr>
                <td align="right">Min Stock</td>
                <td><s:textfield id="item.minStock" name="item.minStock" size="20" cssStyle="text-align:right" 
                         value = "1.00" formatter="number" formatoptions= "{ thousandsSeparator:','}"></s:textfield></td>   
            </tr>
            
            <tr>
                <td align="right">Max Stock</td>
                <td><s:textfield id="item.maxStock" name="item.maxStock" size="20" cssStyle="text-align:right" 
                         value = "1.00" formatter="number" formatoptions= "{ thousandsSeparator:','}"></s:textfield></td> 
            </tr>

            <tr>
                <td align="right"><B>Active Status *</B>
                <s:textfield id="item.activeStatus" name="item.activeStatus" readonly="false" size="5" style="display:none"></s:textfield></td>
                <td><s:radio id="item.activeStatus" name="item.activeStatus" list="{'Active','InActive'}"></s:radio></td>                    
            </tr>
            <tr>
                <td><s:textfield id="item.createdBy"  name="item.createdBy" size="20" style="display:none"></s:textfield></td>
                <td><s:textfield id="item.createdDate" name="item.createdDate" size="20" style="display:none"></s:textfield></td>
            </tr>
            <tr height="10px">
            <tr>
                <td/>
                <td>
                    <sj:a href="#" id="btnItemSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnItemCancel" button="true">Cancel</sj:a>            
                </td>
            </tr>
        </table>

    </s:form>
</div>
    
    

    
    
    
    