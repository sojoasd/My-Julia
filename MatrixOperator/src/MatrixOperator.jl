module MatrixOperator

using Random

greet() = print("Hello MatrixOperator")

# 自訂一個複雜的型別結構
struct ComplexStruct
    a::Float64
    b::Array{Float64, 2}
end

# 定義一個複雜的運算函數，包含大量矩陣運算
function matrix_operations(cs::ComplexStruct)
    A = cs.b
    for i in 1:10
        A = A * A'  # 矩陣相乘
        A .= A .+ randn(size(A))  # 增加隨機噪音
    end
    return sum(A)
end

export greet, ComplexStruct, matrix_operations

end # module MatrixOperator
