@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order items - Consumption View'
@Search.searchable: true
@Metadata.allowExtensions: true


define view entity zc_mso_item
  as projection on zi_mso_item 
{
  key SalesorderId,
      @Search.defaultSearchElement: true
  key Itempos,
      @Consumption.valueHelpDefinition: [{ association: '_Product' }]
      @ObjectModel:{ text.element: ['PrdName']}
      Prodid,
      _Pdesc.ProductName         as PrdName,
      Unitid,
      @Semantics.quantity.unitOfMeasure: 'unitid'
      Quantity,
      Currencycode,
      @Semantics.amount.currencyCode: 'currencycode'
      Grossamount,
      @Semantics.amount.currencyCode: 'currencycode'
      Net_Amount,
      @Consumption.valueHelpDefinition: [{ association: '_Atp' }]
      @ObjectModel.text.element: ['AtpStatus']
      Available,
      _Atp.ATPstatus             as AtpStatus,
      @Semantics.imageUrl: true
      _Product.ProductPictureURL as ProdPicture,
      /* Associations */
      _Atp,
      _Pdesc,
      _Product,
      _SalesOrder : redirected to parent zc_mso_header
}
