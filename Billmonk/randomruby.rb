@amount_owed_to_the_payer = {
  'w' => 700,
  'a' => nil,
  's' => nil,
  'n' => 300
}

@amount_owed_by_the_payee = {
  'w' => nil,
  'a' => 500,
  's' => 500,
  'n' => nil
}

@amount_owed_to_the_payer.each { |payer_id, amount_owed|
  if amount_owed.to_i > 0 then
    @amount_owed_by_the_payee.each {|payee_id, amount_owes|
      if amount_owes.to_i > 0 && @amount_owed_to_the_payer[payer_id].to_i > 0 then
        if amount_owes.to_i >= @amount_owed_to_the_payer[payer_id].to_i then
          puts "First if " + payee_id.to_s + " pays " + payer_id.to_s + " : " + @amount_owed_to_the_payer[payer_id].to_s;
          @amount_owed_by_the_payee[payee_id] = @amount_owed_by_the_payee[payee_id].to_i - @amount_owed_to_the_payer[payer_id].to_i;
          @amount_owed_to_the_payer[payer_id] = @amount_owed_to_the_payer[payer_id] - @amount_owed_to_the_payer[payer_id].to_i;
          #puts "@amount_owed_to_the_payer";
          #puts @amount_owed_to_the_payer;
          #puts "@amount_owed_by_the_payee"
          #puts @amount_owed_by_the_payee;
        elsif amount_owes.to_i.to_i < @amount_owed_to_the_payer[payer_id].to_i then
          puts "Second if " + payee_id.to_s + " pays " + payer_id.to_s + " : " + amount_owes.to_s;
          @amount_owed_by_the_payee[payee_id] = @amount_owed_by_the_payee[payee_id].to_i - amount_owes.to_i;
          @amount_owed_to_the_payer[payer_id] = @amount_owed_to_the_payer[payer_id] - amount_owes.to_i;
          #puts "@amount_owed_to_the_payer";
          #puts @amount_owed_to_the_payer;
          #puts "@amount_owed_by_the_payee"
          #puts @amount_owed_by_the_payee;
        end
      end
    }
  end
}

puts "@amount_owed_to_the_payer";
puts @amount_owed_to_the_payer;

puts "@amount_owed_by_the_payee"
puts @amount_owed_by_the_payee;


@amount_owed_to_the_payer = {
  'w' => 2544,
  'a' => nil,
  's' => nil,
  'n' => nil
}

@amount_owed_by_the_payee = {
  'w' => nil,
  'a' => 848,
  's' => 848,
  'n' => 848
}


@amount_owed_to_the_payer.each { |payer_id, amount_owed|
  if amount_owed.to_i > 0 then
    @amount_owed_by_the_payee.each {|payee_id, amount_owes|
      if amount_owes.to_i > 0 && @amount_owed_to_the_payer[payer_id].to_i > 0 then
        if amount_owes.to_i >= @amount_owed_to_the_payer[payer_id].to_i then
          puts "First if " + payee_id.to_s + " pays " + payer_id.to_s + " : " + @amount_owed_to_the_payer[payer_id].to_s;
          @amount_owed_by_the_payee[payee_id] = @amount_owed_by_the_payee[payee_id].to_i - @amount_owed_to_the_payer[payer_id].to_i;
          @amount_owed_to_the_payer[payer_id] = @amount_owed_to_the_payer[payer_id] - @amount_owed_to_the_payer[payer_id].to_i;
          #puts "@amount_owed_to_the_payer";
          #puts @amount_owed_to_the_payer;
          #puts "@amount_owed_by_the_payee"
          #puts @amount_owed_by_the_payee;
        elsif amount_owes.to_i.to_i < @amount_owed_to_the_payer[payer_id].to_i then
          puts "Second if " + payee_id.to_s + " pays " + payer_id.to_s + " : " + amount_owes.to_s;
          @amount_owed_by_the_payee[payee_id] = @amount_owed_by_the_payee[payee_id].to_i - amount_owes.to_i;
          @amount_owed_to_the_payer[payer_id] = @amount_owed_to_the_payer[payer_id] - amount_owes.to_i;
          #puts "@amount_owed_to_the_payer";
          #puts @amount_owed_to_the_payer;
          #puts "@amount_owed_by_the_payee"
          #puts @amount_owed_by_the_payee;
        end
      end
    }
  end
}

puts "@amount_owed_to_the_payer";
puts @amount_owed_to_the_payer;

puts "@amount_owed_by_the_payee"
puts @amount_owed_by_the_payee;

@amount_owed_to_the_payer = {
  'w' => 50,
  'a' => 50,
  's' => nil,
  'n' => nil
}

@amount_owed_by_the_payee = {
  'w' => nil,
  'a' => nil,
  's' => 50,
  'n' => 50
}

@amount_owed_to_the_payer.each { |payer_id, amount_owed|
  if amount_owed.to_i > 0 then
    @amount_owed_by_the_payee.each {|payee_id, amount_owes|
      if amount_owes.to_i > 0 && @amount_owed_to_the_payer[payer_id].to_i > 0 then
        if amount_owes.to_i >= @amount_owed_to_the_payer[payer_id].to_i then
          puts "First if " + payee_id.to_s + " pays " + payer_id.to_s + " : " + @amount_owed_to_the_payer[payer_id].to_s;
          @amount_owed_by_the_payee[payee_id] = @amount_owed_by_the_payee[payee_id].to_i - @amount_owed_to_the_payer[payer_id].to_i;
          @amount_owed_to_the_payer[payer_id] = @amount_owed_to_the_payer[payer_id] - @amount_owed_to_the_payer[payer_id].to_i;
          #puts "@amount_owed_to_the_payer";
          #puts @amount_owed_to_the_payer;
          #puts "@amount_owed_by_the_payee"
          #puts @amount_owed_by_the_payee;
        elsif amount_owes.to_i.to_i < @amount_owed_to_the_payer[payer_id].to_i then
          puts "Second if " + payee_id.to_s + " pays " + payer_id.to_s + " : " + amount_owes.to_s;
          @amount_owed_by_the_payee[payee_id] = @amount_owed_by_the_payee[payee_id].to_i - amount_owes.to_i;
          @amount_owed_to_the_payer[payer_id] = @amount_owed_to_the_payer[payer_id] - amount_owes.to_i;
          #puts "@amount_owed_to_the_payer";
          #puts @amount_owed_to_the_payer;
          #puts "@amount_owed_by_the_payee"
          #puts @amount_owed_by_the_payee;
        end
      end
    }
  end
}

puts "@amount_owed_to_the_payer";
puts @amount_owed_to_the_payer;

puts "@amount_owed_by_the_payee"
puts @amount_owed_by_the_payee;


@amount_owed_to_the_payer = {
  'w' => nil,
  'a' => nil,
  's' => 1600,
  'n' => nil
}

@amount_owed_by_the_payee = {
  'w' => 400,
  'a' => 600,
  's' => nil,
  'n' => 600
}

@amount_owed_to_the_payer.each { |payer_id, amount_owed|
  if amount_owed.to_i > 0 then
    @amount_owed_by_the_payee.each {|payee_id, amount_owes|
      if amount_owes.to_i > 0 && @amount_owed_to_the_payer[payer_id].to_i > 0 then
        if amount_owes.to_i >= @amount_owed_to_the_payer[payer_id].to_i then
          puts "First if " + payee_id.to_s + " pays " + payer_id.to_s + " : " + @amount_owed_to_the_payer[payer_id].to_s;
          @amount_owed_by_the_payee[payee_id] = @amount_owed_by_the_payee[payee_id].to_i - @amount_owed_to_the_payer[payer_id].to_i;
          @amount_owed_to_the_payer[payer_id] = @amount_owed_to_the_payer[payer_id] - @amount_owed_to_the_payer[payer_id].to_i;
          #puts "@amount_owed_to_the_payer";
          #puts @amount_owed_to_the_payer;
          #puts "@amount_owed_by_the_payee"
          #puts @amount_owed_by_the_payee;
        elsif amount_owes.to_i.to_i < @amount_owed_to_the_payer[payer_id].to_i then
          puts "Second if " + payee_id.to_s + " pays " + payer_id.to_s + " : " + amount_owes.to_s;
          @amount_owed_by_the_payee[payee_id] = @amount_owed_by_the_payee[payee_id].to_i - amount_owes.to_i;
          @amount_owed_to_the_payer[payer_id] = @amount_owed_to_the_payer[payer_id] - amount_owes.to_i;
          #puts "@amount_owed_to_the_payer";
          #puts @amount_owed_to_the_payer;
          #puts "@amount_owed_by_the_payee"
          #puts @amount_owed_by_the_payee;
        end
      end
    }
  end
}

puts "@amount_owed_to_the_payer";
puts @amount_owed_to_the_payer;

puts "@amount_owed_by_the_payee"
puts @amount_owed_by_the_payee;

@amount_owed_to_the_payer = {
  'w' => 12625,
  'a' => 12425,
  's' => nil,
  'n' => 12525
}

@amount_owed_by_the_payee = {
  'w' => nil,
  'a' => nil,
  's' => 37575,
  'n' => nil
}

@amount_owed_to_the_payer.each { |payer_id, amount_owed|
  if amount_owed.to_i > 0 then
    @amount_owed_by_the_payee.each {|payee_id, amount_owes|
      if amount_owes.to_i > 0 && @amount_owed_to_the_payer[payer_id].to_i > 0 then
        if amount_owes.to_i >= @amount_owed_to_the_payer[payer_id].to_i then
          puts "First if " + payee_id.to_s + " pays " + payer_id.to_s + " : " + @amount_owed_to_the_payer[payer_id].to_s;
          @amount_owed_by_the_payee[payee_id] = @amount_owed_by_the_payee[payee_id].to_i - @amount_owed_to_the_payer[payer_id].to_i;
          @amount_owed_to_the_payer[payer_id] = @amount_owed_to_the_payer[payer_id] - @amount_owed_to_the_payer[payer_id].to_i;
          #puts "@amount_owed_to_the_payer";
          #puts @amount_owed_to_the_payer;
          #puts "@amount_owed_by_the_payee"
          #puts @amount_owed_by_the_payee;
        elsif amount_owes.to_i.to_i < @amount_owed_to_the_payer[payer_id].to_i then
          puts "Second if " + payee_id.to_s + " pays " + payer_id.to_s + " : " + amount_owes.to_s;
          @amount_owed_by_the_payee[payee_id] = @amount_owed_by_the_payee[payee_id].to_i - amount_owes.to_i;
          @amount_owed_to_the_payer[payer_id] = @amount_owed_to_the_payer[payer_id] - amount_owes.to_i;
          #puts "@amount_owed_to_the_payer";
          #puts @amount_owed_to_the_payer;
          #puts "@amount_owed_by_the_payee"
          #puts @amount_owed_by_the_payee;
        end
      end
    }
  end
}

puts "@amount_owed_to_the_payer";
puts @amount_owed_to_the_payer;

puts "@amount_owed_by_the_payee"
puts @amount_owed_by_the_payee;



