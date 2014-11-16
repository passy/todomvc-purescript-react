module Main where

import Control.Monad.Eff
import Debug.Trace (trace)
import Data.Array (map)
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

exampleItems =
  [ { id: 0
    , todo: "Go to Paris"
    , editing: false
    },
    { id: 1
    , todo: "Write PureScript TodoMVC"
    , editing: false
    },
    { id: 2
    , todo: "Find the Hotel"
    , editing: true
    }
  ]

todoList = mkUI spec do
  let todoItems = flip map exampleItems (\i -> li [] [ text i.todo ])
  pure $ ul [ idProp "todo-list" ] todoItems

todoMain = mkUI spec do
  pure $ section [ idProp "main" ]
    [ input
      [ idProp "toggle-all"
      , typeProp "checkbox"
      ] []
    , todoList []
    ]

-- Only temporarily
renderUI el = mkUI spec el []

main :: Eff (dom :: React.DOM) React.UI
main = do
  renderToElementById "todoapp" $ renderUI do
    pure $ div'
      [ todoHeader []
      , todoMain []
      ]
