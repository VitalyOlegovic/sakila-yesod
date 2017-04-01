module Handler.ActorHandler where

import Import

getActorListR :: Handler Html
getActorListR = do
    actorList <- runDB $ selectList ([] :: [Filter Actor]) []
    defaultLayout $ do
        --Set the title
        let title = "Actor list" :: String
        setTitle (toHtml title)
        --Set the view to use to show data to the user
        $(widgetFile "actor-list")

getNewActorR :: Handler Html
getNewActorR = do
    defaultLayout $ do
        $(widgetFile "actor-new")

postCreateActorR :: Handler Html
postCreateActorR = do
    actor <- runInputPost $ Actor
                    <$> ireq textField "firstName"
                    <*> ireq textField "lastName"
    --insertedActor <- runDB $ insertEntity actor
    defaultLayout $ do
        $(widgetFile "actor-new")
