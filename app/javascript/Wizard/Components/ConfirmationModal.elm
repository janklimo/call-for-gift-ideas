module Wizard.Components.ConfirmationModal exposing (confirmationModal)

-- external modules

import Html exposing (Html, div, text, p)
import Bootstrap.Modal as Modal
import Bootstrap.Button as Button
import Bootstrap.Modal as Modal


-- internal modules

import Wizard.Msgs exposing (..)
import Utils exposing (onClick)


confirmationModal : Modal.State -> Html Msg
confirmationModal state =
    Modal.config ModalMsg
        |> Modal.small
        |> Modal.h5 [] [ text "Remove this item?" ]
        |> Modal.body [] [ p [] [ text "This is a modal for you !" ] ]
        |> Modal.footer []
            [ Button.button
                [ Button.outlineSecondary
                , Button.attrs [ onClick <| ModalMsg Modal.hiddenState ]
                ]
                [ text "Close" ]
            , Button.button
                [ Button.primary
                , Button.attrs [ onClick <| ModalMsg Modal.hiddenState ]
                ]
                [ text "Remove" ]
            ]
        |> Modal.view state
