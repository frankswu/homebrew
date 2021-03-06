require 'formula'

class Noweb < Formula
  homepage 'http://www.cs.tufts.edu/~nr/noweb/'
  url 'ftp://www.eecs.harvard.edu/pub/nr/noweb.tgz'
  version '2.11b'
  md5 '1df580723497b2f2efde07646abf764c'

  depends_on 'icon'

  def install
    cd "src" do
      system "bash", "awkname", "awk"
      system "make LIBSRC=icon ICONC=icont CFLAGS='-U_POSIX_C_SOURCE -D_POSIX_C_SOURCE=1'"

      if which 'kpsewhich'
        ohai 'TeX installation found. Installing TeX support files there might fail if your user does not have permission'
        texmf = "`kpsewhich -var-value=TEXMFLOCAL`"
      else
        ohai 'No TeX installation found. Installing TeX support files in the noweb Cellar.'
        texmf = "#{prefix}"
      end

      bin.mkpath
      lib.mkpath
      man.mkpath

      system "mkdir -p #{texmf}/tex/generic/noweb"
      system "make", "install", "BIN=#{bin}",
                                "LIB=#{lib}",
                                "MAN=#{man}",
                                "TEXINPUTS=#{texmf}/tex/generic/noweb"
    end
  end
end
