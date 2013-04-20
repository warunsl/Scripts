require 'net/http'
require 'rexml/document'
include REXML

#Using REXML to parse the xml
billmonk_file = File.new( "billmonk_08_27_2012.xml" )
parsed_doc = REXML::Document.new billmonk_file

#All the bills in the billmonk exported data use the participant's id. So a hash map of names and ids would come in handy to display results.
@names_and_ids_hash = Hash.new (0);
parsed_doc.elements.each("billmonk/friends/friend") {|friend_cursor| 
  @names_and_ids_hash[friend_cursor.attributes["id"]] = friend_cursor.attributes["name"]; 
}

parsed_doc.elements.each("billmonk/account") {|account_cursor| 
  @account_owner_id = account_cursor.attributes["id"]
}

XPath.each(parsed_doc, "billmonk/account/contacts/contact/text()") {|ele|  
  @account_owner_name = ele
}

@names_and_ids_hash[@account_owner_id] = @account_owner_name;

@amount_owed_to_the_payer;
@amount_owed_by_the_payee;
@amount_paid_by_the_payer;

#Initialize the billmonk_matrix nested hash
@billmonk_matrix = Hash.new {0}; 

#Initialize the hashes for each of the friends
parsed_doc.elements.each("billmonk/friends/friend") {|elements| 
  temp = elements.attributes["id"];
  temp_friend = @names_and_ids_hash[temp]
  @billmonk_matrix[temp_friend.to_s] = Hash.new {0};
}

#Initialize the hash for the account holder
parsed_doc.elements.each("billmonk/account") {|elements| 
  temp = elements.attributes["id"]
  temp_friend = @names_and_ids_hash[temp]
  @billmonk_matrix[temp_friend.to_s] = Hash.new {0};
}

#The first pass through the xml constructs two hashes : @amount_owed_to_the_payer and @amount_owed_by_the_payee, both of which are indexed by the id of the participant

parsed_doc.elements.each("billmonk/bills/bill") {|bill_cursor| 
  bill_type = bill_cursor.attributes["type"];
  bill_description = bill_cursor.attributes["description"];

  #puts "--------------";
  #puts "Bill type : " + bill_type.to_s;
  #puts "Bill description : " + bill_description.to_s;

  #Construct the @amount_owed_to_the_payer hash
  @amount_owed_to_the_payer = Hash.new {0};
  @amount_owed_by_the_payee = Hash.new {0};
  @amount_paid_by_the_payer = Hash.new {0};

  bill_cursor.elements.each("payers/payer") {|payer_cursor|
    payer_id = payer_cursor.attributes["friend_id"]; 
    payer_paid = payer_cursor.attributes["amount"]; 

    @amount_paid_by_the_payer[payer_id] = payer_paid.to_i;

    bill_cursor.elements.each("payees/payee") {|payee_cursor|
      payee_id = payee_cursor.attributes["friend_id"];
      payee_share = payee_cursor.attributes["amount"];

      if @amount_owed_by_the_payee[payee_id] != nil then
        @amount_owed_by_the_payee[payee_id] = payee_share.to_i;
      end

      if payer_id.to_s == payee_id.to_s then
        @amount_owed_to_the_payer[payer_id] = @amount_paid_by_the_payer[payer_id].to_i - payee_share.to_i;
        if @amount_owed_to_the_payer[payer_id] > 0 then
          @amount_owed_by_the_payee[payee_id] = nil;
        end
      end
    }
  }

  #Correction logic to account for the case where the payer has paid an amount that is less than his personal share for the bill. In that case, there would be a negative value against his id in the @amount_owed_to_the_payer hash

  @amount_owed_to_the_payer.each{|payer, amount|
    if amount.to_i < 0 then
      @amount_owed_by_the_payee[payer] = -amount.to_i;
    end
  }

  @amount_owed_to_the_payer.each {|payer, amount|
    if amount.to_i < 0 then
      @amount_owed_to_the_payer[payer] = nil;     
    end
  }

  #Now we parse through the  hashes created above and create the @billmonk_hash. @billmonk_matrix[person1][person2] would be the amount person1 owes person2.

  #Case 1 : If the bill type is a SharedReceipt, the two hashes that are to be played with to construct the billmonk_matrix are @amount_owed_to_the_payer and @amount_owed_by_the_payee

  #Case 2 : If the bill type is a LoanReceipt, the two hashes that are to be played with are, @amount_paid_by_the_payer and @amount_owed_by_the_payee

  if bill_type.to_s == "SharedReceipt" then
    @amount_owed_to_the_payer.each { |payer_id, amount_owed|
      if amount_owed.to_i > 0 then
        @amount_owed_by_the_payee.each {|payee_id, amount_owes|
          if amount_owes.to_i > 0 && @amount_owed_to_the_payer[payer_id].to_i > 0 then

              @srpayee_name = @names_and_ids_hash[payee_id];
              @srpayer_name = @names_and_ids_hash[payer_id];

            if amount_owes.to_i >= @amount_owed_to_the_payer[payer_id].to_i then
              @billmonk_matrix[@srpayee_name.to_s][@srpayer_name.to_s] = @billmonk_matrix[@srpayee_name.to_s][@srpayer_name.to_s].to_i + @amount_owed_to_the_payer[payer_id].to_i;
              #puts "First if " + @names_and_ids_hash[payee_id].to_s + " pays " + @names_and_ids_hash[payer_id].to_s + " : " + @amount_owed_to_the_payer[payer_id].to_s;
              @amount_owed_by_the_payee[payee_id] = @amount_owed_by_the_payee[payee_id].to_i - @amount_owed_to_the_payer[payer_id].to_i;
              @amount_owed_to_the_payer[payer_id] = @amount_owed_to_the_payer[payer_id] - @amount_owed_to_the_payer[payer_id].to_i;

            elsif amount_owes.to_i.to_i < @amount_owed_to_the_payer[payer_id].to_i then
              @billmonk_matrix[@srpayee_name.to_s][@srpayer_name.to_s] = @billmonk_matrix[@srpayee_name.to_s][@srpayer_name.to_s].to_i + amount_owes.to_i;
              #puts "Second if " + @names_and_ids_hash[payee_id].to_s + " pays " + @names_and_ids_hash[payer_id].to_s + " : " + amount_owes.to_s;
              @amount_owed_by_the_payee[payee_id] = @amount_owed_by_the_payee[payee_id].to_i - amount_owes.to_i;
              @amount_owed_to_the_payer[payer_id] = @amount_owed_to_the_payer[payer_id] - amount_owes.to_i;
            end
          end
        }
      end
    }
  
  elsif bill_type.to_s == "LoanReceipt" then

    bill_cursor.elements.each("payers/payer") { |payer_cursor|
      @lrpayer_id = payer_cursor.attributes["friend_id"];
      @lramount_owed = @amount_paid_by_the_payer[@lrpayer_id];
    }
    
    bill_cursor.elements.each("payees/payee") { |payee_cursor|
      @lrpayee_id = payee_cursor.attributes["friend_id"];
      @lramount_owes = @amount_owed_by_the_payee[@lrpayee_id];
    }
        
    @lrpayee_name = @names_and_ids_hash[@lrpayee_id];
    @lrpayer_name = @names_and_ids_hash[@lrpayer_id];

    @billmonk_matrix[@lrpayee_name.to_s][@lrpayer_name.to_s] = @billmonk_matrix[@lrpayee_name.to_s][@lrpayer_name.to_s].to_i + @lramount_owes.to_i;

    @amount_owed_by_the_payee[@lrpayee_id] = 0;
    @amount_owed_to_the_payer[@lrpayer_id] = 0;

  end
}

@billmonk_matrix.each{|element|
  puts element;
}