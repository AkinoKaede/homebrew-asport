class AsportClient < Formula
  desc "A quick and secure reverse proxy client based on QUIC for NAT traversal."
  homepage "https://github.com/AkinoKaede/asport"
  url "https://github.com/AkinoKaede/asport/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "f4a33fda5db89e5e750fe419aff43e00dbe0a04c1a86f5b7b46ff6c5ddeecedf"
  license "GPL-3.0-or-later"
  head "https://github.com/AkinoKaede/asport", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "asport-client")
    (etc/"asport").install "client.example.toml"
    (etc/"asport").install "client.quick.example.toml"
  end

  service do
    run [opt_bin/"asport-client", "#{etc}/asport/client.toml"]
    keep_alive true
    log_path var/"log/asport-client.log"
    error_log_path var/"log/asport-client.log"
  end

  test do
    assert_match(/asport-client:\s*#{version}/, shell_output("#{bin}/asport-client --version"))
  end
end