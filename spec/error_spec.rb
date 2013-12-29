describe Vigor::Error do

  describe 'from status' do

    context 'unexpected response' do
      it 'returns ApiError' do
        expect(Vigor::Error.from_status(-1)).to eq Vigor::Error::ApiError
      end
    end

    context 'status 400' do
      it 'returns BadRequest' do
        expect(Vigor::Error.from_status(400)).to eq Vigor::Error::BadRequest
      end
    end

    context 'status 401' do
      it 'returns Unauthorized' do
        expect(Vigor::Error.from_status(401)).to eq Vigor::Error::Unauthorized
      end
    end

    context 'status 404' do
      it 'returns SummonerNotFound' do
        expect(Vigor::Error.from_status(404)).to eq Vigor::Error::SummonerNotFound
      end
    end

    context 'status 500' do
      it 'returns InternalServerError' do
        expect(Vigor::Error.from_status(500)).to eq Vigor::Error::InternalServerError
      end
    end

  end
end
