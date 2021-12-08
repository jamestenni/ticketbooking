class Ticket < Product
  def is_owned?
    return self.users.size == 1
  end

  def is_available?
    return self.users.size == 0
  end
end