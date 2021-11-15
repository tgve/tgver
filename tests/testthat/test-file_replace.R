test_that("file_replace works", {
  p = tempInstance()
  print(p)
  # safety check
  expect_true(length(list.files(p, pattern = "html")) == 1)
  expect_error(replace())
  # dummy file
  f = file.path(p, "dummy.txt")
  writeLines("DummyText To Test.\n The End.", f)
  t = readLines(f, warn = FALSE)
  g = grepl("End.", t)
  expect_true(any(g))
  file_replace(f, "End.", "Beginning.")
  t = readLines(f, warn = FALSE)
  g = grepl("End.", t)
  expect_false(any(g))
})
test_that("list_api_files works", {
  p = tempInstance()
  expect_error(list_api_files())
  a = list_api_files(p)
  expect_true(length(a) > 1)
  # mess it up
  file.remove(a)
  expect_error(list_api_files(p))
})

test_that("help shows messages", {
  expect_message(help())
})
