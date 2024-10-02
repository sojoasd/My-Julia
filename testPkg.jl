pkgName = ARGS[1]

pkgDir = "$(@__DIR__)/$pkgName"
println("$pkgDir")

using Pkg

Pkg.activate(@__DIR__)
Pkg.instantiate()
Pkg.develop(path=pkgDir)
Pkg.test(pkgName)

