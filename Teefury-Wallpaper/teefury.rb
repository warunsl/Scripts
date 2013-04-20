require 'open-uri'
require 'nokogiri'

wallpaper = "";
filename = "";

doc = Nokogiri::HTML(open("http://www.teefury.com/"));
doc.xpath('//body/div[@id = "wrapper"]/div[@id = "main"]/div[@id = "content"]/div[@id = "zoom-pic"]/img').each do |node|
  wallpaper =  node['src'].to_s
end

filename = wallpaper.split("/")
filename = filename.last


%x[wget -P ~/Downloads/Teefury-Wallpapers/ #{wallpaper}]
%x[defaults write com.apple.desktop Background '{default = {ImageFilePath = "~/Downloads/Teefury-Wallpapers/#{filename}"; };}']
%x[killall Dock]

