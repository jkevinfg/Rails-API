class User < ApplicationRecord
    has_many :posts, dependent: :destroy
    validates :email, presence: true
    validates :email, uniqueness: { message: '%{value} already exists' }
    validates :name, presence: true
    validates :auth_token, presence: true

    after_initialize :generate_auth_token #se ejecuta apenas se inicializa el objeto user

    def generate_auth_token
        unless auth_token.present? 
            self.auth_token = TokenGenerationService.generate
        end
    end
end



