class ChatgptService
    include HTTParty
    
    attr_reader :api_url, :options, :model, :message

    def initialize(message, model = "gpt-3.5-turbo")
        api_key = Rails.application.credentials.chatgpt_api_key
        @options = {
            headers: {
                'Content-Type' => 'application/json',
                'Authorization' => "Bearer #{api_key}"
            }
        }
        @api_url = 'https://api.openai.com/v1/chat/completions'
        @model = model
        @message = message
    end

    def call 
        body = {
            model: @model,
            messages: [
                {
                    role: "system", 
                    content: "You will be provided with a description of a mood, and your task is to generate 3 Spotify genres that matches it. Write your output in json with a single key called \"spotify_genres\"."
                },
                {
                    role: "user",
                    content: message
                }
            ]
        }
        response = HTTParty.post(api_url, body: body.to_json, headers: options[:headers], timeout: 10)
        raise response['error']['message'] unless response.code == 200
    end

    class << self
        def call(message, model = 'gpt-3.5-turbo')
            new(message, model).call
        end
    end

end