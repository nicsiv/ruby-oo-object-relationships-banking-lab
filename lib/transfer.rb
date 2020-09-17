class Transfer
  attr_reader :sender, :receiver, :amount
  attr_accessor :status
 
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    if @status == "pending"
      if sender.balance >= amount && self.valid?
        sender.balance -= self.amount
        receiver.deposit(self.amount)
        @status = "complete"
      else 
        @status = "rejected"
        "Transaction rejected. Please check your account balance."
      end
    end
  end
 
  def reverse_transfer 
    if @status == "complete"
      sender.balance += self.amount 
      receiver.balance -= self.amount 
      @status = "reversed"
    end
  end
end
