pkgName = ARGS[1]
println("pkgName: $pkgName")

symbol = Symbol(pkgName)
eval(:(using $symbol))
modulePath = pathof(eval(Symbol(pkgName)))
println("modulePath: $modulePath")
testPath = joinpath(dirname(dirname(modulePath)), "test", "runtests.jl")
println("testPath: $testPath")
@time include(testPath)
println("test completed")
