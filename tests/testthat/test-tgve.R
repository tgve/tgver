test_that("tgve returns a plumber instance", {
  server = tgve(run = FALSE)
  expect_true(inherits(server, "Plumber"))
  expect_equal(length(server$mounts), 1)
  ps = tgve(background = TRUE)
  expect_true(inherits(ps, "r_process"))
  ps$kill()
})
