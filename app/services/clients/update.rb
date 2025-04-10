class Clients::Update
  def initialize(client, params)
    @client = client
    @params = params
  end

  def call
    if @client.update(@params)
      success_response(@client)
    else
      failure_response(@client)
    end
  end

  private

  def success_response(client)
    {
      success: true,
      message: "Client successfully updated.",
      data: client
    }
  end

  def failure_response(client)
    {
      success: false,
      message: "Failed to update client.",
      errors: client.errors.full_messages
    }
  end
end
