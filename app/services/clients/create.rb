class Clients::Create
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    return client_exists_response if client_exists?

    client = Client.new(params)
    if client.save
      success_response(client)
    else
      failure_response(client)
    end
  end

  def client_exists?
    @existing_client = Client.find_by(email: params[:email])
  end

  def client_exists_response
    {
      success: false,
      message: 'A client with this email already exists.',
      data: @existing_client
    }
  end

  def success_response(client)
    {
      success: true,
      message: 'Client created successfully.',
      data: client
    }
  end

  def failure_response(client)
    {
      success: false,
      message: 'Failed to create client.',
      errors: client.errors.full_messages
    }
  end
end
