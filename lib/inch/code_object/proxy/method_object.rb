module Inch
  module CodeObject
    module Proxy
      class MethodObject < Base
        def has_parameters?
          !parameters.empty?
        end

        def method?
          true
        end

        def parameters
          @parameters ||= all_parameter_names.map do |name|
            in_signature = signature_parameter_names.include?(name)
            tag = parameter_tag(name)
            mentioned = !!tag
            types = tag && tag.types
            description = tag && tag.text
            MethodParameterObject.new(name, in_signature, mentioned, types, description)
          end
        end

        def parameter(name)
          parameters.detect { |p| p.name == name.to_s }
        end

        def return_typed?
          !!return_tag
        end

        private

        def all_parameter_names
          names = signature_parameter_names
          names.concat parameter_tags.map(&:name)
          names.uniq
        end


        def signature_parameter_names
          object.parameters.map(&:first)
        end

        def parameter_tag(param_name)
          parameter_tags.detect do |tag|
            tag.name == param_name
          end
        end

        def parameter_tags
          object.tags(:param)
        end

        def return_tag
          object.tags(:return).first
        end
      end
    end
  end
end