using MatrixOperator

cs = MatrixOperator.ComplexStruct(3.14, rand(3000, 3000))  # 產生一個大矩陣
@time MatrixOperator.matrix_operations(cs)
