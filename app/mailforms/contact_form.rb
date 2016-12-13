class ContactForm < MailForm::Base
  attribute :name, validate: true
  attribute :message, validate: true
  attribute :email, validate: true
  attribute :subject, validate: true

  def headers
    {
        subject: %("#{subject}"),
        to: 'customerservice@househound.co',
        from: %("#{name}" <#{email}>)
    }
  end
end