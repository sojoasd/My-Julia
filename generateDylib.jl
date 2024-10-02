pkgName = ARGS[1]
pkgVersion = ARGS[2]
repoToken = ARGS[3]
registryPrivateRepoUrl = "https://x-access-token:$repoToken@github.com/sojoasd/My-Julia.git"

println("pkgName: $pkgName")
println("pkgVersion: $pkgVersion")
println("registryPrivateRepoUrl: $registryPrivateRepoUrl")

using Pkg

Pkg.instantiate()
Pkg.Registry.add(Pkg.RegistrySpec(url=registryPrivateRepoUrl))
Pkg.Registry.update()
Pkg.add(name=pkgName, version=pkgVersion)

using PackageCompiler

# import pkgName
symbol = Symbol(pkgName)
eval(:(using $symbol))
modulePath = pathof(eval(Symbol(pkgName)))
println("modulePath: $modulePath")
testPath = joinpath(dirname(dirname(modulePath)), "test", "runtests.jl")
println("testPath: $testPath")

# activate installed package and instantiate
installPkgPath = joinpath(dirname(dirname(modulePath)))
println("installPkgPath: $installPkgPath")
cd(installPkgPath)
Pkg.activate(installPkgPath)
Pkg.instantiate()
Base.retry_load_extensions()
println("Package installed")
pkg"st"

# create dylib
println("creating dylib at $(@__DIR__)/$pkgName.dylib")

println("test uncompiled")
PackageCompiler.create_sysimage([symbol]; 
    sysimage_path="$(@__DIR__)/$pkgName.dylib", 
    precompile_execution_file=testPath
)

println("dylib created")



