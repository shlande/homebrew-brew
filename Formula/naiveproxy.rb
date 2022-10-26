# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Naiveproxy < Formula
  desc "chrome network stack backended proxy client"
  homepage "https://github.com/klzgrad/naiveproxy"
  url "https://github.com/klzgrad/naiveproxy/releases/download/v106.0.5249.91-1/naiveproxy-v106.0.5249.91-1-mac-arm64.tar.xz"
  sha256 "e57a7e652e2d291dcee943baf6036a5d363aaa332ec542814a7af43d2283de8c"
  license "BSD-3-Clause"

  # depends_on "cmake" => :build

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure
    # https://rubydoc.brew.sh/Formula.html#std_configure_args-instance_method
    bin.install "naive"
    (etc/"naiveproxy").mkpath
    etc.install "config.json" => "naiveproxy/config.json"
  end

  service do
    run [opt_bin/"naive", "-c", etc/"naiveproxy/config.json"]
    keep_alive true
    error_log_path var/"log/naiveproxy-error.log"
    log_path var/"log/naiveproxy.log"
  end
end
