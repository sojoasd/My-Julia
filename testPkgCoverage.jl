pkgName = ARGS[1]

pkgDir = "$(@__DIR__)/$pkgName"
println("$pkgDir")

using Pkg

Pkg.instantiate()
Pkg.develop(path=pkgDir)
# Pkg.test(pkgName)

function parseLcov(lcov::String)
    uncoveredLines = Dict{String, Vector{Int64}}()
    currentFile = ""

    for line in eachline(lcov)
        if startswith(line, "SF:")
            currentFile = split(line, ":")[2]
            uncoveredLines[currentFile] = []
        elseif startswith(line, "DA:")
            parts = split(line, ":")[2]

            lineNum, hitCount = split(parts, ",")
            if parse(Int, hitCount) == 0
                push!(uncoveredLines[currentFile], parse(Int, lineNum))
            end
        end
    end

    return uncoveredLines
end

using LocalCoverage

symbol = Symbol(pkgName)
eval(:(using $symbol))
modulePath = pathof(eval(symbol))
println("modulePath: $modulePath")

generate_coverage(pkgName; run_test = true)

lcovPath = joinpath(dirname(dirname(modulePath)), "coverage", "lcov.info")
println("lcovPath: $lcovPath")

uncoveredLines = parseLcov(lcovPath)

for (file, line) in uncoveredLines
    println("File: $file, Uncovered lines: $line")
end
