# frozen_string_literal: true

RSpec.describe SessionSerializer do
  subject { described_class.new(session) }

  let(:session) { create(:session) }

  let(:attributes) do
    { token: JwtEncoder.encode(uuid: session.uuid) }
  end

  it 'returns session representation' do
    expect(subject.serializable_hash).to a_hash_including(
      data:
        {
          id: session.id.to_s,
          type: :session,
          attributes: attributes
        }
    )
  end
end
