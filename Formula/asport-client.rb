class AsportClient < Formula
  desc "A quick and secure reverse tunnel client based on QUIC."
  homepage "https://github.com/AkinoKaede/asport"
  url "https://github.com/AkinoKaede/asport/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "4318bc503b3a04adc020d72324c64b0fe53b718298f9a25c7cbdfbebbc375d17"
  license "GPL-3.0-or-later"
  head "https://github.com/AkinoKaede/asport", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "asport-client")
    (etc/"asport").install "client.example.toml"
    (etc/"asport").install "client.quick.example.toml"
  end

  service do
    run [opt_bin/"asport-client", "run", "--config", "#{etc}/asport/client.toml"]
    keep_alive true
    log_path var/"log/asport-client.log"
    error_log_path var/"log/asport-client.log"
  end

  test do
    assert_match(/asport-client:\s*#{version}/, shell_output("#{bin}/asport-client --version"))
  end
end