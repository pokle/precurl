module Parse where

import Data.Either

data ParseError = Error String
type ParseState = {
  in :: String,
  out:: String
}
type Parser = ParseState -> Either ParseError ParseState

string :: String -> Parser
string str = \state -> Left (Error "No way")