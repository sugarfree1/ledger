class CreateAccount
  include Dry::Monads::Result::Mixin

  def call(params)
    validate(params).bind { |values|
      create_account(values[:account]).bind { |account|
        create_owner(account, values[:owner]).fmap { |owner|
          [account, owner]
        }
      }
    }
  end
end

class CreateAccount
  include Dry::Monads::Result::Mixin
  include Dry::Monads::Do

  def call(params)
    values = yield validate(params)
    account = yield create_account(values[:account])
    owner = yield create_owner(account, values[:owner])

    Success([account, user])
  end
end
