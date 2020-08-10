defmodule Identicon do
  def main(input) do
    input
    |> hash_input
    |> color_picker
    |> gen_grid
    |> filtered_list
    |> color_points
    |> draw_image
    |> save_image_to_disk(input)
  end

  def save_image_to_disk(image, input) do
    File.write("#{input}.png", image) 
  end

  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each pixel_map, fn ({start, stop}) -> 
      :egd.filledRectangle(image, start, stop, fill)
    end

    :egd.render(image)
  end

  def gen_grid(%Identicon.Image{hex: hex} = image) do 
    grid = 
      hex
      |> Enum.chunk_every(3, 3, :discard)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index

    %Identicon.Image{image | grid: grid}
  end

  def color_points(%Identicon.Image{grid: gridlist} = image) do
    pixel_map = Enum.map gridlist, fn({_val, index}) -> 
      horizontal = rem(index, 5) * 50
      vertical = div(index, 5) * 50

      top_left = {horizontal, vertical}
      bottom_right = {horizontal + 50, vertical + 50}

      { top_left, bottom_right }
    end

    %Identicon.Image{image | pixel_map: pixel_map}
  end 

  def filtered_list(%Identicon.Image{grid: gridlist} = image) do
    grid = Enum.filter gridlist, fn ({val, _index}) -> 
      rem(val, 2) == 0
    end

    %Identicon.Image{image | grid: grid}
  end

  def mirror_row(row) do
    [first, second | _rest] = row

    row ++ [second, first]
  end

  def color_picker(%Identicon.Image{hex: [r, g, b | _everythingelse]} = imagehex) do
    %Identicon.Image{imagehex | color: {r, g, b}}
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}

  end

end
