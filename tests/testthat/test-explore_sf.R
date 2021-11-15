test_that("explore_sf works", {
  expect_error(explore_sf())
  nc = sf::st_read(system.file("shape/nc.shp", package="sf"), quiet = TRUE)
  ps = tgver::explore_sf(nc, background = TRUE)
  expect_true(inherits(ps, "r_process"))
  ps$kill()
})
