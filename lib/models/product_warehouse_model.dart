class ProductWarehouseModel {
  final String? warehouseId;
  final String? warehouseName;

  ProductWarehouseModel({
    this.warehouseId,
    this.warehouseName,
  });

  factory ProductWarehouseModel.fromJson(Map<String, dynamic> json) => ProductWarehouseModel(
    warehouseId: json["warehouse_id"],
    warehouseName: json["warehouse_name"],
  );

  Map<String, dynamic> toJson() => {
    "warehouse_id": warehouseId,
    "warehouse_name": warehouseName,
  };
}