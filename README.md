# precurl
Purescript parser combinators.

[![CircleCI](https://circleci.com/gh/pokle/precurl.svg?style=svg)](https://circleci.com/gh/pokle/precurl)

Still early days, but a simple parser combinator library for Purescript.

My motivation is something that can parse structured URL paths such as: `/customer/456/ticket/7`, and turn it into a record such as `{ customer: "456", ticket: "7" }`
