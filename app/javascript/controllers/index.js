// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import ChatController from "./chat_controller"
application.register("chat", ChatController)

import ModalController from "./modal_controller"
application.register("modal", ModalController)

import QuestionFormController from "./question_form_controller"
application.register("question-form", QuestionFormController)

import TreeController from "./tree_controller"
application.register("tree", TreeController)
