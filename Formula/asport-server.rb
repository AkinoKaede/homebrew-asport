class AsportServer < Formula
  desc "A quick and secure reverse tunnel server based on QUIC."
  homepage "https://github.com/AkinoKaede/asport"
  url "https://github.com/AkinoKaede/asport/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "4318bc503b3a04adc020d72324c64b0fe53b718298f9a25c7cbdfbebbc375d17"
  license "GPL-3.0-or-later"
  head "https://github.com/AkinoKaede/asport", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "asport-server")
    (etc/"asport").install "server.example.toml"
    (etc/"asport").install "server.quick.example.toml"
  end

  service do
    run [opt_bin/"asport-server", "run", "--config", "#{etc}/asport/server.toml"]
    keep_alive true
    log_path var/"log/asport-server.log"
    error_log_path var/"log/asport-server.log"
  end

  test do
    assert_match(/asport-server:\s*#{version}/, shell_output("#{bin}/asport-server --version"))
  end
end