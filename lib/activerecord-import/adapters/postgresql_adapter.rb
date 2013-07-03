module ActiveRecord::Import::PostgreSQLAdapter
  include ActiveRecord::Import::ImportSupport

  def insert_many( sql, values, *args ) # :nodoc:
    number_of_inserts = 1

    base_sql,post_sql = if sql.is_a?( String )
      [ sql, '' ]
    elsif sql.is_a?( Array )
      [ sql.shift, sql.join( ' ' ) ]
    end

    sql2insert = base_sql + values.join( ',' ) + post_sql
    ids = select_values( sql2insert, *args )

    [number_of_inserts,ids]
  end


  def next_value_for_sequence(sequence_name)
    %{nextval('#{sequence_name}')}
  end

  def supports_setting_primary_key?
    true
  end
end

