shader_type canvas_item;

uniform vec2 player_pos; // Posição do jogador no espaço
uniform vec4 light_color; // Cor da luz
uniform float light_radius; // Raio da luz
uniform float light_intensity; // Intensidade da luz

void fragment() {
    // Calcula a distância do pixel ao jogador
    float distance_to_player = distance(FRAGCOORD.xy, player_pos);
	float light_intensity2 = clamp(1.0 - (distance_to_player / light_radius), 0.0, 1.0) * light_intensity;
    
    // Aplica a cor da luz ao pixel
    COLOR.rgb *= light_color.rgb * light_intensity2;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
