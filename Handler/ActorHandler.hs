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
    firstName <- runInputPost $ ireq textField "firstName"
    lastName <- runInputPost $ ireq textField "lastName"
    now <- liftIO getCurrentTime
    let actor = Actor firstName lastName now
    insertedActor <- runDB $ insertEntity actor
    defaultLayout $ do
        $(widgetFile "actor-new")

getEditActorR :: Handler Html
getEditActorR = do
    actorId <- runInputGet $ ireq intField "id"
    --actor <- runDB $ get $ Key $ toPersistValue actorId
    defaultLayout $ do
        $(widgetFile "actor-edit")

getDeleteActorR :: Handler Html
getDeleteActorR = do
    defaultLayout $ do
        $(widgetFile "actor-delete")
