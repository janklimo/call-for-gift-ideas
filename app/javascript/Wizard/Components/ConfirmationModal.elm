module Wizard.Components.ConfirmationModal exposing (confirmationModal)

-- external modules

import Html exposing (Html, text, p)
import Bootstrap.Modal as Modal
import Bootstrap.Button as Button
import Bootstrap.Modal as Modal


-- internal modules

import Wizard.Msgs exposing (..)
import Wizard.Models exposing (..)
import Utils exposing (onClick)


confirmationModal : Model -> Html Msg
confirmationModal model =
    Modal.config ToggleModalState
        |> Modal.small
        |> Modal.h5 [] [ text "Please confirm" ]
        |> Modal.body [] [ p [] [ text "The product will be removed from your wishlist. Are you sure?" ] ]
        |> Modal.footer []
            [ Button.button
                [ Button.outlineSecondary
                , Button.attrs [ onClick <| ToggleModalState Modal.hiddenState ]
                ]
                [ text "Close" ]
            , Button.button
                [ Button.primary
                , Button.attrs [ onClick <| AnimatedDelete ]
                ]
                [ text "Remove" ]
            ]
        |> Modal.view model.modalState
