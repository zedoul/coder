.onAttach <- function(libname, pkgname) {
  packageStartupMessage("Type coder() to start")
  setting_file <- file.path(find.package(pkgname), "conf", "conf.yml")
  options(yaml::yaml.load_file(setting_file))
}
