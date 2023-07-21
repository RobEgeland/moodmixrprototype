class ConversationsController < ApplicationController
    def index
        openai_client = OpenAI::Client.new

        response = openai_client.chat(
            parameters: {
                model:  "gpt-3.5-turbo",
                messages: [
                {
                    role: "system", 
                    content: "You will be provided with a description of a mood, and your task is to generate 3 Spotify genres that matches it. Write your output in json with a single key called \"spotify_genres\"."
                },
                {
                    role: "user",
                    content: params[:message]
                }
                ],
                temperature: 0.7,
            }
        )
        text = response.dig("choices", 0, "message", "content")
        render json: text
    end
end
