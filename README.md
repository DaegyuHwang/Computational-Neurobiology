## Computational neurobiology
I have made all of these codes under professor G.LaCamera while studying Computational Neurosbiology.

All Matlab codes were developed based on theoretical mathematical equations, and the generated PDF files were used to verify that they match the theory well, and the dynamics of spike trains and some parameters were investigated to gain insight into the patterns.

## models
M4_L3: The transition rates of gating variables in Hodgkin-Huxley model

M4_L4: Saddle-node on an invariant circle bifurcation (SNIC bifurcation)

M4_L6: Leaky integrate and Fire neuron model (LIF)

M4_L7: Comparing 'error function' of LIF model with mathematical model with tanh(x) 

Fig 6.6&6.7: simulation of LIF neuron model driven by muliple spike trains



### #M4_L3: The transition rates of gating variables in Hodgkin-Huxley model
Simultaion of the voltage-sensitive transition rates α, β (‘gating functions’) based on Eq.3.5-3.6 below.
![image](https://github.com/user-attachments/assets/46fa72fa-046b-49ef-994a-c426b6325ddb)

### #M4_L4: Saddle-node on an invariant circle bifurcation (SNIC bifurcation)
Simulations of SNIC model based on polar coordinates below. I aimed to show that ‘repetitive firing’ occurs above when w = 1.
![image](https://github.com/user-attachments/assets/de2dc9ad-9987-42b2-8cca-bf18c4033050)

### #M4_L6: Leaky integrate and Fire neuron model (LIF)
Simulation of LIF neuron driven by a spike train based on the computational model Eq.6.40 below.
![image](https://github.com/user-attachments/assets/1cb9a83f-63f8-4c42-b773-f476dbd9555f)

### #M4_L7: Comparing 'error function' of LIF model with mathematical model with tanh(x) 
It is trivial to prove below equation mathematically. We used the definition of the hyperbolic tangent, tanh(x) = (e^x - e^(-x))/(e^x + e^(-x)).
![image](https://github.com/user-attachments/assets/aaf14cbe-c46f-4216-954f-7fc74ac0d4a5)
Now we would like to confirm the theoretical content of the approximation by plotting both sides of the equation on xy-plane. 

### #Fig 6.6&6.7: simulation of LIF neuron model driven by muliple spike trains
This Matlab code represents membrane potential of the LIF neurons driven by multiple spike trains with different fring rate(λ). 

Although the computed average of the input firing rate is a single value, it is more realistic to think of the interval between interspikes as random. we confirmed that the peak of the membrance potential could differ significantly between the regular and random interspike-interval models, even at the same firing rate.

I also replaced the delta function with an exponential function and presented the original LIF model and the modified LIF model in the result PDF files. (Because it is realistic to think that it will take some time to respond to input, even if it is only for a short time).

By changing values of 'delta_input'(two options for post-synaptic current) and 'lambda'(represting the input firing rate) in the code, we could get different types of results.





