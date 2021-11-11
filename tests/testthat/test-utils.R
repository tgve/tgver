test_that("tempInstance works", {
  t = tempInstance()
  expect_true(dir.exists(t))
  expect_true(length(list.files(t, pattern = "html")) == 1)
})
