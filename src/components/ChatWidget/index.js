import React from "react";
import { ApiAiClient } from "api-ai-javascript";

import "react-chat-widget/lib/styles.css";

import avatar from "../../images/jpg/avatar.jpg";

let chatWidget;
const dialogFlowClient = new ApiAiClient({
  accessToken: "7e51983981b3451b97fc5f98c8938f22"
});

class ChatWidget extends React.Component {
  constructor() {
    super();
    this.state = { showChat: false };
  }

  handleResponse = response => {
    chatWidget.addResponseMessage(response);
  };

  handleNewUserMessage = newMessage => {
    dialogFlowClient
      .textRequest(newMessage)
      .then(response => {
        if (response.status.code === 200) {
          if (response.result && response.result.fulfillment) {
            const reply = response.result.fulfillment.speech;
            this.handleResponse(reply);
          }
        } else {
          this.handleResponse(
            "Aww man! 😕 Something weird has happeded. But don't worry, I've let my Human know."
          );
        }
      })
      .catch(err => console.log(err));
  };

  render() {
    return (
      this.state.showChat && (
        <React.Fragment>
          <chatWidget.Widget
            title="Hi there 👋🏽"
            subtitle="What can I help you with today?"
            profileAvatar={avatar}
            handleNewUserMessage={this.handleNewUserMessage}
          />
          <style jsx>
            {`
              :global(.rcw-launcher) {
                background-color: #709425;
              }

              :global(.rcw-conversation-container > .rcw-header) {
                background-color: #709425;
              }

              :global(.rcw-conversation-container .rcw-close-button) {
                background-color: #709425;
              }

              :global(.rcw-new-message) {
                font-size: 16px;
              }
            `}
          </style>
        </React.Fragment>
      )
    );
  }

  componentDidMount() {
    chatWidget = require("react-chat-widget");

    this.setState({ showChat: true });
    chatWidget.dropMessages();
    this.handleResponse("Hi 👋🏽");
    this.handleResponse("What can I help you with today?");
  }
}

export default ChatWidget;
