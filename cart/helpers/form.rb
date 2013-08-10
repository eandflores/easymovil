VQ::Cart.helpers do
    def input form, name, options = {}
        options[:as] = :text_field unless options.has_key? :as
        as = options.delete :as

        label = options.delete :label
        label = name if label.blank?
        label = label.to_s.titleize

        %{
            <fieldset class='control-group'>
                #{form.label label, class: 'control-label'}
                <div class='controls'>
                    #{
                        str = form.text_field( name, options ) if as.eql? :text_field
                        str = form.text_area( name, options ) if as.eql? :text_area
                        str = form.select( name, options ) if as.eql? :select
                        str = form.password( name, options ) if as.eql? :password
                        str = form.number( name, options ) if as.eql? :number
                        str = form.telephone_field( name, options ) if as.eql? :telephone
                        str = form.email_field( name, options ) if as.eql? :email
                        str = form.checkbox( name, options ) if as.eql? :checkbox
                        str = form.file_field( name, options ) if ( as.eql?( :file_field ) || as.eql?( :file ) )
                        str
                    }
                </div>
            </fieldset>
        }

    end
    def csrf_token_field(token = nil)
    if defined?(session) && token  ||= session[:csrf]
      hidden_field_tag :authenticity_token, :value => session[:csrf]
    end
  end
    
end