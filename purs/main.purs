module Main where

import Control.Monad.Eff
import Debug.Trace (trace)
import React
import React.DOM

todoHeader = mkUI spec do
  pure $ header [ idProp "header" ]
    [ h1' [ text "todos" ]
    , input
      [ idProp "new-todo"
      , placeholder "What needs to be done?"
      , autoFocus "true"
      ] []
    ]

helloWorld :: { what :: String } -> React.UI
helloWorld = mkUI spec do
  props <- getProps
  pure $ h1 [className "hello"] [
      text $ "Hello, " ++ props.what
    ]

main :: Eff (dom :: React.DOM) React.UI
main = do
  renderToElementById "todoapp" $ todoHeader []
