class AddIndexToUsersEmail < ActiveRecord::Migration

	# 6.19: migration for enforcing email uniqueness
	# uses a Rails method called add_index to add an
	# index on the email column of the users table.
	#  The index by itself doesn’t enforce uniqueness, 
	# but the option unique: true does.
  def change
    add_index :users, :email, unique: true
  end
end