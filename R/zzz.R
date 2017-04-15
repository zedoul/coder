.onAttach <- function(libname, pkgname) {
  packageStartupMessage("Type coder() to start")
  setting_path <- system.file("conf", "conf.yml", package = pkgname)
  stopifnot(file.exists(setting_path))
  options(yaml::yaml.load_file(setting_path))
}
