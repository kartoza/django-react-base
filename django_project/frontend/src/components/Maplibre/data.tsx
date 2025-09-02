import { LayerSpecification, RasterSourceSpecification } from "maplibre-gl";

export const sources = {
  osm: {
    type: "raster",
    tiles: [
      "https://tile.openstreetmap.org/{z}/{x}/{y}.png"
    ],
    tileSize: 256
  } as RasterSourceSpecification
}
export const layers = [
  {
    id: "osm-background",
    type: "raster",
    source: "osm",
    minzoom: 0,
    maxzoom: 19
  } as LayerSpecification
]