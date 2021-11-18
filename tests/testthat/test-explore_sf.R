test_that("explore_sf works", {
  expect_error(explore_sf())
  # TODO: install sf in tic.yml before uncommenting these
  # nc = sf::st_read(system.file("shape/nc.shp", package="sf"), quiet = TRUE)

  # from geojsonsf readme
  js <- c(
    '[
      {"type":"Point","coordinates":[0,0]},
      {"type":"LineString","coordinates":[[-1,-1],[1,1]]},
        {
      "type": "FeatureCollection",
      "features": [
      {
        "type": "Feature",
        "properties": {"id":1},
        "geometry": {"type": "Point", "coordinates": [100.0, 0.0]}
      }
    ]
  }
    ]'
  )

  sf = geojsonsf::geojson_sf( js )
  ps = tgver::explore_sf(sf, background = TRUE)
  expect_true(inherits(ps, "r_process"))
  ps$kill()

  # explore_geojson
  expect_error(explore_geojson())
  expect_error(explore_geojson("/endpoint"))
  expect_error(explore_geojson("endpoint", NA, TRUE))
  expect_error(explore_geojson("endooint", "{uselessGeoJSON}", "notLogical"))
})
