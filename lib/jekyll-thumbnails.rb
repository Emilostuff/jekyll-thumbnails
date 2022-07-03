# Generates a thumbnail to an image and renders an image tag.

require "jekyll"
require "mini_magick"
require "image_processing/mini_magick"

class JekyllThumbnail < Liquid::Tag

  def look_up(context, name)
    lookup = context

    name.split(".").each do |value|
      lookup = lookup[value]
    end

    lookup
  end
  
  def initialize(tag_name, markup, tokens)
    if /(?<source>[^\s]+)\s+(?<width>[^\s]+)/i =~ markup
      @source = source
      @width = width
    end
    super
  end

  def render(context)
    if @source

      # parking
      # also put the parameters into the liquid parser again, to allow variable paths
      source = @source
      source = look_up context, source unless File.readable?(source)
      raise "Could not find source #{@source}" if source.nil? or source.empty?

      width = @width

      source_path = "#{source}".strip
      source_path = "assets/images/" + "#{source}".strip unless File.readable?(source_path)

      raise "#{source_path} is not readable" unless File.readable?(source_path)
      ext = File.extname(source)
      ext = '.jpg'
      desc = width.gsub(/[^\da-z]+/i, '')
      dest_dir = "#{File.dirname(source_path)}/thumbnails"
      Dir.mkdir dest_dir unless Dir.exists? dest_dir
      dest = "#{dest_dir}/#{File.basename(source, ext)}_#{desc}#{ext}"
      dest_path = "#{dest}"

      # only thumbnail the image if it doesn't exist or is less recent than the source file
      # will prevent re-processing thumbnails for a ton of images...
      if !File.exists?(dest_path) || File.mtime(dest_path) <= File.mtime(source_path)
        # puts ENV.inspect

        puts "Thumbnailing #{source} to #{dest} (#{width})"

        image = MiniMagick::Image.open(source_path)
        pipeline = ImageProcessing::MiniMagick.source(image)
        processed = pipeline
          .strip
          .resize_to_limit(width, '10000')
          .convert('jpg')
          .call

        watermark = "img/watermark-#{width}.png"


        puts "Write to #{dest_path}"
        MiniMagick::Image.new(processed.path).write dest_path

      end

      # return path to thumbnail image
      """#{look_up context, 'site.url'}/#{dest}"""

    else
      "Could not create thumbnail for #{source}. Usage: thumbnail /path/to/local/image.png 500"
    end
  end
end

Liquid::Template.register_tag('thumbnails', JekyllThumbnail)
