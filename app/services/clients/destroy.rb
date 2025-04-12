class Clients::Destroy
  def initialize(client)
    @client = client
  end

  def call
    return client_not_found_response unless client_exists?

    if @client.destroy
      success_response
    else
      failure_response
    end
  end

  private

  def client_exists?
    @client.present?
  end

  def client_not_found_response
    {
      success: false,
      message: "Client not found.",
      data: nil
    }
  end

  def success_response
    {
      success: true,
      message: "Client successfully deleted.",
      data: @client
    }
  end

  def failure_response
    {
      success: false,
      message: "Failed to delete client.",
      errors: @client.errors.full_messages
    }
  end
end
