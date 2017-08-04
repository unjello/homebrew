# basically a copy of jmuncaster's tap @
# https://github.com/jmuncaster/homebrew-header-only/blob/master/cppzmq.rb
class Cppzmq < Formula
  desc "C++ bindings for ZeroMQ"
  homepage "https://github.com/zeromq/cppzmq"
  url "https://codeload.github.com/zeromq/cppzmq/tar.gz/v4.2.2"
  sha256 "3ef50070ac5877c06c6bb25091028465020e181bbfd08f110294ed6bc419737d"
  depends_on "zeromq"

  def install
    include.install "zmq.hpp"
    include.install "zmq_addon.hpp"
  end

  test do
    (testpath/"test.cpp").write <<-EOS.undent
      #include <zmq.hpp>
      #include <iostream>
      int main()
      {
        int major=0, minor=0, patch=0;
        zmq::version(&major, &minor, &patch);
        std::cout << major << "." << minor << "." << patch << std::endl;
        return 0;
      }
    EOS
    system ENV.cxx, "test.cpp", "-I#{include}", "-L#{lib}", "-lzmq", "-o", "test"
  end
end
