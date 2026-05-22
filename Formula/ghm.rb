class Ghm < Formula
  desc "GitHub CLI account manager — switch between multiple gh accounts"
  homepage "https://github.com/luisdrsim/gh-manager"
  url "https://github.com/luisdrsim/gh-manager/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "PLACEHOLDER_SHA256"
  license "MIT"
  version "1.0.0"

  head "https://github.com/luisdrsim/gh-manager.git", branch: "main"

  depends_on "gh"

  def install
    bin.install "bin/ghm"
  end

  test do
    # Requires `gh` auth, so just check the binary runs
    assert_match "gh-manager", shell_output("#{bin}/ghm help")
  end
end
