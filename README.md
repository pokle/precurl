# recurl
Purescript parser combinators.

[![CircleCI](https://circleci.com/gh/pokle/recurl/tree/master.svg?style=svg&circle-token=bb2fbb7df82113f1466c0fb05fd10bcfc27b228b)](https://circleci.com/gh/pokle/recurl/tree/master)

Still early days, but a simple parser combinator library for Purescript.

My motivation is something that can parse structured URL paths such as: `/customer/456/ticket/7`, and turn it into a record such as `{ customer: "456", ticket: "7" }`
