pkgName = ARGS[1]
registryRepoUrl = "git@github.com:sojoasd/My-Julia.git"

pkgDir = "$(@__DIR__)/$pkgName"
println("$pkgDir")
println("$registryRepoUrl")

using Pkg

Pkg.instantiate()

using LocalRegistry

# check Registry.toml exists
if !isfile("Registry.toml")
    println("Registry.toml not found")
    
    LocalRegistry.create_registry("MyJuliaRegistry", registryRepoUrl; push = true)
    println("Registry.toml created")
end

LocalRegistry.register(pkgDir; registry = registryRepoUrl)
println("Package registered")



