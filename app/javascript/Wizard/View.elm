module Wizard.View exposing (..)

import Html exposing (Html)
import Wizard.Models exposing (..)
import Wizard.Msgs exposing (..)
import Wizard.Screens.Welcome exposing (viewWelcomeScreen)
import Wizard.Screens.Cards exposing (viewCardsScreen)
import Wizard.Screens.Sort exposing (viewSortScreen)


view : Model -> Html Msg
view model =
    case model.currentPage of
        Welcome ->
            viewWelcomeScreen model.recipientName

        Cards ->
            viewCardsScreen model

        Sort ->
            viewSortScreen model
