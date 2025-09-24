import React, { useEffect, useState, useRef } from "react";
import maplibregl from "maplibre-gl";
import { Box } from "@chakra-ui/react";

import { layers, sources } from "./data";

import "maplibre-gl/dist/maplibre-gl.css";
import "./style.scss";

/** MapLibre component. */
export default function MapLibre() {
  const [map, setMap] = useState<maplibregl.Map | null>(null);

  /** Initiate */
  useEffect(() => {
    if (map) return;
    const newMap = new maplibregl.Map({
      container: 'map',
      style: {
        version: 8,
        sources: sources,
        layers: layers,
        glyphs: "/static/fonts/{fontstack}/{range}.pbf",
      },
      center: [0, 0],
      zoom: 1,
      attributionControl: false,
    })
    newMap.addControl(new maplibregl.NavigationControl(), "bottom-left");
    setMap(newMap)
  }, []);

  return <Box id="map"/>;
}
