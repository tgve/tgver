test_that("setup works", {
  # can only test on tempdir so similar to tempInstance
  t = file.path(tempdir(), "setup-test")
  expect_false(dir.exists(t))
  expect_error(setup())
  expect_message(setup(t))
  expect_true(dir.exists(t))
  expect_true(length(list.files(t, pattern = "html")) == 1)
})
