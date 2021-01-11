String html_compress =
    """<!DOCTYPE html><html><head><meta charset=utf-8 /><title>Gateways</title><meta name='viewport' content='initial-scale=1,maximum-scale=1,user-scalable=no' /><link href='https://api.mapbox.com/mapbox-gl-js/v1.12.0/mapbox-gl.css' rel='stylesheet' /><style>      body { margin:0; padding:0; }      #map { position:absolute; top:0; bottom:0; width:100%; }</style></head><body><div id='map'></div><script>        mapboxgl.accessToken = 'pk.eyJ1IjoibXhjZGF0YWRhc2giLCJhIjoiY2s5bnc4dmh4MDBiMDNnbnczamRoN2ExeCJ9.sq0w8DGDXpA_6AMoejYaUw';                window.map = new mapboxgl.Map({          container: 'map', pitchWithRotate: false,          style: 'mapbox://styles/mxcdatadash/ck9qr005y5xec1is8yu6i51kw',          center: [-103.59179687498357, 40.66995747013945],          zoom: 0, maxZoom: 12       });</script></body></html>""";

String map_html = """
  document.write("$html_compress");
""";
