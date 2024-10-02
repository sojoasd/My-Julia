using MatrixOperator

# 執行主程式
cs = MatrixOperator.ComplexStruct(3.14, rand(2000, 2000))  # 產生一個大矩陣
@time MatrixOperator.matrix_operations(cs)
