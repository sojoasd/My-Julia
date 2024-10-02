pkgName = ARGS[1]
repoToken = ARGS[2]
registryRepoUrl = "git@github.com:sojoasd/My-Julia.git"
registryPublicRepoUrl = "https://$repoToken@github.com/sojoasd/My-Julia.git"

pkgDir = "$(@__DIR__)/$pkgName"
println("$pkgDir")
println("$registryRepoUrl")
println("$registryPublicRepoUrl")

using Pkg

Pkg.instantiate()

using LocalRegistry

# check Registry.toml exists
if !isfile("Registry.toml")
    println("Registry.toml not found")
    
    LocalRegistry.create_registry("MyJuliaRegistry", registryPublicRepoUrl; push = true)
    println("Registry.toml created")
end

LocalRegistry.register(pkgDir; registry = registryPublicRepoUrl, repo = registryRepoUrl)
println("Package registered")
