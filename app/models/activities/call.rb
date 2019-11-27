module Activities
  class Call < Activity
    enum call_outcome: %w(no_answer bussy wrong_number left_live_message left_voice_message connected)

  end
end
