test_that("build works", {
  p = tempInstance()
  # safety check
  expect_true(length(list.files(p, pattern = "html")) == 1)
  f = list_api_files(p)
  expect_true(length(f) == 2)
  # there has to be
  c = readLines(f[1], warn = FALSE)
  g = grepl("tgver.dark", c)
  c2 = readLines(f[2], warn = FALSE)
  g2 = grepl("tgver.dark", c2)
  expect_true(any(g))
  expect_true(any(g2))
  # build by changing tgver.dark to ""
  # easy
  build(p, dark="")
  c = readLines(f[1], warn = FALSE)
  g = grepl("tgver.dark", c)
  c2 = readLines(f[2], warn = FALSE)
  g2 = grepl("tgver.dark", c2)
  expect_false(any(g))
  expect_false(any(g2))
})
