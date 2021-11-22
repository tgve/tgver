test_that("static tgve works", {
  p = tempdir()
  ip = file.path(p, "tgve", "index.html")
  r = tgve(browse = FALSE)
  expect_true(identical(ip, r))
  # try again
  unlink(file.path(p, "tgve"), recursive = TRUE)
  expect_message(tgve())
})
