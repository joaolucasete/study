# defmodule Digits.Model do
#   @moduledoc """
#   The Digits Machine Learning model
#   """
#   def download do
#     Scidata.MNIST.download()
#   end

#   def get_random_number_image(images) do
#     images
#     |> Digits.Model.transform_images()
#     |> Nx.slice_along_axis(0, 1, axis: 0)
#     |> Nx.reshape({1, 1, 28, 28})
#     |> Nx.to_heatmap()
#   end

#   def transform_images({binary, type, shape}) do
#     # Nx.divide(Nx.reshape(Nx.from_binary(binary, type)))
#     binary
#     |> Nx.from_binary(type)
#     |> Nx.reshape(shape)
#     |> Nx.divide(255)
#   end

#   # label was be a binary list like that: 
#   # [1, 0, 0, 0, 0, 0, 0, 0, 0, 0] = number 0
#   # that process of encoding is called one-hot encoding
#   # could has any meaning, how to be a type of a dog or flower.
#   # but in this case represent a number that was handwritten
#   def transform_labels({binary, type, _}) do
#     binary
#     |> Nx.from_binary(type)
#     |> Nx.new_axis(-1)
#     |> Nx.equal(Nx.tensor(Enum.to_list(0..9)))
#   end

#   def new({channels, height, width}) do
#     Axon.input("input_0", shape: {nil, channels, height, width})
#     |> Axon.flatten()
#     |> Axon.dense(128, activation: :relu)
#     |> Axon.dense(10, activation: :softmax)
#   end

#   def train(model, training_data, validation_data) do
#     model
#     |> Axon.Loop.trainer(:categorical_cross_entropy, Axon.Optimizers.adam(0.01))
#     |> Axon.Loop.metric(:accuracy, "Accuracy")
#     |> Axon.Loop.validate(model, validation_data)
#     |> Axon.Loop.run(training_data, %{}, compiler: EXLA, epochs: 10)
#   end

#   def test(model, state, test_data) do
#     model
#     |> Axon.Loop.evaluator()
#     |> Axon.Loop.metric(:accuracy, "Accuracy")
#     |> Axon.Loop.run(test_data, state)
#   end

#   def save!(model, state) do
#     contents = Axon.serialize(model, state)

#     File.write!(path(), contents)
#   end

#   def load! do
#     path()
#     |> File.read!()
#     |> Axon.deserialize()
#   end

#   def path do
#     Path.join(Application.app_dir(:digits, "priv"), "model.axon")
#   end
# end
