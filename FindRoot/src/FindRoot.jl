module FindRoot

using Roots
using Plots

greet() = print("Hello FindRoot")

function findRoot(polynomial, min, max, plot_data)
    # 使用 Roots 套件找到多項式的根
    roots = find_zeros(polynomial, min, max)  # 在區間 [min, max] 中尋找根

    println("多項式的根: ", roots)

    # 計算多項式的值
    x_vals = (min-1):0.1:(max+1)
    y_vals = [polynomial(x) for x in x_vals]

    # 將計算結果添加到 plot_data 中
    push!(plot_data, (x_vals, y_vals, polynomial))
end

# 繪製所有多項式的圖形
function plotPolynomials(plot_data)
    for (x_vals, y_vals, polynomial) in plot_data
        plot!(x_vals, y_vals, label="f(x) = $(polynomial)", xlabel="x", ylabel="f(x)", title="Polynomial Plot", legend=:topright)
    end

    save_path = joinpath(dirname(dirname(@__DIR__)), "polynomial_plot.png")
    println("Saving plot to $save_path")
    savefig(save_path)  # 將圖形保存為 PNG 文件
end

# 執行多個測試
function findRootByPolynomials(ary, min, max)
    plot_data = []  # 用於存儲每個多項式的數據
    for polynomial in ary
        findRoot(polynomial, min, max, plot_data)
    end
    plotPolynomials(plot_data)  # 繪製所有多項式
end

export greet, findRootByPolynomials

end # module FindRoot
