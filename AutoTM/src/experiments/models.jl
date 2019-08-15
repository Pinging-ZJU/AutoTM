#####
##### Convenience Wrappers for models
#####

# Resnet
struct Resnet{T}
    batchsize::Int
    zoo::T
end
Resnet50(batchsize) = Resnet(batchsize, Zoo.Resnet50())
Resnet200(batchsize) = Resnet(batchsize, Zoo.Resnet200())

_sz(::Zoo.Resnet50) = "50"
_sz(::Zoo.Resnet200) = "200"
name(R::Resnet) = "resnet$(_sz(R.zoo))_batchsize_$(R.batchsize)"
Visualizer.titlename(R::Resnet) = "Resnet$(_sz(R.zoo))"
(R::Resnet)() = Zoo.resnet_training(R.zoo, R.batchsize)

# VGG
struct Vgg{T}
    batchsize::Int
    zoo::T
end
Vgg19(batchsize) = Vgg(batchsize, Zoo.Vgg19())
Vgg416(batchsize) = Vgg(batchsize, Zoo.Vgg416())

_sz(::Zoo.Vgg19) = "19"
_sz(::Zoo.Vgg416) = "416"
name(R::Vgg) = "vgg$(_sz(R.zoo))_batchsize_$(R.batchsize)"
Visualizer.titlename(R::Vgg) = "Vgg$(_sz(R.zoo))"
(R::Vgg)() = Zoo.vgg_training(R.zoo, R.batchsize)

# Inception
struct Inception_v4
    batchsize::Int
end
name(R::Inception_v4) = "inception_v4_batchsize_$(R.batchsize)"
Visualizer.titlename(::Inception_v4) = "Inception v4"
(R::Inception_v4)() = Zoo.inception_v4_training(R.batchsize)
 
# DenseNet
struct DenseNet
    batchsize::Int
end
Visualizer.titlename(R::DenseNet) = "DenseNet 264"
name(R::DenseNet) = "densenet264_batchsize_$(R.batchsize)"
(R::DenseNet)() = Zoo.densenet_training(R.batchsize)
 
struct Transformer
    batchsize::Int
    sequence_length::Int
end
#Runner.titlename(T::Transformer) = "Transformer"
name(T::Transformer) = "transformer_batchsize_$(T.batchsize)_seqlen_$(T.sequence_length)"
(T::Transformer)() = Zoo.transformer_training(T.batchsize, T.sequence_length)