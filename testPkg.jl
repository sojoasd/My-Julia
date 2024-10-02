pkgName = ARGS[1]

pkgDir = "$(@__DIR__)/$pkgName"
println("$pkgDir")

using Pkg

Pkg.instantiate()
Pkg.develop(path=pkgDir)
Pkg.test(pkgName)

