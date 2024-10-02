pkgName = ARGS[1]
repoToken = ARGS[2]
registryRepoUrl = "git@github.com:sojoasd/My-Julia.git"
registryPublicRepoUrl = "https://x-access-token:$repoToken@github.com/sojoasd/My-Julia.git"

pkgDir = "$(@__DIR__)/$pkgName"
println("$pkgDir")
println("$registryRepoUrl")
println("$registryPublicRepoUrl")

using Pkg

Pkg.instantiate()

using LocalRegistry

# Set Git user configuration
run(`git config --global user.email "sojoasd@gmail.com"`)
run(`git config --global user.name "zeal yen"`)

# check Registry.toml exists
if !isfile("Registry.toml")
    println("Registry.toml not found")
    
    LocalRegistry.create_registry("MyJuliaRegistry", registryPublicRepoUrl; push = true)
    println("Registry.toml created")
end

LocalRegistry.register(pkgDir; registry = registryPublicRepoUrl, repo = registryPublicRepoUrl)
println("Package registered")
