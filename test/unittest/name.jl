module TestNameManager
using MXNet
if VERSION ≥ v"0.5.0-dev+7720"
    using Base.Test
else
    using BaseTestNext
    const Test = BaseTestNext
end

function test_default()
  info("NameManager::default")

  name = :_____aaaaa_____
  @test get!(mx.DEFAULT_NAME_MANAGER, name, "") == name
  @test get!(mx.DEFAULT_NAME_MANAGER, string(name), "") == name

  hint = name
  @test get!(mx.DEFAULT_NAME_MANAGER, "", hint) == Symbol("$(hint)0")
  @test get!(mx.DEFAULT_NAME_MANAGER, "", string(hint)) == Symbol("$(hint)1")
end

function test_prefix()
  info("NameManager::prefix")

  name   = :_____bbbbb_____
  prefix = :_____foobar_____

  prefix_manager = mx.PrefixNameManager(prefix)
  @test get!(prefix_manager, name, "") == Symbol("$prefix$name")
  @test get!(prefix_manager, "", name) == Symbol("$prefix$(name)0")
end

@testset "Name Test" begin
  test_default()
  test_prefix()
end

end
