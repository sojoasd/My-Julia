using MatrixOperator

cs = MatrixOperator.ComplexStruct(3.14, rand(1000, 1000))  # 產生一個大矩陣
@time MatrixOperator.matrix_operations(cs)
