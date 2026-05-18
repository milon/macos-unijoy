cask "macos-unijoy" do
  version "1.0.0"
  sha256 "2e347c29d77f70fbdf33471cd72c4daf2800d3523369d26cec15985ed2bcc4af"

  url "https://github.com/milon/macos-unijoy/archive/refs/tags/v#{version}.tar.gz",
      verified: "github.com/milon/macos-unijoy/"
  name "Unijoy"
  desc "Bengali Unijoy keyboard layout for macOS"
  homepage "https://github.com/milon/macos-unijoy"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :big_sur"

  keyboard_layout "macos-unijoy-#{version}/unijoy.keylayout"
  keyboard_layout "macos-unijoy-#{version}/unijoy.icns"

  caveats do
    reboot
    <<~EOS
      To enable the layout:
        1. Open System Settings → Keyboard → Input Sources → Edit…
        2. Click +, choose "Other", select "বাংলা (Unijoy)", click Add.
    EOS
  end
end
