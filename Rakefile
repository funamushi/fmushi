desc "CLIP STUDIOが吐いた名前をリネームする"
task :rename do
  %w(idle walk-1-0 walk-1-1 walk-2-0 walk-2-1).each_with_index do |name, i|
    to   = "./src/frames/fmushi_#{name}.png"
    from = "./src/frames/fmushi_#{'%03d' % (i + 1)}.png"
    sh "mv #{from} #{to}"
  end
end

desc "アニメ確認用にGIFアニメを作る"
task :gif do
  sh "convert" <<
    " -dispose previous" <<
    " -delay 25" <<
    " -loop 0 " <<
    " ./src/frames/fmushi_walk-*.png" <<
    " ./src/frames/fmushi_walk.gif"
end

desc "TexturePackerで、スプライトアトラスを作る"
task :pack do
    sh "TexturePacker "<<
      "  --format json-hash " <<
      "  --data ../public/app.json " <<
      "  --sheet ../public/app.png " <<
      " ./src/frames"
end

