class Transfer
  attr_accessor :sender, :receiver, :amount, :status, :last

  def initialize sender, receiver, amount
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = 'pending'
    @last = {}
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

  def last_transaction(sender, receiver, amount)
    @last["sender"] = sender
    @last["receiver"] = receiver
    @last["amount"] = amount
  end

  def execute_transaction
    if @status == 'pending'
      @sender.balance -= @amount
      @receiver.balance += @amount
      if valid?
        @status = 'complete'
        last_transaction(@sender, @receiver, @amount)
      else
        @status = 'rejected'
        "Transaction rejected. Please check your account balance."
      end
    end
  end

  def reverse_transfer
    if @status == 'complete'
      @sender.balance = @last["sender"].balance += @last["amount"]
      @receiver.balance = @last["receiver"].balance -= @last["amount"]
      @status = 'reversed'
    end
  end
end
