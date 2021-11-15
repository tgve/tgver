test_that("setup works", {
  # can only test on tempdir so similar to tempInstance
  t = file.path(tempdir(), "setup-test")
  tp = file.path(t, "tgve")
  expect_false(dir.exists(t))
  expect_error(setup())
  expect_message(setup(t))
  expect_true(dir.exists(t))
  expect_true(length(list.files(tp, pattern = "html")) == 1)
  static = list.files(file.path(tp, "static"))
  expect_true(length(static) > 1)
})
