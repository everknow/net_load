defmodule NetSim do
  @behaviour Load.Sim

  require Logger

  @prepare_execution_condition """
  \x11\x7b\x43\x4f\x1a\x54\xe9\x04\x4f\x4f\x54\x92\x3b\x2c\xff\x9e\
  \x4a\x6d\x42\x0a\xe2\x81\xd5\x02\x5d\x7b\xb0\x40\xc4\xb4\xc0\x4a\
  """

  @impl true
  def init do
    %{
      list: ["node2.node3.node4.node5.","node2.node8.node9.","node2.node6.node7.","node2.node8.node5.","node4.node3.node2.node1.","node8.node2.node1.node."],
      host: Application.get_env(:net_load, :host, "localhost") |> String.to_charlist(),
      port: Application.get_env(:net_load, :port, "8800")  |> String.to_integer(),
      opts: %{protocols: [:ilp_packet], transport: :tcp}
    }
  end

  @impl true
  def run(state) do

    {:ok, payload} = IlpPacket.encode_prepare(%{
      "amount" => 107,
      "data" => "\x01" <> UUID.string_to_binary!(UUID.uuid4()) <> Enum.random(state.list),
      "destination" => "example.alice",
      "execution_condition" => @prepare_execution_condition,
      "expires_at" => "2023-06-07T20:48:42.483Z"
    })
    {:ok, res_payload, state} = Load.Worker.hit("", [], payload, state)

    decoded_response = IlpPacket.decode(res_payload)
    Logger.debug("sim received back #{inspect(decoded_response)}")

    state
  end

end
