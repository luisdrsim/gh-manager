class Ghm < Formula
  desc "GitHub CLI account manager — switch between multiple gh accounts"
  homepage "https://github.com/lcajigasm/gh-manager"
  url "https://github.com/lcajigasm/gh-manager/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "155c23c06cf8b97ccbd8818b8109c0feeaf782fd4bc126b549f6336736e51154"
  license "MIT"
  version "1.0.0"

  head "https://github.com/lcajigasm/gh-manager.git", branch: "main"

  depends_on "gh"

  def install
    bin.install "bin/ghm"
  end

  test do
    # Requires `gh` auth, so just check the binary runs
    assert_match "gh-manager", shell_output("#{bin}/ghm help")
  end
end
