module Precurl where

import Data.Either (Either(..))
import Data.Eq (class Eq, eq)
import Data.Foldable (foldl)
import Data.Maybe (Maybe(..))
import Data.Show (show)
import Data.String (Pattern(..), stripPrefix, drop, length)
import Data.String.Regex (Regex, match)
import Prelude (class Show, (<>), (&&), (==))

--| A Parser performs some parsing on the given ParseState and
--| generates the next ParseState (or an error)
type Parser = ParseState -> Either ParseError ParseState

--|
--| Representation of errors while parsing
newtype ParseError = ParseError String

instance showParseErrorShow :: Show ParseError where
  show (ParseError msg) = "ParseError: " <> msg

instance showParseErrorEq :: Eq ParseError where
  eq (ParseError msga) (ParseError msgb) = eq msga msgb


--|
--| How do I make out a parametised type?
newtype ParseState = ParseState {
  inp :: String,
  out :: String
}

instance parseStateEq :: Eq ParseState where
  eq (ParseState {inp:inp1, out:out1}) (ParseState {inp:inp2, out:out2}) = 
    (eq inp1 inp2) && (eq out1 out2)

--| Handy helper to help you make a ParseState with just the input string.
parseState :: String -> ParseState
parseState s = ParseState { inp: s, out: "" }

instance showParseState :: Show ParseState where
  show (ParseState {inp, out}) = "ParseState {inp: " <> (show inp) <> ", out: " <> (show out) <> "}"

--|
--| Parsers

string :: String -> Parser
string str (ParseState state) = 
  case stripPrefix (Pattern str) state.inp of
    Just suffix -> Right (ParseState state { inp = suffix })
    Nothing     -> Left (ParseError ("Expected '" <> str <> "', but saw '" <> state.inp <> "'"))

--| Parse a parameter
param :: String -> Regex -> Parser
param name re (ParseState ps) =
  case match re ps.inp of 
    (Just [(Just prefix)]) -> Right (ParseState { inp: drop (length prefix) ps.inp, out: ps.out <> "," <> name <> "=" <> prefix })
    _ -> Left (ParseError ("Expected to match " <> (show re) <> ", but saw '" <> ps.inp <> "'"))
  
--|
--| Combinators

--| Identity
id :: Parser
id ps = Right ps

--| Pipe one parser to the second
and :: Parser -> Parser -> Parser
and a b ps = case a ps of
  Right parseOfA -> b parseOfA
  Left parseError -> Left parseError  

--| Calls a sequence of Parsers, and only succeeds if they all succeed.
seq :: Array Parser -> Parser
seq parsers = foldl and id parsers

--| Always succeeds.
optional :: Parser -> Parser
optional p ps = 
  case p ps of 
    Left _ -> Right ps
    blah -> blah

--| No leftovers
complete :: Parser -> Parser
complete p ps =
  case p ps of
    Right (ParseState {inp,out}) -> 
      if inp == "" 
      then Right (ParseState {inp,out}) 
      else Left (ParseError ("Dregs: " <> inp))
    blah -> blah
