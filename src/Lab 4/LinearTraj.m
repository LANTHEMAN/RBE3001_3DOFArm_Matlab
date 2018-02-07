function [ Traj] = LinearTraj( old,new )
dist = new-old;
Traj = [];
for K=1:10
   Traj = [Traj,(old+dist/10*K)];
end
end

