# User class for testing Jennifer ORM
class JenniferUser < Jennifer::Model::Base
  include Mochi
  mochi_jennifer(
    :authenticable,
    :confirmable,
    :trackable,
    :omniauthable,
    :recoverable,
    :lockable,
    :invitable
  )

  with_timestamps
  mapping(
    id: {type: Int32, primary: true},
    created_at: {type: Time, null: true},
    updated_at: {type: Time, null: true},
    email: {type: String, default: ""},
    password_digest: {type: String?},
    confirmation_token: {type: String?, null: true},
    confirmed: {type: Bool, default: false},
    confirmed_at: {type: Time?},
    uncomfirmed_email: {type: String?},
    confirmation_sent_at: {type: Time?},
    uid: {type: String?},
    sign_in_count: {type: Int32, default: 0, null: false},
    current_sign_in_ip: {type: String?},
    last_sign_in_ip: {type: String?},
    current_sign_in_at: {type: Time?, null: true},
    last_sign_in_at: {type: Time?, null: true},
    reset_password_sent_at: {type: Time?},
    reset_password_token: {type: String?},
    password_reset_in_progress: {type: Bool?, default: false},
    locked_at: {type: Time?},
    failed_attempts: {type: Int32, default: 0, null: false},
    unlock_token: {type: String?},
    invitation_accepted_at: {type: Time?},
    invitation_created_at: {type: Time?},
    invitation_token: {type: String?},
    invited_by: {type: Int32?},
    invitation_sent_at: {type: Time?},
  )

  def self.build(params : NamedTuple | Hash | Nil = nil)
    params = params.nil? ? Hash(Symbol, String).new : params

    user = JenniferUser.new(params.to_h)
    user.email = params[:email]? || "#{UUID.random}@email.com"
    user.password = params[:password]? || "Password123"
    user
  end

  def self.build!(params : NamedTuple | Hash | Nil = nil)
    user = JenniferUser.build(params)
    user.save
    user
  end
end

# User class for testing Granite ORM
# Should be identical to JenniferUser
class User < Granite::Base
  include Mochi
  mochi_granite(
    :authenticable,
    :confirmable,
    :trackable,
    :omniauthable,
    :recoverable,
    :lockable,
    :invitable
  )

  connection postgres
  table jennifer_users

  column id : Int32, primary: true
  column email : String = ""
  column password_digest : String?
  column confirmation_token : String?
  column confirmed : Bool? = false
  column confirmed_at : Time?
  column confirmation_sent_at : Time?
  column uncomfirmed_email : String?
  column uid : String?
  column sign_in_count : Int32 = 0
  column current_sign_in_ip : String?
  column last_sign_in_ip : String?
  column current_sign_in_at : Time?
  column last_sign_in_at : Time?
  column reset_password_sent_at : Time?
  column reset_password_token : String?
  column password_reset_in_progress : Bool? = false
  column locked_at : Time?
  column failed_attempts : Int32 = 0
  column unlock_token : String?
  column invitation_accepted_at : Time?
  column invitation_created_at : Time?
  column invitation_token : String?
  column invited_by : Int32?
  column invitation_sent_at : Time?
  timestamps

  def self.build(params : NamedTuple | Hash | Nil = nil)
    params = params.nil? ? Hash(Symbol, String).new : params

    user = User.new(params.to_h)
    user.email = params[:email]? || "#{UUID.random}@email.com"
    user.password = params[:password]? || "Password123"
    user
  end

  def self.build!(params : NamedTuple | Hash | Nil = nil)
    user = User.build(params)
    user.save
    user
  end
end
