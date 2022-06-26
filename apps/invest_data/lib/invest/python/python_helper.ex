defmodule InvestData.PythonHelper do

  def start_instance(path, version \\ 'python') do
    :python.start([{:python_path, path}, {:python, version}])
  end

  def call_instance(pid, function, args \\ []) do
    :python.call(pid, :elixir_handler, function, args)
  end


  def stop_instance(pid) do
    :python.stop(pid)
  end


 end
