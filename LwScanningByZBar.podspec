Pod::Spec.new do |s|

  s.name         = "LwScanningByZBar"
  s.version      = "0.0.1"
  s.summary      = "集成二维码相关功能:扫描.识别.生成"

  s.description  = <<-DESC
                    集成二维码相关功能:扫描,识别,生成.采用ZBar
                   DESC

  s.homepage     = "https://github.com/guakeliao/LwScanningByZBar"

  s.license      = "MIT"

  s.author             = { "guakeliao" => "guakeliao@gmail.com" }

  s.platform     = :ios,"7.0"

  s.source       = { :git => 'https://github.com/guakeliao/LwScanningByZBar.git',:tag => s.version.to_s}

  s.source_files  =  "ScanningByZBar/ScanningByZBar/QRCostom/**/*.{h,m}"  
  s.requires_arc = true

  #警告框
  s.dependency "TSMessages", "~> 0.9.12"
  #生成二维码
  s.dependency "QR-Code-Encoder-for-Objective-C"
end
