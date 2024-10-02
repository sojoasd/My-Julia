using FindRoot

# 定義一個多項式函數
polynomials = [
    x -> x^2 - 4,        # f(x) = x^2 - 4
    x -> x^3 - 6x^2 + 11x - 6,  # f(x) = x^3 - 6x^2 + 11x - 6
    x -> x^2 - 2x + 1   # f(x) = (x - 1)^2
]

# 呼叫 FindRoot 模組的函數
FindRoot.findRootByPolynomials(polynomials, 0, 6)
