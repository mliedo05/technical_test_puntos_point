class PurchaseMailer < ApplicationMailer
  default from: 'mliendo05@gmail.com'
  require 'sendgrid-ruby'
  include SendGrid

  def first_purchase_email(purchase, creator, cc_admins)
    @purchase = purchase
    @product = purchase.product
    @client = purchase.client

    mail(
      to: creator.email,
      cc: cc_admins.pluck(:email),
      subject: "¡Primera compra del producto #{@product.name}!",
      body: <<~BODY
        ¡Hola #{creator.name}!

        Se ha realizado la primera compra del producto: #{@product.name}

        Detalles de la compra:
        - Cliente: #{@client.name}
        - Cantidad: #{@purchase.quantity}
        - Total pagado: $#{@purchase.total_price}

        ¡Felicitaciones!

        - Tu equipo de la app
      BODY
    )
  end

  def daily_report_email(admin, report)
    mail(
      to: admin.email,
      subject: "Reporte diario de compras - #{Date.yesterday.strftime('%d/%m/%Y')}",
      body: <<~BODY
        Hola #{admin.name},

        Este es el reporte de compras de #{Date.yesterday.strftime('%d/%m/%Y')}:

        #{report}

        Saludos,
        Tu App
      BODY
    )
  end
end
