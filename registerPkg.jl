pkgName = ARGS[1]
registryRepoUrl = "git@github.com:sojoasd/My-Julia.git"
registryPublicRepoUrl = "https://@github.com/sojoasd/My-Julia.git"

pkgDir = "$(@__DIR__)/$pkgName"
println("$pkgDir")
println("$registryRepoUrl")
println("$registryPublicRepoUrl")

using Pkg

using Pkg
Pkg.activate(@__DIR__)
Pkg.instantiate()

using LocalRegistry

# check Registry.toml exists
if !isfile("Registry.toml")
    println("Registry.toml not found")
    
    LocalRegistry.create_registry("MyJuliaRegistry", registryRepoUrl; push = true)
    println("Registry.toml created")
end

LocalRegistry.register(pkgDir; registry = registryRepoUrl, repo = registryPublicRepoUrl)
println("Package registered")



